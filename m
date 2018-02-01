Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeBANHG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:07:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752237AbeBANHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:07:05 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v11 4/4] fw_cfg: write vmcoreinfo details
Date: Thu,  1 Feb 2018 14:03:00 +0100
Message-Id: <20180201130300.9962-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180201130300.9962-1-marcandre.lureau@redhat.com>
References: <20180201130300.9962-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the "etc/vmcoreinfo" fw_cfg file is present and we are not running
the kdump kernel, write the addr/size of the vmcoreinfo ELF note.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gabriel Somlo <somlo@cmu.edu>
---
 drivers/firmware/qemu_fw_cfg.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 686f0e839858..3b3cf6222c97 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -34,6 +34,8 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/crash_dump.h>
+#include <linux/crash_core.h>
 
 MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
@@ -57,6 +59,8 @@ MODULE_LICENSE("GPL");
 /* fw_cfg "file name" is up to 56 characters (including terminating nul) */
 #define FW_CFG_MAX_FILE_PATH 56
 
+#define VMCOREINFO_FORMAT_ELF 0x1
+
 /* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir. */
 static u32 fw_cfg_rev;
 
@@ -195,6 +199,47 @@ static ssize_t fw_cfg_read_blob(struct device *dev, u16 key,
 	return ret;
 }
 
+#ifdef CONFIG_CRASH_CORE
+/* write chunk of given fw_cfg blob (caller responsible for sanity-check) */
+static ssize_t fw_cfg_write_blob(struct device *dev, u16 key,
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
+		ret = fw_cfg_dma_transfer(dev, buf, count, key << 16
+					  | FW_CFG_DMA_CTL_SELECT
+					  | FW_CFG_DMA_CTL_WRITE);
+	} else {
+		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+		ret = fw_cfg_dma_transfer(dev, NULL, pos, FW_CFG_DMA_CTL_SKIP);
+		if (ret < 0)
+			goto end;
+		ret = fw_cfg_dma_transfer(dev, buf, count, FW_CFG_DMA_CTL_WRITE);
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
@@ -314,6 +359,37 @@ struct fw_cfg_sysfs_entry {
 	struct device *dev;
 };
 
+#ifdef CONFIG_CRASH_CORE
+static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_file *f)
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
+	ret = fw_cfg_write_blob(dev, f->select, data, 0, sizeof(struct vmci));
+
+	kfree(data);
+	return ret;
+}
+#endif /* CONFIG_CRASH_CORE */
+
 /* get fw_cfg_sysfs_entry from kobject member */
 static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj)
 {
@@ -554,6 +630,14 @@ static int fw_cfg_register_file(struct device *dev, const struct fw_cfg_file *f)
 	int err;
 	struct fw_cfg_sysfs_entry *entry;
 
+#ifdef CONFIG_CRASH_CORE
+	if (fw_cfg_dma_enabled() &&
+		strcmp(f->name, "etc/vmcoreinfo") == 0 && !is_kdump_kernel()) {
+		if (write_vmcoreinfo(dev, f) < 0)
+			pr_warn("fw_cfg: failed to write vmcoreinfo");
+	}
+#endif
+
 	/* allocate new entry */
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-- 
2.16.0.rc1.1.gef27df75a1
