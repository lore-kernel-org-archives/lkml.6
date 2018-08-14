Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA56721471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA56721471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbeHNUdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:33:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390369AbeHNUdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:33:11 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96AFFC9A;
        Tue, 14 Aug 2018 17:44:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 103/107] x86/mm/pat: Make set_memory_np() L1TF safe
Date:   Tue, 14 Aug 2018 19:18:06 +0200
Message-Id: <20180814171526.962135815@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream

set_memory_np() is used to mark kernel mappings not present, but it has
it's own open coded mechanism which does not have the L1TF protection of
inverting the address bits.

Replace the open coded PTE manipulation with the L1TF protecting low level
PTE routines.

Passes the CPA self test.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ dwmw2: Pull in pud_mkhuge() from commit a00cc7d9dd, and pfn_pud() ]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/pgtable.h |   27 +++++++++++++++++++++++++++
 arch/x86/mm/pageattr.c         |    8 ++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -413,12 +413,39 @@ static inline pmd_t pfn_pmd(unsigned lon
 	return __pmd(pfn | massage_pgprot(pgprot));
 }
 
+static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
+{
+	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	pfn ^= protnone_mask(pgprot_val(pgprot));
+	pfn &= PHYSICAL_PUD_PAGE_MASK;
+	return __pud(pfn | massage_pgprot(pgprot));
+}
+
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
 	return pfn_pmd(pmd_pfn(pmd),
 		       __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
+static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
+{
+	pudval_t v = native_pud_val(pud);
+
+	return __pud(v | set);
+}
+
+static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
+{
+	pudval_t v = native_pud_val(pud);
+
+	return __pud(v & ~clear);
+}
+
+static inline pud_t pud_mkhuge(pud_t pud)
+{
+	return pud_set_flags(pud, _PAGE_PSE);
+}
+
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1001,8 +1001,8 @@ static long populate_pmd(struct cpa_data
 
 		pmd = pmd_offset(pud, start);
 
-		set_pmd(pmd, __pmd(cpa->pfn << PAGE_SHIFT | _PAGE_PSE |
-				   massage_pgprot(pmd_pgprot)));
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
+					canon_pgprot(pmd_pgprot))));
 
 		start	  += PMD_SIZE;
 		cpa->pfn  += PMD_SIZE >> PAGE_SHIFT;
@@ -1074,8 +1074,8 @@ static long populate_pud(struct cpa_data
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
 	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
-		set_pud(pud, __pud(cpa->pfn << PAGE_SHIFT | _PAGE_PSE |
-				   massage_pgprot(pud_pgprot)));
+		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+				   canon_pgprot(pud_pgprot))));
 
 		start	  += PUD_SIZE;
 		cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;


