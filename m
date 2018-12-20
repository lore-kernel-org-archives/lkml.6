Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DDD20866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbeLTMfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:35:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60681 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730044AbeLTMfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:35:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D948320801; Thu, 20 Dec 2018 13:35:16 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7C13A207D4;
        Thu, 20 Dec 2018 13:35:06 +0100 (CET)
Date:   Thu, 20 Dec 2018 13:35:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] ARM: mxs: cfa10036: Fixup OLED display reset
 polarity
Message-ID: <20181220123505.GH2188@piout.net>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
 <1545308005-51559-5-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545308005-51559-5-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 12:13:57+0000, Vokáč Michal wrote:
> There was a bug in reset signal generation in ssd1307fb OLED driver.
> The display needs an active-low reset signal but the driver produced
> the correct sequence only if the GPIO used for reset was specified as
> GPIO_ACTIVE_HIGH.
> 
> Now as the OLED driver is fixed it is also necessarry to implement
> a fixup for all current users of the old DT ABI. There is only one
> in-tree user and that is the Crystalfontz CFA-10036 board. In case
> this board is booting and GPIO_ACTIVE_HIGH is used for reset we
> override it to GPIO_ACTIVE_LOW.
> 

Honestly, the platform has been discontinued and I don't really think
it is worth having that fixup in the tree forever.

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes from v1:
>  - Add R-by from Rob
>  - Use of_property_read_variable_u32_array to read the GPIO specifier
>    array instead of reading it manualy in for cycle. (Rob)
> 
>  arch/arm/mach-mxs/mach-mxs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 1c6062d..50038d6 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -21,6 +21,7 @@
>  #include <linux/reboot.h>
>  #include <linux/micrel_phy.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -268,9 +269,52 @@ static void __init apx4devkit_init(void)
>  					   apx4devkit_phy_fixup);
>  }
>  
> +#define OLED_RESET_GPIO_LEN	3
> +#define OLED_RESET_GPIO_SIZE	(OLED_RESET_GPIO_LEN * sizeof(u32))
> +
> +static void __init crystalfontz_oled_reset_fixup(void)
> +{
> +	struct property *newgpio;
> +	struct device_node *np;
> +	u32 *gpiospec;
> +	int ret;
> +
> +	np = of_find_compatible_node(NULL, NULL, "solomon,ssd1306fb-i2c");
> +	if (!np)
> +		return;
> +
> +	newgpio = kzalloc(sizeof(*newgpio) + OLED_RESET_GPIO_SIZE, GFP_KERNEL);
> +	if (!newgpio)
> +		return;
> +
> +	newgpio->value = newgpio + 1;
> +	newgpio->length = OLED_RESET_GPIO_SIZE;
> +	newgpio->name = kstrdup("reset-gpios", GFP_KERNEL);
> +	if (!newgpio->name) {
> +		kfree(newgpio);
> +		return;
> +	}
> +
> +	gpiospec = newgpio->value;
> +	ret = of_property_read_variable_u32_array(np, "reset-gpios", gpiospec,
> +						  OLED_RESET_GPIO_LEN, 0);
> +
> +	if (ret < 0) {
> +		kfree(newgpio);
> +		return;
> +	}
> +
> +	if (!(gpiospec[2] & OF_GPIO_ACTIVE_LOW)) {
> +		gpiospec[2] |= OF_GPIO_ACTIVE_LOW;
> +		cpu_to_be32_array(gpiospec, gpiospec, OLED_RESET_GPIO_LEN);
> +		of_update_property(np, newgpio);
> +	}
> +}
> +
>  static void __init crystalfontz_init(void)
>  {
>  	update_fec_mac_prop(OUI_CRYSTALFONTZ);
> +	crystalfontz_oled_reset_fixup();
>  }
>  
>  static void __init duckbill_init(void)
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
