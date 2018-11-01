Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DBECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717E2205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717E2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeKAMZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:25:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbeKAMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 570E73001E49;
        Thu,  1 Nov 2018 03:24:00 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 958FF5D6A6;
        Thu,  1 Nov 2018 03:23:55 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Vineet Gupta <vgupta@synopsys.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH RFC] mm: arc: fix potential double realease of mmap_sem
Date:   Thu,  1 Nov 2018 11:23:54 +0800
Message-Id: <20181101032354.19351-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 01 Nov 2018 03:24:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_page_fault() of ARC we have:

        ...
	fault = handle_mm_fault(vma, address, flags);

        /* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
        if (unlikely(fatal_signal_pending(current))) {
                if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
                        up_read(&mm->mmap_sem);     <---------------- [1]
                if (user_mode(regs))
                        return;
        }
        ...
	if (likely(!(fault & VM_FAULT_ERROR))) {
                ...
		return;
	}

	if (fault & VM_FAULT_OOM)
		goto out_of_memory;                <----------------- [2]
	else if (fault & VM_FAULT_SIGSEGV)
		goto bad_area;                     <----------------- [3]
	else if (fault & VM_FAULT_SIGBUS)
		goto do_sigbus;                    <----------------- [4]

Logically it's possible that we might try to release the mmap_sem twice
by having a scenario like:

        - task received SIGKILL,
        - task handled kernel mode page fault,
        - handle_mm_fault() returned with one of VM_FAULT_ERROR,

Then we'll go into path [1] to release the mmap_sem, however we won't
return immediately since user_mode(regs) check will fail (a kernel page
fault).  Then we might go into either [2]-[4] and either of them will
try to release the mmap_sem again.

To fix this, we only release the mmap_sem at [1] when we're sure we'll
quit immediately (after we checked with user_mode(regs)).

CC: Vineet Gupta <vgupta@synopsys.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Peter Xu <peterx@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Souptick Joarder <jrdr.linux@gmail.com>
CC: Andrea Arcangeli <aarcange@redhat.com>
CC: linux-snps-arc@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---

I noticed this only by reading the code.  Neither have I verified the
issue, nor have I tested the patch since I even don't know how to (I'm
totally unfamiliar with the arc architecture).  However I'm posting this
out first to see whether there's any quick feedback, and in case it's a
valid issue that we've ignored.
---
 arch/arc/mm/fault.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index c9da6102eb4f..2d28c3dad5c1 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -142,11 +142,10 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	fault = handle_mm_fault(vma, address, flags);
 
 	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
-	if (unlikely(fatal_signal_pending(current))) {
-		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
+	if (unlikely(fatal_signal_pending(current) && user_mode(regs))) {
+		if (!(fault & VM_FAULT_RETRY))
 			up_read(&mm->mmap_sem);
-		if (user_mode(regs))
-			return;
+		return;
 	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-- 
2.17.1

