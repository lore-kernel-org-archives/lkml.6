Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033535AbeEXQTH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:19:07 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:47408 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030620AbeEXQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:19:03 -0400
Date: Thu, 24 May 2018 09:19:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 4/6] watchdog: sp805: set WDOG_HW_RUNNING when
 appropriate
Message-ID: <20180524161901.GB28425@roeck-us.net>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
 <1527120924-12131-5-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527120924-12131-5-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 05:15:22PM -0700, Ray Jui wrote:
> If the watchdog hardware is already enabled during the boot process,
> when the Linux watchdog driver loads, it should reset the watchdog and
> tell the watchdog framework. As a result, ping can be generated from
> the watchdog framework, until the userspace watchdog daemon takes over
> control
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I have one question, though: Is it really correct that both
INT_ENABLE _and_ RESET_ENABLE have to be set to enable the watdog ?
What if only RESET_ENABLE is set ?

Thanks,
Guenter

> ---
>  drivers/watchdog/sp805_wdt.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 1484609..d662a6f 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -42,6 +42,7 @@
>  	/* control register masks */
>  	#define	INT_ENABLE	(1 << 0)
>  	#define	RESET_ENABLE	(1 << 1)
> +	#define	ENABLE_MASK	(INT_ENABLE | RESET_ENABLE)
>  #define WDTINTCLR		0x00C
>  #define WDTRIS			0x010
>  #define WDTMIS			0x014
> @@ -74,6 +75,15 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout,
>  		"Set to 1 to keep watchdog running after device release");
>  
> +/* returns true if wdt is running; otherwise returns false */
> +static bool wdt_is_running(struct watchdog_device *wdd)
> +{
> +	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 wdtcontrol = readl_relaxed(wdt->base + WDTCONTROL);
> +
> +	return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;
> +}
> +
>  /* This routine finds load value that will reset system in required timout */
>  static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>  {
> @@ -239,6 +249,15 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  	watchdog_init_timeout(&wdt->wdd, 0, &adev->dev);
>  	wdt_setload(&wdt->wdd, wdt->wdd.timeout);
>  
> +	/*
> +	 * If HW is already running, enable/reset the wdt and set the running
> +	 * bit to tell the wdt subsystem
> +	 */
> +	if (wdt_is_running(&wdt->wdd)) {
> +		wdt_enable(&wdt->wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +
>  	ret = watchdog_register_device(&wdt->wdd);
>  	if (ret) {
>  		dev_err(&adev->dev, "watchdog_register_device() failed: %d\n",
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
