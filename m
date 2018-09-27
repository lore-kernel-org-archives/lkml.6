Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56560C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1456C216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1456C216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeI1BHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:07:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1BHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:07:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIlTl6129388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:47:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIlTMD129385;
        Thu, 27 Sep 2018 11:47:29 -0700
Date:   Thu, 27 Sep 2018 11:47:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-91ee8f5c1f50a1f4096c178a93a8da46ce3f6cc8@git.kernel.org>
Cc:     dave.hansen@intel.com, peterz@infradead.org, bin.yang@intel.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, mark.gross@intel.com
Reply-To: dave.hansen@intel.com, linux-kernel@vger.kernel.org,
          mark.gross@intel.com, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de, bin.yang@intel.com
In-Reply-To: <20180917143545.995734490@linutronix.de>
References: <20180917143545.995734490@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Allow range check for static protections
Git-Commit-ID: 91ee8f5c1f50a1f4096c178a93a8da46ce3f6cc8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  91ee8f5c1f50a1f4096c178a93a8da46ce3f6cc8
Gitweb:     https://git.kernel.org/tip/91ee8f5c1f50a1f4096c178a93a8da46ce3f6cc8
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:10 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:37 +0200

x86/mm/cpa: Allow range check for static protections

Checking static protections only page by page is slow especially for huge
pages. To allow quick checks over a complete range, add the ability to do
that.

Make the checks inclusive so the ranges can be directly used for debug output
later.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143545.995734490@linutronix.de

---
 arch/x86/mm/pageattr.c | 69 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 9731aeeebe71..61ff27848452 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -286,22 +286,29 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 	}
 }
 
+static bool overlaps(unsigned long r1_start, unsigned long r1_end,
+		     unsigned long r2_start, unsigned long r2_end)
+{
+	return (r1_start <= r2_end && r1_end >= r2_start) ||
+		(r2_start <= r1_end && r2_end >= r1_start);
+}
+
 #ifdef CONFIG_PCI_BIOS
 /*
  * The BIOS area between 640k and 1Mb needs to be executable for PCI BIOS
  * based config access (CONFIG_PCI_GOBIOS) support.
  */
 #define BIOS_PFN	PFN_DOWN(BIOS_BEGIN)
-#define BIOS_PFN_END	PFN_DOWN(BIOS_END)
+#define BIOS_PFN_END	PFN_DOWN(BIOS_END - 1)
 
-static pgprotval_t protect_pci_bios(unsigned long pfn)
+static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
 {
-	if (pcibios_enabled && within(pfn, BIOS_PFN, BIOS_PFN_END))
+	if (pcibios_enabled && overlaps(spfn, epfn, BIOS_PFN, BIOS_PFN_END))
 		return _PAGE_NX;
 	return 0;
 }
 #else
-static pgprotval_t protect_pci_bios(unsigned long pfn)
+static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
 {
 	return 0;
 }
@@ -312,12 +319,17 @@ static pgprotval_t protect_pci_bios(unsigned long pfn)
  * aliases.  This also includes __ro_after_init, so do not enforce until
  * kernel_set_to_readonly is true.
  */
-static pgprotval_t protect_rodata(unsigned long pfn)
+static pgprotval_t protect_rodata(unsigned long spfn, unsigned long epfn)
 {
-	unsigned long start_pfn = __pa_symbol(__start_rodata) >> PAGE_SHIFT;
-	unsigned long end_pfn = __pa_symbol(__end_rodata) >> PAGE_SHIFT;
+	unsigned long epfn_ro, spfn_ro = PFN_DOWN(__pa_symbol(__start_rodata));
+
+	/*
+	 * Note: __end_rodata is at page aligned and not inclusive, so
+	 * subtract 1 to get the last enforced PFN in the rodata area.
+	 */
+	epfn_ro = PFN_DOWN(__pa_symbol(__end_rodata)) - 1;
 
-	if (kernel_set_to_readonly && within(pfn, start_pfn, end_pfn))
+	if (kernel_set_to_readonly && overlaps(spfn, epfn, spfn_ro, epfn_ro))
 		return _PAGE_RW;
 	return 0;
 }
@@ -330,9 +342,12 @@ static pgprotval_t protect_rodata(unsigned long pfn)
  *
  * This does not cover __inittext since that is gone after boot.
  */
-static pgprotval_t protect_kernel_text(unsigned long address)
+static pgprotval_t protect_kernel_text(unsigned long start, unsigned long end)
 {
-	if (within(address, (unsigned long)_text, (unsigned long)_etext))
+	unsigned long t_end = (unsigned long)_etext - 1;
+	unsigned long t_start = (unsigned long)_text;
+
+	if (overlaps(start, end, t_start, t_end))
 		return _PAGE_NX;
 	return 0;
 }
@@ -347,13 +362,14 @@ static pgprotval_t protect_kernel_text(unsigned long address)
  * This will preserve the large page mappings for kernel text/data at no
  * extra cost.
  */
-static pgprotval_t protect_kernel_text_ro(unsigned long address)
+static pgprotval_t protect_kernel_text_ro(unsigned long start,
+					  unsigned long end)
 {
-	unsigned long end = (unsigned long)__end_rodata_hpage_align;
-	unsigned long start = (unsigned long)_text;
+	unsigned long t_end = (unsigned long)__end_rodata_hpage_align - 1;
+	unsigned long t_start = (unsigned long)_text;
 	unsigned int level;
 
-	if (!kernel_set_to_readonly || !within(address, start, end))
+	if (!kernel_set_to_readonly || !overlaps(start, end, t_start, t_end))
 		return 0;
 	/*
 	 * Don't enforce the !RW mapping for the kernel text mapping, if
@@ -367,12 +383,13 @@ static pgprotval_t protect_kernel_text_ro(unsigned long address)
 	 * so the protections for kernel text and identity mappings have to
 	 * be the same.
 	 */
-	if (lookup_address(address, &level) && (level != PG_LEVEL_4K))
+	if (lookup_address(start, &level) && (level != PG_LEVEL_4K))
 		return _PAGE_RW;
 	return 0;
 }
 #else
-static pgprotval_t protect_kernel_text_ro(unsigned long address)
+static pgprotval_t protect_kernel_text_ro(unsigned long start,
+					  unsigned long end)
 {
 	return 0;
 }
@@ -384,18 +401,20 @@ static pgprotval_t protect_kernel_text_ro(unsigned long address)
  * right (again, ioremap() on BIOS memory is not uncommon) so this function
  * checks and fixes these known static required protection bits.
  */
-static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
-					  unsigned long pfn)
+static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
+					  unsigned long pfn, unsigned long npg)
 {
 	pgprotval_t forbidden;
+	unsigned long end;
 
 	/* Operate on the virtual address */
-	forbidden  = protect_kernel_text(address);
-	forbidden |= protect_kernel_text_ro(address);
+	end = start + npg * PAGE_SIZE - 1;
+	forbidden  = protect_kernel_text(start, end);
+	forbidden |= protect_kernel_text_ro(start, end);
 
 	/* Check the PFN directly */
-	forbidden |= protect_pci_bios(pfn);
-	forbidden |= protect_rodata(pfn);
+	forbidden |= protect_pci_bios(pfn, pfn + npg - 1);
+	forbidden |= protect_rodata(pfn, pfn + npg - 1);
 
 	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
@@ -667,10 +686,10 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	 * in it results in a different pgprot than the first one of the
 	 * requested range. If yes, then the page needs to be split.
 	 */
-	new_prot = static_protections(req_prot, address, pfn);
+	new_prot = static_protections(req_prot, address, pfn, 1);
 	pfn = old_pfn;
 	for (i = 0, addr = lpaddr; i < numpages; i++, addr += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
+		pgprot_t chk_prot = static_protections(req_prot, addr, pfn, 1);
 
 		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
 			return 1;
@@ -1280,7 +1299,7 @@ repeat:
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
-		new_prot = static_protections(new_prot, address, pfn);
+		new_prot = static_protections(new_prot, address, pfn, 1);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
