Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AF62064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PCeJ1Tm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AF62064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeGTI4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:56:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeGTI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QAo3jxuYoYiQnIcEgEM3SbDs7faq4jcPRHeNvHLkE9w=; b=PCeJ1Tm2RuDvCjBwZG+zNG4O6
        Cki1TgrvgxDU8QHhGiYqenfK11XwQYJadMfyG12l0cF1Dy6auHuneDcg/p9gQyj4+v3D63Y+wrVgc
        /X3J5+nOhrjbczo0VNRhQ+I4UyofKXHAU6j8ixGoKuDp/GHaOi/wsIL3PWkJigpH+VLXN7y5fYJz6
        i1UmHi+CkBZH4g/rzpinHyIKeAErAefw9WUw3TeCQY1NyX/FdvxjZZ1aQbaOpPReR8kFNqsizK4Ms
        cQS731l22KIDjeQTPEPUWWe8y206yY/rWZX+6wiPxFRe3icHVzz/IOpNhF7QGe0TtZJlItJqAiXMR
        LKhFfGeQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgQTR-0003dt-AI; Fri, 20 Jul 2018 08:09:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2221420289335; Fri, 20 Jul 2018 10:09:11 +0200 (CEST)
Date:   Fri, 20 Jul 2018 10:09:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Message-ID: <20180720080911.GM2494@hirez.programming.kicks-ass.net>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719205545.16512-24-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 04:55:42PM -0400, Pavel Tatashin wrote:
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 0e9dbb2d9aea..422cd63f8f17 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -202,7 +202,25 @@ static void __sched_clock_gtod_offset(void)
>  
>  void __init sched_clock_init(void)
>  {
> +	unsigned long flags;
> +
> +	/*
> +	 * Set __gtod_offset such that once we mark sched_clock_running,
> +	 * sched_clock_tick() continues where sched_clock() left off.
> +	 *
> +	 * Even if TSC is buggered, we're still UP at this point so it
> +	 * can't really be out of sync.
> +	 */
> +	local_irq_save(flags);
> +	__sched_clock_gtod_offset();
> +	local_irq_restore(flags);
> +
>  	sched_clock_running = 1;
> +
> +	/* Now that sched_clock_running is set adjust scd */
> +	local_irq_save(flags);
> +	sched_clock_tick();
> +	local_irq_restore(flags);
>  }

Sorry, that's still wrong. Because the moment you enable
sched_clock_running we need to have everything set-up for it to run.

The above looks double weird because you could've just done that =1
under the same IRQ-disable section and it would've mostly been OK
(except for NMIs). But the reason it's weird like that is because you're
going to change it into a static key later on.

The below cures things.

---
Subject: sched/clock: Close a hole in sched_clock_init()

All data required for the 'unstable' sched_clock must be set-up _before_
enabling it -- setting sched_clock_running. This includes the
__gtod_offset but also a recent scd stamp.

Make the gtod-offset update also set the csd stamp -- it requires the
same two clock reads _anyway_. This doesn't hurt in the
sched_clock_tick_stable() case and ensures sched_clock_init() gets
everything set-up before use.

Also switch to unconditional IRQ-disable/enable because the static key
stuff already requires this is not ran with IRQs disabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/clock.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c5c47ad3f386..811a39aca1ce 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -197,13 +197,14 @@ void clear_sched_clock_stable(void)
 
 static void __sched_clock_gtod_offset(void)
 {
-	__gtod_offset = (sched_clock() + __sched_clock_offset) - ktime_get_ns();
+	struct sched_clock_data *scd = this_scd();
+
+	__scd_stamp(scd);
+	__gtod_offset = (scd->tick_raw + __sched_clock_offset) - scd->tick_gtod;
 }
 
 void __init sched_clock_init(void)
 {
-	unsigned long flags;
-
 	/*
 	 * Set __gtod_offset such that once we mark sched_clock_running,
 	 * sched_clock_tick() continues where sched_clock() left off.
@@ -211,16 +212,11 @@ void __init sched_clock_init(void)
 	 * Even if TSC is buggered, we're still UP at this point so it
 	 * can't really be out of sync.
 	 */
-	local_irq_save(flags);
+	local_irq_disable();
 	__sched_clock_gtod_offset();
-	local_irq_restore(flags);
+	local_irq_enable();
 
 	static_branch_inc(&sched_clock_running);
-
-	/* Now that sched_clock_running is set adjust scd */
-	local_irq_save(flags);
-	sched_clock_tick();
-	local_irq_restore(flags);
 }
 /*
  * We run this as late_initcall() such that it runs after all built-in drivers,

