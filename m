Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338902133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbeLQSYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:24:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388786AbeLQSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:23:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHINZc92561487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:23:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHINZio2561484;
        Mon, 17 Dec 2018 10:23:35 -0800
Date:   Mon, 17 Dec 2018 10:23:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-935f5839827ef54b53406e80906f7c355eb73c1b@git.kernel.org>
Cc:     peterz@infradead.org, bp@alien8.de, riel@surriel.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
          riel@surriel.com, peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, luto@kernel.org, hpa@zytor.com,
          dave.hansen@linux.intel.com
In-Reply-To: <20181203171043.430001980@infradead.org>
References: <20181203171043.430001980@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Optimize cpa_flush_array() TLB
 invalidation
Git-Commit-ID: 935f5839827ef54b53406e80906f7c355eb73c1b
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

Commit-ID:  935f5839827ef54b53406e80906f7c355eb73c1b
Gitweb:     https://git.kernel.org/tip/935f5839827ef54b53406e80906f7c355eb73c1b
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:49 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:26 +0100

x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation

Instead of punting and doing tlb_flush_all(), do the same as
flush_tlb_kernel_range() does and use single page invalidations.

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
Link: http://lkml.kernel.org/r/20181203171043.430001980@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/mm_internal.h |  2 ++
 arch/x86/mm/pageattr.c    | 42 ++++++++++++++++++++++++------------------
 arch/x86/mm/tlb.c         |  4 +++-
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 4e1f6e1b8159..319bde386d5f 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -19,4 +19,6 @@ extern int after_bootmem;
 
 void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
 
+extern unsigned long tlb_single_page_flush_ceiling;
+
 #endif	/* __X86_MM_INTERNAL_H */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index afa98b7b6050..351874259a71 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -26,6 +26,8 @@
 #include <asm/pat.h>
 #include <asm/set_memory.h>
 
+#include "mm_internal.h"
+
 /*
  * The current flushing context - we pass it instead of 5 arguments:
  */
@@ -346,16 +348,26 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	}
 }
 
-static void cpa_flush_array(unsigned long baddr, unsigned long *start,
-			    int numpages, int cache,
-			    int in_flags, struct page **pages)
+void __cpa_flush_array(void *data)
 {
-	unsigned int i, level;
+	struct cpa_data *cpa = data;
+	unsigned int i;
 
-	if (__inv_flush_all(cache))
+	for (i = 0; i < cpa->numpages; i++)
+		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
+}
+
+static void cpa_flush_array(struct cpa_data *cpa, int cache)
+{
+	unsigned int i;
+
+	if (cpa_check_flush_all(cache))
 		return;
 
-	flush_tlb_all();
+	if (cpa->numpages <= tlb_single_page_flush_ceiling)
+		on_each_cpu(__cpa_flush_array, cpa, 1);
+	else
+		flush_tlb_all();
 
 	if (!cache)
 		return;
@@ -366,15 +378,11 @@ static void cpa_flush_array(unsigned long baddr, unsigned long *start,
 	 * will cause all other CPUs to flush the same
 	 * cachelines:
 	 */
-	for (i = 0; i < numpages; i++) {
-		unsigned long addr;
+	for (i = 0; i < cpa->numpages; i++) {
+		unsigned long addr = __cpa_addr(cpa, i);
+		unsigned int level;
 		pte_t *pte;
 
-		if (in_flags & CPA_PAGES_ARRAY)
-			addr = (unsigned long)page_address(pages[i]);
-		else
-			addr = start[i];
-
 		pte = lookup_address(addr, &level);
 
 		/*
@@ -1771,12 +1779,10 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 		goto out;
 	}
 
-	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
-		cpa_flush_array(baddr, addr, numpages, cache,
-				cpa.flags, pages);
-	} else {
+	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY))
+		cpa_flush_array(&cpa, cache);
+	else
 		cpa_flush_range(baddr, numpages, cache);
-	}
 
 out:
 	return ret;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 03b6b4c2238d..999d6d8f0bef 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -15,6 +15,8 @@
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
+#include "mm_internal.h"
+
 /*
  *	TLB flushing, formerly SMP-only
  *		c/o Linus Torvalds.
@@ -721,7 +723,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
  *
  * This is in units of pages.
  */
-static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
