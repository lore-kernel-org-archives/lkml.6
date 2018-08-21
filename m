Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C76C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E8121765
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E8121765
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeHUEei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:34:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:17761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeHUEei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:34:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 18:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="74359148"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 18:16:40 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com, bin.yang@intel.com
Subject: [PATCH v3 4/5] x86/mm: optimize static_protection() by using overlap()
Date:   Tue, 21 Aug 2018 01:16:25 +0000
Message-Id: <1534814186-37067-5-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing a 4K page attr inside the large page range,
try_preserve_large_page() will call static_protections() to check all
4K pages inside the large page range.

In the worst case, when changing a 4K page attr inside 1G large page
range, static_protections() will be called for 262144 times for single
4K page check.

It can be optimized to check for overlapping ranges instead of looping
all pages. If the checking range has overlap with a specific protection
area, it should add the corresponding protection flag.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Shevchenko, Andriy <andriy.shevchenko@intel.com>
Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 arch/x86/mm/pageattr.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index f630eb4..fd90c5b 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -106,6 +106,21 @@ within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
 	return addr >= start && addr <= end;
 }
 
+static inline bool
+overlap(unsigned long start1, unsigned long end1,
+		unsigned long start2, unsigned long end2)
+{
+	/* Is 'start2' within area 1? */
+	if (start1 <= start2 && end1 > start2)
+		return true;
+
+	/* Is 'start1' within area 2? */
+	if (start2 <= start1 && end2 > start1)
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_X86_64
 
 static inline unsigned long highmap_start_pfn(void)
@@ -293,7 +308,7 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
  * checks and fixes these known static required protection bits.
  */
 static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
-				   unsigned long pfn)
+				   unsigned long len, unsigned long pfn)
 {
 	pgprot_t forbidden = __pgprot(0);
 
@@ -302,7 +317,9 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 	 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
 	 */
 #ifdef CONFIG_PCI_BIOS
-	if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
+	if (pcibios_enabled &&
+	    overlap(pfn, pfn + PFN_DOWN(len),
+		    PFN_DOWN(BIOS_BEGIN), PFN_DOWN(BIOS_END)))
 		pgprot_val(forbidden) |= _PAGE_NX;
 #endif
 
@@ -311,7 +328,8 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 	 * Does not cover __inittext since that is gone later on. On
 	 * 64bit we do not enforce !NX on the low mapping
 	 */
-	if (within(address, (unsigned long)_text, (unsigned long)_etext))
+	if (overlap(address, address + len,
+		    (unsigned long)_text, (unsigned long)_etext))
 		pgprot_val(forbidden) |= _PAGE_NX;
 
 	/*
@@ -320,8 +338,9 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 	 * so do not enforce until kernel_set_to_readonly is true.
 	 */
 	if (kernel_set_to_readonly &&
-	    within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
-		   __pa_symbol(__end_rodata) >> PAGE_SHIFT))
+	    overlap(pfn, pfn + PFN_DOWN(len),
+		    PFN_DOWN(__pa_symbol(__start_rodata)),
+		    PFN_DOWN(__pa_symbol(__end_rodata))))
 		pgprot_val(forbidden) |= _PAGE_RW;
 
 #if defined(CONFIG_X86_64)
@@ -335,8 +354,8 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 	 * at no extra cost.
 	 */
 	if (kernel_set_to_readonly &&
-	    within(address, (unsigned long)_text,
-		   (unsigned long)__end_rodata_hpage_align)) {
+	    overlap(address, address + len, (unsigned long)_text,
+		    (unsigned long)__end_rodata_hpage_align)) {
 		unsigned int level;
 
 		/*
@@ -375,19 +394,14 @@ static inline bool
 needs_static_protections(pgprot_t prot, unsigned long address,
 		unsigned long len, unsigned long pfn)
 {
-	int i;
+	pgprot_t chk_prot;
 
 	address &= PAGE_MASK;
 	len = PFN_ALIGN(len);
-	for (i = 0; i < (len >> PAGE_SHIFT); i++, address += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(prot, address, pfn);
-
-		if (pgprot_val(chk_prot) != pgprot_val(prot))
-			return true;
-	}
+	chk_prot = static_protections(prot, address, len, pfn);
 
 	/* Does static_protections() demand a change ? */
-	return false;
+	return pgprot_val(chk_prot) != pgprot_val(prot);
 }
 
 /*
@@ -650,7 +664,8 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	pfn = old_pfn + ((address & (psize - 1)) >> PAGE_SHIFT);
 	cpa->pfn = pfn;
 
-	new_prot = static_protections(req_prot, address, pfn);
+	new_prot = static_protections(req_prot, address,
+				      numpages << PAGE_SHIFT, pfn);
 
 	/*
 	 * The static_protections() is used to check specific protection flags
@@ -1270,7 +1285,8 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
-		new_prot = static_protections(new_prot, address, pfn);
+		new_prot = static_protections(new_prot, address, PAGE_SIZE,
+					      pfn);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
-- 
2.7.4

