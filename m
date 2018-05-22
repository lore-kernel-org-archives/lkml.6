Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeEVU5b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:57:31 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:40411 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbeEVU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:57:29 -0400
Date: Tue, 22 May 2018 13:57:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 2/5] watchdog: sp805: add 'timeout-sec' DT property
 support
Message-ID: <20180522205727.GC16363@roeck-us.net>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-3-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527014840-21236-3-git-send-email-ray.jui@broadcom.com>
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

On Tue, May 22, 2018 at 11:47:17AM -0700, Ray Jui wrote:
> Add support for optional devicetree property 'timeout-sec'.
> 'timeout-sec' is used in the driver if specified in devicetree.
> Otherwise, fall back to driver default, i.e., 60 seconds
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sp805_wdt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 03805bc..1484609 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -230,7 +230,14 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  	spin_lock_init(&wdt->lock);
>  	watchdog_set_nowayout(&wdt->wdd, nowayout);
>  	watchdog_set_drvdata(&wdt->wdd, wdt);
> -	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
> +
> +	/*
> +	 * If 'timeout-sec' devicetree property is specified, use that.
> +	 * Otherwise, use DEFAULT_TIMEOUT
> +	 */
> +	wdt->wdd.timeout = DEFAULT_TIMEOUT;
> +	watchdog_init_timeout(&wdt->wdd, 0, &adev->dev);
> +	wdt_setload(&wdt->wdd, wdt->wdd.timeout);
>  
>  	ret = watchdog_register_device(&wdt->wdd);
>  	if (ret) {
> -- 
> 2.1.4
> 
