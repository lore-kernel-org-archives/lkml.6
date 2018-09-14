Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BBCECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A4E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A4E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeINPlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:41:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38045 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeINPlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:41:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8279D208D9; Fri, 14 Sep 2018 12:27:42 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4EFE32080A;
        Fri, 14 Sep 2018 12:27:32 +0200 (CEST)
Date:   Fri, 14 Sep 2018 12:27:32 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: sama5d4: write the mode register in two
 steps
Message-ID: <20180914102732.GP14988@piout.net>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-3-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914101339.7382-3-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2018 12:13:39+0200, Romain Izard wrote:
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

Hum, that is really weird because when I developed
015b528644a84b0018d3286ecd6ea5f82dce0180, I tested with a program doing:

	flags = WDIOS_DISABLECARD;
	ioctl(fd, WDIOC_SETOPTIONS, &flags);
	for (i = 16; i > 2; i--) {
		ioctl(fd, WDIOC_SETTIMEOUT, &i);
	}

	ioctl(fd, WDIOC_KEEPALIVE, &dummy);

	flags = WDIOS_ENABLECARD;
	ioctl(fd, WDIOC_SETOPTIONS, &flags);

	for (i = 16; i > 2; i--) {
		ioctl(fd, WDIOC_SETTIMEOUT, &i);
	}

This would immediately reproduce the reset when changing WDV/WDD with
WDDIS set.

I'll test again.

> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
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

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
