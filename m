Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9351BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF4121CF8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vMm0GoI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF4121CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbeHINKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:10:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHINKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OJThfwEUBYbJrUIMogBaCwnjABbLAR7TMerjZQcl+os=; b=vMm0GoI4widlqJcN80tTWU4Bz
        3lBYWF9jtqHIiFCThvm6CY+ofHMGuvcd7FNjvPoRdILBf2U1wGnAW2s0KMh3gK8Xv/cfXNGh9iGOw
        OXKqZf64pjSdcxTWhsgzUZjFpNqO5rV+AAsWWLeZAh7BK5tuXe22C4RG3FJsH76maXJp8h5L1ZpAF
        oX3kfB3bBhq9uIrEnP7kHlpXQnDv4Is7SPLqHZWBKhT9QjlhVD+OKqOGzalL3Cs0TbjaKE+rZtsdG
        KM0CalBXpy5qI0YGo6uOoMSmZN7TQGZl2hILNI32xj4YGnWykNytHD0Qea+CdM68gofA336NFhjTH
        wuo9JsKSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fniS1-0000Mk-2j; Thu, 09 Aug 2018 10:45:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB7CC2052FC34; Thu,  9 Aug 2018 12:45:49 +0200 (CEST)
Date:   Thu, 9 Aug 2018 12:45:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Message-ID: <20180809104549.GS2494@hirez.programming.kicks-ass.net>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 01:47:27PM +0800, Leo Yan wrote:
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 1a3e9bd..802286e 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -190,10 +190,18 @@ static void cpuidle_idle_call(void)
>  		 */
>  		next_state = cpuidle_select(drv, dev, &stop_tick);
>  
> -		if (stop_tick)
> +		if (stop_tick) {
>  			tick_nohz_idle_stop_tick();
> -		else
> +		} else {
> +			/*
> +			 * The cpuidle framework says to not stop tick but
> +			 * the tick has been stopped yet, so restart it.
> +			 */
> +			if (tick_nohz_tick_stopped())
> +				tick_nohz_idle_restart_tick();
> +

I suspect you want an 'else' here. restart_tick already calls
timer_clear_idle().

>  			tick_nohz_idle_retain_tick();
> +		}
>  

However, I would rather we stuff all this into retain_tick.

