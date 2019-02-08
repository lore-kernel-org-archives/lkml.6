Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDF22177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DWVcxqd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfBHMJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:09:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=apFhCBtwuGg5WGyFdjFAuOs+eOGdX7+UzmNDhA3Bf+Y=; b=DWVcxqd1+1K3MHQ+3unvHjzzz
        IEyUlAh2KQXF/GtJ+llwVz4wT7qxXOwsUgq1VhWISDgr3fKpowYC34mJdSJeA++533r0CuKmaXoIQ
        CH9wSjKO4m0qQ46TeOzDmoY2ub0tXGnOi329IKAjd6tq46JOZrpkrSpb34CZ8MNEETItCqwz/g9B1
        q1OU7+XVybhkNhTxyBwGmsI1OHMBgXxDuVKvyMAgg5rlBEPqPsSJFFbCckYG9Kp0nrH/74MknhMDw
        NtVovFsYKPHiQzIM/4aJS3UI//NEMDQsPQmziv76gX2Kr/Jd71X9/Plo12xh8EGSkGGZ7yuklqAq/
        JUaIPL/ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs4xq-0006bC-Kc; Fri, 08 Feb 2019 12:09:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06D6A213E9B59; Fri,  8 Feb 2019 13:09:00 +0100 (CET)
Date:   Fri, 8 Feb 2019 13:08:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH] x86/mm/cpa: Fix set_mce_nospec()
Message-ID: <20190208120859.GH32511@hirez.programming.kicks-ass.net>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net>
 <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
 <20190207140131.GB32477@hirez.programming.kicks-ass.net>
 <20190207173600.GA15682@agluck-desk>
 <20190207175720.GE32511@hirez.programming.kicks-ass.net>
 <20190207184021.GA17049@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207184021.GA17049@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:40:21AM -0800, Luck, Tony wrote:

> Tried it out and it works!

Excellent, find below a proper patch!

---
Subject: x86/mm/cpa: Fix set_mce_nospec()

In commit:

 fe0937b24ff5 ("x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array()
                into a single cpa_flush() function")

I accidentally made the call to make_addr_canonical_again() go away,
this breaks set_mce_nospec().

Re-instate the call to convert the address back into canonical form
right before we do either CLFLUSH or INVLPG. Rename the function while
at it to be shorter (and less MAGA).

Reported-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Fixes: fe0937b24ff5 ("x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array() into a single cpa_flush() function")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
@@ -1627,29 +1650,6 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
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
