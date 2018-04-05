Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeDEOJW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:09:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:16914 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:09:21 -0400
Subject: Re: INFO: task hung in __blkdev_get
To: mingo@redhat.com, peterz@infradead.org
References: <f403043a9be410acd1055fe5f72e@google.com>
Cc: syzbot
        <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <652eab47-81b5-3249-3c78-427eeec45fbc@I-love.SAKURA.ne.jp>
Date: Thu, 5 Apr 2018 23:08:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f403043a9be410acd1055fe5f72e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the reproducer in my environment. The reproducer can trivially
reproduce a hung up. If the bug I'm observing is what the syzbot is
reporting (I ran the reproducer using init= kernel command line option),
the reason __blkdev_get() is blocked waiting for bdev->bd_mutex is that
an exiting thread cannot release bdev->bd_mutex held at __blkdev_put()
because that thread is unable to return from wait_event_interruptible()
in blk_queue_enter(). (By the way, since the exiting task is sleeping in
interruptible state, khungtaskd does not help; we need to use SysRq-t.)

----------------------------------------
[  200.731135] a.out           S    0   447    446 0x80000002
[  200.732646] Call Trace:
[  200.733566]  ? __schedule+0x2a4/0x9f0
[  200.734764]  ? _raw_spin_unlock_irqrestore+0x40/0x50
[  200.736251]  schedule+0x34/0x80
[  200.737353]  schedule_timeout+0x1cd/0x530
[  200.738595]  ? collect_expired_timers+0xa0/0xa0
[  200.739921]  ? blk_queue_enter+0x7d/0x550
[  200.741500]  blk_queue_enter+0x275/0x550
[  200.743017]  ? wait_woken+0x80/0x80
[  200.744273]  generic_make_request+0xe3/0x2a0
[  200.745621]  ? submit_bio+0x67/0x130
[  200.746831]  submit_bio+0x67/0x130
[  200.747915]  ? guard_bio_eod+0xae/0x200
[  200.749177]  submit_bh_wbc+0x161/0x190
[  200.750326]  __block_write_full_page+0x15c/0x3c0
[  200.751678]  ? check_disk_change+0x60/0x60
[  200.752923]  __writepage+0x11/0x50
[  200.754023]  write_cache_pages+0x1ea/0x530
[  200.755575]  ? __test_set_page_writeback+0x440/0x440
[  200.757039]  ? __lock_acquire+0x38f/0x1a10
[  200.758718]  generic_writepages+0x5f/0xa0
[  200.760128]  ? do_writepages+0x12/0x50
[  200.761281]  do_writepages+0x12/0x50
[  200.762369]  __filemap_fdatawrite_range+0xc3/0x100
[  200.763719]  ? __mutex_lock+0x72/0x950
[  200.764876]  filemap_write_and_wait+0x25/0x60
[  200.766168]  __blkdev_put+0x71/0x200
[  200.767261]  blkdev_close+0x1c/0x20
[  200.768333]  __fput+0x95/0x1d0
[  200.769339]  task_work_run+0x84/0xa0
[  200.770767]  do_exit+0x301/0xbf0
[  200.771877]  ? __do_page_fault+0x2ca/0x510
[  200.773086]  do_group_exit+0x38/0xb0
[  200.774260]  SyS_exit_group+0xb/0x10
[  200.776094]  do_syscall_64+0x68/0x210
[  200.777486]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[  200.815616] Showing all locks held in the system:
[  200.817791] 2 locks held by kworker/0:1/38:
[  200.819125]  #0: 0000000057489670 ((wq_completion)"events_freezable_power_efficient"){+.+.}, at: process_one_work+0x1e2/0x690
[  200.821878]  #1: 00000000c9c74590 ((work_completion)(&(&ev->dwork)->work)){+.+.}, at: process_one_work+0x1e2/0x690
[  200.824690] 1 lock held by a.out/447:
[  200.826448]  #0: 00000000bedfcca8 (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0x3c/0x200


[  270.495110] a.out           S    0   447    446 0x80000002
[  270.496770] Call Trace:
[  270.497779]  ? __schedule+0x2a4/0x9f0
[  270.498930]  ? _raw_spin_unlock_irqrestore+0x40/0x50
[  270.500433]  schedule+0x34/0x80
[  270.501513]  schedule_timeout+0x1cd/0x530
[  270.502773]  ? collect_expired_timers+0xa0/0xa0
[  270.504125]  ? blk_queue_enter+0x7d/0x550
[  270.505706]  blk_queue_enter+0x275/0x550
[  270.507352]  ? wait_woken+0x80/0x80
[  270.508614]  generic_make_request+0xe3/0x2a0
[  270.509913]  ? submit_bio+0x67/0x130
[  270.511876]  submit_bio+0x67/0x130
[  270.513160]  ? guard_bio_eod+0xae/0x200
[  270.514430]  submit_bh_wbc+0x161/0x190
[  270.515691]  __block_write_full_page+0x15c/0x3c0
[  270.517024]  ? check_disk_change+0x60/0x60
[  270.518301]  __writepage+0x11/0x50
[  270.519420]  write_cache_pages+0x1ea/0x530
[  270.520691]  ? __test_set_page_writeback+0x440/0x440
[  270.522118]  ? __lock_acquire+0x38f/0x1a10
[  270.523377]  generic_writepages+0x5f/0xa0
[  270.524624]  ? do_writepages+0x12/0x50
[  270.525974]  do_writepages+0x12/0x50
[  270.527222]  __filemap_fdatawrite_range+0xc3/0x100
[  270.529115]  ? __mutex_lock+0x72/0x950
[  270.530378]  filemap_write_and_wait+0x25/0x60
[  270.531741]  __blkdev_put+0x71/0x200
[  270.532904]  blkdev_close+0x1c/0x20
[  270.534074]  __fput+0x95/0x1d0
[  270.535139]  task_work_run+0x84/0xa0
[  270.536331]  do_exit+0x301/0xbf0
[  270.537458]  ? __do_page_fault+0x2ca/0x510
[  270.538717]  do_group_exit+0x38/0xb0
[  270.539830]  SyS_exit_group+0xb/0x10
[  270.540963]  do_syscall_64+0x68/0x210
[  270.542097]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[  270.582465] Showing all locks held in the system:
[  270.584584] 2 locks held by kworker/1:2/136:
[  270.585939]  #0: 0000000057489670 ((wq_completion)"events_freezable_power_efficient"){+.+.}, at: process_one_work+0x1e2/0x690
[  270.589850]  #1: 00000000e793cf79 ((work_completion)(&(&ev->dwork)->work)){+.+.}, at: process_one_work+0x1e2/0x690
[  270.592813] 1 lock held by a.out/447:
[  270.594237]  #0: 00000000bedfcca8 (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0x3c/0x200
----------------------------------------

I checked variables using below patch, but no variable changed over time.

----------------------------------------
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -857,10 +857,26 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
                 */
                smp_rmb();

-               ret = wait_event_interruptible(q->mq_freeze_wq,
-                               (atomic_read(&q->mq_freeze_depth) == 0 &&
-                                (preempt || !blk_queue_preempt_only(q))) ||
-                               blk_queue_dying(q));
+               while (1) {
+                       ret = wait_event_interruptible_timeout
+                               (q->mq_freeze_wq,
+                                (atomic_read(&q->mq_freeze_depth) == 0 &&
+                                 (preempt || !blk_queue_preempt_only(q))) ||
+                                blk_queue_dying(q), 5 * HZ);
+                       if (ret < 0) {
+                               break;
+                       } else if (ret == 0) {
+                               printk("q->mq_freeze_depth=%d preempt=%u "
+                                      "blk_queue_preempt_only(q)=%u "
+                                      "blk_queue_dying(q)=%u\n",
+                                      atomic_read(&q->mq_freeze_depth),
+                                      preempt, blk_queue_preempt_only(q),
+                                      blk_queue_dying(q));
+                       } else {
+                               ret = 0;
+                               break;
+                       }
+               }
                if (blk_queue_dying(q))
                        return -ENODEV;
                if (ret)
----------------------------------------

[   28.090809] loop: module loaded
[   43.488409] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0
[   48.608715] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0
[   53.728281] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0
[   58.848387] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0
(...snipped...)
[  289.248694] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0
[  294.368484] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0
[  299.488896] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0
[  304.608632] q->mq_freeze_depth=1 preempt=0 blk_queue_preempt_only(q)=0 blk_queue_dying(q)=0

This means that we deadlocked there.
