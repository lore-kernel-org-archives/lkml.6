Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2101BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D462B20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D462B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeGYKlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:41:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56635 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbeGYKlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:41:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 46E85207A8; Wed, 25 Jul 2018 11:30:18 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0FB5C20731;
        Wed, 25 Jul 2018 11:30:18 +0200 (CEST)
Date:   Wed, 25 Jul 2018 11:30:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180725093018.GA3539@piout.net>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
 <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/07/2018 11:21:22+0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v5:
> 
>   * Added an additional check to see if ALARM2 status is not set
>     before retrying.
>   * Cleaned up comments
>   * Also reduced mdelay to 1S lesser as per this commit
> 
>  drivers/rtc/rtc-omap.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 44ff4cc..caa6da6 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -421,12 +421,6 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>   * The RTC can be used to control an external PMIC via the pmic_power_en pin,
>   * which can be configured to transition to OFF on ALARM2 events.
>   *
> - * Notes:
> - * The two-second alarm offset is the shortest offset possible as the alarm
> - * registers must be set before the next timer update and the offset
> - * calculation is too heavy for everything to be done within a single access
> - * period (~15 us).
> - *
>   * Called with local interrupts disabled.
>   */
>  static void omap_rtc_power_off(void)
> @@ -435,17 +429,20 @@ static void omap_rtc_power_off(void)
>  	struct rtc_time tm;
>  	unsigned long now;
>  	u32 val;
> +	int seconds;
>  
>  	rtc->type->unlock(rtc);
>  	/* enable pmic_power_en control */
>  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>  
> -	/* set alarm two seconds from now */
> +again:
> +	/* set alarm one second from now */
>  	omap_rtc_read_time_raw(rtc, &tm);
> +	seconds = tm.tm_sec;
>  	bcd2tm(&tm);
>  	rtc_tm_to_time(&tm, &now);
> -	rtc_time_to_tm(now + 2, &tm);
> +	rtc_time_to_tm(now + 1, &tm);
>  
>  	if (tm2bcd(&tm) < 0) {
>  		dev_err(&rtc->rtc->dev, "power off failed\n");
> @@ -470,14 +467,25 @@ static void omap_rtc_power_off(void)
>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> +
> +	/*
> +	 * first check if ALARM2 has fired, if not then check if
> +	 * our calculations started right before the rollover, try again
> +	 * in case of rollover
> +	 */
> +	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
> +						 OMAP_RTC_STATUS_REG)) &&
> +	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> +		goto again;
> +

Can you use a while loop instead of goto?

>  	rtc->type->lock(rtc);
>  
>  	/*
> -	 * Wait for alarm to trigger (within two seconds) and external PMIC to
> +	 * Wait for alarm to trigger (within one second) and external PMIC to
>  	 * power off the system. Add a 500 ms margin for external latencies
>  	 * (e.g. debounce circuits).
>  	 */
> -	mdelay(2500);
> +	mdelay(1500);
>  }
>  
>  static const struct rtc_class_ops omap_rtc_ops = {
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
