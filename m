Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754370AbeBGBmx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:42:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754300AbeBGBms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:42:48 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v13 3/4] fw_cfg: write vmcoreinfo details
Date: Wed,  7 Feb 2018 02:35:24 +0100
Message-Id: <20180207013525.1634-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180207013525.1634-1-marcandre.lureau@redhat.com>
References: <20180207013525.1634-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the "etc/vmcoreinfo" fw_cfg file is present and we are not running
the kdump kernel, write the addr/size of the vmcoreinfo ELF note.

The DMA operation is expected to run synchronously with today qemu,
but the specification states that it may become async, so we run
"control" field check in a loop for eventual changes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 157 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 740df0df2260..fd576ba7b337 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -33,6 +33,9 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/crash_dump.h>
+#include <linux/crash_core.h>
 
 MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
@@ -43,12 +46,24 @@ MODULE_LICENSE("GPL");
 #define FW_CFG_ID         0x01
 #define FW_CFG_FILE_DIR   0x19
 
+#define FW_CFG_VERSION_DMA     0x02
+#define FW_CFG_DMA_CTL_ERROR   0x01
+#define FW_CFG_DMA_CTL_READ    0x02
+#define FW_CFG_DMA_CTL_SKIP    0x04
+#define FW_CFG_DMA_CTL_SELECT  0x08
+#define FW_CFG_DMA_CTL_WRITE   0x10
+
 /* size in bytes of fw_cfg signature */
 #define FW_CFG_SIG_SIZE 4
 
 /* fw_cfg "file name" is up to 56 characters (including terminating nul) */
 #define FW_CFG_MAX_FILE_PATH 56
 
+#define VMCOREINFO_FORMAT_ELF 0x1
+
+/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir. */
+static u32 fw_cfg_rev;
+
 /* fw_cfg file directory entry type */
 struct fw_cfg_file {
 	u32 size;
@@ -57,6 +72,12 @@ struct fw_cfg_file {
 	char name[FW_CFG_MAX_FILE_PATH];
 };
 
+struct fw_cfg_dma {
+	u32 control;
+	u32 length;
+	u64 address;
+} __packed;
+
 /* fw_cfg device i/o register addresses */
 static bool fw_cfg_is_mmio;
 static phys_addr_t fw_cfg_p_base;
@@ -75,6 +96,59 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
 	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
 }
 
+static inline bool fw_cfg_dma_enabled(void)
+{
+	return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
+}
+
+/* qemu fw_cfg device is sync today, but spec says it may become async */
+static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
+{
+	do {
+		u32 ctrl = be32_to_cpu(READ_ONCE(d->control));
+
+		if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) == 0)
+			return;
+
+		usleep_range(50, 100);
+	} while (true);
+}
+
+static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
+{
+	phys_addr_t dma;
+	struct fw_cfg_dma *d = NULL;
+	ssize_t ret = length;
+
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	*d = (struct fw_cfg_dma) {
+		.address = address ? cpu_to_be64(virt_to_phys(address)) : 0,
+		.length = cpu_to_be32(length),
+		.control = cpu_to_be32(control)
+	};
+
+	dma = virt_to_phys(d);
+
+	iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
+	iowrite32be(dma, fw_cfg_reg_dma + 4);
+
+	fw_cfg_wait_for_control(d);
+
+	if (be32_to_cpu(READ_ONCE(d->control)) & FW_CFG_DMA_CTL_ERROR) {
+		ret = -EIO;
+	}
+
+end:
+	kfree(d);
+
+	return ret;
+}
+
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
 static inline void fw_cfg_read_blob(u16 key,
 				    void *buf, loff_t pos, size_t count)
@@ -103,6 +177,47 @@ static inline void fw_cfg_read_blob(u16 key,
 	acpi_release_global_lock(glk);
 }
 
+#ifdef CONFIG_CRASH_CORE
+/* write chunk of given fw_cfg blob (caller responsible for sanity-check) */
+static ssize_t fw_cfg_write_blob(u16 key,
+				 void *buf, loff_t pos, size_t count)
+{
+	u32 glk = -1U;
+	acpi_status status;
+	ssize_t ret = count;
+
+	/* If we have ACPI, ensure mutual exclusion against any potential
+	 * device access by the firmware, e.g. via AML methods:
+	 */
+	status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
+	if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
+		/* Should never get here */
+		WARN(1, "%s: Failed to lock ACPI!\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&fw_cfg_dev_lock);
+	if (pos == 0) {
+		ret = fw_cfg_dma_transfer(buf, count, key << 16
+					  | FW_CFG_DMA_CTL_SELECT
+					  | FW_CFG_DMA_CTL_WRITE);
+	} else {
+		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+		ret = fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
+		if (ret < 0)
+			goto end;
+		ret = fw_cfg_dma_transfer(buf, count, FW_CFG_DMA_CTL_WRITE);
+	}
+
+end:
+	mutex_unlock(&fw_cfg_dev_lock);
+
+	acpi_release_global_lock(glk);
+
+	return ret;
+}
+#endif /* CONFIG_CRASH_CORE */
+
 /* clean up fw_cfg device i/o */
 static void fw_cfg_io_cleanup(void)
 {
@@ -201,9 +316,6 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir. */
-static u32 fw_cfg_rev;
-
 static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
 {
 	return sprintf(buf, "%u\n", fw_cfg_rev);
@@ -224,6 +336,37 @@ struct fw_cfg_sysfs_entry {
 	struct list_head list;
 };
 
+#ifdef CONFIG_CRASH_CORE
+static ssize_t write_vmcoreinfo(const struct fw_cfg_file *f)
+{
+	struct vmci {
+		__le16 host_format;
+		__le16 guest_format;
+		__le32 size;
+		__le64 paddr;
+	} __packed;
+	static struct vmci *data;
+	ssize_t ret;
+
+	data = kmalloc(sizeof(struct vmci), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	*data = (struct vmci) {
+		.guest_format = cpu_to_le16(VMCOREINFO_FORMAT_ELF),
+		.size = cpu_to_le32(VMCOREINFO_NOTE_SIZE),
+		.paddr = cpu_to_le64(paddr_vmcoreinfo_note())
+	};
+	/* spare ourself reading host format support for now since we
+	 * don't know what else to format - host may ignore ours
+	 */
+	ret = fw_cfg_write_blob(f->select, data, 0, sizeof(struct vmci));
+
+	kfree(data);
+	return ret;
+}
+#endif /* CONFIG_CRASH_CORE */
+
 /* get fw_cfg_sysfs_entry from kobject member */
 static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj)
 {
@@ -464,6 +607,14 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	int err;
 	struct fw_cfg_sysfs_entry *entry;
 
+#ifdef CONFIG_CRASH_CORE
+	if (fw_cfg_dma_enabled() &&
+		strcmp(f->name, "etc/vmcoreinfo") == 0 && !is_kdump_kernel()) {
+		if (write_vmcoreinfo(f) < 0)
+			pr_warn("fw_cfg: failed to write vmcoreinfo");
+	}
+#endif
+
 	/* allocate new entry */
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-- 
2.16.1.73.g5832b7e9f2
