Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13227C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C5B21533
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4DxwzGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C5B21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbeHNMJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:09:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44888 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeHNMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:09:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so14770948ljq.11;
        Tue, 14 Aug 2018 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aGhImojv5JVZey8SNYSUrqN+tpOKlvVUWE4hzQpmBqw=;
        b=T4DxwzGweq6pwf/33wOg/DFxTz4tXET8GLF+9CD71tkRWU3BG4yY63CXjZ/RGfnmEa
         euJNhdOaXGKOCjRZlYKBomsH8uGky3b9/SybtodKjcEXu/G2Kl2N0THkMzUaTmYtQA0H
         Aaiy4s4nhVnhmJzflN5L6fCilXfuusFrWBK+dqldtvkJYHtr7e/hebbEqrV7gTRE4/K6
         WCVEfMeMLlu9uxhtUDk63l4Ft6oy1W7l7Srlym1NA45eXaLJ0Lktwh1fUR2DxgEKp+1c
         JDbBoZ+GYWY+ZQ1jPv+XIkq9FF1vri5xatGUL64o3ftFFcBgx4qB+7H7OEeK529RQYHJ
         qq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGhImojv5JVZey8SNYSUrqN+tpOKlvVUWE4hzQpmBqw=;
        b=CStlNvNbgIyVCiImxEXGXtX0sLHSBH971PIzBHcsihnXIc/2bl+VSh6jzxDm86uVAF
         ERrIkQWIsvD79+9WXW/enACnkahPOskQYOy0joQ7B18VxvnxmWf27dXMezgvBJik4OI1
         ANtJkAO59E8ON7dA1BD/6LVuzahIXY5fSrV1swdLFA6r9fpF/8pVGEy5PFsGHJyRTXsJ
         7kfsLsA4LMc9/g7ZgAR6F5CvxtxezkZFat0zIWyjnTcInPn1IXlVypNyuxS1E1CUqAIq
         3qSr2DyTwcsjWcDERMTZgPSmi8GxxR2ldvmvKE7cGOKQbwPGKHMzd83Zq5KCKCx7hRzV
         t3/w==
X-Gm-Message-State: AOUpUlGtLmrU6U4dc2dWAE/4XjShR6w/8uQXU0AN2/gIh6eD6hHQWZmH
        tb/1JfPO05UCCPAqjnDBlTo=
X-Google-Smtp-Source: AA+uWPz4tXf67yD449S53KnicdPU4sOdVN5VYYHEsOmwkCvdcYbng7x1QrmgMecRXYCgfvuoLAxWLg==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr14264610ljf.102.1534238603845;
        Tue, 14 Aug 2018 02:23:23 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b87-v6sm3805669lfh.33.2018.08.14.02.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 02:23:23 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fpVXp-0003VI-6M; Tue, 14 Aug 2018 11:23:17 +0200
Date:   Tue, 14 Aug 2018 11:23:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180814092317.GA30344@localhost>
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

On Wed, Jul 25, 2018 at 11:21:22AM +0530, Keerthy wrote:
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

Nit: I'd place this above val to maintain the reverse xmas-tree style.

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

This is unnecessarily verbose; I'd rephrase it as something like:

	/* Retry in case roll over happened before alarm was armed. */

> +	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
> +						 OMAP_RTC_STATUS_REG)) &&
> +	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> +		goto again;

And this is clearly broken. First, you use boolean && instead of the &
bit operation.

Second, you need to check the status register *after* checking for
roll-over, as I already mentioned.

Also, use the rtc pointer rather than omap_rtc_power_off_rtc, which will
allow for more readable code.

I also strongly suggest you split the conditional, and use val to store
the status register value, that is:

	if (rtc_read(rtc, OMAP_RTC_SECONDS_REG) != seconds) {
		val = rtc_read(rtc, OMAP_RTC_STATUS_REG);
		if (!(val & OMAP_RTC_STATUS_ALARM2))
			goto again;
	}

> +
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

Johan
