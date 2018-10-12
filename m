Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A03C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A39B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A39B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJLQfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:35:31 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:47766 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJLQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:35:30 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Oct 2018 12:35:28 EDT
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id A9CA540D0A4; Fri, 12 Oct 2018 10:57:25 +0200 (CEST)
Date:   Fri, 12 Oct 2018 10:57:24 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        kernel@pengutronix.de
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Message-ID: <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 10, 2018 at 09:33:26AM +0000, Vok=C3=A1=C4=8D Michal wrote:
> Normally the PWM output is held LOW when PWM is disabled. This can cause
> problems when inverted PWM signal polarity is needed. With this behavior
> the connected circuit is fed by 100% duty cycle instead of being shut-off.
>=20
> Allow users to define a "gpio" and a "pwm" pinctrl states. The pwm pinctrl
> state is then selected when PWM is enabled and the gpio pinctrl state is
> selected when PWM is disabled. Also add a new pwm-gpios GPIO that is used
> to drive the output in the gpio state.
>=20
> If all the pinctrl states and the pwm-gpios are not correctly specified
> in DT the logic will work as before.
>=20
> As an example, with this patch a PWM controlled backlight with inversed
> signal polarity can be used in full brightness range. Without this patch
> the backlight can not be turned off as brightness =3D 0 disables the PWM
> and that in turn set PWM output LOW, that is full brightness.
>=20
> Output of the PWM with "default" pinctrl and with "pwm"+"gpio" pinctrl:
>=20
> +--------------+------------+---------------+---------------------------+
> | After reset  | Bootloader | Linux pinctrl | User (sysfs, backlight..) |
> | 100k pull-up | (not used) |               |   enable    |   disable   |
> +--------------+------------+---------------+---------------------------+
>  ___________________________    default        _   _   _
>                             |_________________| |_| |_| |_|_____________
>=20
>                                pwm + gpio
>  ___________________________________________   _   _   _   _____________
>                                             |_| |_| |_| |_|

I was made aware of this patch by Thierry while discussion about a patch
opportunity. I already pointed out some stuff I don't like about this
patch in the repective thread, but I repeat it here to have it at the
right place.

> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
> Changes in v2:
>  - Utilize the "pwm" and "gpio" pinctrl states.
>  - Use the pwm-gpios signal to drive the output in "gpio" pinctrl state.
>  - Select the right pinctrl state in probe.=20
>=20
>  drivers/pwm/pwm-imx.c | 86 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 86 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 6cd3b72..3502123 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -10,11 +10,13 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
> @@ -92,10 +94,45 @@ struct imx_chip {
>  	void __iomem	*mmio_base;
> =20
>  	struct pwm_chip	chip;
> +
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_pins_gpio;
> +	struct pinctrl_state *pinctrl_pins_pwm;
> +	struct gpio_desc *pwm_gpiod;

The pinctrl framework already knows about "init" and "default". These
should be enough. i.e. "init" configures as gpio and "default" als pwm.

>  };
> =20
> +
>  #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
> =20
> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> +		struct platform_device *pdev)
> +{
> +	imx_chip->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> +	if (!imx_chip->pinctrl || IS_ERR(imx_chip->pinctrl)) {
> +		dev_info(&pdev->dev, "can not get pinctrl\n");
> +		return PTR_ERR(imx_chip->pinctrl);
> +	}
> +
> +	imx_chip->pinctrl_pins_pwm =3D pinctrl_lookup_state(imx_chip->pinctrl,
> +			"pwm");
> +	imx_chip->pinctrl_pins_gpio =3D pinctrl_lookup_state(imx_chip->pinctrl,
> +			"gpio");
> +	imx_chip->pwm_gpiod =3D devm_gpiod_get_optional(&pdev->dev, "pwm",
> +			GPIOD_IN);
> +
> +	if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER) {

You must not use PTR_ERR on a value that might not contain an error
pointer.

> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(imx_chip->pwm_gpiod) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_pwm) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_gpio)) {

Would it be more correct to handle imx_chip->pinctrl_pins_pwm =3D=3D
ERR_PTR(-EPROBE_DEFER) similar to imx_chip->pwm_gpiod =3D=3D
ERR_PTR(-EPROBE_DEFER)?

> +		dev_dbg(&pdev->dev, "PWM pinctrl information incomplete\n");

I wouldn't call that "incomplete". It's incomplete for the gpio
switching trick, but enough in general.

> +		devm_pinctrl_put(imx_chip->pinctrl);
> +		imx_chip->pinctrl =3D NULL;
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx_pwm_get_state(struct pwm_chip *chip,
>  		struct pwm_device *pwm, struct pwm_state *state)
>  {
> @@ -306,7 +343,31 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  					MX3_PWMCR_POUTC_INVERTED);
> =20
>  		writel(cr, imx->mmio_base + MX3_PWMCR);
> +
> +		/*
> +		 * If we are in charge of pinctrl then switch output to
> +		 * the PWM signal.
> +		 */
> +		if (imx->pinctrl)
> +			pinctrl_select_state(imx->pinctrl,
> +					imx->pinctrl_pins_pwm);
>  	} else if (cstate.enabled) {
> +		/*
> +		 * PWM block will be disabled. Normally its output will be set
> +		 * low no matter what output polarity is configured. Lets use

s/Lets/Let's/

> +		 * pinctrl to switch the output pin to GPIO functon and keep
> +		 * the output at the same level as for duty-cycle =3D 0.

Is it obvious that using a GPIO is more efficient/better/worth the
complexity than just enabling the PWM with duty-cycle 0 and the right
polarity?

> +		 * First set the GPIO to the desired level, then switch the
> +		 * muxing and at last disable PWM. In that order we do not get
> +		 * unwanted logic level changes on the output.
> +		 */
> +		if (imx->pinctrl) {
> +			gpiod_set_value_cansleep(imx->pwm_gpiod, 0);

You must call gpiod_direction_output for this to have any effect.
There might be mechanisms in pincontrol that automatically mux the pin
if it's configured as gpio, I didn't follow the details though.

Also it should be possible to configure the GPIO as output immediatly.
If the pinmuxing is set to the PWM function this doesn't have a visible
side effect.

> +			pinctrl_select_state(imx->pinctrl,
> +					imx->pinctrl_pins_gpio);

Usually align function arguments to the opening (.

> +		}
> +
>  		writel(0, imx->mmio_base + MX3_PWMCR);
> =20
>  		clk_disable_unprepare(imx->clk_per);
> @@ -354,6 +415,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  	const struct of_device_id *of_id =3D
>  			of_match_device(imx_pwm_dt_ids, &pdev->dev);
>  	const struct imx_pwm_data *data;
> +	struct pwm_state cstate;
>  	struct imx_chip *imx;
>  	struct resource *r;
>  	int ret =3D 0;
> @@ -385,6 +447,10 @@ static int imx_pwm_probe(struct platform_device *pde=
v)
>  		imx->chip.of_pwm_n_cells =3D 3;
>  	}
> =20
> +	ret =3D imx_pwm_init_pinctrl_info(imx, pdev);
> +	if (ret)
> +		return ret;
> +
>  	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(imx->mmio_base))
> @@ -394,6 +460,26 @@ static int imx_pwm_probe(struct platform_device *pde=
v)
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (imx->pinctrl) {
> +		/*
> +		 * Update cstate after pwmchip_add() call as the core might
> +		 * call the get_state() function to read the PWM registers
> +		 * to get the actual HW=C2=A0state.
> +		 */
> +		pwm_get_state(imx->chip.pwms, &cstate);
> +		if (cstate.enabled) {
> +			dev_dbg(&pdev->dev,
> +				"PWM entered probe in enabled state\n");
> +			pinctrl_select_state(imx->pinctrl,
> +					imx->pinctrl_pins_pwm);
> +		} else {
> +			gpiod_set_value_cansleep(imx->pwm_gpiod, 0);
> +			pinctrl_select_state(imx->pinctrl,
> +					imx->pinctrl_pins_gpio);
> +
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, imx);
>  	return 0;
>  }=0D

There is nothing in this patch that would prevent this code to live in a
place where other drivers could reuse this. (But attention, there are
dragons: Thierry already replied on my topic that his view is different
in this aspect compared to other maintainers though. His POV is that as
long as there is only a single driver known that has a problem this
should be handled in driver specific code.)

Best regards
Uwe

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlvAYewACgkQwfwUeK3K
7An/9Qf/fyd8YM2jWB8ajTv19XqGj/FKEOkLF+Qn4n+BBfmqhm3qmPSOx/DNtWZX
p7286gPgPHvMV5qJrapxt2RwD5CLlbLEH0ddsye5ahob7vOPhhiHpqdn0DDlweoC
Rr6ztZImE76GqTW+QXSmiQSuXcSpSwtGXXir0FSUlxjBI6ZGFNX5tiiwJSIS55C4
0CPrQPouZ/tdBQlXHHQhZxmrY8ijBRX2p78yWiaTEtBIN9YQcpcQGdqyWLdzOtu5
04EDP6+Vegn7dv2R3Kg9pOn9ZKt4PYrM5RHg0k1vCioToqrZNJ6evVd1QdTh+2Jo
AqFrT7pPMpR0xf+mz5od/bOdt5vnyg==
=Qd+g
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
