Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78085ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E87F2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E87F2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeIRE2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:28:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbeIRE2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:28:50 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6258CC7D;
        Mon, 17 Sep 2018 22:59:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 70/70] mm: get rid of vmacache_flush_all() entirely
Date:   Tue, 18 Sep 2018 00:42:43 +0200
Message-Id: <20180917211654.558485513@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 7a9cdebdcc17e426fb5287e4a82db1dfe86339b2 upstream.

Jann Horn points out that the vmacache_flush_all() function is not only
potentially expensive, it's buggy too.  It also happens to be entirely
unnecessary, because the sequence number overflow case can be avoided by
simply making the sequence number be 64-bit.  That doesn't even grow the
data structures in question, because the other adjacent fields are
already 64-bit.

So simplify the whole thing by just making the sequence number overflow
case go away entirely, which gets rid of all the complications and makes
the code faster too.  Win-win.

[ Oleg Nesterov points out that the VMACACHE_FULL_FLUSHES statistics
  also just goes away entirely with this ]

Reported-by: Jann Horn <jannh@google.com>
Suggested-by: Will Deacon <will.deacon@arm.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mm_types.h      |    2 +-
 include/linux/sched.h         |    2 +-
 include/linux/vm_event_item.h |    1 -
 include/linux/vmacache.h      |    5 -----
 mm/debug.c                    |    4 ++--
 mm/vmacache.c                 |   38 --------------------------------------
 6 files changed, 4 insertions(+), 48 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -396,7 +396,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct vm_area_struct *mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
-	u32 vmacache_seqnum;                   /* per-thread vmacache */
+	u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 	unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1559,7 +1559,7 @@ struct task_struct {
 
 	struct mm_struct *mm, *active_mm;
 	/* per-thread vma caching */
-	u32 vmacache_seqnum;
+	u64 vmacache_seqnum;
 	struct vm_area_struct *vmacache[VMACACHE_SIZE];
 #if defined(SPLIT_RSS_COUNTING)
 	struct task_rss_stat	rss_stat;
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -97,7 +97,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
 #ifdef CONFIG_DEBUG_VM_VMACACHE
 		VMACACHE_FIND_CALLS,
 		VMACACHE_FIND_HITS,
-		VMACACHE_FULL_FLUSHES,
 #endif
 		NR_VM_EVENT_ITEMS
 };
--- a/include/linux/vmacache.h
+++ b/include/linux/vmacache.h
@@ -15,7 +15,6 @@ static inline void vmacache_flush(struct
 	memset(tsk->vmacache, 0, sizeof(tsk->vmacache));
 }
 
-extern void vmacache_flush_all(struct mm_struct *mm);
 extern void vmacache_update(unsigned long addr, struct vm_area_struct *newvma);
 extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
 						    unsigned long addr);
@@ -29,10 +28,6 @@ extern struct vm_area_struct *vmacache_f
 static inline void vmacache_invalidate(struct mm_struct *mm)
 {
 	mm->vmacache_seqnum++;
-
-	/* deal with overflows */
-	if (unlikely(mm->vmacache_seqnum == 0))
-		vmacache_flush_all(mm);
 }
 
 #endif /* __LINUX_VMACACHE_H */
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -95,7 +95,7 @@ EXPORT_SYMBOL(dump_vma);
 
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %p mmap %p seqnum %d task_size %lu\n"
+	pr_emerg("mm %p mmap %p seqnum %llu task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %p\n"
 #endif
@@ -125,7 +125,7 @@ void dump_mm(const struct mm_struct *mm)
 #endif
 		"def_flags: %#lx(%pGv)\n",
 
-		mm, mm->mmap, mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
--- a/mm/vmacache.c
+++ b/mm/vmacache.c
@@ -6,44 +6,6 @@
 #include <linux/vmacache.h>
 
 /*
- * Flush vma caches for threads that share a given mm.
- *
- * The operation is safe because the caller holds the mmap_sem
- * exclusively and other threads accessing the vma cache will
- * have mmap_sem held at least for read, so no extra locking
- * is required to maintain the vma cache.
- */
-void vmacache_flush_all(struct mm_struct *mm)
-{
-	struct task_struct *g, *p;
-
-	count_vm_vmacache_event(VMACACHE_FULL_FLUSHES);
-
-	/*
-	 * Single threaded tasks need not iterate the entire
-	 * list of process. We can avoid the flushing as well
-	 * since the mm's seqnum was increased and don't have
-	 * to worry about other threads' seqnum. Current's
-	 * flush will occur upon the next lookup.
-	 */
-	if (atomic_read(&mm->mm_users) == 1)
-		return;
-
-	rcu_read_lock();
-	for_each_process_thread(g, p) {
-		/*
-		 * Only flush the vmacache pointers as the
-		 * mm seqnum is already set and curr's will
-		 * be set upon invalidation when the next
-		 * lookup is done.
-		 */
-		if (mm == p->mm)
-			vmacache_flush(p);
-	}
-	rcu_read_unlock();
-}
-
-/*
  * This task may be accessing a foreign mm via (for example)
  * get_user_pages()->find_vma().  The vmacache is task-local and this
  * task's vmacache pertains to a different mm (ie, its own).  There is


