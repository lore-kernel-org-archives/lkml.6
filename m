Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA66ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F62151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BucPnQWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2F62151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeISOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeISOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CeX0+Mc1uzJ/cb3A7PmHzNYzsLFC0QiOoIhYEUrTetI=; b=BucPnQWXAN6vY1OLX3s+IhanfL
        Q1gFp8bJfW6krqY5UlqgKi5d7YIypDZmy2yH0SQCH3+3RFduMWLU58WdkHf8tKyzC2r3PPjR5Tz2F
        xUOvhhr5VwZZyrY/ezFpb68P4LZA0aDe6UigZOt06z4bQHqkyZuze4QJvxobcCb/vHNFYCviXWtCG
        KCjy8K8V+849vu8cAP/BNOdK2j0dhNZmGG5EmHaTl0Tm70PUQDFY0XJPM6rSv78Hc7cJedhp8aox/
        0ErpXyaITT8kpddFzyeb7bWUikQc/JgpXFKaBB2P9BM9BmGl6/uSCQf/tbChtOrD8d86U/gZqMWT+
        ZwuB8n3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLQ-0007cD-SW; Wed, 19 Sep 2018 09:00:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9C877202C1A3C; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085947.831102058@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 1/8] x86/mm/cpa: Use flush_tlb_all()
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coding it..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,16 +285,6 @@ static void cpa_flush_all(unsigned long
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static void __cpa_flush_range(void *arg)
-{
-	/*
-	 * We could optimize that further and do individual per page
-	 * tlb invalidates for a low number of pages. Caveat: we must
-	 * flush the high aliases on 64bit as well.
-	 */
-	__flush_tlb_all();
-}
-
 static void cpa_flush_range(unsigned long start, int numpages, int cache)
 {
 	unsigned int i, level;
@@ -303,7 +293,7 @@ static void cpa_flush_range(unsigned lon
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	on_each_cpu(__cpa_flush_range, NULL, 1);
+	flush_tlb_all();
 
 	if (!cache)
 		return;


