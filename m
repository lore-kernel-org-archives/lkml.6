Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523253294; cv=none;
        d=google.com; s=arc-20160816;
        b=r8pARsXI0Q4JbwBzjpdw2APtqa/pTXteIpjTrH0X0OnYJ2FfF0PiOnrGwQSsObgup5
         UQHWCyNBxEntx+/LsXOHa88/X1foMytZ3lXqXGY1EblyggbnMP9/A96IQur1JpSdZYpI
         jG5aA7LBtJS0OYS0SOIoVOSXhttYsxVDo7Vec9CPNUCjxkptiUG1D++Yo51llYuWAK6v
         LZWw6qSYPGNjw54o3wN3pOnCVmcGs/1GTyExOODHcSv63IHc5KTEwTr/5pzVmfc5yHNo
         S26DpbfRQy9hmo0V7wlmWgFbklvY++YyiI4pfg3cYb77ubEDs6iATIe2YdLDBmq9M30C
         odBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=njRoe4hmdOLZE/Gl75P9jU5zUuMvfvyP3vhvQnJLCxA=;
        b=S+8X5t0A0VWzSRpG55TRxqmIwySVzMF9oGcubimiuS/jLVEnBKbTuzW9E+Na2ITkRj
         aSvmFIKOtVvt79NR632S7KnNwa2+yBPRIonQnZCQCR6EQYgkP1JdUEvvXb2Rmh9Y4App
         nbx5b5AuTmS4Y2GIukGSsVH1IL+ZMJ1jNFSS6sXl58tFerbgmuMko3HlPZTox2cx0YJ5
         3MNGKacLVJ7gqO5b3bgJ0PsYThYqDQHMJk8u0mEtstt+MxxXbEKN8qp1ivCEzYNpH/Qr
         F/Ux1dE5iPCBNQKXTvrNny2VwU/3+QDT5Ed/89o3lHat9sUzuXzZFDTJ/c6hArcwcR8T
         mRSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UjFViJR4;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UjFViJR4;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4+aVfXaHu7Y0KtfKGnOCr4Xj7QFhq4cetcIkC6m6wQkaTBIDSCqnbu03FMNhll+Y7+vWltNJg==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/4] zram: introduce zram memory tracking
Date: Mon,  9 Apr 2018 14:54:35 +0900
Message-Id: <20180409055435.135695-5-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409055435.135695-1-minchan@kernel.org>
References: <20180409055435.135695-1-minchan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597246846962715384?=
X-GMAIL-MSGID: =?utf-8?q?1597246846962715384?=
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
      300    75.033841 .wh
      301    63.806904 s..
      302    63.806919 ..h

First column is zram's block index and 3rh one represents symbol
(s: same page w: written page to backing store h: huge page) of the
block state. Second column represents usec time unit of the block
was last accessed. So above example means the 300th block is accessed
at 75.033851 second and it was huge so it was written to the backing
store.

Admin can leverage this information to catch cold|incompressible pages
of process with *pagemap* once part of heaps are swapped out.

Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/blockdev/zram.txt |  24 ++++++
 drivers/block/zram/Kconfig      |   9 +++
 drivers/block/zram/zram_drv.c   | 139 +++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h   |   5 ++
 4 files changed, 166 insertions(+), 11 deletions(-)

diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 78db38d02bc9..45509c7d5716 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -243,5 +243,29 @@ to backing storage rather than keeping it in memory.
 User should set up backing device via /sys/block/zramX/backing_dev
 before disksize setting.
 
+= memory tracking
+
+With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
+zram block. It could be useful to catch cold or incompressible
+pages of the proess with*pagemap.
+If you enable the feature, you could see block state via
+/sys/kernel/debug/zram/zram0/block_state". The output is as follows,
+
+	  300    75.033841 .wh
+	  301    63.806904 s..
+	  302    63.806919 ..h
+
+First column is zram's block index.
+Second column is access time.
+Third column is state of the block.
+(s: same page
+w: written page to backing store
+h: huge page)
+
+First line of above example says 300th block is accessed at 75.033841sec
+and the block's state is huge so it is written back to the backing
+storage. It's a debugging feature so anyone shouldn't rely on it to work
+properly.
+
 Nitin Gupta
 ngupta@vflare.org
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index ac3a31d433b2..efe60c82d8ec 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -26,3 +26,12 @@ config ZRAM_WRITEBACK
 	 /sys/block/zramX/backing_dev.
 
 	 See zram.txt for more infomration.
+
+config ZRAM_MEMORY_TRACKING
+	bool "Tracking zram block status"
+	depends on ZRAM
+	select DEBUG_FS
+	help
+	  With this feature, admin can track the state of allocated block
+	  of zRAM. Admin could see the information via
+	  /sys/kernel/debug/zram/zramX/block_state.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7fc10e2ad734..80e461dc70bc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/sysfs.h>
+#include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 
 #include "zram_drv.h"
@@ -67,6 +68,13 @@ static inline bool init_done(struct zram *zram)
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
@@ -83,7 +91,7 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 }
 
 /* flag operations require table entry bit_spin_lock() being held */
-static int zram_test_flag(struct zram *zram, u32 index,
+static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
 	return zram->table[index].value & BIT(flag);
@@ -107,16 +115,6 @@ static inline void zram_set_element(struct zram *zram, u32 index,
 	zram->table[index].element = element;
 }
 
-static void zram_accessed(struct zram *zram, u32 index)
-{
-	zram->table[index].ac_time = sched_clock();
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
@@ -620,6 +618,121 @@ static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 static void zram_wb_clear(struct zram *zram, u32 index) {}
 #endif
 
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+
+static struct dentry *zram_debugfs_root;
+
+static void zram_debugfs_create(void)
+{
+	zram_debugfs_root = debugfs_create_dir("zram", NULL);
+}
+
+static void zram_debugfs_destroy(void)
+{
+	debugfs_remove_recursive(zram_debugfs_root);
+}
+
+static void zram_accessed(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = sched_clock();
+}
+
+static void zram_reset_access(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = 0;
+}
+
+static long long ns2usecs(u64 nsec)
+{
+	nsec += 500;
+	do_div(nsec, 1000);
+	return nsec;
+}
+
+static ssize_t read_block_state(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	ssize_t index, written = 0;
+	struct zram *zram = file->private_data;
+	u64 last_access;
+	unsigned long usec_rem;
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
+		int copied;
+
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		last_access = ns2usecs(zram->table[index].ac_time);
+		usec_rem = do_div(last_access, USEC_PER_SEC);
+		copied = snprintf(kbuf + written, count,
+			"%12lu %5lu.%06lu %c%c%c\n",
+			index, (unsigned long)last_access, usec_rem,
+			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
+			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
+			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.');
+
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
+static void zram_debugfs_create(void) {};
+static void zram_debugfs_destroy(void) {};
+static void zram_accessed(struct zram *zram, u32 index) {};
+static void zram_reset_access(struct zram *zram, u32 index) {};
+static void zram_debugfs_register(struct zram *zram) {};
+static void zram_debugfs_unregister(struct zram *zram) {};
+#endif
 
 /*
  * We switched to per-cpu streams and this attr is not needed anymore.
@@ -1604,6 +1717,7 @@ static int zram_add(void)
 	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
+	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
@@ -1637,6 +1751,7 @@ static int zram_remove(struct zram *zram)
 	zram->claim = true;
 	mutex_unlock(&bdev->bd_mutex);
 
+	zram_debugfs_unregister(zram);
 	/*
 	 * Remove sysfs first, so no one will perform a disksize
 	 * store while we destroy the devices. This also helps during
@@ -1738,6 +1853,7 @@ static int zram_remove_cb(int id, void *ptr, void *data)
 static void destroy_devices(void)
 {
 	class_unregister(&zram_control_class);
+	zram_debugfs_destroy();
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
@@ -1760,6 +1876,7 @@ static int __init zram_init(void)
 		return ret;
 	}
 
+	zram_debugfs_create();
 	zram_major = register_blkdev(0, "zram");
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 1075218e88b2..6aeb0213afd7 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -61,7 +61,9 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long value;
+#ifdef	CONFIG_ZRAM_MEMORY_TRACKING
 	u64 ac_time;
+#endif
 };
 
 struct zram_stats {
@@ -110,5 +112,8 @@ struct zram {
 	unsigned long nr_pages;
 	spinlock_t bitmap_lock;
 #endif
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	struct dentry *debugfs_dir;
+#endif
 };
 #endif
-- 
2.17.0.484.g0c8726318c-goog
