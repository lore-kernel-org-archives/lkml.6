Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E89C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45955206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hZ/FFYKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45955206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeJKSMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:12:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48410 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HN479tzdU54QRnUDQtE6lxB5nnX/z8WDbreCzMPNQC8=; b=hZ/FFYKrSm2Re3vZTrChh0UMeA
        PQS4vsYtF9K1cY8MKVgf7+BdwB0ypwtGaRkPVyfyXcXM9e7wsEWWeIdCTYjAIijCbmX9M5KfuOWpL
        7lKVOQ7jKNDxX34OYhbh43twH0XuoGiVIeavF5liNh2Z5heX7piAJ3yWuLnVCpMtfbg5XOYKErZIY
        sVivabFIA0r+/ybW04uFVP/6df3X8nKjaWl1jgnl/GSleUlysZxgX/18pXoGBhIqxRoJsGw+krAPo
        rY7xMGz54qoJ5uyN46oPHkr2WUM1NzisE45kvumO8JiP4f7jcfLcn5lnvzYIIQqV8diqVCbq8G3vC
        v2tYGE5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAYSs-00034j-3G; Thu, 11 Oct 2018 10:45:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 92B4B20298C01; Thu, 11 Oct 2018 12:45:07 +0200 (CEST)
Message-ID: <20181011104019.695196158@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Oct 2018 12:38:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, edumazet@google.com,
        eric.dumazet@gmail.com, bp@alien8.de, peterz@infradead.org
Subject: [PATCH 1/2] x86/tsc: Force inlining of cyc2ns bits
References: <20181011103825.023036082@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the asm for native_sched_clock() I noticed we don't inline
enough. Mostly caused by sharing code with cyc2ns_read_begin(), which
we didn't used to do. So mark all that __force_inline to make it DTRT.

Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/tsc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -57,7 +57,7 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
-void cyc2ns_read_begin(struct cyc2ns_data *data)
+void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
@@ -74,7 +74,7 @@ void cyc2ns_read_begin(struct cyc2ns_dat
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }
 
-void cyc2ns_read_end(void)
+void __always_inline cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
 }
@@ -103,7 +103,7 @@ void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
 	unsigned long long ns;


