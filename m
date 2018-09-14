Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA7ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D342083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNvTskKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D342083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIOCpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:45:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40609 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeIOCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:45:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so4736322plp.7;
        Fri, 14 Sep 2018 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1w4T8MQ1D00c8c39poICnF9PjfT9QzjBedt6qyZsCFI=;
        b=FNvTskKDIdiIGvH4m68wApgNWyjYJIPqPDzr9sA7KEjXDRTH6XBmnv+6SvMlQCJvPG
         oF06+Ninao0y1HaD4+r98UF7FmIX2EJsDkdBjFOndtfRKc6TwvM2HJAvm6AgVD+ABqZ/
         XrvN7V8Y6TwchAr3LUJXvA7B20Ga/59/+F9zFUAtlAezrl4elZhrFjLqPoZqaOIYrRyn
         gdtxMQ1hColacxkvegSQ4VmssHCuiodRtRf3Y7JSgxJJhmC/FzqoVs0lp0xYMj5zYlOn
         ExH6bispvp6QBbBDye+3MP+wWujKzSxGe6H0MsmW6C3tGXicyDUEVIRlPeiGfX8pLJjO
         8IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1w4T8MQ1D00c8c39poICnF9PjfT9QzjBedt6qyZsCFI=;
        b=PER8qzXN7Q3p+dZ0CWDl5jnV/IhFPMI1PCCqrFBB+f3ubBx2bWI5WyyUPxvQ1Qcd4x
         bhO2u0hiz/bYnw9vy15JEaSNjYN2S0E/TL+hGEex+WA6Xf/sgUmVtCqYCSZ2HKwRGKHV
         EP42p+VLfXElaTOkOdSt6amdNMTm5ypMqefx8H7h0JagvET60gDNRcbGHjiBkmYSHTmJ
         dgPJiiN2ofK3GwOilAtTE9Cd4N3Akin72DkJ391BEir7EnArjTefo9WwZti4cM8pjAxh
         UBmSqXyjiuj6G9FkDXGx7+DPK/KpDfcaQnLpQ6m6LB7WkZeTFeYUKm80yDEXAll3QiKD
         qoKQ==
X-Gm-Message-State: APzg51B1z/566Hri6l+pA9GbPRVJGrBZPpIBtSz6M9noHIlEL10Ihyp5
        +v9MpEPsa9doTWpc659qntU=
X-Google-Smtp-Source: ANB0VdbYOjGosMUsfmZq+XBDRh3MhznCPqfromnez/XuXkUuxJqbnX7spsa0mN85E59OJkqhE3MsAg==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr13643488pla.325.1536960556726;
        Fri, 14 Sep 2018 14:29:16 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u184-v6sm14697862pgd.46.2018.09.14.14.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 14:29:16 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:29:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: sama5d4: write the mode register in two
 steps
Message-ID: <20180914212915.GA31857@roeck-us.net>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-3-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914101339.7382-3-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:13:39PM +0200, Romain Izard wrote:
> The specification for SAMA5D2 and SAMA5D4 chips, that use this IP for
> their watchdog timer, has the following advice regarding the Mode Register:
> 
> "When setting the WDDIS bit, and while it is set, the fields WDV and WDD
> must not be modified."
> 
> I have observed on a board based on a SAMA5D2 chip that using any other
> timeout duration than the default 16s in the device tree will reset the
> board when the watchdog device is opened; this is probably due to ignoring
> the aforementioned constraint.
> 
> To fix this, read the content of the Mode Register before writing it,
> and split the access into two parts if WDV or WDD need to be changed.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

That code now looks terribly complicated. Assuming it is indeed necessary,
would it be possible to update the affected register in its own function ?

Guenter

> ---
>  drivers/watchdog/sama5d4_wdt.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 1e93c1b0e3cf..1e05268ad94b 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -46,7 +46,10 @@ MODULE_PARM_DESC(nowayout,
>  	"Watchdog cannot be stopped once started (default="
>  	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> -#define wdt_enabled (!(wdt->mr & AT91_WDT_WDDIS))
> +#define wdt_enabled(reg) (!((reg) & AT91_WDT_WDDIS))
> +
> +#define wdt_different_counters(reg_a, reg_b) \
> +	(((reg_a) ^ (reg_b)) & (AT91_WDT_WDV | AT91_WDT_WDD))
>  
>  #define wdt_read(wdt, field) \
>  	readl_relaxed((wdt)->reg_base + (field))
> @@ -78,8 +81,11 @@ static void wdt_write_nosleep(struct sama5d4_wdt *wdt, u32 field, u32 val)
>  static int sama5d4_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 reg = wdt_read(wdt, AT91_WDT_MR);
>  
>  	wdt->mr &= ~AT91_WDT_WDDIS;
> +	if (!wdt_enabled(reg) && wdt_different_counters(reg, wdt->mr))
> +		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
>  	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
>  
>  	return 0;
> @@ -88,8 +94,11 @@ static int sama5d4_wdt_start(struct watchdog_device *wdd)
>  static int sama5d4_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 reg = wdt_read(wdt, AT91_WDT_MR);
>  
>  	wdt->mr |= AT91_WDT_WDDIS;
> +	if (wdt_enabled(reg) && wdt_different_counters(reg, wdt->mr))
> +		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
>  	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
>  
>  	return 0;
> @@ -122,7 +131,7 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
>  	 * If the watchdog is enabled, then the timeout can be updated. Else,
>  	 * wait that the user enables it.
>  	 */
> -	if (wdt_enabled)
> +	if (wdt_enabled(wdt->mr))
>  		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
>  
>  	wdd->timeout = timeout;
> @@ -186,13 +195,17 @@ static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
>  	 * If the watchdog is already running, we can safely update it.
>  	 * Else, we have to disable it properly.
>  	 */
> -	if (wdt_enabled) {
> +	reg = wdt_read(wdt, AT91_WDT_MR);
> +	if (wdt_enabled(reg)) {
> +		if (!wdt_enabled(wdt->mr))
> +			wdt_write_nosleep(wdt, AT91_WDT_MR,
> +					  wdt->mr & ~AT91_WDT_WDDIS);
>  		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
> -	} else {
> -		reg = wdt_read(wdt, AT91_WDT_MR);
> -		if (!(reg & AT91_WDT_WDDIS))
> +	} else if (wdt_enabled(wdt->mr)) {
> +		if (wdt_different_counters(reg, wdt->mr))
>  			wdt_write_nosleep(wdt, AT91_WDT_MR,
> -					  reg | AT91_WDT_WDDIS);
> +					  reg & ~AT91_WDT_WDDIS);
> +		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
>  	}
>  	return 0;
>  }
> -- 
> 2.17.1
> 
