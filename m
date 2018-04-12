Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDLO1T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:27:19 -0400
Received: from muru.com ([72.249.23.125]:36426 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbeDLO1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:27:18 -0400
Date: Thu, 12 Apr 2018 07:27:14 -0700
From: Tony Lindgren <tony@atomide.com>
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com,
        Russ.Dill@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, ssantosh@kernel.org,
        haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org,
        d-gerlach@ti.com
Subject: Re: [PATCH 12/14] OMAP: CLK: CLKSRC: Add suspend resume hooks
Message-ID: <20180412142714.GX5700@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-13-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523505239-16229-13-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> Add the save and restore for clksrc as part of suspend and resume
> so that it saves the counter value and restores. This is needed in
> modes like rtc+ddr in self-refresh not doing this stalls the time.

I suspect this too should really happen with cpu_pm.

> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -442,6 +442,38 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
>  	return ret;
>  }
>  
> +static unsigned int omap2_gptimer_clksrc_load;
> +
> +static void omap2_gptimer_clksrc_suspend(struct clocksource *unused)
> +{
> +	struct omap_hwmod *oh;
> +
> +	omap2_gptimer_clksrc_load =
> +		__omap_dm_timer_read_counter(&clksrc, OMAP_TIMER_NONPOSTED);
> +
> +	oh = omap_hwmod_lookup(clocksource_gpt.name);
> +	if (!oh)
> +		return;
> +
> +	omap_hwmod_idle(oh);
> +}

Probably no need to look up the hwmod every time? Especially if am437x
will start supporting deeper idle modes during runtime.

And probably the cpu_pm notifies should be directly in the hwmod
code so we don't need to add more any more dependencies to hwmod
functions to timer code. We should have this code move to drivers
anyways at some point.

Regards,

Tony
