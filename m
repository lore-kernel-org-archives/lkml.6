Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932390AbeBLBMC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:12:02 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38030 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeBLBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:12:00 -0500
X-Google-Smtp-Source: AH8x225HVbQbUM5hoPBvcxdXfJWK7rZr/XvTKVFBfqGJDLk4WL7MB+3cpid4dTNOU0vji/2sBguRNw==
Date: Sun, 11 Feb 2018 17:11:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [v3, 7/7] watchdog: coh901327: make use of timeout-secs provided
 in devicetree
Message-ID: <20180212011158.GA4778@roeck-us.net>
References: <20180211200847.25000-7-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211200847.25000-7-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 09:08:47PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Notes:
>     v3:
>     	- Reformat and use coh901327_wdt.timeout instead of margin when print out
>     	  timout in probe function.
>     
>     v2:
>     	- Set .timeout in coh901327_wdt structure declaration.
>     	- Set .min_timeout to 1 instead of 0. I could not find a datasheet
>     	  for coh901327, so I'm not sure if 0 is valid. However, 0 seems
>     	  wrong to me and most driver has 1 as min value. If it should
>     	  be 0, please let me know and I have to set another initial
>     	  value for margin.
> 
>  drivers/watchdog/coh901327_wdt.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 4410337f4f7f..500af8a7ec5a 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -67,7 +67,9 @@
>  #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
>  
>  /* Default timeout in seconds = 1 minute */
> -static unsigned int margin = 60;
> +#define U300_WDOG_DEFAULT_TIMEOUT					60
> +
> +static unsigned int margin;
>  static int irq;
>  static void __iomem *virtbase;
>  static struct device *parent;
> @@ -235,8 +237,9 @@ static struct watchdog_device coh901327_wdt = {
>  	 * timeout register is max
>  	 * 0x7FFF = 327670ms ~= 327s.
>  	 */
> -	.min_timeout = 0,
> +	.min_timeout = 1,
>  	.max_timeout = 327,
> +	.timeout = U300_WDOG_DEFAULT_TIMEOUT,
>  };
>  
>  static int __exit coh901327_remove(struct platform_device *pdev)
> @@ -315,16 +318,15 @@ static int __init coh901327_probe(struct platform_device *pdev)
>  		goto out_no_irq;
>  	}
>  
> -	ret = watchdog_init_timeout(&coh901327_wdt, margin, dev);
> -	if (ret < 0)
> -		coh901327_wdt.timeout = 60;
> +	watchdog_init_timeout(&coh901327_wdt, margin, dev);
>  
>  	coh901327_wdt.parent = dev;
>  	ret = watchdog_register_device(&coh901327_wdt);
>  	if (ret)
>  		goto out_no_wdog;
>  
> -	dev_info(dev, "initialized. timer margin=%d sec\n", margin);
> +	dev_info(dev, "initialized. (timeout=%d sec)\n",
> +			coh901327_wdt.timeout);
>  	return 0;
>  
>  out_no_wdog:
