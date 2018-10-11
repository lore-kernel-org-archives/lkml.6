Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAAEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3D220658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGLTiLDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3D220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeJKSL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:11:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VgIGGstyElEILIG84w7jr3aH+N4IDrf6UVb8Eu3D5RU=; b=iGLTiLDaKilU1IIKv3jZumoQI2
        bDwFq+GXq0eSumenYbVv65vnKS0tOMxtqkHfkJax6un09aCuK9y/3gKLiuvvZEQTxjGYc/TEnsmQw
        dilZc1i+AYzeXmezQJpnoyGbno9FAJOr0F59MADCdUWeVqCs/b40y51sSipd9CAEWtRFYfLUZzm10
        9qFvyh6EfmJ9qfS/puSoGzVwPAKhs88fJYutODnj1ySxGPiBBLG4kGpaxVhU+NWNQENbmep3Ndo7v
        fm2/cge2HeGqMXkOqSBGF94h8g3QlbgJf4VEgH/FHplF8s6CHqZ/+Cb/OoRqn7I3mvrOJBtbKDdS/
        6r9ObrLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAYSr-0002ve-LL; Thu, 11 Oct 2018 10:45:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 949142027E194; Thu, 11 Oct 2018 12:45:07 +0200 (CEST)
Message-ID: <20181011104019.748208519@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Oct 2018 12:38:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, edumazet@google.com,
        eric.dumazet@gmail.com, bp@alien8.de, peterz@infradead.org
Subject: [PATCH 2/2] x86/percpu: Fix this_cpu_read()
References: <20181011103825.023036082@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric reported that a sequence count loop using this_cpu_read() got
optimized out. This is wrong, this_cpu_read() must imply READ_ONCE()
because the interface is IRQ-safe, therefore an interrupt can have
changed the per-cpu value.

Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -185,22 +185,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(1)",%0"		\
+		asm volatile(op "b "__percpu_arg(1)",%0"\
 		    : "=q" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(1)",%0"		\
+		asm volatile(op "w "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(1)",%0"		\
+		asm volatile(op "l "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(1)",%0"		\
+		asm volatile(op "q "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\


