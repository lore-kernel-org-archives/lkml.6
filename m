Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BEFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D732192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D732192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeHFKYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:24:54 -0400
Received: from muru.com ([72.249.23.125]:52864 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeHFKYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:24:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A53C2803A;
        Mon,  6 Aug 2018 08:20:29 +0000 (UTC)
Date:   Mon, 6 Aug 2018 01:16:56 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        baolin.wang@linaro.org, d-gerlach@ti.com, grygorii.strashko@ti.com,
        t-kristo@ti.com
Subject: Re: [PATCH] clocksource: ti-32k: Remove CLOCK_SOURCE_SUSPEND_NONSTOP
 flag
Message-ID: <20180806081656.GN99251@atomide.com>
References: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keerthy,

* Keerthy <j-keerthy@ti.com> [180802 06:39]:
> With the introduction of below commit:
> 
> commit 39232ed5a1793f67b11430c43ed8a9ed6e96c6eb
> 
> time: Introduce one suspend clocksource to compensate the suspend time
> 
> The suspend/resume fails on AM437x platforms as the source is not
> a non-stop while trying to compensate time using this.
>
> Hence remove the CLOCK_SOURCE_SUSPEND_NONSTOP flag.

The 32k timer only stops on am4, on omap3 to omap5 and dra7 it's always
on. So the NONSTOP flag should be removed only for am4.

Care to do an incremental patch clearing NONSTOP based on compatible
property?

Regards,

Tony

> Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/clocksource/timer-ti-32k.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
> index 880a861..7368e8e 100644
> --- a/drivers/clocksource/timer-ti-32k.c
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -78,8 +78,7 @@ static u64 notrace ti_32k_read_cycles(struct clocksource *cs)
>  		.rating		= 250,
>  		.read		= ti_32k_read_cycles,
>  		.mask		= CLOCKSOURCE_MASK(32),
> -		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
> -				CLOCK_SOURCE_SUSPEND_NONSTOP,
> +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS, 
>  	},
>  };
>  
> -- 
> 1.9.1
> 
