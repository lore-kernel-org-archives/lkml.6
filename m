Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEB1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D78252D5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D78252D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031126AbeGAQfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:35:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031107AbeGAQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:35:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCF3D49B;
        Sun,  1 Jul 2018 16:35:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jia He <hejianet@gmail.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 139/157] mm/ksm.c: ignore STABLE_FLAG of rmap_item->address in rmap_walk_ksm()
Date:   Sun,  1 Jul 2018 18:23:31 +0200
Message-Id: <20180701160900.015418458@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia He <jia.he@hxt-semitech.com>

commit 1105a2fc022f3c7482e32faf516e8bc44095f778 upstream.

In our armv8a server(QDF2400), I noticed lots of WARN_ON caused by
PAGE_SIZE unaligned for rmap_item->address under memory pressure
tests(start 20 guests and run memhog in the host).

  WARNING: CPU: 4 PID: 4641 at virt/kvm/arm/mmu.c:1826 kvm_age_hva_handler+0xc0/0xc8
  CPU: 4 PID: 4641 Comm: memhog Tainted: G        W 4.17.0-rc3+ #8
  Call trace:
   kvm_age_hva_handler+0xc0/0xc8
   handle_hva_to_gpa+0xa8/0xe0
   kvm_age_hva+0x4c/0xe8
   kvm_mmu_notifier_clear_flush_young+0x54/0x98
   __mmu_notifier_clear_flush_young+0x6c/0xa0
   page_referenced_one+0x154/0x1d8
   rmap_walk_ksm+0x12c/0x1d0
   rmap_walk+0x94/0xa0
   page_referenced+0x194/0x1b0
   shrink_page_list+0x674/0xc28
   shrink_inactive_list+0x26c/0x5b8
   shrink_node_memcg+0x35c/0x620
   shrink_node+0x100/0x430
   do_try_to_free_pages+0xe0/0x3a8
   try_to_free_pages+0xe4/0x230
   __alloc_pages_nodemask+0x564/0xdc0
   alloc_pages_vma+0x90/0x228
   do_anonymous_page+0xc8/0x4d0
   __handle_mm_fault+0x4a0/0x508
   handle_mm_fault+0xf8/0x1b0
   do_page_fault+0x218/0x4b8
   do_translation_fault+0x90/0xa0
   do_mem_abort+0x68/0xf0
   el0_da+0x24/0x28

In rmap_walk_ksm, the rmap_item->address might still have the
STABLE_FLAG, then the start and end in handle_hva_to_gpa might not be
PAGE_SIZE aligned.  Thus it will cause exceptions in handle_hva_to_gpa
on arm64.

This patch fixes it by ignoring (not removing) the low bits of address
when doing rmap_walk_ksm.

IMO, it should be backported to stable tree.  the storm of WARN_ONs is
very easy for me to reproduce.  More than that, I watched a panic (not
reproducible) as follows:

  page:ffff7fe003742d80 count:-4871 mapcount:-2126053375 mapping: (null) index:0x0
  flags: 0x1fffc00000000000()
  raw: 1fffc00000000000 0000000000000000 0000000000000000 ffffecf981470000
  raw: dead000000000100 dead000000000200 ffff8017c001c000 0000000000000000
  page dumped because: nonzero _refcount
  CPU: 29 PID: 18323 Comm: qemu-kvm Tainted: G W 4.14.15-5.hxt.aarch64 #1
  Hardware name: <snip for confidential issues>
  Call trace:
    dump_backtrace+0x0/0x22c
    show_stack+0x24/0x2c
    dump_stack+0x8c/0xb0
    bad_page+0xf4/0x154
    free_pages_check_bad+0x90/0x9c
    free_pcppages_bulk+0x464/0x518
    free_hot_cold_page+0x22c/0x300
    __put_page+0x54/0x60
    unmap_stage2_range+0x170/0x2b4
    kvm_unmap_hva_handler+0x30/0x40
    handle_hva_to_gpa+0xb0/0xec
    kvm_unmap_hva_range+0x5c/0xd0

I even injected a fault on purpose in kvm_unmap_hva_range by seting
size=size-0x200, the call trace is similar as above.  So I thought the
panic is similarly caused by the root cause of WARN_ON.

Andrea said:

: It looks a straightforward safe fix, on x86 hva_to_gfn_memslot would
: zap those bits and hide the misalignment caused by the low metadata
: bits being erroneously left set in the address, but the arm code
: notices when that's the last page in the memslot and the hva_end is
: getting aligned and the size is below one page.
:
: I think the problem triggers in the addr += PAGE_SIZE of
: unmap_stage2_ptes that never matches end because end is aligned but
: addr is not.
:
: 	} while (pte++, addr += PAGE_SIZE, addr != end);
:
: x86 again only works on hva_start/hva_end after converting it to
: gfn_start/end and that being in pfn units the bits are zapped before
: they risk to cause trouble.

Jia He said:

: I've tested by myself in arm64 server (QDF2400,46 cpus,96G mem) Without
: this patch, the WARN_ON is very easy for reproducing.  After this patch, I
: have run the same benchmarch for a whole day without any WARN_ONs

Link: http://lkml.kernel.org/r/1525403506-6750-1-git-send-email-hejianet@gmail.com
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Tested-by: Jia He <hejianet@gmail.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/ksm.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -199,6 +199,8 @@ struct rmap_item {
 #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
 #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
 #define STABLE_FLAG	0x200	/* is listed from the stable tree */
+#define KSM_FLAG_MASK	(SEQNR_MASK|UNSTABLE_FLAG|STABLE_FLAG)
+				/* to mask all the flags */
 
 /* The stable and unstable tree heads */
 static struct rb_root one_stable_tree[1] = { RB_ROOT };
@@ -2562,10 +2564,15 @@ again:
 		anon_vma_lock_read(anon_vma);
 		anon_vma_interval_tree_foreach(vmac, &anon_vma->rb_root,
 					       0, ULONG_MAX) {
+			unsigned long addr;
+
 			cond_resched();
 			vma = vmac->vma;
-			if (rmap_item->address < vma->vm_start ||
-			    rmap_item->address >= vma->vm_end)
+
+			/* Ignore the stable/unstable/sqnr flags */
+			addr = rmap_item->address & ~KSM_FLAG_MASK;
+
+			if (addr < vma->vm_start || addr >= vma->vm_end)
 				continue;
 			/*
 			 * Initially we examine only the vma which covers this
@@ -2579,8 +2586,7 @@ again:
 			if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
 				continue;
 
-			if (!rwc->rmap_one(page, vma,
-					rmap_item->address, rwc->arg)) {
+			if (!rwc->rmap_one(page, vma, addr, rwc->arg)) {
 				anon_vma_unlock_read(anon_vma);
 				return;
 			}


