Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1448C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF5021C3C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVjOib94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF5021C3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeHIJUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:20:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55967 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:20:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so5199972wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxdI6tUygiB6HbMIwc26zc2clAZ/I/HQREgZ6tfI3fI=;
        b=gVjOib94BjKI6UpPhW69+bxT9H6mD8MCh7NlrDuexGheR17jiTBOGJbpCsfeFGEhOw
         9vsONQPeja48f61167FmN8WgR9SfLEOkiJKiMvzojQKoAbN9N6VQiYzRsBW8C2tX6hx6
         +vxZ0xBPWaBDVM97EIXkKQBbHkEcifFAgy2Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxdI6tUygiB6HbMIwc26zc2clAZ/I/HQREgZ6tfI3fI=;
        b=YQBdqaRMNYwvUbXMzzOVWO9cQ77A9UsuedGV7k+YVGBjod+BVIepH3OXWE+Pf8jQZS
         XDY2H8JdBA9UpkPq+C2y9UL0N6bCrMNakK5L6AWxqvsUvsLjXdnWHtE7t3Phhy0RrM6Z
         NjhqSsE1i+aPsfedRb41r8mfj4DN0e5+jIjiOUaIae05KAB657Dc4fOgGOi5/y+lLa/E
         9qxv1o/bQk1xsDq1+6AcLzjJBBzCfZdhx8hN2j/pGMbBwPp1LvhIwyiVbxr1QeuqcBX7
         JfIDKJ0ns3OJoE9xB2zixnmK7kOnZKpVCh5uvc7WViludcLi8zoc66t/47omU1Wvxa9a
         iuYg==
X-Gm-Message-State: AOUpUlHUihvgX9rwmQB1/bWCxEXI9/zxphUEqFWc9wkoK1bG8JWooD1L
        HieSYJexGjQuyOhanJaEKzQJJg==
X-Google-Smtp-Source: AA+uWPzexso+bVHgoAa2I944sL6/GLFdtDMTlEgiRlfqAs/oYtlZDjhwhwRGu8BFptGADfaYnmPnyQ==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196-v6mr777858wmd.114.1533797845546;
        Wed, 08 Aug 2018 23:57:25 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id f132-v6sm12870016wme.24.2018.08.08.23.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 23:57:24 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:57:15 +0800
From:   leo.yan@linaro.org
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Message-ID: <20180809065715.GA14362@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 01:47:27PM +0800, Leo Yan wrote:
> The idle loop stops tick by respecting the decision from cpuidle
> framework, if the condition 'need_resched()' is false without any task
> scheduling, the CPU keeps running in the loop in do_idle() and it has no
> chance call tick_nohz_idle_exit() to enable the tick.  This results in
> the idle loop cannot reenable sched tick afterwards, if the idle
> governor selects a shallow state, thus the powernightmares issue can
> occur again.
> 
> This issue can be easily reproduce with the case on Arm Hikey board: use
> CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
> function it start a hrtimer with 4ms, so the 4ms timer delta value can
> let 'menu' governor to choose deepest state in the next entering idle
> time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
> 10 times, so this can utilize the typical pattern in 'menu' governor to
> have prediction for 1ms duration, finally idle governor is easily to
> select a shallow state, on Hikey board it usually is to select CPU off
> state.  From then on, CPU7 stays in this shallow state for long time
> until there have other interrupts on it.
> 
> C2: cluster off; C1: CPU off
> 
> Idle state:           C2    C2    C2    C2    C2    C2    C2    C1
>             --------------------------------------------------------->
> Interrupt:   ^        ^     ^     ^     ^     ^     ^     ^     ^
>             IPI      Timer Timer Timer Timer Timer Timer Timer Timer
> 	             4ms   1ms   1ms   1ms   1ms   1ms   1ms   1ms
> 
> To fix this issue, the idle loop needs to support reenabling sched tick.
> This patch checks the conditions 'stop_tick' is false when the tick is
> stopped, this condition indicates the cpuidle governor asks to reenable
> the tick and we can use tick_nohz_idle_restart_tick() for this purpose.
> 
> A synthetic case is used to to verify this patch, we use CPU0 to send
> IPI to wake up CPU7 with 50ms interval, CPU7 generate a series hrtimer
> events (the first interval is 4ms, then the sequential 10 timer events
> are 1ms interval, same as described above).  We do statistics for idle
> states duration, the unit is second (s), the testing result shows the
> C2 state (deepest state) staying time can be improved significantly for
> CPU7 (+7.942s for 10s execution time on CPU7) and all CPUs wide
> (+13.360s for ~80s of all CPUs execution time).
> 
>        Without patches         With patches         Difference
>      --------------------  --------------------  -----------------------
> CPU    C0     C1      C2     C0     C1      C2      C0      C1       C2
> 0    0.000  0.027   9.941  0.055  0.038   9.700  +0.055  +0.010   -0.240
> 1    0.045  0.000   9.964  0.019  0.000   9.943  -0.026  +0.000   -0.020
> 2    0.002  0.003  10.007  0.035  0.053   9.916  +0.033  +0.049   -0.090
> 3    0.000  0.023   9.994  0.024  0.246   9.732  +0.024  +0.222   -0.261
> 4    0.032  0.000   9.985  0.015  0.007   9.993  -0.016  +0.007   +0.008
> 5    0.001  0.000   9.226  0.039  0.000   9.971  +0.038  +0.000   +0.744
> 6    0.000  0.000   0.000  0.036  0.000   5.278  +0.036  +0.000   +5.278
> 7    1.894  8.013   0.059  1.509  0.026   8.002  -0.384  -7.987   +7.942
> All  1.976  8.068  59.179  1.737  0.372  72.539  -0.239  -7.695  +13.360

I found the CPU6 data in upper table is flaw when I read this again,
CPU6 has no any ftrace event for idle entering/exiting from the start
testing, both two runs have the same issue.  so the result is not
reliable for CPU6.

Retested this case and at the beginning to wake up all CPUs so we can
have sane idle ftrace events.  Below is result, the conclusion is: CPU7
has improvement for staying in deepest state and there have no
regression on other CPUs.

       Without patches         With patches         Difference
     --------------------  --------------------  ----------------------
CPU    C0     C1      C2     C0     C1      C2      C0      C1      C2
0    0.000  0.021   9.837  0.000  0.022   9.919  +0.000  +0.000  +0.081
1    0.000  0.003  10.034  0.028  0.000   9.983  +0.028  -0.003  -0.051
2    0.023  0.031   9.963  0.007  0.019   9.986  -0.016  -0.011  +0.023
3    0.028  0.003   9.976  0.000  0.008  10.006  -0.027  +0.005  +0.030
4    0.052  0.000   9.971  0.023  0.000   9.994  -0.028  +0.000  +0.022
5    0.027  0.000  10.002  0.024  0.000   9.996  -0.002  +0.000  -0.006
6    0.013  0.000  10.018  0.025  0.000   9.992  +0.011  +0.000  -0.025
7    1.766  8.041   0.043  1.981  0.030   7.872  +0.214  -8.011  +7.829
All  1.912  8.101  69.847  2.092  0.081  77.752  +0.180  -8.020  +7.905


Another important dependency should to mention, we also need another
prerequisite patch "cpuidle: menu: Correct the criteria for stopping
tick" [1] for the testing, if without this patch, the idle governor
will select shallow state in idle loop but it will not tell idle loop
to reenable tick:

'expected_interval' is always be clamped to
min(TICK_USEC, ktime_to_us(delta_next)) [2] when tick is stopped,
thus 'expected_interval' is assigned to TICK_USEC at the last
time when the CPU enter idle state and without timer event, this results
in it cannot meet condition 'expected_interval < TICK_USEC' [3] for
enabling tick. We need rely on the dependent patch to set tick enabling
flag '*stop_tick = false' for shallow states.

[1] https://lkml.org/lkml/2018/8/7/407
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpuidle/governors/menu.c?h=v4.18-rc8#n358
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpuidle/governors/menu.c?h=v4.18-rc8#n407

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  kernel/sched/idle.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
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
>  			tick_nohz_idle_retain_tick();
> +		}
>  
>  		rcu_idle_enter();
>  
> -- 
> 2.7.4
> 
