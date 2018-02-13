Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934789AbeBMKF3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:05:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933810AbeBMKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:05:24 -0500
Date: Tue, 13 Feb 2018 02:05:17 -0800
From: tip-bot for Yang Shi <tipbot@zytor.com>
Message-ID: <tip-1ea9b98b007a662e402551a41a4413becad40a65@git.kernel.org>
Cc: yang.shi@linux.alibaba.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, yang.shi@linux.alibaba.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1517872708-24207-5-git-send-email-yang.shi@linux.alibaba.com>
References: <1517872708-24207-5-git-send-email-yang.shi@linux.alibaba.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Use global free list in
 __debug_check_no_obj_freed()
Git-Commit-ID: 1ea9b98b007a662e402551a41a4413becad40a65
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1ea9b98b007a662e402551a41a4413becad40a65
Gitweb:     https://git.kernel.org/tip/1ea9b98b007a662e402551a41a4413becad40a65
Author:     Yang Shi <yang.shi@linux.alibaba.com>
AuthorDate: Tue, 6 Feb 2018 07:18:28 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 13 Feb 2018 10:59:18 +0100

debugobjects: Use global free list in __debug_check_no_obj_freed()

__debug_check_no_obj_freed() iterates over the to be freed memory region in
chunks and iterates over the corresponding hash bucket list for each
chunk. This can accumulate to hundred thousands of checked objects. In the
worst case this can trigger the soft lockup detector:

NMI watchdog: BUG: soft lockup - CPU#15 stuck for 22s!
CPU: 15 PID: 110342 Comm: stress-ng-getde
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

The code path might be called in either atomic or non-atomic context, but
in_atomic() can't tell if the current context is atomic or not on a
PREEMPT=n kernel, so cond_resched() can't be used to prevent the
softlockup.

Utilize the global free list to shorten the loop execution time.

[ tglx: Massaged changelog ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com
Link: https://lkml.kernel.org/r/1517872708-24207-5-git-send-email-yang.shi@linux.alibaba.com
---
 lib/debugobjects.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 3e79c10..faab2c4 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -751,13 +751,13 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	struct hlist_node *tmp;
-	HLIST_HEAD(freelist);
 	struct debug_obj_descr *descr;
 	enum debug_obj_state state;
 	struct debug_bucket *db;
+	struct hlist_node *tmp;
 	struct debug_obj *obj;
 	int cnt, objs_checked = 0;
+	bool work = false;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -788,18 +788,12 @@ repeat:
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
 
@@ -808,6 +802,10 @@ repeat:
 
 	if (objs_checked > debug_objects_maxchecked)
 		debug_objects_maxchecked = objs_checked;
+
+	/* Schedule work to actually kmem_cache_free() objects */
+	if (work)
+		schedule_work(&debug_obj_work);
 }
 
 void debug_check_no_obj_freed(const void *address, unsigned long size)
