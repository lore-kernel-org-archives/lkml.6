Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F943C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAB220C0B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAB220C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeHPXrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:47:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:64863 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbeHPXrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:47:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 13:47:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="77459450"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.132])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2018 13:47:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] x86/speculation/l1tf: Exempt zeroed PTEs from XOR conversion
Date:   Thu, 16 Aug 2018 13:46:38 -0700
Message-Id: <20180816204638.4046-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_page() does not undergo the XOR logic to invert the address
bits, i.e. PTE, PMD and PUD entries that have not been individually
written will have val=0 and so will trigger __pte_needs_invert().
As a result, {pte,pmd,pud}_pfn() will return the wrong PFN value,
i.e. all ones (adjusted by the max PFN mask) instead of zero.
A zeroed entry is ok because the page at physical address 0 is
reserved early in boot specifically to mitigate L1TF, so explicitly
exempt them from the inversion when reading the PFN.

Manifested as an unexpected mprotect(..., PROT_NONE) failure when
called on a VMA that has VM_PFNMAP and was mmap'd to as something
other than PROT_NONE but never used.  mprotect() sends the PROT_NONE
request down prot_none_walk(), which walks the PTEs to check the PFNs.
prot_none_pte_entry() gets the bogus PFN from pte_pfn() and returns
-EACCES because it thinks mprotect() is trying to adjust a high MMIO
address.

Fixes: 6b28baca9b1f ("x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/pgtable.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e4ffa565a69f..f21a1df4ca89 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -195,21 +195,24 @@ static inline u64 protnone_mask(u64 val);
 static inline unsigned long pte_pfn(pte_t pte)
 {
 	phys_addr_t pfn = pte_val(pte);
-	pfn ^= protnone_mask(pfn);
+	if (pfn)
+		pfn ^= protnone_mask(pfn);
 	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	phys_addr_t pfn = pmd_val(pmd);
-	pfn ^= protnone_mask(pfn);
+	if (pfn)
+		pfn ^= protnone_mask(pfn);
 	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	phys_addr_t pfn = pud_val(pud);
-	pfn ^= protnone_mask(pfn);
+	if (pfn)
+		pfn ^= protnone_mask(pfn);
 	return (pfn & pud_pfn_mask(pud)) >> PAGE_SHIFT;
 }
 
-- 
2.18.0

