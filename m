Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F112C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B39208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME/gjCVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B39208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbeGKN7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:59:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46235 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:59:16 -0400
Received: by mail-lf0-f67.google.com with SMTP id l16-v6so21347608lfc.13;
        Wed, 11 Jul 2018 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIW7ZboyrFFtIfcd9tTtjAcTsH4qzGQ1IFWMMbdWZrw=;
        b=ME/gjCVR5OrgB0+LhZ7lx/iUHD5WVtdwRvgHq98bz8bwmSKhpyI/wI3uK9DBtWNbkp
         GxP1re/73m4WtBaH9gH8XPeqa4r6E2baKr5eqGRtn3srEU75zcKl34CmkdfbyZi5x9Bi
         mN/TLAs9+D4CFHFxg7PiAXCP/ZMY9jGcdtUtJuC2I8cffhUQn7E4ToFmmaq8ipeiqRlv
         D3zU829NVs6xTzdCrKg8qfn57eRSMC5hTwgmirGE6QoqCcUS4HTNzAIQkTxKN+3mUfMJ
         9tArJ+FHtxqq0WnZGDrc/GOwYYFa2m6fFphTkKjGeN6YdNhZGO2tn9u7rIEVDhFAAPIf
         a6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIW7ZboyrFFtIfcd9tTtjAcTsH4qzGQ1IFWMMbdWZrw=;
        b=sfJw9yysjOT0HJDjcoe979RGUrSg0esChHE6NJiZ9EUkWupyN12IocPsTjI7cQL6t4
         iWvmIscTFa8L6uNi6GNwstHUV9zgeS5v++tvSPtGbQMTZAsmjjB8+0PqEiFHcxydpJ3w
         sK7ryfsc9EvtDH2IO0C1SygDkLNfxqvOuR8zljwTP3oQkWougigbb1r+8ovSich01lqT
         GTiugmJViMbHAC9IwdGqhWn6oNm+aOZTrfapYA58e7MSmeOnIM/P3bDcNpTpzxEaS/Vn
         bkK2zV105hEjJazQyn6Jw0noB2Utp/aDUV37A1u8Nkr6zaKKpa0pTYWmB/WnqeMM86Xg
         f3ew==
X-Gm-Message-State: APt69E0sk5Rpb57XB6X2PYMbtQhpFxav/ISyv/1AeuuPIsOCoZW9accl
        qK6Qy5T82ziCrxUHsAfZmGo6Iiho
X-Google-Smtp-Source: AAOMgpcrgEEm28Vav/GIV+m8zzS9V5j9u6xXvmH1cZWdulgarmWTXY8qT6U1uB9WeYE3tasE2oCe5g==
X-Received: by 2002:a19:b519:: with SMTP id e25-v6mr5863253lff.119.1531317286648;
        Wed, 11 Jul 2018 06:54:46 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id b14-v6sm5074247lfa.62.2018.07.11.06.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:54:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fdFZs-0004ZS-3O; Wed, 11 Jul 2018 15:54:44 +0200
Date:   Wed, 11 Jul 2018 15:54:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v3 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180711135444.GC12517@localhost>
References: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
 <1531205452-6086-2-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531205452-6086-2-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:20:49PM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 323ff55..14f2241 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -441,11 +441,12 @@ static void omap_rtc_power_off(void)
>  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>  
> -	/* set alarm two seconds from now */
> +again:
> +	/* set alarm one second from now */
>  	omap_rtc_read_time_raw(rtc, &tm);
>  	bcd2tm(&tm);
>  	rtc_tm_to_time(&tm, &now);
> -	rtc_time_to_tm(now + 2, &tm);
> +	rtc_time_to_tm(now + 1, &tm);
>  
>  	if (tm2bcd(&tm) < 0) {
>  		dev_err(&rtc->rtc->dev, "power off failed\n");
> @@ -455,6 +456,10 @@ static void omap_rtc_power_off(void)
>  
>  	rtc_wait_not_busy(rtc);
>  
> +	/* Our calculations started right before the rollover, try again */
> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> +		goto again;

First, this doesn't even compile.

Second, nothing is preventing the rollover from happening here after the
check. 

> +
>  	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
>  	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
>  	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);

Johan
