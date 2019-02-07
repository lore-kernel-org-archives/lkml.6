Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F6A2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cWKXI3j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfBGKSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:18:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zsBJCjqzCHb+jAJAJgavx5TZ6nri+z4/DkXqLVivWkc=; b=cWKXI3j6GsF42yHcIj45metbB
        TotxBY+ejoQJ8LpzmWOaPoXnhuIO7zbgz57T+6DasIh3kgsuQjDuw2+++H+85+xvpfnMxp9e4Mm4q
        gY6rfeAiShhfInb07evKMSWQ292sdJ+3lLgfQ2Tu6c63OJ/K9s5D1H2H+Bmhs0Xc/69dfdXJij2AA
        9YsIpTTbaXoVvJgVfnbSutefwWAdxXvgJegE2Tr5fjkBu9HG/ksUvInYQwDDiaYy4ukteO/XFVaN0
        5o3jBCCZgLbrHnK000VjOZNXLuh9TzwxMya28ZwYeIrPtRiSbcwbMGRM32opVOdxKPnJLdaiR/fwf
        IZUHfYdQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grglb-0005qs-KX; Thu, 07 Feb 2019 10:18:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2281E201476F0; Thu,  7 Feb 2019 11:18:46 +0100 (CET)
Date:   Thu, 7 Feb 2019 11:18:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20190207101846.GB32511@hirez.programming.kicks-ass.net>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207001737.GA32096@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:42PM -0800, Luck, Tony wrote:

> fe0937b24ff5 ("x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array() into a single cpa_flush() function")

Boris pointed me at this gem:

  c7486104a5ce ("x86/mce: Fix set_mce_nospec() to avoid #GP fault")

(can I just revel at the pure awesome grossness of that)

But we then see my above commit having:

@@ -1732,11 +1685,6 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
			 */
			WARN_ON_ONCE(1);
		}
-               /*
-                * Save address for cache flush. *addr is modified in the call
-                * to __change_page_attr_set_clr() below.
-                */
-               baddr = make_addr_canonical_again(*addr);

Where I clearly got distracted by that excellent comment..


So now the question is where to put it back in, I'm thinking this might
want to be in __cpa_addr().

Something like so?

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4f8972311a77..319b767484fb 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -230,6 +230,28 @@ static bool __cpa_pfn_in_highmap(unsigned long pfn)
 
 #endif
 
+/*
+ * Machine check recovery code needs to change cache mode of poisoned
+ * pages to UC to avoid speculative access logging another error. But
+ * passing the address of the 1:1 mapping to set_memory_uc() is a fine
+ * way to encourage a speculative access. So we cheat and flip the top
+ * bit of the address. This works fine for the code that updates the
+ * page tables. But at the end of the process we need to flush the cache
+ * and the non-canonical address causes a #GP fault when used by the
+ * CLFLUSH instruction.
+ *
+ * But in the common case we already have a canonical address. This code
+ * will fix the top bit if needed and is a no-op otherwise.
+ */
+static inline unsigned long make_addr_canonical_again(unsigned long addr)
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
@@ -244,7 +266,7 @@ static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 	if (cpa->flags & CPA_ARRAY)
 		return cpa->vaddr[idx];
 
-	return *cpa->vaddr + idx * PAGE_SIZE;
+	return make_addr_canonical_again(*cpa->vaddr + idx * PAGE_SIZE);
 }
 
 /*
@@ -1627,29 +1649,6 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
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
