Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B95ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F380021508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v2zt92aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F380021508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeISOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeISOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ZPVQ0z1vyyChYAsxGTS4wJMVuY5Y79QrDuo5PiLFxs=; b=v2zt92aChYJmYlNLmiPx+4fDtk
        3G/PQUOOzAUEKgslwI7PT+F2uPp0xZxlPHDwYIIEik5HbvuK4hORk3YFB1DmtXAHDa5h5J9ty9Hvb
        7f3yC5DcouiFP/veS1cmdvVTJ3PSZ+C1vd/iGqILunC1DDWevZTIHsJmzr2Jy3xptZAOggDt69h+p
        1q2hLF7qzl6W1Hdk2Yut65OnXk3ec5q16o5l7/EFQ7aYYHVtx7zjamS09YI3ddfVlb3sVPGXnAK8L
        N3JuHu2N4BR3hM5e3JkP/9bAorFrkKLoFrqYf4AYoUSYo04KcD0PER+5JqSqLtIN5o93cbP1Vvg1b
        YoX7AYzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLS-0000pV-C4; Wed, 19 Sep 2018 09:00:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B8729202EDA24; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085948.138859183@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 7/8] x86/mm/cpa: Factor common code between cpa_flush_*()
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The start of cpa_flush_range() and cpa_flush_array() is the same, use
a common function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,22 +285,28 @@ static void cpa_flush_all(unsigned long
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static void cpa_flush_range(unsigned long start, int numpages, int cache)
+static bool __cpa_flush_range(unsigned long start, int numpages, int cache)
 {
-	unsigned int i, level;
-	unsigned long addr;
-
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
+
 	WARN_ON(PAGE_ALIGN(start) != start);
 
 	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
-		return;
+		return true;
 	}
 
 	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
 
-	if (!cache)
+	return !cache;
+}
+
+static void cpa_flush_range(unsigned long start, int numpages, int cache)
+{
+	unsigned int i, level;
+	unsigned long addr;
+
+	if (__cpa_flush_range(start, numpages, cache))
 		return;
 
 	/*
@@ -326,16 +332,7 @@ static void cpa_flush_array(unsigned lon
 {
 	unsigned int i, level;
 
-	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
-
-	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
-		cpa_flush_all(cache);
-		return;
-	}
-
-	flush_tlb_kernel_range(baddr, baddr + PAGE_SIZE * numpages);
-
-	if (!cache)
+	if (__cpa_flush_range(baddr, numpages, cache))
 		return;
 
 	/*


