Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936169AbeEYOQq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:16:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46219 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934614AbeEYOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:16:45 -0400
Message-ID: <1527257797.3472.8.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 16:16:37 +0200
In-Reply-To: <20180525030153.15986-1-andrew.smirnov@gmail.com>
References: <20180525030153.15986-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 24.05.2018, 20:01 -0700 schrieb Andrey Smirnov:
> Make sure that MX51_PAD_GPIO1_1 does not remain configure as
> ALT0/SD1_WP (it is out of reset). This is needed because of external
> pull-up resistor attached to that pad that, when left unchanged, will
> drive SD1_WP high preventing eSDHC1/eMMC from working correctly.
> 
> To fix that add a pinmux configuration line configureing the pad to
> function as a GPIO. While we are at it, add a corresponding input GPIO
> hog in an effort to minimize current consumption.

Enabling the input part of the pad also consumes (a small amount of)
power, if you are after minimizing power consumption, better configure
the pin as output and drive it in the pull direction.

> 
> > Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index df9eca94d812..d484e7e46b27 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -476,6 +476,17 @@
> >  	status = "okay";
>  };
>  
> +&gpio1 {
> > +	unused-sd3-wp-gpio {
> > +		/*
> > +		 * See pinctrl_esdhc1 below for more details on this
> > +		 */
> > +		gpio-hog;
> > +		gpios = <1 GPIO_ACTIVE_HIGH>;
> > +		input;
> > +	};
> +};
> +
>  &i2c2 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_i2c2>;
> @@ -660,6 +671,23 @@
> > >  			MX51_PAD_SD1_DATA1__SD1_DATA1		0x20d5
> > >  			MX51_PAD_SD1_DATA2__SD1_DATA2		0x20d5
> > >  			MX51_PAD_SD1_DATA3__SD1_DATA3		0x20d5
> > +			/*
> > +			 * GPIO1_1 is not directly used by eSDHC1 in
> > +			 * any capacity, but earlier versions of RDU1
> > +			 * used that pin as WP GPIO for eSDHC3 and
> > +			 * because of that that pad has an external
> > +			 * pull-up resistor. This is problematic
> > +			 * because out of reset the pad is configured
> > +			 * as ALT0 which serves as SD1_WP, which, when
> > +			 * pulled high by and external pull-up, will
> > +			 * inhibit execution of any write request to
> > +			 * attached eMMC device.
> > +			 *
> > +			 * To avoid this problem we configure the pad
> > +                	 * to ALT1/GPIO and avoid driving SD1_WP
> +                	 * signal high.

Applying the patch complains about whitespace damage in the above 2
lines.

Regards,
Lucas
