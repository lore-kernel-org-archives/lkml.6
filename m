Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68776ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDC2214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PO/O42CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDC2214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeIQUD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:03:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQUD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nEl94gvCQ58xJ4u5L4Sgz/Ln+ePH4eWsZnvw71aHIbw=; b=PO/O42CXCjTu17qEMPEIhTbq9
        eeyO8dJcxBKPqZWhkZPgkfZdrnHZkFRR/DNXet7qMSA8uhWOMt910vPO6/U1KtWNwBTthVuTC/wxw
        m6JXH0B5US5clrX4ZSv6FhHTWXvhKvPUlU8h4qzFDuTwazFu1UU8+mA8wgNVevS8IAl82Lhcd4hed
        PAnrYgUlvDiRk5PkowGcGOhkUHm1m4NSf4zEyTw6jryeyKi2dvzK5daQ94L08QDE75jBtpuWTf4DH
        3b+mqfzZ5FApiYjO+KabrDPBPAjgzxvRrauqRVSa9/cxFhtYh8pbXFTaruB0Ck+7hmaw2Y40pmaZk
        qDA0oDqXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1ucw-0004Vq-Fv; Mon, 17 Sep 2018 14:35:50 +0000
Date:   Mon, 17 Sep 2018 07:35:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, mark.rutland@arm.com, robh@kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC 3/3] RISC-V: Remove per cpu clocksource
Message-ID: <20180917143550.GC15588@infradead.org>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
 <1536962096-233842-4-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536962096-233842-4-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think only having one clocksource is indeed the right thing.

But that makes the whole TIMER_OF_DECLARE for each hart (cpu core for
those not RISC-V savvy) even more questionable than it already is.

I think we should just initialize the clocksource directly as it is
architectually guaranteed to exist.  Below is a completely untested
(not even compiled) version of your patch that does what I think
we should be doing here.  But I'd rather hear from more timer and/or
DT savvy folks before proceeding.

diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 4e8b347e43e2..2fe497c67283 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -48,7 +48,7 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
 	return get_cycles64();
 }
 
-static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
+static struct clocksource, riscv_clocksource = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
 	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
@@ -82,24 +82,16 @@ void riscv_timer_interrupt(void)
 	evdev->event_handler(evdev);
 }
 
-static int __init riscv_timer_init_dt(struct device_node *n)
+static int __init riscv_timer_init(void)
 {
-	int cpu_id = riscv_of_processor_hart(n), error;
-	struct clocksource *cs;
-
-	if (cpu_id != smp_processor_id())
-		return 0;
-
-	cs = per_cpu_ptr(&riscv_clocksource, cpu_id);
-	clocksource_register_hz(cs, riscv_timebase);
+	int error;
 
+	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
 	if (error)
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpu_id);
+		pr_err("RISCV timer register failed: %d.\n", error);
 	return error;
 }
-
-TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
+core_initcall(riscv_timer_init);
