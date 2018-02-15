Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167380AbeBOVdz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:33:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163497AbeBOVdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:53 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 11/11] RFC: fw_cfg: do DMA read operation
Date: Thu, 15 Feb 2018 22:33:12 +0100
Message-Id: <20180215213312.29234-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify fw_cfg_read_blob() to use DMA if the device supports it.
Return errors, because the operation may fail.

So far, only one call in fw_cfg_register_dir_entries() is using
kmalloc'ed buf and is thus clearly eligible to DMA read.

Initially, I didn't implement DMA read to speed up boot time, but as a
first step before introducing DMA write (since read operations were
already presents). Even more, I didn't realize fw-cfg entries were
being read by the kernel during boot by default. But actally fw-cfg
entries are being populated during module probe. I knew DMA improved a
lot bios boot time (the main reason the DMA interface was added
afaik). Let see the time it would take to read the whole ACPI
tables (128kb allocated)

 # time cat /sys/firmware/qemu_fw_cfg/by_name/etc/acpi/tables/raw
  - with DMA: sys 0m0.003s
  - without DMA (-global fw_cfg.dma_enabled=off): sys 0m7.674s

FW_CFG_FILE_DIR (0x19) is the only "file" that is read during kernel
boot to populate sysfs qemu_fw_cfg directory, and it is quite
small (1-2kb). Since it does not expose itself, in order to measure
the time it takes to read such small file, I took a comparable sized
file of 2048 bytes and exposed it (-fw_cfg test,file=file with a
modified read_raw enabling DMA)

 # perf stat -r 100 cat /sys/firmware/qemu_fw_cfg/by_name/test/raw >/dev/null
  - with DMA:
          0.636037      task-clock (msec)         #    0.141 CPUs utilized            ( +-  1.19% )
  - without DMA:
          6.430128      task-clock (msec)         #    0.622 CPUs utilized            ( +-  0.22% )

That's a few msec saved during boot by enabling DMA read (the gain
would be more substantial if other & bigger fw-cfg entries are read by
others from sysfs, unfortunately, it's not clear if we can always
enable DMA there)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 61 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 3015e77aebca..94df57e9be66 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -124,12 +124,47 @@ static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
 	return ret;
 }
 
+/* with acpi & dev locks taken */
+static ssize_t fw_cfg_read_blob_dma(u16 key,
+				void *buf, loff_t pos, size_t count)
+{
+	ssize_t ret;
+
+	if (pos == 0) {
+		ret = fw_cfg_dma_transfer(buf, count, key << 16
+					| FW_CFG_DMA_CTL_SELECT
+					| FW_CFG_DMA_CTL_READ);
+	} else {
+		fw_cfg_sel_endianness(key);
+		ret = fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
+		if (ret < 0)
+			return ret;
+		ret = fw_cfg_dma_transfer(buf, count,
+					FW_CFG_DMA_CTL_READ);
+	}
+
+	return ret;
+}
+
+/* with acpi & dev locks taken */
+static ssize_t fw_cfg_read_blob_io(u16 key,
+				void *buf, loff_t pos, size_t count)
+{
+	fw_cfg_sel_endianness(key);
+	while (pos-- > 0)
+		ioread8(fw_cfg_reg_data);
+	ioread8_rep(fw_cfg_reg_data, buf, count);
+	return count;
+}
+
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
 static ssize_t fw_cfg_read_blob(u16 key,
-				void *buf, loff_t pos, size_t count)
+				void *buf, loff_t pos, size_t count,
+				bool dma)
 {
 	u32 glk = -1U;
 	acpi_status status;
+	ssize_t ret;
 
 	/* If we have ACPI, ensure mutual exclusion against any potential
 	 * device access by the firmware, e.g. via AML methods:
@@ -143,14 +178,17 @@ static ssize_t fw_cfg_read_blob(u16 key,
 	}
 
 	mutex_lock(&fw_cfg_dev_lock);
-	fw_cfg_sel_endianness(key);
-	while (pos-- > 0)
-		ioread8(fw_cfg_reg_data);
-	ioread8_rep(fw_cfg_reg_data, buf, count);
+	if (dma && fw_cfg_dma_enabled()) {
+		ret = fw_cfg_read_blob_dma(key, buf, pos, count);
+	} else {
+		ret = fw_cfg_read_blob_io(key, buf, pos, count);
+	}
+
 	mutex_unlock(&fw_cfg_dev_lock);
 
 	acpi_release_global_lock(glk);
-	return count;
+
+	return ret;
 }
 
 #ifdef CONFIG_CRASH_CORE
@@ -284,7 +322,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 
 	/* verify fw_cfg device signature */
 	if (fw_cfg_read_blob(FW_CFG_SIGNATURE, sig,
-				0, FW_CFG_SIG_SIZE) < 0 ||
+				0, FW_CFG_SIG_SIZE, false) < 0 ||
 		memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) != 0) {
 		fw_cfg_io_cleanup();
 		return -ENODEV;
@@ -468,7 +506,8 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
 	if (count > entry->size - pos)
 		count = entry->size - pos;
 
-	return fw_cfg_read_blob(entry->select, buf, pos, count);
+	/* do not use DMA, virt_to_phys(buf) might not be ok */
+	return fw_cfg_read_blob(entry->select, buf, pos, count, false);
 }
 
 static struct bin_attribute fw_cfg_sysfs_attr_raw = {
@@ -634,7 +673,7 @@ static int fw_cfg_register_dir_entries(void)
 	size_t dir_size;
 
 	ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, &files_count,
-			0, sizeof(files_count));
+			0, sizeof(files_count), false);
 	if (ret < 0)
 		return ret;
 
@@ -646,7 +685,7 @@ static int fw_cfg_register_dir_entries(void)
 		return -ENOMEM;
 
 	ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, dir,
-			sizeof(files_count), dir_size);
+			sizeof(files_count), dir_size, false);
 	if (ret < 0)
 		goto end;
 
@@ -697,7 +736,7 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 		goto err_probe;
 
 	/* get revision number, add matching top-level attribute */
-	err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
+	err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev), false);
 	if (err < 0)
 		goto err_probe;
 
-- 
2.16.1.73.g5832b7e9f2
