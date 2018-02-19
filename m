Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeBSAHj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 19:07:39 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35205 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeBSAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 19:07:37 -0500
X-Google-Smtp-Source: AH8x225jmtE2eXO3rGzjTF23VzRL0+LNMl3LE2DK3I9tBcgKTKTPZ1ZWI3WOudhaDjBgOciS5taugw==
Date: Sun, 18 Feb 2018 18:07:35 -0600
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
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
Subject: Re: [PATCH v3 3/7] watchdog: sirfsoc: allow setting timeout in
 devicetree
Message-ID: <20180219000735.i5i3gne4idzzhxot@rob-hp-laptop>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211200847.25000-3-marcus.folkesson@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 09:08:43PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also
> let us to set timout-sec property in devicetree.

typo

> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt | 4 ++++
>  drivers/watchdog/sirfsoc_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> index 9cbc76c89b2b..0dce5e3100b4 100644
> --- a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> @@ -5,10 +5,14 @@ Required properties:
>  - reg: Address range of tick timer/WDT register set
>  - interrupts: interrupt number to the cpu
>  
> +Optional properties:
> +- timeout-sec : Contains the watchdog timeout in seconds
> +
>  Example:
>  
>  timer@b0020000 {
>  	compatible = "sirf,prima2-tick";
>  	reg = <0xb0020000 0x1000>;
>  	interrupts = <0>;
> +	timeout-sec = <30>;
>  };
> diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
> index 4eea351e09b0..ac0c9d2c4aee 100644
> --- a/drivers/watchdog/sirfsoc_wdt.c
> +++ b/drivers/watchdog/sirfsoc_wdt.c
> @@ -29,7 +29,7 @@
>  #define SIRFSOC_WDT_MAX_TIMEOUT		(10 * 60)	/* 10 mins */
>  #define SIRFSOC_WDT_DEFAULT_TIMEOUT	30		/* 30 secs */
>  
> -static unsigned int timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
> +static unsigned int timeout;

If you have an old dtb, then you still need the default.

>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  module_param(timeout, uint, 0);
> -- 
> 2.15.1
> 
