Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBEXTr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:19:47 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33394 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752058AbeBEXTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:19:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SxlA7uj_1517872711;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: tglx@linutronix.de, longman@redhat.com
Cc: yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4 v6] lib: debugobjects: handle objects free in a batch outside the loop
Date: Tue,  6 Feb 2018 07:18:28 +0800
Message-Id: <1517872708-24207-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are nested loops on debug objects free path, sometimes it may take
over hundred thousands of loops, then cause soft lockup with
!CONFIG_PREEMPT occasionally, like below:

NMI watchdog: BUG: soft lockup - CPU#15 stuck for 22s!
[stress-ng-getde:110342]

 CPU: 15 PID: 110342 Comm: stress-ng-getde Tainted: G
E   4.9.44-003.ali3000.alios7.x86_64.debug #1
 Hardware name: Dell Inc. PowerEdge R720xd/0X6FFV, BIOS
1.6.0 03/07/2013

Call Trace:
  [<ffffffff8141177e>] debug_check_no_obj_freed+0x13e/0x220
  [<ffffffff811f8751>] __free_pages_ok+0x1f1/0x5c0
  [<ffffffff811fa785>] __free_pages+0x25/0x40
  [<ffffffff812638db>] __free_slab+0x19b/0x270
  [<ffffffff812639e9>] discard_slab+0x39/0x50
  [<ffffffff812679f7>] __slab_free+0x207/0x270
  [<ffffffff81269966>] ___cache_free+0xa6/0xb0
  [<ffffffff8126c267>] qlist_free_all+0x47/0x80
  [<ffffffff8126c5a9>] quarantine_reduce+0x159/0x190
  [<ffffffff8126b3bf>] kasan_kmalloc+0xaf/0xc0
  [<ffffffff8126b8a2>] kasan_slab_alloc+0x12/0x20
  [<ffffffff81265e8a>] kmem_cache_alloc+0xfa/0x360
  [<ffffffff812abc8f>] ? getname_flags+0x4f/0x1f0
  [<ffffffff812abc8f>] getname_flags+0x4f/0x1f0
  [<ffffffff812abe42>] getname+0x12/0x20
  [<ffffffff81298da9>] do_sys_open+0xf9/0x210
  [<ffffffff81298ede>] SyS_open+0x1e/0x20
  [<ffffffff817d6e01>] entry_SYSCALL_64_fastpath+0x1f/0xc2

The code path might be called in either atomic or non-atomic context,
and in_atomic() can't tell if current context is atomic or not on
!PREEMPT kernel, so cond_resched() can't be used to prevent from the
softlockup.

Utilize the global free list to defer objects free outside of the loop in
a batch to save some cycles in the loop.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 09f2469..b1b42bd 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -776,12 +776,12 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
 	struct hlist_node *tmp;
-	HLIST_HEAD(freelist);
 	struct debug_obj_descr *descr;
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	int cnt, max_loops = 0;
+	bool work = false;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -812,18 +812,12 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-				hlist_add_head(&obj->node, &freelist);
+				work |= __free_object(obj);
 				break;
 			}
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 
-		/* Now free them */
-		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
-			hlist_del(&obj->node);
-			free_object(obj);
-		}
-
 		if (cnt > debug_objects_maxchain)
 			debug_objects_maxchain = cnt;
 
@@ -832,6 +826,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 	if (max_loops > debug_objects_maxloops)
 		debug_objects_maxloops = max_loops;
+
+	/* Schedule work to move free objs to pool list */
+	if (work)
+		schedule_work(&debug_obj_work);
 }
 
 void debug_check_no_obj_freed(const void *address, unsigned long size)
-- 
1.8.3.1
