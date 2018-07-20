Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADCBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55881206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55881206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeGTLZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:25:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:39896 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeGTLZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:25:04 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6KAaMw4027435;
        Fri, 20 Jul 2018 19:36:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 20 Jul 2018 19:36:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6KAaLZW027413
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 20 Jul 2018 19:36:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in generic_file_write_iter
To:     akpm@linux-foundation.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jack@suse.cz, jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
Date:   Fri, 20 Jul 2018 19:36:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/18 19:28, Tetsuo Handa wrote:
> There are many reports which are stalling inside __getblk_gfp().

Currently 18 reports out of 65 "INFO: task hung in " reports.

  INFO: task hung in aead_recvmsg
  INFO: task hung in inode_sleep_on_writeback
  INFO: task hung in __writeback_inodes_sb_nr
  INFO: task hung in __blkdev_get (2)
  INFO: task hung in lookup_slow
  INFO: task hung in iterate_supers
  INFO: task hung in flush_work
  INFO: task hung in vfs_setxattr
  INFO: task hung in lock_mount
  INFO: task hung in __get_super
  INFO: task hung in do_unlinkat
  INFO: task hung in fat_fallocate
  INFO: task hung in generic_file_write_iter
  INFO: task hung in d_alloc_parallel
  INFO: task hung in __fdget_pos (2)
  INFO: task hung in path_openat
  INFO: task hung in do_truncate
  INFO: task hung in filename_create

> And there is horrible comment for __getblk_gfp():
> 
>   /*
>    * __getblk_gfp() will locate (and, if necessary, create) the buffer_head
>    * which corresponds to the passed block_device, block and size. The
>    * returned buffer has its reference count incremented.
>    *
>    * __getblk_gfp() will lock up the machine if grow_dev_page's
>    * try_to_free_buffers() attempt is failing.  FIXME, perhaps?
>    */
> 
> This report is stalling after mount() completed and process used remap_file_pages().
> I think that we might need to use debug printk(). But I don't know what to examine.
> 

Andrew, can you pick up this debug printk() patch?
I guess we can get the result within one week.

From 8f55e00b21fefffbc6abd9085ac503c52a302464 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 20 Jul 2018 19:29:06 +0900
Subject: [PATCH] fs/buffer.c: add debug print for __getblk_gfp() stall problem

Among syzbot's unresolved hung task reports, 18 out of 65 reports contain
__getblk_gfp() line in the backtrace. Since there is a comment block that
says that __getblk_gfp() will lock up the machine if try_to_free_buffers()
attempt from grow_dev_page() is failing, let's start from checking whether
syzbot is hitting that case. This change will be removed after the bug is
fixed.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 fs/buffer.c           | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/sched.h |  7 +++++++
 lib/Kconfig.debug     |  6 ++++++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index be31e28..ebf78ab 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -955,10 +955,20 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 			end_block = init_page_buffers(page, bdev,
 						(sector_t)index << sizebits,
 						size);
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+			current->getblk_executed |= 0x01;
+#endif
 			goto done;
 		}
-		if (!try_to_free_buffers(page))
+		if (!try_to_free_buffers(page)) {
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+			current->getblk_executed |= 0x02;
+#endif
 			goto failed;
+		}
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+		current->getblk_executed |= 0x04;
+#endif
 	}
 
 	/*
@@ -978,6 +988,9 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 	spin_unlock(&inode->i_mapping->private_lock);
 done:
 	ret = (block < end_block) ? 1 : -ENXIO;
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+	current->getblk_executed |= 0x08;
+#endif
 failed:
 	unlock_page(page);
 	put_page(page);
@@ -1033,6 +1046,12 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 		return NULL;
 	}
 
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+	current->getblk_stamp = jiffies;
+	current->getblk_executed = 0;
+	current->getblk_bh_count = 0;
+	current->getblk_bh_state = 0;
+#endif
 	for (;;) {
 		struct buffer_head *bh;
 		int ret;
@@ -1044,6 +1063,18 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 		ret = grow_buffers(bdev, block, size, gfp);
 		if (ret < 0)
 			return NULL;
+
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+		if (!time_after(jiffies, current->getblk_stamp + 3 * HZ))
+			continue;
+		printk(KERN_ERR "%s(%u): getblk(): executed=%x bh_count=%d bh_state=%lx\n",
+		       current->comm, current->pid, current->getblk_executed,
+		       current->getblk_bh_count, current->getblk_bh_state);
+		current->getblk_executed = 0;
+		current->getblk_bh_count = 0;
+		current->getblk_bh_state = 0;
+		current->getblk_stamp = jiffies;
+#endif
 	}
 }
 
@@ -3216,6 +3247,11 @@ int sync_dirty_buffer(struct buffer_head *bh)
  */
 static inline int buffer_busy(struct buffer_head *bh)
 {
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+	current->getblk_executed |= 0x80;
+	current->getblk_bh_count = atomic_read(&bh->b_count);
+	current->getblk_bh_state = bh->b_state;
+#endif
 	return atomic_read(&bh->b_count) |
 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
 }
@@ -3254,11 +3290,18 @@ int try_to_free_buffers(struct page *page)
 	int ret = 0;
 
 	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
+	if (PageWriteback(page)) {
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+		current->getblk_executed |= 0x10;
+#endif
 		return 0;
+	}
 
 	if (mapping == NULL) {		/* can this still happen? */
 		ret = drop_buffers(page, &buffers_to_free);
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+		current->getblk_executed |= 0x20;
+#endif
 		goto out;
 	}
 
@@ -3282,6 +3325,9 @@ int try_to_free_buffers(struct page *page)
 	if (ret)
 		cancel_dirty_page(page);
 	spin_unlock(&mapping->private_lock);
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+	current->getblk_executed |= 0x40;
+#endif
 out:
 	if (buffers_to_free) {
 		struct buffer_head *bh = buffers_to_free;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c4e0aba..95b143e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1207,6 +1207,13 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+	unsigned long			getblk_stamp;
+	unsigned int			getblk_executed;
+	unsigned int			getblk_bh_count;
+	unsigned long			getblk_bh_state;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c731ff9..0747ce7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2058,3 +2058,9 @@ config IO_STRICT_DEVMEM
 	  if the driver using a given range cannot be disabled.
 
 	  If in doubt, say Y.
+
+config DEBUG_AID_FOR_SYZBOT
+       bool "Additional debug code for syzbot"
+       default n
+       help
+         This option is intended for testing by syzbot.
-- 
1.8.3.1
