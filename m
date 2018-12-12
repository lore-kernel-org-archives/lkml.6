Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A434EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C83720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C83720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kleine-koenig.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLLKv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:51:29 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:45650 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeLLKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:51:29 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 5683B4DA80C; Wed, 12 Dec 2018 11:51:26 +0100 (CET)
Date:   Wed, 12 Dec 2018 11:51:24 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [3/3] pwm: imx: Implement get_state() function for hardware
 readout
Message-ID: <20181212105118.GA9268@taurus.defre.kleine-koenig.org>
References: <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 01, 2018 at 04:19:48PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Implement the get_state() function and set the initial state to reflect
> real state of the hardware. This allows to keep the PWM running if it was
> enabled in bootloader. It is very similar to the GPIO behavior. GPIO pin
> set as output in bootloader keep the same setting in Linux unless it is
> reconfigured.
>=20
> If we find the PWM block enabled we need to prepare and enable its source
> clock otherwise the clock will be disabled late in the boot as unused.
> That will leave the PWM in enabled state but with disabled clock. That has
> a side effect that the PWM output is left at its current level at which
> the clock was disabled. It is totally non-deterministic and it may be LOW
> or HIGH.

Does this problem still exist if the pwm-imx driver is a module?

> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 7a4907b..6cd3b72 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -83,6 +83,9 @@
> =20
>  #define MX3_PWM_SWR_LOOP		5
> =20
> +/* PWMPR register value of 0xffff has the same effect as 0xfffe */
> +#define MX3_PWMPR_MAX			0xfffe
> +
>  struct imx_chip {
>  	struct clk	*clk_per;
> =20
> @@ -93,6 +96,55 @@ struct imx_chip {
> =20
>  #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
> =20
> +static void imx_pwm_get_state(struct pwm_chip *chip,
> +		struct pwm_device *pwm, struct pwm_state *state)

broken alignment.

> +{
> +	struct imx_chip *imx =3D to_imx_chip(chip);
> +	u32 period, prescaler, pwm_clk, ret, val;
> +	u64 tmp;
> +
> +	val =3D readl(imx->mmio_base + MX3_PWMCR);
> +
> +	if (val & MX3_PWMCR_EN) {
> +		state->enabled =3D true;
> +		ret =3D clk_prepare_enable(imx->clk_per);
> +		if (ret)
> +			return;
> +	} else {
> +		state->enabled =3D false;
> +	}
> +
> +	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
> +	case MX3_PWMCR_POUTC_NORMAL:
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +		break;
> +	case MX3_PWMCR_POUTC_INVERTED:
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +		break;
> +	default:
> +		dev_warn(chip->dev, "can't set polarity, output disconnected");

Should we return an error here?

> +	}
> +
> +	prescaler =3D MX3_PWMCR_PRESCALER_GET(val);
> +	pwm_clk =3D clk_get_rate(imx->clk_per);
> +	pwm_clk =3D DIV_ROUND_CLOSEST_ULL(pwm_clk, prescaler);
> +	val =3D readl(imx->mmio_base + MX3_PWMPR);

It would be more cautionous to not rely on the reserved bits to read as
zero. So I suggest to mask the value with 0xffff.

> +	period =3D val >=3D MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
> +
> +	/* PWMOUT (Hz) =3D PWMCLK / (PWMPR + 2) */
> +	tmp =3D NSEC_PER_SEC * (u64)(period + 2);
> +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);

Would it make sense to introduce a policy about how to round in this
case? (Similarily for .apply?) This is of course out of scope for this
patch.

> +
> +	/* PWMSAR can be read only if PWM is enabled */
> +	if (state->enabled) {
> +		val =3D readl(imx->mmio_base + MX3_PWMSAR);
> +		tmp =3D NSEC_PER_SEC * (u64)(val);
> +		state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> +	} else {
> +		state->duty_cycle =3D 0;
> +	}
> +}
> +
>  static int imx_pwm_config_v1(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> @@ -272,6 +324,7 @@ static const struct pwm_ops imx_pwm_ops_v1 =3D {
> =20
>  static const struct pwm_ops imx_pwm_ops_v2 =3D {
>  	.apply =3D imx_pwm_apply_v2,
> +	.get_state =3D imx_pwm_get_state,
>  	.owner =3D THIS_MODULE,
>  };
> =20

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlwQ6CIACgkQwfwUeK3K
7AlMWgf9Gj9lIoShtg2SzUGV34HsRZ0VXDzyUeASF86bsQechN8iN5SsR+PQNmgC
LtStIJnVKknQz2FhdgcRfXo2wUVBpMIvmsyJSH4IhmYVd51u1TX8sigjIMZarofi
pN2Hy2jua0pwxQeOWicEgXO3ukl9yoOlQc6C716Gaf4fjxXCYddEUz3EyXEXumQM
XijO9J1bx22fr4hEmxCve95rV6xP2mpjhyvRLhVGFwR8RWlTj+ToOJQZ4Kv7j9hU
uc+S1G+WcV+Z8bvufh3Vko/C1pWwNfI6mD73X9sOapJVfQ7Wscx9Q4U6EoJBfmx/
PTxjDqSQvSuVUg+T4Hk7C5of+trTGw==
=+grv
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
