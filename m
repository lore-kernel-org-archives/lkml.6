Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CE3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB7E20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB7E20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbeGJSdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387961AbeGJSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4749DE6B;
        Tue, 10 Jul 2018 18:33:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 35/53] mm: hwpoison: disable memory error handling on 1GB hugepage
Date:   Tue, 10 Jul 2018 20:25:11 +0200
Message-Id: <20180710182500.819612094@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
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

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

commit 31286a8484a85e8b4e91ddb0f5415aee8a416827 upstream.

Recently the following BUG was reported:

    Injecting memory failure for pfn 0x3c0000 at process virtual address 0x7fe300000000
    Memory failure: 0x3c0000: recovery action for huge page: Recovered
    BUG: unable to handle kernel paging request at ffff8dfcc0003000
    IP: gup_pgd_range+0x1f0/0xc20
    PGD 17ae72067 P4D 17ae72067 PUD 0
    Oops: 0000 [#1] SMP PTI
    ...
    CPU: 3 PID: 5467 Comm: hugetlb_1gb Not tainted 4.15.0-rc8-mm1-abc+ #3
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014

You can easily reproduce this by calling madvise(MADV_HWPOISON) twice on
a 1GB hugepage.  This happens because get_user_pages_fast() is not aware
of a migration entry on pud that was created in the 1st madvise() event.

I think that conversion to pud-aligned migration entry is working, but
other MM code walking over page table isn't prepared for it.  We need
some time and effort to make all this work properly, so this patch
avoids the reported bug by just disabling error handling for 1GB
hugepage.

[n-horiguchi@ah.jp.nec.com: v2]
  Link: http://lkml.kernel.org/r/1517284444-18149-1-git-send-email-n-horiguchi@ah.jp.nec.com
Link: http://lkml.kernel.org/r/1517207283-15769-1-git-send-email-n-horiguchi@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h  |    1 +
 mm/memory-failure.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2549,6 +2549,7 @@ enum mf_action_page_type {
 	MF_MSG_POISONED_HUGE,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
+	MF_MSG_NON_PMD_HUGE,
 	MF_MSG_UNMAP_FAILED,
 	MF_MSG_DIRTY_SWAPCACHE,
 	MF_MSG_CLEAN_SWAPCACHE,
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -508,6 +508,7 @@ static const char * const action_page_ty
 	[MF_MSG_POISONED_HUGE]		= "huge page already hardware poisoned",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
+	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
 	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
 	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
 	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
@@ -1090,6 +1091,21 @@ static int memory_failure_hugetlb(unsign
 		return 0;
 	}
 
+	/*
+	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
+	 * simply disable it. In order to make it work properly, we need
+	 * make sure that:
+	 *  - conversion of a pud that maps an error hugetlb into hwpoison
+	 *    entry properly works, and
+	 *  - other mm code walking over page table is aware of pud-aligned
+	 *    hwpoison entries.
+	 */
+	if (huge_page_size(page_hstate(head)) > PMD_SIZE) {
+		action_result(pfn, MF_MSG_NON_PMD_HUGE, MF_IGNORED);
+		res = -EBUSY;
+		goto out;
+	}
+
 	if (!hwpoison_user_mappings(p, pfn, trapno, flags, &head)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;


