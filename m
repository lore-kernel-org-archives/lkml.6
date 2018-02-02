Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeBBCod (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:44:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbeBBCoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:44:25 -0500
Date: Fri, 2 Feb 2018 04:44:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, slp@redhat.com, bhe@redhat.com,
        somlo@cmu.edu, xiaolong.ye@intel.com
Subject: Re: [PATCH v11 4/4] fw_cfg: write vmcoreinfo details
Message-ID: <20180202044330-mutt-send-email-mst@kernel.org>
References: <20180201130300.9962-1-marcandre.lureau@redhat.com>
 <20180201130300.9962-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180201130300.9962-5-marcandre.lureau@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 02:03:00PM +0100, Marc-André Lureau wrote:
> @@ -314,6 +359,37 @@ struct fw_cfg_sysfs_entry {
>  	struct device *dev;
>  };
>  
> +#ifdef CONFIG_CRASH_CORE
> +static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_file *f)
> +{
> +	struct vmci {
> +		__le16 host_format;
> +		__le16 guest_format;
> +		__le32 size;
> +		__le64 paddr;
> +	} __packed;
> +	static struct vmci *data;
> +	ssize_t ret;
> +
> +	data = kmalloc(sizeof(struct vmci), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	*data = (struct vmci) {
> +		.guest_format = cpu_to_le16(VMCOREINFO_FORMAT_ELF),
> +		.size = cpu_to_le32(VMCOREINFO_NOTE_SIZE),
> +		.paddr = cpu_to_le64(paddr_vmcoreinfo_note())
> +	};
> +	/* spare ourself reading host format support for now since we
> +	 * don't know what else to format - host may ignore ours
> +	 */
> +	ret = fw_cfg_write_blob(dev, f->select, data, 0, sizeof(struct vmci));
> +
> +	kfree(data);
> +	return ret;
> +}
> +#endif /* CONFIG_CRASH_CORE */
> +
>  /* get fw_cfg_sysfs_entry from kobject member */
>  static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj)
>  {

kmalloc during crash is I think a bad idea.
How about preallocating on probe?

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 33e0256..ffd81d1 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -363,22 +363,33 @@ struct fw_cfg_sysfs_entry {
 };
 
 #ifdef CONFIG_CRASH_CORE
+
+struct vmci {
+	__le16 host_format;
+	__le16 guest_format;
+	__le32 size;
+	__le64 paddr;
+} *fw_cfg_vmcore_data;
+
+static int fw_cfg_vmcore_init(void)
+{
+	fw_cfg_vmcore_data = kmalloc(sizeof(*fw_cfg_vmcore_data), GFP_KERNEL);
+	if (!fw_cfg_vmcore_data)
+		return -ENOMEM;
+	return 0;
+}
+
+static int fw_cfg_vmcore_cleanup(void)
+{
+	kfree(fw_cfg_vmcore_data);
+}
+
 static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_file *f)
 {
-	struct vmci {
-		__le16 host_format;
-		__le16 guest_format;
-		__le32 size;
-		__le64 paddr;
-	} __packed;
 	static struct vmci *data;
 	ssize_t ret;
 
-	data = kmalloc(sizeof(struct vmci), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	*data = (struct vmci) {
+	*fw_cfg_vmcore_data = (struct vmci) {
 		.guest_format = cpu_to_le16(VMCOREINFO_FORMAT_ELF),
 		.size = cpu_to_le32(VMCOREINFO_NOTE_SIZE),
 		.paddr = cpu_to_le64(paddr_vmcoreinfo_note())
@@ -386,11 +397,23 @@ static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_file *f)
 	/* spare ourself reading host format support for now since we
 	 * don't know what else to format - host may ignore ours
 	 */
-	ret = fw_cfg_write_blob(dev, f->select, data, 0, sizeof(struct vmci));
+	ret = fw_cfg_write_blob(dev, f->select, fw_cfg_vmcore_data, 0,
+				sizeof(*fw_cfg_vmcore_data));
 
-	kfree(data);
 	return ret;
 }
+
+#else
+
+static int fw_cfg_vmcore_init(void)
+{
+	return 0;
+}
+
+static int fw_cfg_vmcore_cleanup(void)
+{
+}
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* get fw_cfg_sysfs_entry from kobject member */
@@ -725,11 +748,15 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 	if (fw_cfg_sel_ko)
 		return -EBUSY;
 
+	err = fw_cfg_vmcore_init();
+	if (err)
+		goto err_sel;
+
 	/* create by_key and by_name subdirs of /sys/firmware/qemu_fw_cfg/ */
 	err = -ENOMEM;
 	fw_cfg_sel_ko = kobject_create_and_add("by_key", fw_cfg_top_ko);
 	if (!fw_cfg_sel_ko)
-		goto err_sel;
+		goto err_vmcore;
 	fw_cfg_fname_kset = kset_create_and_add("by_name", NULL, fw_cfg_top_ko);
 	if (!fw_cfg_fname_kset)
 		goto err_name;
@@ -764,6 +791,8 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 	fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
 err_name:
 	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
+err_vmcore:
+	fw_cfg_vmcore_cleanup();
 err_sel:
 	return err;
 }
@@ -776,6 +805,7 @@ static int fw_cfg_sysfs_remove(struct platform_device *pdev)
 	fw_cfg_io_cleanup();
 	fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
 	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
+	fw_cfg_vmcore_cleanup();
 	return 0;
 }
 
