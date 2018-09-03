Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EA7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEED2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEED2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbeICVlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:41:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbeICVkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:40:13 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 69392D10;
        Mon,  3 Sep 2018 17:19:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 073/165] mm: delete historical BUG from zap_pmd_range()
Date:   Mon,  3 Sep 2018 18:55:59 +0200
Message-Id: <20180903165658.757763061@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: Hugh Dickins <hughd@google.com>

[ Upstream commit 53406ed1bcfdabe4b5bc35e6d17946c6f9f563e2 ]

Delete the old VM_BUG_ON_VMA() from zap_pmd_range(), which asserted
that mmap_sem must be held when splitting an "anonymous" vma there.
Whether that's still strictly true nowadays is not entirely clear,
but the danger of sometimes crashing on the BUG is now fairly clear.

Even with the new stricter rules for anonymous vma marking, the
condition it checks for can possible trigger. Commit 44960f2a7b63
("staging: ashmem: Fix SIGBUS crash when traversing mmaped ashmem
pages") is good, and originally I thought it was safe from that
VM_BUG_ON_VMA(), because the /dev/ashmem fd exposed to the user is
disconnected from the vm_file in the vma, and madvise(,,MADV_REMOVE)
insists on VM_SHARED.

But after I read John's earlier mail, drawing attention to the
vfs_fallocate() in there: I may be wrong, and I don't know if Android
has THP in the config anyway, but it looks to me like an
unmap_mapping_range() from ashmem's vfs_fallocate() could hit precisely
the VM_BUG_ON_VMA(), once it's vma_is_anonymous().

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1417,11 +1417,9 @@ static inline unsigned long zap_pmd_rang
 	do {
 		next = pmd_addr_end(addr, end);
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
-				VM_BUG_ON_VMA(vma_is_anonymous(vma) &&
-				    !rwsem_is_locked(&tlb->mm->mmap_sem), vma);
+			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
-			} else if (zap_huge_pmd(tlb, vma, pmd, addr))
+			else if (zap_huge_pmd(tlb, vma, pmd, addr))
 				goto next;
 			/* fall through */
 		}


