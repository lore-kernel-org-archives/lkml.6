Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC59C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D2421738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D2421738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbeHNUgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:36:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390875AbeHNUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:36:17 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 523C0C74;
        Tue, 14 Aug 2018 17:48:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <JBeulich@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 38/43] x86/speculation/l1tf: Fix up pte->pfn conversion for PAE
Date:   Tue, 14 Aug 2018 19:18:14 +0200
Message-Id: <20180814171519.579666720@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.cz>

commit e14d7dfb41f5807a0c1c26a13f2b8ef16af24935 upstream

Jan has noticed that pte_pfn and co. resp. pfn_pte are incorrect for
CONFIG_PAE because phys_addr_t is wider than unsigned long and so the
pte_val reps. shift left would get truncated. Fix this up by using proper
types.

[dwmw2: Backport to 4.9]

Fixes: 6b28baca9b1f ("x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation")
Reported-by: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/pgtable.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -154,21 +154,21 @@ static inline u64 protnone_mask(u64 val)
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	unsigned long pfn = pte_val(pte);
+	phys_addr_t pfn = pte_val(pte);
 	pfn ^= protnone_mask(pfn);
 	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
-	unsigned long pfn = pmd_val(pmd);
+	phys_addr_t pfn = pmd_val(pmd);
 	pfn ^= protnone_mask(pfn);
 	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pud_pfn(pud_t pud)
 {
-	unsigned long pfn = pud_val(pud);
+	phys_addr_t pfn = pud_val(pud);
 	pfn ^= protnone_mask(pfn);
 	return (pfn & pud_pfn_mask(pud)) >> PAGE_SHIFT;
 }
@@ -369,7 +369,7 @@ static inline pgprotval_t massage_pgprot
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PTE_PFN_MASK;
 	return __pte(pfn | massage_pgprot(pgprot));
@@ -377,7 +377,7 @@ static inline pte_t pfn_pte(unsigned lon
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PHYSICAL_PMD_PAGE_MASK;
 	return __pmd(pfn | massage_pgprot(pgprot));


