Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0081ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322722151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gETcbdgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322722151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeITE4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:56:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40662 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbeITE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:56:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so3448262pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upesM3/JllML0LNNgjjQOvrQWh7XEfYp5JW8q2MKRfc=;
        b=gETcbdgx4uwtvpmXzuStTsgDCEv7dEcig09uuf99RInrx/QUbKyaFOa7hGLxcjlLE8
         ZhQv9afRbBqlF6bfvttwNoV+W0oc3RaGvxUhKyK22NAefKngtn0f38kw2FlOx0JBn3AY
         W3wGLfMsZAzmhPLitCkq/Nceq9GNmzvKLhv20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upesM3/JllML0LNNgjjQOvrQWh7XEfYp5JW8q2MKRfc=;
        b=cZXByw648pjUIFfR+5w4IygIUgKEvm0E2b9jK7um5ntosJ2mcAySU+jLta+5SZPCoN
         busnbdozJegTGBYq4ln0ViDaVuZU5WfY3Gzdehq3c76fOzIyoNzVdt2i6fksip0ebtAD
         sS2MoTEtEOP5ZxboIgrd6CsmrZ7AGSLJvM0zF7JalmyEK3P0K9XEw3KbWDVcE3cxWGfg
         UMfRtJGjt5eYmcEPsAsfu81dk/BH4fn95fwzSp6slzTm/kB8qcWHzs5tNlIvOH/J5WAS
         OQCAvpjU5XCZX1KSidpGQl24rM1cg0UnIUszA0xeB7hg2xOdHr7ogKijIiF0AwIBy38Z
         P68Q==
X-Gm-Message-State: APzg51Df+hXyT7RJBuxoaL1KMI7pROQFG87l9kPpLCewNsEUFD0iXRuh
        Fmtsac/Np8sjqdzzQMMKhr3FzA==
X-Google-Smtp-Source: ANB0VdZTGARNJclNzdJGPwBfkcWTVSFmmMEA1u6Vm1vX+l3AqJ67FI95bjFc748i9bhar3zNMvqzUg==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr34692726pgv.436.1537398994617;
        Wed, 19 Sep 2018 16:16:34 -0700 (PDT)
Received: from [10.21.2.196] ([209.121.128.187])
        by smtp.googlemail.com with ESMTPSA id n29-v6sm26439749pgl.30.2018.09.19.16.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 16:16:33 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
To:     Tao Ren <taoren@fb.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, cov@fb.com, tfang@fb.com,
        Linus Walleij <linus.walleij@linaro.org>
References: <20180919221331.2511558-1-taoren@fb.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bb452948-0a9e-140d-57d5-85c1732fca86@linaro.org>
Date:   Thu, 20 Sep 2018 01:16:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919221331.2511558-1-taoren@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 00:13, Tao Ren wrote:
> Currently, the aspeed MATCH1 register is updated to <current_count -
> cycles> in set_next_event handler, with the assumption that COUNT
> register value is preserved when the timer is disabled and it continues
> decrementing after the timer is enabled. But the assumption is wrong:
> RELOAD register is loaded into COUNT register when the aspeed timer is
> enabled, which means the next event may be delayed because timer
> interrupt won't be generated until <0xFFFFFFFF - current_count +
> cycles>.
> 
> The problem can be fixed by updating RELOAD register to <cycles>, and
> COUNT register will be re-loaded when the timer is enabled and interrupt
> is generated when COUNT register overflows.
> 
> The test result on Facebook Backpack-CMM BMC hardware (AST2500) shows
> the issue is fixed: without the patch, usleep(100) suspends the process
> for several milliseconds (and sometimes even over 40 milliseconds);
> after applying the fix, usleep(100) takes averagely 240 microseconds to
> return under the same workload level.
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

Linus, any comments ?

> ---
>  drivers/clocksource/timer-fttmr010.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
> index c020038ebfab..cf93f6419b51 100644
> --- a/drivers/clocksource/timer-fttmr010.c
> +++ b/drivers/clocksource/timer-fttmr010.c
> @@ -130,13 +130,17 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
>  	cr &= ~fttmr010->t1_enable_val;
>  	writel(cr, fttmr010->base + TIMER_CR);
>  
> -	/* Setup the match register forward/backward in time */
> -	cr = readl(fttmr010->base + TIMER1_COUNT);
> -	if (fttmr010->count_down)
> -		cr -= cycles;
> -	else
> -		cr += cycles;
> -	writel(cr, fttmr010->base + TIMER1_MATCH1);
> +	if (fttmr010->count_down) {
> +		/*
> +		 * ASPEED Timer Controller will load TIMER1_LOAD register
> +		 * into TIMER1_COUNT register when the timer is re-enabled.
> +		 */
> +		writel(cycles, fttmr010->base + TIMER1_LOAD);
> +	} else {
> +		/* Setup the match register forward in time */
> +		cr = readl(fttmr010->base + TIMER1_COUNT);
> +		writel(cr + cycles, fttmr010->base + TIMER1_MATCH1);
> +	}
>  
>  	/* Start */
>  	cr = readl(fttmr010->base + TIMER_CR);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

