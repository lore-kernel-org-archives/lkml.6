Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3852520844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBHNhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:37:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:37:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x18DbF7n2188684
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 05:37:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x18DbFDd2188680;
        Fri, 8 Feb 2019 05:37:15 -0800
Date:   Fri, 8 Feb 2019 05:37:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-0521e8be211cd20d547bff9da2534b7ed6f2c1b9@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, luto@kernel.org, peterz@infradead.org,
        bp@alien8.de, hpa@zytor.com, tony.luck@intel.com,
        dave.hansen@linux.intel.com, mingo@kernel.org, tglx@linutronix.de,
        riel@surriel.com
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          dan.j.williams@intel.com, peterz@infradead.org, luto@kernel.org,
          bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          riel@surriel.com
In-Reply-To: <20190208120859.GH32511@hirez.programming.kicks-ass.net>
References: <20190208120859.GH32511@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/cpa: Fix set_mce_nospec()
Git-Commit-ID: 0521e8be211cd20d547bff9da2534b7ed6f2c1b9
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

Commit-ID:  0521e8be211cd20d547bff9da2534b7ed6f2c1b9
Gitweb:     https://git.kernel.org/tip/0521e8be211cd20d547bff9da2534b7ed6f2c1b9
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 8 Feb 2019 13:08:59 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 8 Feb 2019 14:31:56 +0100

x86/mm/cpa: Fix set_mce_nospec()

The recent commit fe0937b24ff5 ("x86/mm/cpa: Fold cpa_flush_range() and
cpa_flush_array() into a single cpa_flush() function") accidentally made
the call to make_addr_canonical_again() go away, which breaks
set_mce_nospec().

Re-instate the call to convert the address back into canonical form right
before invoking either CLFLUSH or INVLPG. Rename the function while at it
to be shorter (and less MAGA).

Fixes: fe0937b24ff5 ("x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array() into a single cpa_flush() function")
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lkml.kernel.org/r/20190208120859.GH32511@hirez.programming.kicks-ass.net
---
 arch/x86/mm/pageattr.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4f8972311a77..14e6119838a6 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -230,6 +230,29 @@ static bool __cpa_pfn_in_highmap(unsigned long pfn)
 
 #endif
 
+/*
+ * See set_mce_nospec().
+ *
+ * Machine check recovery code needs to change cache mode of poisoned pages to
+ * UC to avoid speculative access logging another error. But passing the
+ * address of the 1:1 mapping to set_memory_uc() is a fine way to encourage a
+ * speculative access. So we cheat and flip the top bit of the address. This
+ * works fine for the code that updates the page tables. But at the end of the
+ * process we need to flush the TLB and cache and the non-canonical address
+ * causes a #GP fault when used by the INVLPG and CLFLUSH instructions.
+ *
+ * But in the common case we already have a canonical address. This code
+ * will fix the top bit if needed and is a no-op otherwise.
+ */
+static inline unsigned long fix_addr(unsigned long addr)
+{
+#ifdef CONFIG_X86_64
+	return (long)(addr << 1) >> 1;
+#else
+	return addr;
+#endif
+}
+
 static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
 	if (cpa->flags & CPA_PAGES_ARRAY) {
@@ -313,7 +336,7 @@ void __cpa_flush_tlb(void *data)
 	unsigned int i;
 
 	for (i = 0; i < cpa->numpages; i++)
-		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
+		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
 static void cpa_flush(struct cpa_data *data, int cache)
@@ -347,7 +370,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 		 * Only flush present addresses:
 		 */
 		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range_opt((void *)addr, PAGE_SIZE);
+			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);
 	}
 	mb();
 }
@@ -1627,29 +1650,6 @@ out:
 	return ret;
 }
 
-/*
- * Machine check recovery code needs to change cache mode of poisoned
- * pages to UC to avoid speculative access logging another error. But
- * passing the address of the 1:1 mapping to set_memory_uc() is a fine
- * way to encourage a speculative access. So we cheat and flip the top
- * bit of the address. This works fine for the code that updates the
- * page tables. But at the end of the process we need to flush the cache
- * and the non-canonical address causes a #GP fault when used by the
- * CLFLUSH instruction.
- *
- * But in the common case we already have a canonical address. This code
- * will fix the top bit if needed and is a no-op otherwise.
- */
-static inline unsigned long make_addr_canonical_again(unsigned long addr)
-{
-#ifdef CONFIG_X86_64
-	return (long)(addr << 1) >> 1;
-#else
-	return addr;
-#endif
-}
-
-
 static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
 				    int force_split, int in_flag,
