Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843DA2563D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUPm1eHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843DA2563D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeFYI4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:56:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46386 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeFYI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N3lf4SlXfq0ZO0vCyrEw6Gaua8j5NFntXtt8b9BlZeE=; b=MUPm1eHYUvgDgrKiC2+oelLXl
        +4mpoZO5X+7tQSDqKPXiv70JZ45ReVFEbvddVRyaoFcB3NV1Z5FQZoVqm+GA/78ivTBwg2PLFEwvA
        tpJfRR7i1O+OEgFxqUtPzz0Y/YIVxXrBmroYcLopBDWiXSsy6RNBqZqZNhyNUqEvoigwU0jSQ1R2u
        vsAn36wDar1pSJzKpEE/CZxzNzH/2DIZZRAGqwnb7brDDMn51JRa7Rw7MkhlHEQ4M9rjOYgR/mJpL
        xzmnBtxWgzEPpdE2SGfmhHaFM+SQZsDnyPsG/RK0paJfU2NHnorryNgxEvafRtQBJoZhUNIGXW3E3
        XdG6hQnng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXNHn-0006Ye-8K; Mon, 25 Jun 2018 08:55:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2BCB2029F1DB; Mon, 25 Jun 2018 10:55:43 +0200 (CEST)
Date:   Mon, 25 Jun 2018 10:55:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180625085543.GT2494@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621212518.19914-11-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:25:17PM -0400, Pavel Tatashin wrote:
> Allow sched_clock() to be used before schec_clock_init() and
> sched_clock_init_late() are called. This provides us with a way to get
> early boot timestamps on machines with unstable clocks.

There are !x86 architectures that use this code and might not expect to
have their sched_clock() called quite that early. Please verify.

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  kernel/sched/clock.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 10c83e73837a..f034392b0f6c 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -205,6 +205,11 @@ void clear_sched_clock_stable(void)
>   */
>  static int __init sched_clock_init_late(void)
>  {
> +	/* Transition to unstable clock from early clock */

This is wrong... or at least it smells horribly.

This is not the point where we transition from early to unstable, that
is in fact in sched_clock_init.

This function, sched_clock_init_late(), is where we attempt to
transition from unstable to stable. And this is _waaaay_ after SMP init.

> +	local_irq_disable();
> +	__gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
> +	local_irq_enable();

This might work in sched_clock_init(), which is pre-SMP.

>  	sched_clock_running = 2;
>  	/*
>  	 * Ensure that it is impossible to not do a static_key update.
> @@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
>  	if (sched_clock_stable())
>  		return sched_clock() + __sched_clock_offset;
>  
> -	if (unlikely(!sched_clock_running))
> -		return 0ull;
> +	/* Use early clock until sched_clock_init_late() */
> +	if (unlikely(sched_clock_running < 2))
> +		return sched_clock() + __sched_clock_offset;

And then this remains !sched_clock_running, except instead of 0, you
then return sched_clock() + __sched_clock_offset;

>  	preempt_disable_notrace();
>  	scd = cpu_sdc(cpu);


