Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE55C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C2325879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C2325879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeFYMJC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:09:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:3873 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933755AbeFYMJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:09:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 05:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="51707594"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2018 05:08:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2F6D62DF; Mon, 25 Jun 2018 15:08:59 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] x86/efi: Fix efi_call_phys_epilog() with CONFIG_X86_5LEVEL=y
Date:   Mon, 25 Jun 2018 15:08:52 +0300
Message-Id: <20180625120852.18300-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open-coded page table entry checks don't work correctly when we fold the
page table level at runtime.

pgd_present() on 4-level paging machine always returns true, but
open-coded version of the check may return false-negative result and
we silently skip the rest of the loop body in efi_call_phys_epilog().

Replace open-coded checks with proper helpers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 94133e46a0f5 ("x86/efi: Correct EFI identity mapping under 'efi=old_map' when KASLR is enabled")
Cc: stable@vger.kernel.org # 4.12+
Cc: Baoquan He <bhe@redhat.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 arch/x86/platform/efi/efi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e01f7ceb9e7a..77873ce700ae 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -166,14 +166,14 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 		pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
 		set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
 
-		if (!(pgd_val(*pgd) & _PAGE_PRESENT))
+		if (!pgd_present(*pgd))
 			continue;
 
 		for (i = 0; i < PTRS_PER_P4D; i++) {
 			p4d = p4d_offset(pgd,
 					 pgd_idx * PGDIR_SIZE + i * P4D_SIZE);
 
-			if (!(p4d_val(*p4d) & _PAGE_PRESENT))
+			if (!p4d_present(*p4d))
 				continue;
 
 			pud = (pud_t *)p4d_page_vaddr(*p4d);
-- 
2.18.0

