Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73F320851
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WbsN6ZGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfB0KRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:17:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33208 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbfB0KQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T7jcLUvqrJkePzD80jUYBQo1alDq4+zLkCdBM9fkmBY=; b=WbsN6ZGsM1SI+hfkaTFjwsFGHH
        tW4WbHST6hXdMY7L/hQGIWd2CiP5dYKq9Uqv2U6FdskDcoLxZErIvz8NmFb2XbXkId/G7qzhc6Cwy
        TkRM9V2US7GChaeZj7oaG2dbabVryyJ2zDJd6YLZfjWbCH6NTyHRf/jMVBiq6bKHzdKV6InyeS646
        QGfa6o5FAfoQ9RuOIYoavck2bIwi526rgAGuRydbuqlqi0rQE8AWRNA9PGe+xNL7J6LhO2WwuD95X
        /D4snq0et9VsPLXrZ0hktDBuDqAg+/NkVScAGUitbx+noAkjVlxX1Ne6VRE3tjTh4z4mkUroTrjaz
        mFnyJ6nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gywGO-0007nu-Jm; Wed, 27 Feb 2019 10:16:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0CEDD28524771; Wed, 27 Feb 2019 11:16:29 +0100 (CET)
Message-Id: <20190227101544.395741248@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 27 Feb 2019 11:12:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 3/5] x86/percpu, x86/irq: Relax {set,get}_irq_regs()
References: <20190227101252.413192716@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav reported that since the this_cpu_*() ops got asm-volatile
constraints on, code generation suffered for do_IRQ(), but since this
is all with IRQs disabled we can use __this_cpu_*().

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/irq_regs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/irq_regs.h
+++ b/arch/x86/include/asm/irq_regs.h
@@ -16,7 +16,7 @@ DECLARE_PER_CPU(struct pt_regs *, irq_re
 
 static inline struct pt_regs *get_irq_regs(void)
 {
-	return this_cpu_read(irq_regs);
+	return __this_cpu_read(irq_regs);
 }
 
 static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
@@ -24,7 +24,7 @@ static inline struct pt_regs *set_irq_re
 	struct pt_regs *old_regs;
 
 	old_regs = get_irq_regs();
-	this_cpu_write(irq_regs, new_regs);
+	__this_cpu_write(irq_regs, new_regs);
 
 	return old_regs;
 }


