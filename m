Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeB1PHN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:07:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932250AbeB1PHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:07:09 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, bhe@redhat.com, slp@redhat.com, mst@redhat.com,
        somlo@cmu.edu, xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v16 11/11] RFC: fw_cfg: do DMA read operation
Date: Wed, 28 Feb 2018 16:06:15 +0100
Message-Id: <20180228150615.17317-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180228150615.17317-1-marcandre.lureau@redhat.com>
References: <20180228150615.17317-1-marcandre.lureau@redhat.com>
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
 drivers/firmware/qemu_fw_cfg.c | 68 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 14fedbeca724..db1cba4f99bd 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -66,7 +66,6 @@ static void fw_cfg_sel_endianness(u16 key)
 		iowrite16(key, fw_cfg_reg_ctrl);
 }
 
-#ifdef CONFIG_CRASH_CORE
 static inline bool fw_cfg_dma_enabled(void)
 {
 	return (fw_cfg_rev & FW_CFG_VERSION_DMA) && fw_cfg_reg_dma;
@@ -124,14 +123,49 @@ static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
 
 	return ret;
 }
-#endif
+
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
 
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
 static ssize_t fw_cfg_read_blob(u16 key,
-				void *buf, loff_t pos, size_t count)
+				void *buf, loff_t pos, size_t count,
+				ssize_t (*readfn)(u16 key, void *buf,
+						loff_t pos, size_t count))
 {
 	u32 glk = -1U;
 	acpi_status status;
+	ssize_t ret;
 
 	/* If we have ACPI, ensure mutual exclusion against any potential
 	 * device access by the firmware, e.g. via AML methods:
@@ -145,14 +179,19 @@ static ssize_t fw_cfg_read_blob(u16 key,
 	}
 
 	mutex_lock(&fw_cfg_dev_lock);
-	fw_cfg_sel_endianness(key);
-	while (pos-- > 0)
-		ioread8(fw_cfg_reg_data);
-	ioread8_rep(fw_cfg_reg_data, buf, count);
+
+	/* fallback to IO if DMA is not available */
+	if (readfn == fw_cfg_read_blob_dma && !fw_cfg_dma_enabled()) {
+		readfn = fw_cfg_read_blob_io;
+	}
+
+	ret = readfn(key, buf, pos, count);
+
 	mutex_unlock(&fw_cfg_dev_lock);
 
 	acpi_release_global_lock(glk);
-	return count;
+
+	return ret;
 }
 
 #ifdef CONFIG_CRASH_CORE
@@ -286,7 +325,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 
 	/* verify fw_cfg device signature */
 	if (fw_cfg_read_blob(FW_CFG_SIGNATURE, sig,
-				0, FW_CFG_SIG_SIZE) < 0 ||
+				0, FW_CFG_SIG_SIZE, fw_cfg_read_blob_io) < 0 ||
 		memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) != 0) {
 		fw_cfg_io_cleanup();
 		return -ENODEV;
@@ -470,7 +509,9 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
 	if (count > entry->size - pos)
 		count = entry->size - pos;
 
-	return fw_cfg_read_blob(entry->select, buf, pos, count);
+	/* do not use DMA, virt_to_phys(buf) might not be ok */
+	return fw_cfg_read_blob(entry->select, buf, pos, count,
+				fw_cfg_read_blob_io);
 }
 
 static struct bin_attribute fw_cfg_sysfs_attr_raw = {
@@ -636,7 +677,7 @@ static int fw_cfg_register_dir_entries(void)
 	size_t dir_size;
 
 	ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, &files_count,
-			0, sizeof(files_count));
+			0, sizeof(files_count), fw_cfg_read_blob_io);
 	if (ret < 0)
 		return ret;
 
@@ -648,7 +689,7 @@ static int fw_cfg_register_dir_entries(void)
 		return -ENOMEM;
 
 	ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, dir,
-			sizeof(files_count), dir_size);
+			sizeof(files_count), dir_size, fw_cfg_read_blob_dma);
 	if (ret < 0)
 		goto end;
 
@@ -699,7 +740,8 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 		goto err_probe;
 
 	/* get revision number, add matching top-level attribute */
-	err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
+	err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev),
+			fw_cfg_read_blob_io);
 	if (err < 0)
 		goto err_probe;
 
-- 
2.16.1.73.g5832b7e9f2
