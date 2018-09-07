Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503B0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1645920876
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1645920876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeIGUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:24:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36654 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbeIGUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIuq-00055i-VC; Fri, 07 Sep 2018 17:43:25 +0200
Message-Id: <20180907152054.735423242@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 04/10] x86/mm/cpa: Add debug mechanism
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-mm-cpa--Add-proper-debug-output.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole static protection magic is silently fixing up anything which is
handed in. That's just wrong. The offending call sites need to be fixed.

Add a debug mechanism which emits a warning if a requested mapping needs to be
fixed up. The DETECT debug mechanism is really not meant to be enabled except
for developers, so limit the output hard to the protection fixups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |   60 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 9 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -42,6 +42,13 @@ struct cpa_data {
 	struct page	**pages;
 };
 
+enum cpa_warn {
+	CPA_PROTECT,
+	CPA_DETECT,
+};
+
+static const int cpa_warn_level = CPA_PROTECT;
+
 /*
  * Serialize cpa() (for !DEBUG_PAGEALLOC which uses large identity mappings)
  * using cpa_lock. So that we don't allow any other cpu, with stale large tlb
@@ -392,6 +399,27 @@ static pgprotval_t protect_kernel_text_r
 }
 #endif
 
+static inline bool conflicts(pgprot_t prot, pgprotval_t val)
+{
+	return (pgprot_val(prot) & ~val) != pgprot_val(prot);
+}
+
+static inline void check_conflict(int warnlvl, pgprot_t prot, pgprotval_t val,
+				  unsigned long start, unsigned long end,
+				  unsigned long pfn, const char *txt)
+{
+	static const char *lvltxt[] = {
+		[CPA_PROTECT]	= "protect",
+		[CPA_DETECT]	= "detect",
+	};
+
+	if (warnlvl > cpa_warn_level || !conflicts(prot, val))
+		return;
+
+	pr_warn("CPA %8s %10s: 0x%016lx - 0x%016lx PFN %lx req %016lx prevent %016lx\n",
+		lvltxt[warnlvl], txt, start, end, pfn, pgprot_val(prot), val);
+}
+
 /*
  * Certain areas of memory on x86 require very specific protection flags,
  * for example the BIOS area or kernel text. Callers don't always get this
@@ -399,19 +427,31 @@ static pgprotval_t protect_kernel_text_r
  * checks and fixes these known static required protection bits.
  */
 static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
-					  unsigned long pfn, unsigned long npg)
+					  unsigned long pfn, unsigned long npg,
+					  int warnlvl)
 {
-	pgprotval_t forbidden;
+	pgprotval_t forbidden, res;
 	unsigned long end;
 
 	/* Operate on the virtual address */
 	end = start + npg * PAGE_SIZE - 1;
-	forbidden  = protect_kernel_text(start, end);
-	forbidden |= protect_kernel_text_ro(start, end);
+
+	res = protect_kernel_text(start, end);
+	check_conflict(warnlvl, prot, res, start, end, pfn, "Text NX");
+	forbidden = res;
+
+	res = protect_kernel_text_ro(start, end);
+	check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
+	forbidden |= res;
 
 	/* Check the PFN directly */
-	forbidden |= protect_pci_bios(pfn, pfn + npg - 1);
-	forbidden |= protect_rodata(pfn, pfn + npg - 1);
+	res = protect_pci_bios(pfn, pfn + npg - 1);
+	check_conflict(warnlvl, prot, res, start, end, pfn, "PCIBIOS NX");
+	forbidden |= res;
+
+	res = protect_rodata(pfn, pfn + npg - 1);
+	check_conflict(warnlvl, prot, res, start, end, pfn, "Rodata RO");
+	forbidden |= res;
 
 	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
@@ -683,10 +723,11 @@ static int __should_split_large_page(pte
 	 * in it results in a different pgprot than the first one of the
 	 * requested range. If yes, then the page needs to be split.
 	 */
-	new_prot = static_protections(req_prot, address, pfn, 1);
+	new_prot = static_protections(req_prot, address, pfn, 1, CPA_DETECT);
 	pfn = old_pfn;
 	for (i = 0, addr = lpaddr; i < numpages; i++, addr += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(req_prot, addr, pfn, 1);
+		pgprot_t chk_prot = static_protections(req_prot, addr, pfn, 1,
+						       CPA_DETECT);
 
 		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
 			return 1;
@@ -1296,7 +1337,8 @@ static int __change_page_attr(struct cpa
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
-		new_prot = static_protections(new_prot, address, pfn, 1);
+		new_prot = static_protections(new_prot, address, pfn, 1,
+					      CPA_PROTECT);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 


