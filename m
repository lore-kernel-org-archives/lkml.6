Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522133456; cv=none;
        d=google.com; s=arc-20160816;
        b=w3Su/L92ATAJle1P5nWb2z3F0KnRrTyt1PA9KgpKbFxqANUkFsgyUuj2gw4hFZsPSg
         K4Z+2A+gmKcD0t8U8bM0MoxSJGVw3ku8e86K0SceeBoCB9ctdY2g1PDmm5//Xo9XRIHb
         LGhwBhxoOGpnoOYMGcHIbT/EFMrzNIgHzyK5PyYHEvnJMbDyx52c0nAEpLXHmyqS5+Xj
         8aPd3GQ82dw2wLq8eZLYegLacOCYrOudOGNBcRH/loqezHC8ydi7O1RUbA4UyPfXHsIQ
         eIN5gQ94NeRPcf9+xAhOeBsuUl5B9ZjcJGrEYOi4TxCTK80qCA3dorW+FFz1zCSfO1GY
         QOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=81w9lSvNXS6NfqXbSoYCtuJUL/6G+F03q3Pve1Zfv9s=;
        b=E3fMeLDNay8LP+38zFYXoY7VyHUYwyxubtVC+Gahz+cMukvzKnZDhcnZeqQIac540J
         WtncDV+BhH/6DnLuOSx5QdgZ1VjARSyQnb9OuKUQmIx+PYHnWL5FtNacuO1cSYK9gv1m
         4zcQCD1OrgjkIm5RkNd3qAmILrypqShUVtuLDoZH34vMmZk4WjzSP+js7xqYlJQ4CSDN
         QERduEvW7l9CiCFUIvcUqhQ9qvidyeTWBImvxO+dQTlPL6Ei31FbA/lDFI75xc4T+C/y
         fm7UWIeVnSfFkEvTDy821bPvR2yGhqRJl5/gPayKPu+cOR6FZb35xh4Z6S5YXkaCdbsN
         TYgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oQsc5SJI;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oQsc5SJI;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AG47ELuTCEwthMlvKkB/lJCZzfENWV6HbrsNaU3hPIBws5zON5Qtm7z66UHKnNFBk2bZ14G7DfTbZQ==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2 4/4] zram: introduce zram memory tracking
Date: Tue, 27 Mar 2018 15:50:33 +0900
Message-Id: <20180327065033.181819-5-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180327065033.181819-1-minchan@kernel.org>
References: <20180327065033.181819-1-minchan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596072611048521150?=
X-GMAIL-MSGID: =?utf-8?q?1596072611048521150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

zRam as swap is useful for small memory device. However, swap means
those pages on zram are mostly cold pages due to VM's LRU algorithm.
Especially, once init data for application are touched for launching,
they tend to be not accessed any more and finally swapped out.
zRAM can store such cold pages as compressed form but it's pointless
to keep in memory. Better idea is app developers free them directly
rather than remaining them on heap.

This patch tell us last access time of each block of zram via
"cat /sys/kernel/debug/zram/zram0/block_state".

The output is as follows,

   25064    .wh       100
   25065    s..       9
   25067    ..h       15

First column is zram's block index and second one represents symbol
(s: same page w: written page to backing store h: huge page) of the
block state. Last one means number of seconds elapsed since the block
was last accessed. So above example means the 25065th block is accessed
100 second ago and it was huge so it was written to the backing store.

Admin can leverage this information to catch cold|incompressible pages
of process with *pagemap* once part of heaps are swapped out.

Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/Kconfig    |  10 +++
 drivers/block/zram/zram_drv.c | 124 +++++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h |   3 +
 3 files changed, 126 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index ac3a31d433b2..fb0763133dd1 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -26,3 +26,13 @@ config ZRAM_WRITEBACK
 	 /sys/block/zramX/backing_dev.
 
 	 See zram.txt for more infomration.
+
+config ZRAM_MEMORY_TRACKING
+       bool "Tracking zram block status"
+       depends on ZRAM
+       select DEBUG_FS
+       default n
+       help
+	 With this feature, admin can track the state of allocated block
+	 of zRAM. Admin could see the information via
+	 /sys/kernel/debug/zram/zramX/block_state.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa48d3e0d4fc..11dcadc40cea 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -31,10 +31,15 @@
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/sysfs.h>
+#include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 
 #include "zram_drv.h"
 
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+static struct dentry *zram_debugfs_root;
+#endif
+
 static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
 static DEFINE_MUTEX(zram_index_mutex);
@@ -67,6 +72,13 @@ static inline bool init_done(struct zram *zram)
 	return zram->disksize;
 }
 
+static inline bool zram_allocated(struct zram *zram, u32 index)
+{
+
+	return (zram->table[index].value >> (ZRAM_FLAG_SHIFT + 1)) ||
+					zram->table[index].handle;
+}
+
 static inline struct zram *dev_to_zram(struct device *dev)
 {
 	return (struct zram *)dev_to_disk(dev)->private_data;
@@ -83,7 +95,7 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 }
 
 /* flag operations require table entry bit_spin_lock() being held */
-static int zram_test_flag(struct zram *zram, u32 index,
+static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
 	return zram->table[index].value & BIT(flag);
@@ -107,16 +119,6 @@ static inline void zram_set_element(struct zram *zram, u32 index,
 	zram->table[index].element = element;
 }
 
-static void zram_accessed(struct zram *zram, u32 index)
-{
-	zram->table[index].ac_time = get_seconds();
-}
-
-static void zram_reset_access(struct zram *zram, u32 index)
-{
-	zram->table[index].ac_time = 0;
-}
-
 static unsigned long zram_get_element(struct zram *zram, u32 index)
 {
 	return zram->table[index].element;
@@ -620,6 +622,98 @@ static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 static void zram_wb_clear(struct zram *zram, u32 index) {}
 #endif
 
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+static void zram_accessed(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = get_seconds();
+}
+
+static void zram_reset_access(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = 0;
+}
+
+static ssize_t read_block_state(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	ssize_t index, written = 0;
+	struct zram *zram = file->private_data;
+	unsigned long last_access, nr_pages = zram->disksize >> PAGE_SHIFT;
+	char flags[__NR_ZRAM_PAGEFLAGS - ZRAM_FLAG_SHIFT];
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
+		int copied;
+
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		snprintf(flags, sizeof(flags), "%c%c%c",
+			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
+			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
+			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.');
+
+		last_access = get_seconds() - zram->table[index].ac_time;
+		copied = snprintf(kbuf + written, count, "%12lu %6s %12lu\n",
+						index, flags, last_access);
+		if (count < copied) {
+			zram_slot_unlock(zram, index);
+			break;
+		}
+		written += copied;
+		count -= copied;
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
+static const struct file_operations proc_zram_block_state_op = {
+	.open = simple_open,
+	.read = read_block_state,
+	.llseek = default_llseek,
+};
+
+static void zram_debugfs_register(struct zram *zram)
+{
+	if (!zram_debugfs_root)
+		return;
+
+	zram->debugfs_dir = debugfs_create_dir(zram->disk->disk_name,
+						zram_debugfs_root);
+	debugfs_create_file("block_state", 0400, zram->debugfs_dir,
+				zram, &proc_zram_block_state_op);
+}
+
+static void zram_debugfs_unregister(struct zram *zram)
+{
+	debugfs_remove_recursive(zram->debugfs_dir);
+}
+#else
+static void zram_accessed(struct zram *zram, u32 index) {};
+static void zram_reset_access(struct zram *zram, u32 index) {};
+static unsigned long zram_access_time(struct zram *zram, u32 index) { return 0 };
+static void zram_debugfs_register(struct zram *zram) {};
+static void zram_debugfs_unregister(struct zram *zram) {};
+#endif
 
 /*
  * We switched to per-cpu streams and this attr is not needed anymore.
@@ -1604,6 +1698,7 @@ static int zram_add(void)
 	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
+	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
@@ -1637,6 +1732,7 @@ static int zram_remove(struct zram *zram)
 	zram->claim = true;
 	mutex_unlock(&bdev->bd_mutex);
 
+	zram_debugfs_unregister(zram);
 	/*
 	 * Remove sysfs first, so no one will perform a disksize
 	 * store while we destroy the devices. This also helps during
@@ -1738,6 +1834,9 @@ static int zram_remove_cb(int id, void *ptr, void *data)
 static void destroy_devices(void)
 {
 	class_unregister(&zram_control_class);
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	debugfs_remove_recursive(zram_debugfs_root);
+#endif
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
@@ -1760,6 +1859,9 @@ static int __init zram_init(void)
 		return ret;
 	}
 
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	zram_debugfs_root = debugfs_create_dir("zram", NULL);
+#endif
 	zram_major = register_blkdev(0, "zram");
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f9943d623934..247d287d5054 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -111,5 +111,8 @@ struct zram {
 	unsigned long nr_pages;
 	spinlock_t bitmap_lock;
 #endif
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	struct dentry *debugfs_dir;
+#endif
 };
 #endif
-- 
2.17.0.rc0.231.g781580f067-goog
