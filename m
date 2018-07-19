Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E07C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED4E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xIKTj9yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED4E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGSLWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:22:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeGSLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g8wrvPkHwVUGWtSaRwgkHhKtR8VQQou89nvraJQkADE=; b=xIKTj9yBUQej/LxkEwhjNzR91
        oyepp6bLjV6q9OksEWCxy26m/hfKIBtQxcAYOoEyHyns/jUGlW12GdljDDcw6Nub4bE9lHxHC5+U5
        tP1u2kXkHfux9qt3hnum56C31AoQw5c5TiYUk8VFhxXu5Qqg46pzq/5yxxfYI13ucOsgGGgy9bVqw
        NaXW1cXiT7iJ4ZcZ8kavTdZYt+1cVxPRQnfDCn3Ztxsf94jwQjon3Jaescfe7Y3WrHIk2M3EbLPUU
        PhOfCzGLeG3JKTm1xadCrtzODWJXdCyCghsD6MjWJlJf/hz/b1Sa7ugQOgGXM1FLKt4HTdsM9m22k
        RQXRXijyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg6Kw-0002SL-Fx; Thu, 19 Jul 2018 10:39:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D09DE20289330; Thu, 19 Jul 2018 12:39:03 +0200 (CEST)
Date:   Thu, 19 Jul 2018 12:39:03 +0200
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
Subject: Re: [PATCH v14 24/25] sched: early boot clock
Message-ID: <20180719103903.GB2494@hirez.programming.kicks-ass.net>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-25-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718022211.6259-25-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:22:10PM -0400, Pavel Tatashin wrote:

> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 0e9dbb2d9aea..7a8a63b940ee 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -202,7 +202,15 @@ static void __sched_clock_gtod_offset(void)
>  
>  void __init sched_clock_init(void)
>  {
> +	unsigned long flags;
> +
>  	sched_clock_running = 1;
> +
> +	/* Adjust __gtod_offset for contigious transition from early clock */
> +	local_irq_save(flags);
> +	sched_clock_tick();
> +	local_irq_restore(flags);
> +	__sched_clock_gtod_offset();

I think we want to keep __sched_clock_gtod_offset() inside the IRQ
disabled region.

And I just looked at my patch:

  https://lkml.kernel.org/r/20180626090003.GA2458@hirez.programming.kicks-ass.net

and that had a comment about how we wanted to set the gtod offset
_before_ setting sched_clock_running, yet here you do it the other way
around. Hmm?

>  }
>  /*
>   * We run this as late_initcall() such that it runs after all built-in drivers,
> @@ -356,7 +364,7 @@ u64 sched_clock_cpu(int cpu)
>  		return sched_clock() + __sched_clock_offset;
>  
>  	if (unlikely(!sched_clock_running))
> -		return 0ull;
> +		return sched_clock();
>  
>  	preempt_disable_notrace();
>  	scd = cpu_sdc(cpu);
