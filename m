Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBEXSt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:18:49 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43003 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750862AbeBEXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:18:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SxlA7uj_1517872711;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: tglx@linutronix.de, longman@redhat.com
Cc: yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4 v6] lib: debugobjects: Introduce new global free list and defer objects free via the free list
Date: Tue,  6 Feb 2018 07:18:24 +0800
Message-Id: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since there are 4 patches now for this version, it is hard to track the change
log in single patch, so came up with this cover letter to track the change.

Here is the problem.

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

Defer objects free outside of the loop in a batch to save some cycles
in the loop.
The objects will be added to a global free list, then put them back to
pool list in a work if the pool list is not full. If the pool list is
already full, the objects will stay on the global free list, then will
be freed later.
When allocating objects, check if there are any objects available on
the global free list and just reuse the objects if the global free list
is not empty. Reuse pool lock to protect the free list.

v6:
 * Splitted the second patch into 3 patches
 * Introduced __free_object()
 * Moved free objs reuse to fill_pool()
 * Fixed obj_pool_used leak
v5:
 * Trimmed commit log to just keep call stack and process info.
 * Per tglx's comment, just move free objs to the pool list when it is not
   full. If the pool list is full, free the memory of objs on the free list.
v4:
 * Dropped touching softlockup watchdog approach, and defer objects free
   outside the for loop per the suggestion from tglx.
v3:
 * Use debugfs_create_u32() helper API per Waiman's suggestion
v2:
 * Added suppress_lockup knob in debugfs per Waiman's suggestion

Yang Shi (4):
      lib: debugobjects: export max loops counter
      lib: debugobjects: add global free list and the counter
      lib: debugobjects: use global fre list in free_object()
      lib: debugobjects: handle objects free in a batch outside the loop

 lib/debugobjects.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 91 insertions(+), 25 deletions(-)
