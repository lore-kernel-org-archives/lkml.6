Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F26C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC5820659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRuWPbYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC5820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeJKRBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:01:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeJKRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PwY27Af+KZn6Jy0gBb8Mgj5o12B0lA1sKcrUPy+1KZY=; b=pRuWPbYikc98of7op5qeIC5Zt
        xahCLX2GRJST6KD4SBI/pRsBpXd5zYeL7v3h1X5q3DSikQBvw7GJ0e0LZRJZSV0gIvRXhUjf2iuDs
        dLV7P5nQ1rAbV6DmiC6gbIqWzd05H8CA7gVE4H+In4E7OV2uuMIMnWrY1uZ+6gPAvaW7FvNGfza8e
        WVkXBsaAYOjwAU3IP0LzfTRzQ2PzNaHstXzGwHg6S47lG+bBoV/QEIrzQLhSKGi0ca922TpVZiFMl
        Jmh7nJfTVqfHfqF/IeRYnW3CSjgz8rnrZjLYnKwBB1Y/LMuie7f82irpH/KXwXe8gFVLq3EZJgGGw
        22zTAtdqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAXN5-00017U-18; Thu, 11 Oct 2018 09:35:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 342D42029856A; Thu, 11 Oct 2018 11:35:00 +0200 (CEST)
Date:   Thu, 11 Oct 2018 11:35:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] panic: Avoid extra noisy messages due to stopped cpus
Message-ID: <20181011093500.GB9848@hirez.programming.kicks-ass.net>
References: <1539242268-63036-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539242268-63036-1-git-send-email-feng.tang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:17:48PM +0800, Feng Tang wrote:
> Sometimes when debugging kernel panic, we saw many extra noisy error
> messages after the expected end:
> 
> [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> [   35.749975] ------------[ cut here ]------------
> 
> These messages may overflow the sceen (framebuffer) and make debugging
> much difficulter.

*blink* you actually using the framebuffer for debugging ?! Why the heck
are you doing that?

> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index c93fcfd..b703862 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -520,6 +520,7 @@ void stop_this_cpu(void *dummy)
>  	 * Remove this CPU:
>  	 */
>  	set_cpu_online(smp_processor_id(), false);
> +	set_cpu_active(smp_processor_id(), false);
>  	disable_local_APIC();
>  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
>  

WTH is stop_this_cpu() and how do we even get here with active still
set?

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7fc4a37..cf41b7b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9034,7 +9034,7 @@ static inline int find_new_ilb(void)
>  {
>  	int ilb = cpumask_first(nohz.idle_cpus_mask);
>  
> -	if (ilb < nr_cpu_ids && idle_cpu(ilb))
> +	if (ilb < nr_cpu_ids && idle_cpu(ilb) && cpu_online(ilb))
>  		return ilb;
>  
>  	return nr_cpu_ids;


Similar, this is the result of taking the CPU away without going through
the normal path. You're doing something dodgy.

