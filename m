Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B1621708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B1621708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeI1BHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:07:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1BHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:07:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIkt1c129336
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:46:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIktDH129333;
        Thu, 27 Sep 2018 11:46:55 -0700
Date:   Thu, 27 Sep 2018 11:46:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-afd7969a99e072e6aa0d88511176d4d2f3009fd9@git.kernel.org>
Cc:     tglx@linutronix.de, mark.gross@intel.com, peterz@infradead.org,
        dave.hansen@intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bin.yang@intel.com
Reply-To: bin.yang@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
          peterz@infradead.org, mark.gross@intel.com, tglx@linutronix.de
In-Reply-To: <20180917143545.913005317@linutronix.de>
References: <20180917143545.913005317@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Rework static_protections()
Git-Commit-ID: afd7969a99e072e6aa0d88511176d4d2f3009fd9
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

Commit-ID:  afd7969a99e072e6aa0d88511176d4d2f3009fd9
Gitweb:     https://git.kernel.org/tip/afd7969a99e072e6aa0d88511176d4d2f3009fd9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:37 +0200

x86/mm/cpa: Rework static_protections()

static_protections() is pretty unreadable. Split it up into separate checks
for each protection area.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143545.913005317@linutronix.de

---
 arch/x86/mm/pageattr.c | 162 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 64 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 36f5d711ddbe..9731aeeebe71 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -286,84 +286,118 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 	}
 }
 
+#ifdef CONFIG_PCI_BIOS
 /*
- * Certain areas of memory on x86 require very specific protection flags,
- * for example the BIOS area or kernel text. Callers don't always get this
- * right (again, ioremap() on BIOS memory is not uncommon) so this function
- * checks and fixes these known static required protection bits.
+ * The BIOS area between 640k and 1Mb needs to be executable for PCI BIOS
+ * based config access (CONFIG_PCI_GOBIOS) support.
  */
-static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
-				   unsigned long pfn)
-{
-	pgprot_t forbidden = __pgprot(0);
+#define BIOS_PFN	PFN_DOWN(BIOS_BEGIN)
+#define BIOS_PFN_END	PFN_DOWN(BIOS_END)
 
-	/*
-	 * The BIOS area between 640k and 1Mb needs to be executable for
-	 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
-	 */
-#ifdef CONFIG_PCI_BIOS
-	if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
-		pgprot_val(forbidden) |= _PAGE_NX;
+static pgprotval_t protect_pci_bios(unsigned long pfn)
+{
+	if (pcibios_enabled && within(pfn, BIOS_PFN, BIOS_PFN_END))
+		return _PAGE_NX;
+	return 0;
+}
+#else
+static pgprotval_t protect_pci_bios(unsigned long pfn)
+{
+	return 0;
+}
 #endif
 
-	/*
-	 * The kernel text needs to be executable for obvious reasons
-	 * Does not cover __inittext since that is gone later on. On
-	 * 64bit we do not enforce !NX on the low mapping
-	 */
-	if (within(address, (unsigned long)_text, (unsigned long)_etext))
-		pgprot_val(forbidden) |= _PAGE_NX;
+/*
+ * The .rodata section needs to be read-only. Using the pfn catches all
+ * aliases.  This also includes __ro_after_init, so do not enforce until
+ * kernel_set_to_readonly is true.
+ */
+static pgprotval_t protect_rodata(unsigned long pfn)
+{
+	unsigned long start_pfn = __pa_symbol(__start_rodata) >> PAGE_SHIFT;
+	unsigned long end_pfn = __pa_symbol(__end_rodata) >> PAGE_SHIFT;
 
-	/*
-	 * The .rodata section needs to be read-only. Using the pfn
-	 * catches all aliases.  This also includes __ro_after_init,
-	 * so do not enforce until kernel_set_to_readonly is true.
-	 */
-	if (kernel_set_to_readonly &&
-	    within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
-		   __pa_symbol(__end_rodata) >> PAGE_SHIFT))
-		pgprot_val(forbidden) |= _PAGE_RW;
+	if (kernel_set_to_readonly && within(pfn, start_pfn, end_pfn))
+		return _PAGE_RW;
+	return 0;
+}
+
+/*
+ * Protect kernel text against becoming non executable by forbidding
+ * _PAGE_NX.  This protects only the high kernel mapping (_text -> _etext)
+ * out of which the kernel actually executes.  Do not protect the low
+ * mapping.
+ *
+ * This does not cover __inittext since that is gone after boot.
+ */
+static pgprotval_t protect_kernel_text(unsigned long address)
+{
+	if (within(address, (unsigned long)_text, (unsigned long)_etext))
+		return _PAGE_NX;
+	return 0;
+}
 
 #if defined(CONFIG_X86_64)
+/*
+ * Once the kernel maps the text as RO (kernel_set_to_readonly is set),
+ * kernel text mappings for the large page aligned text, rodata sections
+ * will be always read-only. For the kernel identity mappings covering the
+ * holes caused by this alignment can be anything that user asks.
+ *
+ * This will preserve the large page mappings for kernel text/data at no
+ * extra cost.
+ */
+static pgprotval_t protect_kernel_text_ro(unsigned long address)
+{
+	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long start = (unsigned long)_text;
+	unsigned int level;
+
+	if (!kernel_set_to_readonly || !within(address, start, end))
+		return 0;
 	/*
-	 * Once the kernel maps the text as RO (kernel_set_to_readonly is set),
-	 * kernel text mappings for the large page aligned text, rodata sections
-	 * will be always read-only. For the kernel identity mappings covering
-	 * the holes caused by this alignment can be anything that user asks.
+	 * Don't enforce the !RW mapping for the kernel text mapping, if
+	 * the current mapping is already using small page mapping.  No
+	 * need to work hard to preserve large page mappings in this case.
 	 *
-	 * This will preserve the large page mappings for kernel text/data
-	 * at no extra cost.
+	 * This also fixes the Linux Xen paravirt guest boot failure caused
+	 * by unexpected read-only mappings for kernel identity
+	 * mappings. In this paravirt guest case, the kernel text mapping
+	 * and the kernel identity mapping share the same page-table pages,
+	 * so the protections for kernel text and identity mappings have to
+	 * be the same.
 	 */
-	if (kernel_set_to_readonly &&
-	    within(address, (unsigned long)_text,
-		   (unsigned long)__end_rodata_hpage_align)) {
-		unsigned int level;
-
-		/*
-		 * Don't enforce the !RW mapping for the kernel text mapping,
-		 * if the current mapping is already using small page mapping.
-		 * No need to work hard to preserve large page mappings in this
-		 * case.
-		 *
-		 * This also fixes the Linux Xen paravirt guest boot failure
-		 * (because of unexpected read-only mappings for kernel identity
-		 * mappings). In this paravirt guest case, the kernel text
-		 * mapping and the kernel identity mapping share the same
-		 * page-table pages. Thus we can't really use different
-		 * protections for the kernel text and identity mappings. Also,
-		 * these shared mappings are made of small page mappings.
-		 * Thus this don't enforce !RW mapping for small page kernel
-		 * text mapping logic will help Linux Xen parvirt guest boot
-		 * as well.
-		 */
-		if (lookup_address(address, &level) && (level != PG_LEVEL_4K))
-			pgprot_val(forbidden) |= _PAGE_RW;
-	}
+	if (lookup_address(address, &level) && (level != PG_LEVEL_4K))
+		return _PAGE_RW;
+	return 0;
+}
+#else
+static pgprotval_t protect_kernel_text_ro(unsigned long address)
+{
+	return 0;
+}
 #endif
 
-	prot = __pgprot(pgprot_val(prot) & ~pgprot_val(forbidden));
+/*
+ * Certain areas of memory on x86 require very specific protection flags,
+ * for example the BIOS area or kernel text. Callers don't always get this
+ * right (again, ioremap() on BIOS memory is not uncommon) so this function
+ * checks and fixes these known static required protection bits.
+ */
+static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
+					  unsigned long pfn)
+{
+	pgprotval_t forbidden;
+
+	/* Operate on the virtual address */
+	forbidden  = protect_kernel_text(address);
+	forbidden |= protect_kernel_text_ro(address);
 
-	return prot;
+	/* Check the PFN directly */
+	forbidden |= protect_pci_bios(pfn);
+	forbidden |= protect_rodata(pfn);
+
+	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
 
 /*
