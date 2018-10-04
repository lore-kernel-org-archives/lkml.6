Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BEFC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB762087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9sTk+kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB762087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJDVpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:45:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53366 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeJDVo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:44:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so9338773wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GrkAore9gojLUBZh+VnLDxcs3YsuCIt5vHt/DIkzG3o=;
        b=J9sTk+kNuVF7VQwmFHa5i7MJ6rMMCuEq84qyPAr9FJPQH/WGqMY9ZFETQ56SJWPUiC
         eXXZfCleXMEVMHwv94u9UZ6JuDhZzz85VW/+KEOn19yZ8k77aJupDqfuZtNyDpwOqFv5
         pTlWm382TQ9hthRDYV5Qx9YR84o7ahJyWgCfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GrkAore9gojLUBZh+VnLDxcs3YsuCIt5vHt/DIkzG3o=;
        b=ubcZYIGB5EkFeKLyWBjn6fGqGJg9ry5Yn6eIxCxOIZXW6ldkVL/+lWC0ajTqRp5OGn
         6CYaqvexx5uonnRkaFdJwvmhYSTBNSdJc0qIB7FXC7UKpshtZF9mWN3rbK6Hjzrdl5Im
         SaZxx4Ft7vZ6f8hLMXsNPeBSvMJbW8sXLgnysjUeYYEQDy3BNea6HobqEOZ19JlciST3
         rSrsET2BIsLiaSo/nlVWfahWlRcoJX7d3o+upG/8Pj5KJXFwbf7g92ZZqkMX8enmv/Qt
         My85ttvdLXMbr1cIWlAWiHYuG2HyRlfZFn6OUO7SgErNYHfDCF+fuII6qXH+cflRhqKG
         ggtQ==
X-Gm-Message-State: ABuFfogOTRcZh8jlpcdqwJMdIScZi0q3VSNiW4hL3xiSCvSHgzAC1Upb
        B8aZmyziwFupdwmIb6fnTrED9g==
X-Google-Smtp-Source: ACcGV62ev0MVUNDAuqWSkhALG8EEkuJDB0rU+xD0Usc9RKePdAq4MbQsRfM0PTNbcLofLzp+6srcmQ==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr4839294wmn.116.1538664680214;
        Thu, 04 Oct 2018 07:51:20 -0700 (PDT)
Received: from mai (101.142.88.92.rev.sfr.net. [92.88.142.101])
        by smtp.gmail.com with ESMTPSA id e21-v6sm5639453wma.8.2018.10.04.07.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 07:51:19 -0700 (PDT)
Date:   Thu, 4 Oct 2018 16:51:17 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from
 menu_select()
Message-ID: <20181004145116.GB1881@mai>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <4130376.2FFt7p4687@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4130376.2FFt7p4687@aspire.rjw.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rearrange the code in menu_select() so that the loop over idle states
> always starts from 0 and get rid of the first_idx variable.
> 
> While at it, add two empty lines to separate conditional statements
> one another.
> 
> No intentional behavior changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

This code is becoming a bit complex to follow :/

May be I missed something, but it is not possible to enter the condition without
idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
FLAG_POLLING))

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/cpuidle/governors/menu.c |   32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -285,7 +285,6 @@ static int menu_select(struct cpuidle_dr
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
>  	int latency_req = cpuidle_governor_latency_req(dev->cpu);
>  	int i;
> -	int first_idx;
>  	int idx;
>  	unsigned int interactivity_req;
>  	unsigned int expected_interval;
> @@ -348,36 +347,33 @@ static int menu_select(struct cpuidle_dr
>  			latency_req = interactivity_req;
>  	}
>  
> -	first_idx = 0;
> -	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
> -		struct cpuidle_state *s = &drv->states[1];
> -		unsigned int polling_threshold;
> -
> -		/*
> -		 * Default to a physical idle state, not to busy polling, unless
> -		 * a timer is going to trigger really really soon.
> -		 */
> -		polling_threshold = max_t(unsigned int, 20, s->target_residency);
> -		if (data->next_timer_us > polling_threshold &&
> -		    latency_req > s->exit_latency && !s->disabled &&
> -		    !dev->states_usage[1].disable)
> -			first_idx = 1;
> -	}
> -
>  	/*
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
>  	 */
>  	idx = -1;
> -	for (i = first_idx; i < drv->state_count; i++) {
> +	for (i = 0; i < drv->state_count; i++) {
>  		struct cpuidle_state *s = &drv->states[i];
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
>  
>  		if (s->disabled || su->disable)
>  			continue;
> +
>  		if (idx == -1)
>  			idx = i; /* first enabled state */
> +
>  		if (s->target_residency > predicted_us) {
> +			/*
> +			 * Use a physical idle state, not busy polling, unless
> +			 * a timer is going to trigger really really soon.
> +			 */
> +			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> +			    i == idx + 1 && latency_req > s->exit_latency &&
> +			    data->next_timer_us > max_t(unsigned int, 20,
> +							s->target_residency)) {
> +				idx = i;
> +				break;
> +			}
>  			if (predicted_us < TICK_USEC)
>  				break;
>  
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
