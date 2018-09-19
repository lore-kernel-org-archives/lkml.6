Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2B3ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A967F21508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RbzjKzlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A967F21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbeISOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeISOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=//W/vnsAmMCJpNThzi/9d2H/YLoI3/7b0AZIciqMgOs=; b=RbzjKzlOI3taauxz/ZwPNh8C8u
        2A8F1gGdo5AhLvZfnVsnf+6A5dyimVPdzKuznFHApxtPe68hoa/efPTILCdHq3mwY+SvgipNRG6Q1
        JNpFfXZcdhkUEgFjfoEFqZjou5Ml0BF96sIbtv5kRCxq5vDo74xQIY7RkwcvYK2hHOlRyuYolXMJz
        8sP8IzdhqeUBFV1IY1D0Y8VB3PwMocFddRJxh4rY1B9XvzQr02ZxAdY6F10xgBbWJ0R4i+FVGNXNx
        nfLiqz/P9XdTo1i8RwapCJ30+jJKkquVBNsZ2bmhM1/MMRnABrKFgfMJVdPvYEdVWdc8NVjKq+nLk
        yMkQS0rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLS-0000pW-Ck; Wed, 19 Sep 2018 09:00:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF10920268261; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085948.036195503@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 5/8] x86/mm/cpa: Move CLFLUSH test into cpa_flush_range()
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than guarding all cpa_flush_range() uses with a CLFLUSH test,
put it inside.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -293,6 +293,11 @@ static void cpa_flush_range(unsigned lon
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
+	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
+		return;
+	}
+
 	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
 
 	if (!cache)
@@ -2075,10 +2080,7 @@ static int __set_memory_enc_dec(unsigned
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	if (static_cpu_has(X86_FEATURE_CLFLUSH))
-		cpa_flush_range(start, numpages, 1);
-	else
-		cpa_flush_all(1);
+	cpa_flush_range(start, numpages, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2089,10 +2091,7 @@ static int __set_memory_enc_dec(unsigned
 	 * in case TLB flushing gets optimized in the cpa_flush_range()
 	 * path use the same logic as above.
 	 */
-	if (static_cpu_has(X86_FEATURE_CLFLUSH))
-		cpa_flush_range(start, numpages, 0);
-	else
-		cpa_flush_all(0);
+	cpa_flush_range(start, numpages, 0);
 
 	return ret;
 }


