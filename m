Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B78C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0665206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMZeHtqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0665206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIEMls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:41:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIEMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lU4+8DEmxuSYEYf/+B6ODlmtfUiJ/UKuWLg9Dyyc7ts=; b=TMZeHtqHKL1TT0tJHHcbmWImr
        /J6HMjjoQ8+2rJIslJl7XDglEgatabaFgAb1LXML+J07eNIWn6mD1yTRmuYLj4dTKLrFvVIPDbJej
        B3FGtjM2mPf7qpaKhTe/ubqb9u+fJRtMrEPmahRCbnGRx2mUp++EqC3tFfc9Q/n9E9SvE2Cs/rkih
        UifRdt94LLicDFQez9LaeVkVnXVoQ1EdZunDouWEa1hZYaJj2cnflSvDgE5fRoPPokKLCi6ZY8c1B
        BCT8/+eM1zE1TTzLoBf51+Eve8oqwXc4NcA+ChmCtrEa/g3AFkBrz9GhLEpDU+uOMZd35dRHk9Rsl
        WZVU8cg5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxSvY-0008V3-SK; Wed, 05 Sep 2018 08:12:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E81220191BFD; Wed,  5 Sep 2018 10:12:39 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:12:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     tglx@linutronix.de, josh@joshtriplett.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org, mojha@codeaurora.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpu/hotplug: Fix acquire of st->should_run in
 cpuhp_thread_fun()
Message-ID: <20180905081239.GQ24124@hirez.programming.kicks-ass.net>
References: <1536126727-11629-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536126727-11629-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:22:07AM +0530, Neeraj Upadhyay wrote:
> The smp_mb() in cpuhp_thread_fun() appears to be misplaced, and
> need to be after the load of st->should_run, to prevent
> reordering of the later load/stores w.r.t. the load of
> st->should_run.

I'm tempted to say this changelog needs improvement, but given the
comment that goes with the smp_mb(), yes this is obviously right.

Acked-by: Peter Zijlstra (Intel) <peterz@infraded.org>

> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  kernel/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index aa7fe85..eb4041f 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -607,15 +607,15 @@ static void cpuhp_thread_fun(unsigned int cpu)
>  	bool bringup = st->bringup;
>  	enum cpuhp_state state;
>  
> +	if (WARN_ON_ONCE(!st->should_run))
> +		return;
> +
>  	/*
>  	 * ACQUIRE for the cpuhp_should_run() load of ->should_run. Ensures
>  	 * that if we see ->should_run we also see the rest of the state.
>  	 */
>  	smp_mb();
>  
> -	if (WARN_ON_ONCE(!st->should_run))
> -		return;
> -
>  	cpuhp_lock_acquire(bringup);
>  
>  	if (st->single) {
