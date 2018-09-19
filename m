Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B910214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ciYv9iwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B910214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbeISOhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbeISOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=33jvgJOMfL+K0spk7LkZM3mmDAIOSz8lUZMvQktOGdY=; b=ciYv9iwB5WLVVbEhO/k7bvp2cf
        aKkaBYe+Pb9mLMqToKmIlK7MYRk+KDymDrYK1n3qrpGzY0JwuupRm+nDHx/G1XMosdU1JMfI7LzIP
        7muNA+mPLX3Hwikb7z3vC4dkFV/FICQTAdePrWi8tJjLPKt/tTEIyJLj/N/jH0cMhS89Bl8Md8H7O
        ZxmAwHTsuLid2dPhs297kF6piFb/xTohAZ8ejG9cWBs5cVMN91aVb2BvZs9bJ0SzU6R/Xtvr1Bdtv
        ERT6kMlH798qA3IKkUPM5COi1fykBh6XxwszdPiPUOquZJRwNKDaI5AuB4850H98xborstgALxl7t
        3qEOCSaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLS-0007d2-Lh; Wed, 19 Sep 2018 09:00:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BD2352024EFC3; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085948.195633798@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 8/8] x86/mm/cpa: Optimize __cpa_flush_range()
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we IPI for WBINDV, then we might as well kill the entire TLB too.
But if we don't have to invalidate cache, there is no reason not to
use a range TLB flush.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -291,7 +291,7 @@ static bool __cpa_flush_range(unsigned l
 
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
 		return true;
 	}


