Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0778EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7992098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CydovV7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7992098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJDPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:11:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40713 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJDPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:11:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so7231506wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=14N5CX26+jAF1hRRiNzU1B36D0D61+4lLZzqz2zvR+Q=;
        b=CydovV7AESys5mkLXQ1Kt6OpkTmv8oYzoUOEWz0U4r4qiwBCSE26VQOyIit3aQCjV1
         JGaBOkDZShn74PPjSGvykrAwLLf8j8xnl8cx5oFR3aH5BhOYRY8m6VHfP1BsvHtkQbOC
         +rqE6S3G+QntAKwegVnrKOAPmg70Q3LDofiD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14N5CX26+jAF1hRRiNzU1B36D0D61+4lLZzqz2zvR+Q=;
        b=iIn13hPCGzcm3UGLyMDGYFABgp9NDQjvQMJR9XyJK7R6k6661+SEUmymgTQEuyHsN4
         YJ4JBdXbiGKF9BhNKsg9un9nApgXKYDJeFDQSy9BoIKZvyaUMIkR59dcqKjiBT4mpjXv
         ok7Z98Tfgz7s900K0KJO3jsztKDo5eTXHl7g5pAwLpElZ8FgmLYAigy9iRJFbz9Znmvn
         mrycgxBmWWcAWEqMIHcpoClKJLOwrfzBNAxMVdxwCa/76kCdXZo5FTvNG54923qBu0ve
         MXYNNpm+xF0V41K4aUZ+3LigJYBcN44NBKZTCp/qs0roPojBKJ2B2vFkjElbwF/MmB3y
         9Gsw==
X-Gm-Message-State: ABuFfojUIexDyDi2QO96OOcRFljQpLUMbr5Px6GHkyOFlKJRH/V2tkHW
        o0EVECu/Y1z+ak09MgK0DpZ296xe178=
X-Google-Smtp-Source: ACcGV61txZlP6BWr1dqKrDiwUdqtdqbNjs/1e8GpylC9uj1RkZ9ssepKgLERlzQomTttRrsE1X8jNA==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr4042737wmd.51.1538641174483;
        Thu, 04 Oct 2018 01:19:34 -0700 (PDT)
Received: from [192.168.0.40] (225.182.88.92.rev.sfr.net. [92.88.182.225])
        by smtp.googlemail.com with ESMTPSA id y4-v6sm4817904wrd.25.2018.10.04.01.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:19:33 -0700 (PDT)
Subject: Re: [PATCH 1/6] cpuidle: menu: Fix wakeup statistics updates for
 polling state
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <1561295.epLgDtImU0@aspire.rjw.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bced15a8-44f2-ea0c-a87c-ac6aae2969ae@linaro.org>
Date:   Thu, 4 Oct 2018 10:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1561295.epLgDtImU0@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 23:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the CPU exits the "polling" state due to the time limit in the
> loop in poll_idle(), this is not a real wakeup and it just means
> that the "polling" state selection was not adequate.  The governor
> mispredicted short idle duration, but had a more suitable state been
> selected, the CPU might have spent more time in it.  In fact, there
> is no reason to expect that there would have been a wakeup event
> earlier than the next timer in that case.
> 
> Handling such cases as regular wakeups in menu_update() may cause the
> menu governor to make suboptimal decisions going forward, but ignoring
> them altogether would not be correct either, because every time
> menu_select() is invoked, it makes a separate new attempt to predict
> the idle duration taking distinct time to the closest timer event as
> input and the outcomes of all those attempts should be recorded.
> 
> For this reason, make menu_update() always assume that if the
> "polling" state was exited due to the time limit, the next proper
> wakeup event for the CPU would be the next timer event (not
> including the tick).
> 
> Fixes: a37b969a61c1 "cpuidle: poll_state: Add time limit to poll_idle()"
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/cpuidle/governors/menu.c |   10 ++++++++++
>  drivers/cpuidle/poll_state.c     |    6 +++++-
>  include/linux/cpuidle.h          |    1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -511,6 +511,16 @@ static void menu_update(struct cpuidle_d
>  		 * duration predictor do a better job next time.
>  		 */
>  		measured_us = 9 * MAX_INTERESTING / 10;
> +	} else if ((drv->states[last_idx].flags & CPUIDLE_FLAG_POLLING) &&
> +		   dev->poll_time_limit) {
> +		/*
> +		 * The CPU exited the "polling" state due to a time limit, so
> +		 * the idle duration prediction leading to the selection of that
> +		 * state was inaccurate.  If a better prediction had been made,
> +		 * the CPU might have been woken up from idle by the next timer.
> +		 * Assume that to be the case.
> +		 */
> +		measured_us = data->next_timer_us;
>  	} else {
>  		/* measured value */
>  		measured_us = dev->last_residency;
> Index: linux-pm/include/linux/cpuidle.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpuidle.h
> +++ linux-pm/include/linux/cpuidle.h
> @@ -81,6 +81,7 @@ struct cpuidle_device {
>  	unsigned int		registered:1;
>  	unsigned int		enabled:1;
>  	unsigned int		use_deepest_state:1;
> +	unsigned int		poll_time_limit:1;
>  	unsigned int		cpu;
>  
>  	int			last_residency;
> Index: linux-pm/drivers/cpuidle/poll_state.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/poll_state.c
> +++ linux-pm/drivers/cpuidle/poll_state.c
> @@ -17,6 +17,8 @@ static int __cpuidle poll_idle(struct cp
>  {
>  	u64 time_start = local_clock();
>  
> +	dev->poll_time_limit = false;
> +
>  	local_irq_enable();
>  	if (!current_set_polling_and_test()) {
>  		unsigned int loop_count = 0;
> @@ -27,8 +29,10 @@ static int __cpuidle poll_idle(struct cp
>  				continue;
>  
>  			loop_count = 0;
> -			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
> +			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT) {
> +				dev->poll_time_limit = true;
>  				break;
> +			}
>  		}
>  	}
>  	current_clr_polling();
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

