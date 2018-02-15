Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166088AbeBOSKG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:10:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163370AbeBOSKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:10:02 -0500
Date: Thu, 15 Feb 2018 20:09:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, bhe@redhat.com, slp@redhat.com,
        somlo@cmu.edu, xiaolong.ye@intel.com
Subject: Re: [PATCH v14 8/9] fw_cfg: write vmcoreinfo details
Message-ID: <20180214214105-mutt-send-email-mst@kernel.org>
References: <20180214141850.4017-1-marcandre.lureau@redhat.com>
 <20180214141850.4017-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214141850.4017-9-marcandre.lureau@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 03:18:49PM +0100, Marc-André Lureau wrote:
> If the "etc/vmcoreinfo" fw_cfg file is present and we are not running
> the kdump kernel, write the addr/size of the vmcoreinfo ELF note.
> 
> The DMA operation is expected to run synchronously with today qemu,
> but the specification states that it may become async, so we run
> "control" field check in a loop for eventual changes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 144 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 37638b95cb45..69939e2529f2 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -34,11 +34,17 @@
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/fw_cfg.h>
> +#include <linux/delay.h>
> +#include <linux/crash_dump.h>
> +#include <linux/crash_core.h>
>  
>  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
>  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
>  MODULE_LICENSE("GPL");
>  
> +/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir. */
> +static u32 fw_cfg_rev;
> +
>  /* fw_cfg device i/o register addresses */
>  static bool fw_cfg_is_mmio;
>  static phys_addr_t fw_cfg_p_base;
> @@ -59,6 +65,65 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
>  		(u16 __force)cpu_to_le16(key);
>  }
>  
> +static inline bool fw_cfg_dma_enabled(void)
> +{
> +	return (fw_cfg_rev & FW_CFG_VERSION_DMA) && fw_cfg_reg_dma;
> +}
> +
> +/* qemu fw_cfg device is sync today, but spec says it may become async */
> +static void fw_cfg_wait_for_control(struct fw_cfg_dma_access *d)
> +{
> +	do {
> +		u32 ctrl = be32_to_cpu(READ_ONCE(d->control));
> +
> +		if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) == 0)
> +			return;
> +
> +		usleep_range(50, 100);

I would just do cpu_relax() here.

> +	} while (true);
> +
> +	/* do not reorder the read to d->control */
> +	rmb();

Hmm. I don't really understand the comment.
Is this code ever reacheable? How does it help?

> +}
> +
> +static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
> +{
> +	phys_addr_t dma;
> +	struct fw_cfg_dma_access *d = NULL;
> +	ssize_t ret = length;
> +
> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
> +	if (!d) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +
> +	/* fw_cfg device does not need IOMMU protection, so use physical addresses */
> +	*d = (struct fw_cfg_dma_access) {
> +		.address = cpu_to_be64(address ? virt_to_phys(address) : 0),
> +		.length = cpu_to_be32(length),
> +		.control = cpu_to_be32(control)
> +	};
> +
> +	dma = virt_to_phys(d);
> +
> +	iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
> +	/* force memory to sync before notifying device via MMIO */
> +	wmb();
> +	iowrite32be(dma, fw_cfg_reg_dma + 4);
> +
> +	fw_cfg_wait_for_control(d);
> +
> +	if (be32_to_cpu(READ_ONCE(d->control)) & FW_CFG_DMA_CTL_ERROR) {
> +		ret = -EIO;
> +	}
> +
> +end:
> +	kfree(d);
> +
> +	return ret;
> +}
> +
>  /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
>  static inline void fw_cfg_read_blob(u16 key,
>  				    void *buf, loff_t pos, size_t count)
> @@ -87,6 +152,47 @@ static inline void fw_cfg_read_blob(u16 key,
>  	acpi_release_global_lock(glk);
>  }
>  
> +#ifdef CONFIG_CRASH_CORE
> +/* write chunk of given fw_cfg blob (caller responsible for sanity-check) */
> +static ssize_t fw_cfg_write_blob(u16 key,
> +				 void *buf, loff_t pos, size_t count)
> +{
> +	u32 glk = -1U;
> +	acpi_status status;
> +	ssize_t ret = count;
> +
> +	/* If we have ACPI, ensure mutual exclusion against any potential
> +	 * device access by the firmware, e.g. via AML methods:
> +	 */
> +	status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> +	if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
> +		/* Should never get here */
> +		WARN(1, "%s: Failed to lock ACPI!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&fw_cfg_dev_lock);
> +	if (pos == 0) {
> +		ret = fw_cfg_dma_transfer(buf, count, key << 16
> +					  | FW_CFG_DMA_CTL_SELECT
> +					  | FW_CFG_DMA_CTL_WRITE);
> +	} else {
> +		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> +		ret = fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
> +		if (ret < 0)
> +			goto end;
> +		ret = fw_cfg_dma_transfer(buf, count, FW_CFG_DMA_CTL_WRITE);
> +	}
> +
> +end:
> +	mutex_unlock(&fw_cfg_dev_lock);
> +
> +	acpi_release_global_lock(glk);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_CRASH_CORE */
> +
>  /* clean up fw_cfg device i/o */
>  static void fw_cfg_io_cleanup(void)
>  {
> @@ -185,9 +291,6 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir. */
> -static u32 fw_cfg_rev;
> -
>  static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
>  {
>  	return sprintf(buf, "%u\n", fw_cfg_rev);
> @@ -210,6 +313,32 @@ struct fw_cfg_sysfs_entry {
>  	struct list_head list;
>  };
>  
> +#ifdef CONFIG_CRASH_CORE
> +static ssize_t fw_cfg_write_vmcoreinfo(const struct fw_cfg_file *f)
> +{
> +	static struct fw_cfg_vmcoreinfo *data;
> +	ssize_t ret;
> +
> +	data = kmalloc(sizeof(struct fw_cfg_vmcoreinfo), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	*data = (struct fw_cfg_vmcoreinfo) {
> +		.guest_format = cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF),
> +		.size = cpu_to_le32(VMCOREINFO_NOTE_SIZE),
> +		.paddr = cpu_to_le64(paddr_vmcoreinfo_note())
> +	};
> +	/* spare ourself reading host format support for now since we
> +	 * don't know what else to format - host may ignore ours
> +	 */
> +	ret = fw_cfg_write_blob(be16_to_cpu(f->select), data,
> +				0, sizeof(struct fw_cfg_vmcoreinfo));
> +
> +	kfree(data);
> +	return ret;
> +}
> +#endif /* CONFIG_CRASH_CORE */
> +
>  /* get fw_cfg_sysfs_entry from kobject member */
>  static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj)
>  {
> @@ -450,6 +579,15 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
>  	int err;
>  	struct fw_cfg_sysfs_entry *entry;
>  
> +#ifdef CONFIG_CRASH_CORE
> +	if (fw_cfg_dma_enabled() &&
> +		strcmp(f->name, FW_CFG_VMCOREINFO_FILENAME) == 0 &&
> +		!is_kdump_kernel()) {
> +		if (fw_cfg_write_vmcoreinfo(f) < 0)
> +			pr_warn("fw_cfg: failed to write vmcoreinfo");
> +	}
> +#endif
> +
>  	/* allocate new entry */
>  	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>  	if (!entry)
> -- 
> 2.16.1.73.g5832b7e9f2
