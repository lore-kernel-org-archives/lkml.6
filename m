Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258D321738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfAIBv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:51:28 -0500
Received: from muru.com ([72.249.23.125]:60924 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfAIBv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:51:27 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 529638080;
        Wed,  9 Jan 2019 01:51:33 +0000 (UTC)
Date:   Tue, 8 Jan 2019 17:51:24 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109015124.GO5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109014218.GA8363@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [190109 01:42]:
> Le Tuesday 08 Jan 2019 à 13:37:43 (-0800), Tony Lindgren a écrit :
> > Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> > Anything higher than 2200 ms seems to somehow time out immediately
> > now :)
> 
> This is quite close to the max ns of an int on arm 32bits
> 
> Could you try the patch below ?

Yup great thanks, that's it:

Tested-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7062469..44c5c76 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  
>  	last_busy = READ_ONCE(dev->power.last_busy);
>  
> -	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
> +	expires = last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
>  	if (expires <= now)
>  		expires = 0;	/* Already expired. */
>  
> -- 
> 2.7.4
> 
> 
> > 
> > Regards,
> > 
> > Tony
