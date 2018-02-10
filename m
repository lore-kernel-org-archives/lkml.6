Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeBJLKX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 06:10:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4613 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751041AbeBJLKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 06:10:09 -0500
X-UUID: 06b3e4914d9842828f0bf09ac6ff9cec-20180210
Message-ID: <1518261002.9025.36.camel@mtkswgap22>
Subject: Re: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in
 devicetree
From: Sean Wang <sean.wang@mediatek.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date: Sat, 10 Feb 2018 19:10:02 +0800
In-Reply-To: <20180210091911.3644-5-marcus.folkesson@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
         <20180210091911.3644-5-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Marcus

The changes you made for dt-bindings and driver should be put into
separate patches.

And the property timeout-sec seems to be generic enough to all devices,
so why not add a common document to describe it and allow those devices
to refer to, like other dt-bindings for other kinds of devices usually
did.

	Sean

On Sat, 2018-02-10 at 10:19 +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also
> let us to set timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
>  drivers/watchdog/mtk_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 5b38a30e608c..859dee167b91 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -11,9 +11,13 @@ Required properties:
>  
>  - reg : Specifies base physical address and size of the registers.
>  
> +Optional properties:
> +- timeout-sec: contains the watchdog timeout in seconds.
> +
>  Example:
>  
>  wdt: watchdog@10000000 {
>  	compatible = "mediatek,mt6589-wdt";
>  	reg = <0x10000000 0x18>;
> +	timeout-sec = <10>;
>  };
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 7ed417a765c7..fcdc10ec28a3 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -57,7 +57,7 @@
>  #define DRV_VERSION		"1.0"
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -static unsigned int timeout = WDT_MAX_TIMEOUT;
> +static unsigned int timeout;
>  
>  struct mtk_wdt_dev {
>  	struct watchdog_device wdt_dev;
