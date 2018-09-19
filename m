Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D55ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D67F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EW+i4Ejj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D67F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeISOhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbeISOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W2wxdiGHOI1N5dNYO5MQi2f/CmLiHYtufW6bG+g1VSY=; b=EW+i4Ejj+xKnidHJikjglOl/nI
        RPiPcap98DjhuTw8/lgoTp2d+TPcucBLqMNgPaIiZLHNig8IC2/tU9l6++pzyVzxIQDHEulj6RlFD
        2CFAIBFQXISPnl0gun37f1f3BecSRA2hU3nZhTPaIdRCu+Rxzx7bYSXsrVDytCWbLRMnODW3jqZe0
        UCp7CeW+oknr7EiK24t+7wJ80CzZJKCzbVhoNq/emqMuO14xL9FTWN5SmOeyf6h/giA5kGhhaaMyH
        1CRjP52Lz6kObK/RA7yD2Hmv0gaEnYHOID0pe55NQZqJGYQurxcmSr60hu7EczxnVk9Ar0VJpGuTs
        tN/c3eQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLQ-0007cE-SW; Wed, 19 Sep 2018 09:00:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AA4522027331B; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085947.985193217@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 4/8] x86/mm/cpa: Use flush_tlb_kernel_range()
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both cpa_flush_range() and cpa_flush_array() have a well specified
range, use that to do a range based TLB invalidate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -293,7 +293,7 @@ static void cpa_flush_range(unsigned lon
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	flush_tlb_all();
+	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
 
 	if (!cache)
 		return;
@@ -315,14 +315,15 @@ static void cpa_flush_range(unsigned lon
 	}
 }
 
-static void cpa_flush_array(unsigned long *start, int numpages, int cache,
+static void cpa_flush_array(unsigned long baddr, unsigned long *start,
+			    int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	flush_tlb_all();
+	flush_tlb_kernel_range(baddr, baddr + PAGE_SIZE * numpages);
 
 	if (!cache)
 		return;
@@ -1754,7 +1755,7 @@ static int change_page_attr_set_clr(unsi
 	 */
 	if (!ret && boot_cpu_has(X86_FEATURE_CLFLUSH)) {
 		if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
-			cpa_flush_array(addr, numpages, cache,
+			cpa_flush_array(baddr, addr, numpages, cache,
 					cpa.flags, pages);
 		} else
 			cpa_flush_range(baddr, numpages, cache);


