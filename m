Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AAEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6306214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vaGaxtX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6306214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbeISOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37640 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbeISOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ct9YGIz3qu7JuHXhd/kGToyDQSWGCpHref5mR201ibs=; b=vaGaxtX6DK83xIAdtwgw09to0p
        Xr61UxKGd8J/GlgE/JrLNHmqN3YK2AR7QKw9gCfGJNv2IY7dlFT0W9AH2E6suQ5CbM3ePMpGZZRp2
        P3dV8tovbXlA3Z9hmKMfP6EwpbqEoBjLzNExbIMRQ3OHI0oZelhY6D6GPGkFwnbyDD+txfRMTAOO9
        2CTG1L7zLMsIb68idGhivY1dpuWxlLVPf1zrh0EHi4Kln+YKF5LNokk3F8cO2DzFTRSs6irM0EhYb
        Byj7nSyf2ySLuJ+NF8pmOpuKiYJrT+m2yIBljYXCWjOTqemzooVMDzV26vCnL3j4idV5/acOnZaQ4
        LcfyWWJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLR-0000pT-6e; Wed, 19 Sep 2018 09:00:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A597C2027585B; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085947.933674526@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 3/8] x86/mm/cpa: Unconditionally avoid WBINDV when we can
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAT has happened, WBINDV is bad (even before CAT blowing away the
entire cache on a multi-core platform wasn't nice), try not to use it
ever.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -319,26 +319,12 @@ static void cpa_flush_array(unsigned lon
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
-#ifdef CONFIG_PREEMPT
-	/*
-	 * Avoid wbinvd() because it causes latencies on all CPUs,
-	 * regardless of any CPU isolation that may be in effect.
-	 *
-	 * This should be extended for CAT enabled systems independent of
-	 * PREEMPT because wbinvd() does not respect the CAT partitions and
-	 * this is exposed to unpriviledged users through the graphics
-	 * subsystem.
-	 */
-	unsigned long do_wbinvd = 0;
-#else
-	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
-#endif
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	on_each_cpu(__cpa_flush_all, (void *) do_wbinvd, 1);
+	flush_tlb_all();
 
-	if (!cache || do_wbinvd)
+	if (!cache)
 		return;
 
 	/*


