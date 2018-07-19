Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED05ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5C02084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCFepHAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5C02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeGSLMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:12:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43037 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeGSLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:12:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so5641222lfc.10;
        Thu, 19 Jul 2018 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZvWPv3Vzt0oNb6jYie3Dd1xHllH4fU+rjquPR1U5PCk=;
        b=QCFepHAhBGxy8TqFwI9nBIt0Rg+k2ZZoBA/jD2quOUOjiJMuz0xnW+Kjmn4t4J9IEp
         H8bmOZ+kI3PSyAovgP0y3kjReiRGSMlJ2cIffzCUZgPnwXWHRopquqAjXhUqXe62HtaZ
         7XwNFcQFi+d4mwgAPpGjFWI59r/gd3zqeQPGS+Yi5jz2R6TzNSVn5Di1Yj6RL+/e0cHP
         NMFk+y95eBv3aUNoIc3nHV874uKJBABwgmtnkdLqK+eGnhfl+3QPfGn4fpEwd09Mta5d
         6qj4wPJFAmJOwnfyaznLc8piCrCa2ONA+WA33swuW+AoBwdehC6PAbCBsony7gjg343c
         rPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZvWPv3Vzt0oNb6jYie3Dd1xHllH4fU+rjquPR1U5PCk=;
        b=dvRjZAhduWpNOpSLRvXIFmr1GUz2PUn4mksfK56D2kOKnbg2hMQ/YZfoXRa6CgBw/R
         rY6DGdqTLLvSCmQTVo9LdMArwA29NfYjOEq4ZvdF1u7v0xZLUbp00SjgX0q1bPEKWgwX
         STBDTxztbMlotaNtyqz79jxsRDJG6dgXnfSlStGLyNsEw5h9G6atfakmbCiOU5Avo+Ot
         knRVTcOSVrCjk+ZNZFNULa8dfw/VKaPuviwwfsinl0h4Y/WT2YiPwWxwNi4m6kMmor8Z
         evT8QrFQOrvL9rGoHdon2Pq127hfGNdI8uVtTYO58tNBc9MTlkEcOvN6PjrxzCoi+rFg
         P7Rw==
X-Gm-Message-State: AOUpUlGwfxFysm8tOQb7RBchbztM5rPo8jP+dwdlj5mOPsSv8fJjk+60
        i9D9dMZIoeiE/crTVrntMog=
X-Google-Smtp-Source: AAOMgpeM7pdzCR4Xz3xr037H6ETqRBbk7y/9V5kW51UF6OASeAonNsi4Qptg7MM057T5n/f+ffQVgA==
X-Received: by 2002:a19:e4c1:: with SMTP id x62-v6mr6264627lfi.76.1531996191457;
        Thu, 19 Jul 2018 03:29:51 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id l3-v6sm909139lfi.36.2018.07.19.03.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:29:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fg6Bm-00052f-88; Thu, 19 Jul 2018 12:29:38 +0200
Date:   Thu, 19 Jul 2018 12:29:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v4 2/4] rtc: OMAP: Add support for rtc-only mode
Message-ID: <20180719102938.GR10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-3-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531372060-10532-3-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:37:38AM +0530, Keerthy wrote:
> Prepare rtc driver for rtc-only with DDR in self-refresh mode.
> omap_rtc_power_off now should cater to two features:
> 
> 1) RTC plus DDR in self-refresh is power a saving mode where in the
> entire system including the different voltage rails from PMIC are
> shutdown except the ones feeding on to RTC and DDR. DDR is kept in
> self-refresh hence the contents are preserved. RTC ALARM2 is connected
> to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
> DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
> ALARM1 triggers waking up the system[1]. The control goes to bootloader.
> The bootloader then checks RTC scratchpad registers to confirm it was an
> rtc_only wakeup and follows a different path, configure bare minimal
> clocks for ddr and then jumps to the resume address in another RTC
> scratchpad registers and transfers the control to Kernel. Kernel then
> restores the saved context. omap_rtc_power_off_program does the ALARM2
> programming part.
> 
>      [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884
> 
> 2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
> above omap_rtc_power_off_program function and in addition to that
> programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
> the pushbutton and shuts off the PMIC.
> 
> Hence the split in omap_rtc_power_off.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 53 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 88da927..cb19ece 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -415,21 +415,12 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  
>  static struct omap_rtc *omap_rtc_power_off_rtc;
>  
> -/*
> - * omap_rtc_poweroff: RTC-controlled power off
> - *
> - * The RTC can be used to control an external PMIC via the pmic_power_en pin,
> - * which can be configured to transition to OFF on ALARM2 events.
> - *
> - * Notes:
> - * The two-second alarm offset is the shortest offset possible as the alarm
> - * registers must be set before the next timer update and the offset
> - * calculation is too heavy for everything to be done within a single access
> - * period (~15 us).
> - *
> - * Called with local interrupts disabled.
> +/**
> + * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
> + * generates pmic_pwr_enable control, which can be used to control an external
> + * PMIC.

Since this is kerneldoc, you need an empty line after "sequence." above.

You should also add a comment that this function depends on local
interrupts being disabled when called (for the wait_not_busy handling); 
and make sure you follow that in subsequent patches.

>   */
> -static void omap_rtc_power_off(void)
> +static int omap_rtc_power_off_program(struct device *dev)

dev is never used in this function.

>  {
>  	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
>  	struct rtc_time tm;
> @@ -456,7 +447,7 @@ static void omap_rtc_power_off(void)
>  	if (tm2bcd(&tm) < 0) {
>  		dev_err(&rtc->rtc->dev, "power off failed\n");
>  		rtc->type->lock(rtc);
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	rtc_wait_not_busy(rtc);
> @@ -481,6 +472,38 @@ static void omap_rtc_power_off(void)
>  		goto again;
>  	rtc->type->lock(rtc);
>  
> +	return 0;
> +}
> +
> +/*
> + * omap_rtc_poweroff: RTC-controlled power off
> + *
> + * The RTC can be used to control an external PMIC via the pmic_power_en pin,
> + * which can be configured to transition to OFF on ALARM2 events.
> + *
> + * Notes:
> + * The one-second alarm offset is the shortest offset possible as the alarm
> + * registers must be set before the next timer update and the offset
> + * calculation is too heavy for everything to be done within a single access
> + * period (~15 us).

This note really doesn't make much sense anymore, and should have been
updated as part of the previous patch.

> + *
> + * Called with local interrupts disabled.
> + */
> +static void omap_rtc_power_off(void)
> +{
> +	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;

Use struct omap_rtc here as before.

> +	u32 val;
> +
> +	omap_rtc_power_off_program(rtc->dev.parent);
> +
> +	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
> +	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
> +	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
> +	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
> +			OMAP_RTC_PMIC_EXT_WKUP_EN(0);
> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
> +	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);

What is all this, and why is it here?

Surely fiddling with this register after you've set the alarm to trigger
isn't the right thing to do.

> +
>  	/*
>  	 * Wait for alarm to trigger (within two seconds) and external PMIC to
>  	 * power off the system. Add a 500 ms margin for external latencies

Johan
