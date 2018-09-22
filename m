Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FA7ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8064B20870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8064B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392274AbeIVGPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:15:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44147 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391932AbeIVGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:46 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BN-2u; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdp-0000um-Bi; Sat, 22 Sep 2018 01:19:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Jann Horn" <jannh@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.179802987@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 63/63] mm: get rid of vmacache_flush_all() entirely
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: drop changes to mm debug code]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -345,7 +345,7 @@ struct kioctx_table;
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
@@ -1291,7 +1291,7 @@ struct task_struct {
 	unsigned brk_randomized:1;
 #endif
 	/* per-thread vma caching */
-	u32 vmacache_seqnum;
+	u64 vmacache_seqnum;
 	struct vm_area_struct *vmacache[VMACACHE_SIZE];
 #if defined(SPLIT_RSS_COUNTING)
 	struct task_rss_stat	rss_stat;
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
--- a/mm/vmacache.c
+++ b/mm/vmacache.c
@@ -6,42 +6,6 @@
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

