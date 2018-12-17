Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44202133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbeLQSZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:25:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeLQSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:25:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIOmc12563266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:24:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIOm4A2563263;
        Mon, 17 Dec 2018 10:24:48 -0800
Date:   Mon, 17 Dec 2018 10:24:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-fe0937b24ff5d7b343b9922201e469f9a6009d9d@git.kernel.org>
Cc:     peterz@infradead.org, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, luto@kernel.org, riel@surriel.com,
        bp@alien8.de, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
          mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
          tglx@linutronix.de, luto@kernel.org
In-Reply-To: <20181203171043.559855600@infradead.org>
References: <20181203171043.559855600@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Fold cpa_flush_range() and
 cpa_flush_array() into a single cpa_flush() function
Git-Commit-ID: fe0937b24ff5d7b343b9922201e469f9a6009d9d
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

Commit-ID:  fe0937b24ff5d7b343b9922201e469f9a6009d9d
Gitweb:     https://git.kernel.org/tip/fe0937b24ff5d7b343b9922201e469f9a6009d9d
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:51 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:28 +0100

x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array() into a single cpa_flush() function

Note that the cache flush loop in cpa_flush_*() is identical when we
use __cpa_addr(); further observe that flush_tlb_kernel_range() is a
special case of to the cpa_flush_array() TLB invalidation code.

This then means the two functions are virtually identical. Fold these
two functions into a single cpa_flush() call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom.StDenis@amd.com
Cc: dave.hansen@intel.com
Link: http://lkml.kernel.org/r/20181203171043.559855600@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 92 ++++++++++----------------------------------------
 1 file changed, 18 insertions(+), 74 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 12b69263e501..85ef53b86fa0 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -304,51 +304,7 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static bool __inv_flush_all(int cache)
-{
-	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
-
-	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
-		cpa_flush_all(cache);
-		return true;
-	}
-
-	return false;
-}
-
-static void cpa_flush_range(unsigned long start, int numpages, int cache)
-{
-	unsigned int i, level;
-	unsigned long addr;
-
-	WARN_ON(PAGE_ALIGN(start) != start);
-
-	if (__inv_flush_all(cache))
-		return;
-
-	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
-
-	if (!cache)
-		return;
-
-	/*
-	 * We only need to flush on one CPU,
-	 * clflush is a MESI-coherent instruction that
-	 * will cause all other CPUs to flush the same
-	 * cachelines:
-	 */
-	for (i = 0, addr = start; i < numpages; i++, addr += PAGE_SIZE) {
-		pte_t *pte = lookup_address(addr, &level);
-
-		/*
-		 * Only flush present addresses:
-		 */
-		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range((void *) addr, PAGE_SIZE);
-	}
-}
-
-void __cpa_flush_array(void *data)
+void __cpa_flush_tlb(void *data)
 {
 	struct cpa_data *cpa = data;
 	unsigned int i;
@@ -357,33 +313,31 @@ void __cpa_flush_array(void *data)
 		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
 }
 
-static void cpa_flush_array(struct cpa_data *cpa, int cache)
+static void cpa_flush(struct cpa_data *data, int cache)
 {
+	struct cpa_data *cpa = data;
 	unsigned int i;
 
-	if (cpa_check_flush_all(cache))
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
+
+	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
 		return;
+	}
 
 	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_array, cpa, 1);
+		on_each_cpu(__cpa_flush_tlb, cpa, 1);
 	else
 		flush_tlb_all();
 
 	if (!cache)
 		return;
 
-	/*
-	 * We only need to flush on one CPU,
-	 * clflush is a MESI-coherent instruction that
-	 * will cause all other CPUs to flush the same
-	 * cachelines:
-	 */
 	for (i = 0; i < cpa->numpages; i++) {
 		unsigned long addr = __cpa_addr(cpa, i);
 		unsigned int level;
-		pte_t *pte;
 
-		pte = lookup_address(addr, &level);
+		pte_t *pte = lookup_address(addr, &level);
 
 		/*
 		 * Only flush present addresses:
@@ -1698,7 +1652,6 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 {
 	struct cpa_data cpa;
 	int ret, cache, checkalias;
-	unsigned long baddr = 0;
 
 	memset(&cpa, 0, sizeof(cpa));
 
@@ -1732,11 +1685,6 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 			 */
 			WARN_ON_ONCE(1);
 		}
-		/*
-		 * Save address for cache flush. *addr is modified in the call
-		 * to __change_page_attr_set_clr() below.
-		 */
-		baddr = make_addr_canonical_again(*addr);
 	}
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -1784,11 +1732,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 		goto out;
 	}
 
-	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY))
-		cpa_flush_array(&cpa, cache);
-	else
-		cpa_flush_range(baddr, numpages, cache);
-
+	cpa_flush(&cpa, cache);
 out:
 	return ret;
 }
@@ -2097,18 +2041,18 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush_range(addr, numpages, 1);
+	cpa_flush(&cpa, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
 	/*
-	 * After changing the encryption attribute, we need to flush TLBs
-	 * again in case any speculative TLB caching occurred (but no need
-	 * to flush caches again).  We could just use cpa_flush_all(), but
-	 * in case TLB flushing gets optimized in the cpa_flush_range()
-	 * path use the same logic as above.
+	 * After changing the encryption attribute, we need to flush TLBs again
+	 * in case any speculative TLB caching occurred (but no need to flush
+	 * caches again).  We could just use cpa_flush_all(), but in case TLB
+	 * flushing gets optimized in the cpa_flush() path use the same logic
+	 * as above.
 	 */
-	cpa_flush_range(addr, numpages, 0);
+	cpa_flush(&cpa, 0);
 
 	return ret;
 }
