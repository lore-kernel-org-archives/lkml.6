Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524206131; cv=none;
        d=google.com; s=arc-20160816;
        b=dqGmRdVYSqrNbAvuFtVU5Tn2xYm0hzUL4aFj8olUHXsdPayHayEpfjvs09ihYuxfY8
         FTxjV/YNgtPByBi54SI8UFRLM+4399FSee9KyF+maW6sibGR1RdL+nMrZM4cwen2NVsE
         IrhWENpxg80L8UezGG3Y3YBfwt1FAbwXusOjHG37PDAWvX3wvB3g4MrOjk3JXqOUJRyN
         znx1n2XBO88ra4T5PikOsjfwjT7rs9QMGgDFThmI00LoCHP/f0b1POUGO7ZrxITDSBLL
         VbE/jb67fCtfe4Fj89i1ao6vFyPaPnpI/jedLmR4i2ijbdNFVknBow+fnWavNIuCOi4B
         FyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=LWUmjgS6O+NO974DrVeavVZZy21ilLQW8tM3sPtrz/w=;
        b=DkTks2iwKI+SjoHuoj5l0cKjZdugfq12Sm+XUIIifrPEghqTY4YLdNLr0Kut+Ff6k1
         oqmSwQqueR9PRJPQmThUit1FbAEDWRQeJHpUS3q0leaJUOfEgx4j/7xZdE5BVbE8JvnI
         ACK5la+JeWHk7eGlptQ9jl7o86m32+pcENLsd9uWBmHgJgsnmOw5aooL7F/w376K6a2P
         Ziq7eYRVp8zEJRpifnXXYUg+5X6nbae0grEyNWQB1WN/SBk4UOKnaU6G6Qj7ob3OQFV4
         4dzXAd2MPVakYtUkSIw5PzjwNjYirr+yY46qMtBGKVSyfHJXO1v7M0O81/x016f4bbf7
         nnGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tsJ4ySF1;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tsJ4ySF1;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4+kbwQla/lJ4bTaYkyYNP76mWsoloZB33YJgDpacwMSrl6XJv8XEYKDtMU2vpgkShcO9P0i4w==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 20 Apr 2018 15:35:25 +0900
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] zram: introduce zram memory tracking
Message-ID: <20180420063525.GA253739@rodete-desktop-imager.corp.google.com>
References: <20180416090946.63057-1-minchan@kernel.org>
 <20180416090946.63057-5-minchan@kernel.org>
 <20180417145921.eac3d6379b5bade6c4f1a091@linux-foundation.org>
 <20180418012636.GA196478@rodete-desktop-imager.corp.google.com>
 <20180418140715.4af4e837d6048a82117c85bd@linux-foundation.org>
 <20180420020921.GA155841@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420020921.GA155841@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1598245968571847904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 11:09:21AM +0900, Minchan Kim wrote:
> On Wed, Apr 18, 2018 at 02:07:15PM -0700, Andrew Morton wrote:
> > On Wed, 18 Apr 2018 10:26:36 +0900 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > Hi Andrew,
> > > 
> > > On Tue, Apr 17, 2018 at 02:59:21PM -0700, Andrew Morton wrote:
> > > > On Mon, 16 Apr 2018 18:09:46 +0900 Minchan Kim <minchan@kernel.org> wrote:
> > > > 
> > > > > zRam as swap is useful for small memory device. However, swap means
> > > > > those pages on zram are mostly cold pages due to VM's LRU algorithm.
> > > > > Especially, once init data for application are touched for launching,
> > > > > they tend to be not accessed any more and finally swapped out.
> > > > > zRAM can store such cold pages as compressed form but it's pointless
> > > > > to keep in memory. Better idea is app developers free them directly
> > > > > rather than remaining them on heap.
> > > > > 
> > > > > This patch tell us last access time of each block of zram via
> > > > > "cat /sys/kernel/debug/zram/zram0/block_state".
> > > > > 
> > > > > The output is as follows,
> > > > >       300    75.033841 .wh
> > > > >       301    63.806904 s..
> > > > >       302    63.806919 ..h
> > > > > 
> > > > > First column is zram's block index and 3rh one represents symbol
> > > > > (s: same page w: written page to backing store h: huge page) of the
> > > > > block state. Second column represents usec time unit of the block
> > > > > was last accessed. So above example means the 300th block is accessed
> > > > > at 75.033851 second and it was huge so it was written to the backing
> > > > > store.
> > > > > 
> > > > > Admin can leverage this information to catch cold|incompressible pages
> > > > > of process with *pagemap* once part of heaps are swapped out.
> > > > 
> > > > A few things..
> > > > 
> > > > - Terms like "Admin can" and "Admin could" are worrisome.  How do we
> > > >   know that admins *will* use this?  How do we know that we aren't
> > > >   adding a bunch of stuff which nobody will find to be (sufficiently)
> > > >   useful?  For example, is there some userspace tool to which you are
> > > >   contributing which will be updated to use this feature?
> > > 
> > > Actually, I used this feature two years ago to find memory hogger
> > > although the feature was very fast prototyping. It was very useful
> > > to reduce memory cost in embedded space.
> > > 
> > > The reason I am trying to upstream the feature is I need the feature
> > > again. :)
> > > 
> > > Yub, I have a userspace tool to use the feature although it was
> > > not compatible with this new version. It should be updated with
> > > new format. I will find a time to submit the tool.
> > 
> > hm, OK, can we get this info into the changelog?  
> 
> No problem. I will add as follows,
> 
> "I used the feature a few years ago to find memory hoggers in userspace
> to notice them what memory they have wasted without touch for a long time.
> With it, they could reduce unnecessary memory space. However, at that time,
> I hacked up zram for the feature but now I need the feature again so
> I decided it would be better to upstream rather than keeping it alone.
> I hope I submit the userspace tool to use the feature soon"
> 
> > 
> > > > 
> > > > - block_state's second column is in microseconds since some
> > > >   undocumented time.  But how is userspace to know how much time has
> > > >   elapsed since the access?  ie, "current time".
> > > 
> > > It's a sched_clock so it should be elapsed time since the system boot.
> > > I should have written it explictly.
> > > I will fix it.
> > > 
> > > > 
> > > > - Is the sched_clock() return value suitable for exporting to
> > > >   userspace?  Is it monotonic?  Is it consistent across CPUs, across
> > > >   CPU hotadd/remove, across suspend/resume, etc?  Does it run all the
> > > >   way up to 2^64 on all CPU types, or will some processors wrap it at
> > > >   (say) 32 bits?  etcetera.  Documentation/timers/timekeeping.txt
> > > >   points out that suspend/resume can mess it up and that the counter
> > > >   can drift between cpus.
> > > 
> > > Good point!
> > > 
> > > I just referenced it from ftrace because I thought the goal is similiar
> > > "no need to be exact unless the drift is frequent but wanted to be fast"
> > > 
> > > AFAIK, ftrace/printk is active user of the function so if the problem
> > > happens frequently, it might be serious. :)
> > 
> > It could be that ktime_get() is a better fit here - especially if
> > sched_clock() goes nuts after resume.  Unfortunately ktime_get()
> > appears to be totally undocumented :(
> > 
> 
> I will use ktime_get_boottime(). With it, zram is not demamaged by
> suspend/resume and code would be more simple/clear. For user, it
> would be more straightforward to parse the time.
> 
> Thanks for good suggestion, Andrew!
> 

Hey Andrew,

This is updated patch for 4/4.
If you want to replace full patchset, please tell me. I will send full
patchset.

>From 2ac685c32ffd3fba42d5eea6347f924c6e89bec0 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 9 Apr 2018 14:34:43 +0900
Subject: [PATCH v5 4/4] zram: introduce zram memory tracking

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

I used the feature a few years ago to find memory hoggers in userspace
to notify them what memory they have wasted without touch for a long time.
With it, they could reduce unnecessary memory space. However, at that time,
I hacked up zram for the feature but now I need the feature again so
I decided it would be better to upstream rather than keeping it alone.
I hope I submit the userspace tool to use the feature soon

Cc: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v4
  * use ktime_get_bootimte - Andrew
  * add feature usecase in change log - Andrew

 Documentation/blockdev/zram.txt |  24 ++++++
 drivers/block/zram/Kconfig      |  14 +++-
 drivers/block/zram/zram_drv.c   | 131 +++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h   |   7 +-
 4 files changed, 162 insertions(+), 14 deletions(-)

diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 78db38d02bc9..6cb804b709cf 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -243,5 +243,29 @@ to backing storage rather than keeping it in memory.
 User should set up backing device via /sys/block/zramX/backing_dev
 before disksize setting.
 
+= memory tracking
+
+With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
+zram block. It could be useful to catch cold or incompressible
+pages of the process with*pagemap.
+If you enable the feature, you could see block state via
+/sys/kernel/debug/zram/zram0/block_state". The output is as follows,
+
+	  300    75.033841 .wh
+	  301    63.806904 s..
+	  302    63.806919 ..h
+
+First column is zram's block index.
+Second column is access time since the system is boot
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
index ac3a31d433b2..635235759a0a 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -13,7 +13,7 @@ config ZRAM
 	  It has several use cases, for example: /tmp storage, use as swap
 	  disks and maybe many more.
 
-	  See zram.txt for more information.
+	  See Documentation/blockdev/zram.txt for more information.
 
 config ZRAM_WRITEBACK
        bool "Write back incompressible page to backing device"
@@ -25,4 +25,14 @@ config ZRAM_WRITEBACK
 	 For this feature, admin should set up backing device via
 	 /sys/block/zramX/backing_dev.
 
-	 See zram.txt for more infomration.
+	 See Documentation/blockdev/zram.txt for more information.
+
+config ZRAM_MEMORY_TRACKING
+	bool "Track zRam block status"
+	depends on ZRAM && DEBUG_FS
+	help
+	  With this feature, admin can track the state of allocated blocks
+	  of zRAM. Admin could see the information via
+	  /sys/kernel/debug/zram/zramX/block_state.
+
+	  See Documentation/blockdev/zram.txt for more information.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7fc10e2ad734..68d727d89d38 100644
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
@@ -620,6 +618,113 @@ static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
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
+	zram->table[index].ac_time = ktime_get_boottime();
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
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	struct timespec64 ts;
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
+		ts = ktime_to_timespec64(zram->table[index].ac_time);
+		copied = snprintf(kbuf + written, count,
+			"%12lu %12lu.%06lu %c%c%c\n",
+			index, ts.tv_sec, ts.tv_nsec / NSEC_PER_USEC,
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
+	if (copy_to_user(buf, kbuf, written))
+		written = -EFAULT;
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
@@ -1604,6 +1709,7 @@ static int zram_add(void)
 	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
+	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
@@ -1637,6 +1743,7 @@ static int zram_remove(struct zram *zram)
 	zram->claim = true;
 	mutex_unlock(&bdev->bd_mutex);
 
+	zram_debugfs_unregister(zram);
 	/*
 	 * Remove sysfs first, so no one will perform a disksize
 	 * store while we destroy the devices. This also helps during
@@ -1739,6 +1846,7 @@ static void destroy_devices(void)
 {
 	class_unregister(&zram_control_class);
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
+	zram_debugfs_destroy();
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
@@ -1760,6 +1868,7 @@ static int __init zram_init(void)
 		return ret;
 	}
 
+	zram_debugfs_create();
 	zram_major = register_blkdev(0, "zram");
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 1075218e88b2..72c8584b6dff 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -61,7 +61,9 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long value;
-	u64 ac_time;
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	ktime_t ac_time;
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
