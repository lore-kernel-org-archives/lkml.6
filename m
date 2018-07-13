Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D67ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AAE208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AAE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeGMJCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:02:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52759 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeGMJCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:02:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DC5992074F; Fri, 13 Jul 2018 10:49:02 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id AF59B203EC;
        Fri, 13 Jul 2018 10:49:02 +0200 (CEST)
Date:   Fri, 13 Jul 2018 10:49:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, y2038@lists.linaro.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Stultz <john.stultz@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] rtc: use ktime_get_real_ts64() instead of
 getnstimeofday64()
Message-ID: <20180713084902.GO16084@piout.net>
References: <20180711124723.1114803-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711124723.1114803-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 14:47:12+0200, Arnd Bergmann wrote:
> getnstimeofday64() is just a wrapper around the ktime accessor, so
> we should use that directly.
> 
> I considered using ktime_get_boottime_ts64() (to avoid leap second
> problems) or ktime_get_real_seconds() (to simplify the calculation,
> but in the end concluded that the existing interface is probably
> the most appropriate in this case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Originally sent on Jun 18, but got no reply
> 
> Alexandre, could you pick this up into the rtc tree?

Yes, I've been late in my reviews lately. It is applied now.

I had some trouble figuring out that ktime_get_real_ts64 was not a macro
anymore as I was still looking at 4.17 ;)

> ---
>  drivers/rtc/class.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index d37588f08055..7fa32c922617 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -68,7 +68,7 @@ static int rtc_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> -	getnstimeofday64(&old_system);
> +	ktime_get_real_ts64(&old_system);
>  	old_rtc.tv_sec = rtc_tm_to_time64(&tm);
>  
>  
> @@ -110,7 +110,7 @@ static int rtc_resume(struct device *dev)
>  		return 0;
>  
>  	/* snapshot the current rtc and system time at resume */
> -	getnstimeofday64(&new_system);
> +	ktime_get_real_ts64(&new_system);
>  	err = rtc_read_time(rtc, &tm);
>  	if (err < 0) {
>  		pr_debug("%s:  fail to read rtc time\n", dev_name(&rtc->dev));
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
