Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A03C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381762080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381762080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbeKLGBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:01:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52494 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730739AbeKLGA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:00:59 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt1-0000oM-Ls; Sun, 11 Nov 2018 19:59:11 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Xq-46; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Suzuki K Poulose" <Suzuki.Poulose@arm.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        "Arvind Yadav" <arvind.yadav.cs@gmail.com>,
        "Jia He" <jia.he@hxt-semitech.com>,
        "Claudio Imbrenda" <imbrenda@linux.vnet.ibm.com>,
        "Minchan Kim" <minchan@kernel.org>, "Jia He" <hejianet@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.122173032@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 136/366] mm/ksm.c: ignore STABLE_FLAG of
 rmap_item->address in rmap_walk_ksm()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/ksm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -181,6 +181,8 @@ struct rmap_item {
 #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
 #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
 #define STABLE_FLAG	0x200	/* is listed from the stable tree */
+#define KSM_FLAG_MASK	(SEQNR_MASK|UNSTABLE_FLAG|STABLE_FLAG)
+				/* to mask all the flags */
 
 /* The stable and unstable tree heads */
 static struct rb_root one_stable_tree[1] = { RB_ROOT };
@@ -1919,10 +1921,15 @@ again:
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
@@ -1936,8 +1943,7 @@ again:
 			if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
 				continue;
 
-			ret = rwc->rmap_one(page, vma,
-					rmap_item->address, rwc->arg);
+			ret = rwc->rmap_one(page, vma, addr, rwc->arg);
 			if (ret != SWAP_AGAIN) {
 				anon_vma_unlock_read(anon_vma);
 				goto out;

