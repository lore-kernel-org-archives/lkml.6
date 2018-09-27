Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584BEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D92C216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D92C216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeI1BIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:08:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1BIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:08:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIm12g129480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:48:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIm16Y129477;
        Thu, 27 Sep 2018 11:48:01 -0700
Date:   Thu, 27 Sep 2018 11:48:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4046460b867f8b041c81c26c09d3bcad6d6e814e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, mark.gross@intel.com, bin.yang@intel.com,
        tglx@linutronix.de, hpa@zytor.com, dave.hansen@intel.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, mark.gross@intel.com, bin.yang@intel.com,
          tglx@linutronix.de, hpa@zytor.com, dave.hansen@intel.com
In-Reply-To: <20180917143546.078998733@linutronix.de>
References: <20180917143546.078998733@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Add debug mechanism
Git-Commit-ID: 4046460b867f8b041c81c26c09d3bcad6d6e814e
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

Commit-ID:  4046460b867f8b041c81c26c09d3bcad6d6e814e
Gitweb:     https://git.kernel.org/tip/4046460b867f8b041c81c26c09d3bcad6d6e814e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:38 +0200

x86/mm/cpa: Add debug mechanism

The whole static protection magic is silently fixing up anything which is
handed in. That's just wrong. The offending call sites need to be fixed.

Add a debug mechanism which emits a warning if a requested mapping needs to be
fixed up. The DETECT debug mechanism is really not meant to be enabled except
for developers, so limit the output hard to the protection fixups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143546.078998733@linutronix.de

---
 arch/x86/mm/pageattr.c | 61 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 61ff27848452..1f2519055b30 100644
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
@@ -395,6 +402,28 @@ static pgprotval_t protect_kernel_text_ro(unsigned long start,
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
+	pr_warn("CPA %8s %10s: 0x%016lx - 0x%016lx PFN %lx req %016llx prevent %016llx\n",
+		lvltxt[warnlvl], txt, start, end, pfn, (unsigned long long)pgprot_val(prot),
+		(unsigned long long)val);
+}
+
 /*
  * Certain areas of memory on x86 require very specific protection flags,
  * for example the BIOS area or kernel text. Callers don't always get this
@@ -402,19 +431,31 @@ static pgprotval_t protect_kernel_text_ro(unsigned long start,
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
@@ -686,10 +727,11 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
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
@@ -1299,7 +1341,8 @@ repeat:
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
-		new_prot = static_protections(new_prot, address, pfn, 1);
+		new_prot = static_protections(new_prot, address, pfn, 1,
+					      CPA_PROTECT);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
