Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCZGuG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:50:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36670 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeCZGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:50:02 -0400
X-Google-Smtp-Source: AG47ELsKeLN4AGPFgT/mdrDydo5RDf0t2Sbet3GsafNbcB0/7FDUxgF7up+OT00n1bxnS4TEwUlzMQ==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH 2/2] zram: idle memory tracking
Date: Mon, 26 Mar 2018 15:49:51 +0900
Message-Id: <20180326064951.123940-2-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180326064951.123940-1-minchan@kernel.org>
References: <20180326064951.123940-1-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zRam as swap is useful for small memory device. However, swap means
those pages on zram are mostly cold pages due to VM's LRU algorithm.
Especially, once init data for application are touched for launching,
they tend to be not accessed any more and finally swapped out.
zRAM can store such cold pages as compressed form but it's pointless
to keep in memory. Better idea is app developers free them directly
rather than remaining them on heap.

This patch tell us last accesss time of each block of zram via
"cat /sys/kernel/debug/zram/zram0/access_time".

The output is as follows,

276 1250
277 1800
..  ..
..  ..

First column is zram's block index and second one represents number
of seconds elapsed since the block was last accessed.
So above example means the 276th block is accessed 1250 second ago
and 277th block is accessed 1800 second ago.

Admin can leverage this information to catch cold pages of process
with *pagemap* once part of heaps are swapped out.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/Kconfig    |  11 +++
 drivers/block/zram/zram_drv.c | 159 +++++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h |   6 ++
 3 files changed, 166 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index ac3a31d433b2..5d1f8372fc58 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -26,3 +26,14 @@ config ZRAM_WRITEBACK
 	 /sys/block/zramX/backing_dev.
 
 	 See zram.txt for more infomration.
+
+config ZRAM_IDLE_MEMORY_TRACKING
+       bool "tracking access time of zram block"
+       depends on ZRAM
+       select DEBUG_FS
+       default n
+       help
+	 Record zram block's access time and expose the information via
+	 /sys/kernel/debug/zram/zramX/access_time. If blocks of zram are
+	 mapped of process's address space, you can see which processes
+	 have cold pages via using pagemap and access_time.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4feb983ec9a3..a21c9a63fb2f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -31,10 +31,15 @@
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/sysfs.h>
+#include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 
 #include "zram_drv.h"
 
+#ifdef CONFIG_ZRAM_IDLE_MEMORY_TRACKING
+struct dentry *zram_debugfs_root;
+#endif
+
 static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
 static DEFINE_MUTEX(zram_index_mutex);
@@ -258,6 +263,128 @@ static ssize_t mem_used_max_store(struct device *dev,
 	return len;
 }
 
+static void zram_slot_lock(struct zram *zram, u32 index)
+{
+	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
+}
+
+static void zram_slot_unlock(struct zram *zram, u32 index)
+{
+	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].value);
+}
+
+#ifdef CONFIG_ZRAM_IDLE_MEMORY_TRACKING
+static void zram_accessed(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = get_seconds();
+}
+
+static void zram_reset_accessed(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = 0;
+}
+
+static ssize_t read_access_time(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	ssize_t index;
+	int ret;
+	ssize_t written = 0;
+	ssize_t remained = count;
+	struct zram *zram = file->private_data;
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+
+	kbuf = kvmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		up_read(&zram->init_lock);
+		kvfree(kbuf);
+		return -EINVAL;
+	}
+
+	for (index = *ppos; index < nr_pages; index++) {
+		zram_slot_lock(zram, index);
+		if (zram_test_flag(zram, index, ZRAM_WB))
+			goto next;
+		if (zram_test_flag(zram, index, ZRAM_SAME))
+			goto next;
+		if (!zram_get_handle(zram, index))
+			goto next;
+
+		ret = snprintf(kbuf + written, remained, "%lu %lu\n", index,
+				get_seconds() - zram->table[index].ac_time);
+		if (remained < ret) {
+			zram_slot_unlock(zram, index);
+			break;
+		}
+		written += ret;
+		remained -= ret;
+next:
+		zram_slot_unlock(zram, index);
+		*ppos += 1;
+	}
+
+	up_read(&zram->init_lock);
+	copy_to_user(buf, kbuf, written);
+	kvfree(kbuf);
+
+	return written;
+}
+
+static const struct file_operations proc_zram_access_operations = {
+	.open = simple_open,
+	.read = read_access_time,
+	.llseek = default_llseek,
+};
+
+static int zram_debugfs_register(struct zram *zram)
+{
+	struct dentry *ret;
+
+	if (!zram_debugfs_root)
+		return -ENOENT;
+
+	zram->debugfs_dir = debugfs_create_dir(zram->disk->disk_name,
+						zram_debugfs_root);
+	if (!zram->debugfs_dir)
+		return -ENOMEM;
+
+	ret = debugfs_create_file("access_time", 0400, zram->debugfs_dir,
+				zram, &proc_zram_access_operations);
+	if (!ret)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void zram_debugfs_unregister(struct zram *zram)
+{
+	debugfs_remove_recursive(zram->debugfs_dir);
+}
+#else
+static void zram_accessed(struct zram *zram, u32 index)
+{
+}
+
+static void zram_reset_accessed(struct zram *zram, u32 index)
+{
+}
+
+static int zram_debugfs_register(struct zram *zram)
+{
+	return 0;
+}
+
+static void zram_debugfs_unregister(struct zram *zram)
+{
+
+}
+#endif
+
 #ifdef CONFIG_ZRAM_WRITEBACK
 static bool zram_wb_enabled(struct zram *zram)
 {
@@ -753,16 +880,6 @@ static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
 static DEVICE_ATTR_RO(debug_stat);
 
-static void zram_slot_lock(struct zram *zram, u32 index)
-{
-	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
-}
-
-static void zram_slot_unlock(struct zram *zram, u32 index)
-{
-	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].value);
-}
-
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
 	size_t num_pages = disksize >> PAGE_SHIFT;
@@ -805,6 +922,8 @@ static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
+	zram_reset_accessed(zram, index);
+
 	if (zram_wb_enabled(zram) && zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_wb_clear(zram, index);
 		atomic64_dec(&zram->stats.pages_stored);
@@ -1165,6 +1284,9 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 	}
 
 	generic_end_io_acct(q, rw_acct, &zram->disk->part0, start_time);
+	zram_slot_lock(zram, index);
+	zram_accessed(zram, index);
+	zram_slot_unlock(zram, index);
 
 	if (unlikely(ret < 0)) {
 		if (!is_write)
@@ -1577,9 +1699,19 @@ static int zram_add(void)
 	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
+	ret = zram_debugfs_register(zram);
+	if (ret < 0) {
+		pr_err("Error create debugfs entry for device %d\n",
+				device_id);
+		goto out_free_sysfs;
+	}
+
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
+out_free_sysfs:
+	sysfs_remove_group(&disk_to_dev(zram->disk)->kobj,
+			&zram_disk_attr_group);
 out_free_disk:
 	del_gendisk(zram->disk);
 	put_disk(zram->disk);
@@ -1610,6 +1742,7 @@ static int zram_remove(struct zram *zram)
 	zram->claim = true;
 	mutex_unlock(&bdev->bd_mutex);
 
+	zram_debugfs_unregister(zram);
 	/*
 	 * Remove sysfs first, so no one will perform a disksize
 	 * store while we destroy the devices. This also helps during
@@ -1711,6 +1844,9 @@ static int zram_remove_cb(int id, void *ptr, void *data)
 static void destroy_devices(void)
 {
 	class_unregister(&zram_control_class);
+#ifdef CONFIG_ZRAM_IDLE_MEMORY_TRACKING
+	debugfs_remove_recursive(zram_debugfs_root);
+#endif
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
@@ -1733,6 +1869,9 @@ static int __init zram_init(void)
 		return ret;
 	}
 
+#ifdef CONFIG_ZRAM_IDLE_MEMORY_TRACKING
+	zram_debugfs_root = debugfs_create_dir("zram", NULL);
+#endif
 	zram_major = register_blkdev(0, "zram");
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index baecba5d56a5..3d2cbf46ec7f 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -61,6 +61,9 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long value;
+#ifdef CONFIG_ZRAM_IDLE_MEMORY_TRACKING
+	unsigned long ac_time;
+#endif
 };
 
 struct zram_stats {
@@ -108,5 +111,8 @@ struct zram {
 	unsigned long nr_pages;
 	spinlock_t bitmap_lock;
 #endif
+#ifdef	CONFIG_DEBUG_FS
+	struct dentry *debugfs_dir;
+#endif
 };
 #endif
-- 
2.17.0.rc0.231.g781580f067-goog
