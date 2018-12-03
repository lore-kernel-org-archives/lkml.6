Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4364BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B09D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkpf0+jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B09D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeLCROq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeLCROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lZfTdGALJuhbqIWN4u19QBxprJyfCIvdoElqw4EpkuQ=; b=dkpf0+jQC0Bl9sZa6PDb2N6gYl
        j0s14fcQOTBegNZi7EEMK6A3vwxt+m/uERgEQ4rgy7Bv263umlGXerVN9EUFKCDYbP1/SIpRE2Ipp
        yHmdYcVfJasXXPp0lcCKKsgzAX7sWtMR2UZ/3tf3fQkNUHxjuG5fvEzJa8XJ/rbLBPgqKmRJiaTDY
        PljTzJouGl3eH26zmead8bl15radVoWm7TQ6Y/cuNIy7+Z0SEfBSFJgu3pcAE15Sl2YWD2GAq5jYq
        PIVBnIrLtvgVDYj31HGRWrPeuw+7WWur1N9pg6IBmdNRacqw61MdInXTssrO6whHTkdYQCzsVSpml
        735pe9uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrng-0001wx-HM; Mon, 03 Dec 2018 17:14:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0D84C2029F869; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.089868285@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] x86/mm/cpa: Fix cpa_flush_array() TLB invalidation
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit:

  a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")

I misread the cpa array code and incorrectly used
tlb_flush_kernel_range(), resulting in missing TLB flushes and
consequent failures.

Instead do a full invalidate in this case -- for now.

Fixes: a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")
Reported-by: "StDenis, Tom" <Tom.StDenis@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index bac35001d896..61bc7d1800d7 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,20 +285,16 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static bool __cpa_flush_range(unsigned long start, int numpages, int cache)
+static bool __inv_flush_all(int cache)
 {
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	WARN_ON(PAGE_ALIGN(start) != start);
-
 	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
 		return true;
 	}
 
-	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
-
-	return !cache;
+	return false;
 }
 
 static void cpa_flush_range(unsigned long start, int numpages, int cache)
@@ -306,7 +302,14 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	unsigned int i, level;
 	unsigned long addr;
 
-	if (__cpa_flush_range(start, numpages, cache))
+	WARN_ON(PAGE_ALIGN(start) != start);
+
+	if (__inv_flush_all(cache))
+		return;
+
+	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
+
+	if (!cache)
 		return;
 
 	/*
@@ -332,7 +335,12 @@ static void cpa_flush_array(unsigned long baddr, unsigned long *start,
 {
 	unsigned int i, level;
 
-	if (__cpa_flush_range(baddr, numpages, cache))
+	if (__inv_flush_all(cache))
+		return;
+
+	flush_tlb_all();
+
+	if (!cache)
 		return;
 
 	/*


