Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeBZJBt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:01:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40801 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeBZJAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:00:51 -0500
Date: Mon, 26 Feb 2018 10:00:38 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, wens@csie.org, Claudiu.Beznea@microchip.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
Message-ID: <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
References: <20180225135308.GA14561@arx-s1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qll7qxses6t7myt2"
Content-Disposition: inline
In-Reply-To: <20180225135308.GA14561@arx-s1>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qll7qxses6t7myt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for respinning this serie. It looks mostly good, but you still
have a quite significant number of checkpatch (--strict) warnings that
you should address.

On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
> +#define CAPTURE_IRQ_ENABLE_REG	0x0010
> +#define CFIE(ch)	BIT(ch << 1 + 1)
> +#define CRIE(ch)	BIT(ch << 1)

You should also put your argument between parentheses here (and in all
your other macros).

> +static const u16 div_m_table[] =3D {
> +	1,
> +	2,
> +	4,
> +	8,
> +	16,
> +	32,
> +	64,
> +	128,
> +	256
> +};

If this is just a power of two, you can use either the power of two /
ilog2 to switch back and forth, instead of using that table.

> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +		struct pwm_state *state)
> +{
> +	int ret;
> +	struct sun8i_pwm_chip *sun8i_pwm =3D to_sun8i_pwm_chip(chip);
> +	struct pwm_state cstate;
> +
> +	pwm_get_state(pwm, &cstate);
> +	if (!cstate.enabled) {
> +		ret =3D clk_prepare_enable(sun8i_pwm->clk);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to enable PWM clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	spin_lock(&sun8i_pwm->ctrl_lock);

What do you need that spinlock for? Can you use a mutex instead?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--qll7qxses6t7myt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqTzLUACgkQ0rTAlCFN
r3SqOg//bo7m7IUR7oYaiZbqV2DycgSB6AAogE2/r1a6VnXdnqndUd/7wd0OPG0C
lxdFSuONBYUgz0nrl7gobSCN59TMN4b2IFVW547jvjxZ95s5D8otpujTFTQes2kx
ss37r7SCClQvmtr8H3uJYiIzt7NGRVT+/XUGSthHGVBZmkgHdpWfDboiDFyko3ZU
bC4lofM2UoOOAsfHns9AZE+9BiXhZ7/sT7q19Msmd4zcC8xv5Su6b1zZAkSHvI1J
9kay0dUMzI37/1XqR6xAMWQeMybK4sO9+OKnSYYmID7NKrTGdTA0G0rUsLOa+QTf
ycMkUYJoq6ddxejrpNzHrkTuhJ9FGGZEoYtDT4gpH9LWC96/8Asq3VIrX/Gxg8uM
6DjYa4ehkGxBMZ74wyBDxn71w9Pv1OlIgbg/AtvDt4QcvVMI6cF+yy8Qnj0YSu3w
If9eybVDcdBUEp6d+xT0eq/JOJ2sqxRsIRwrXSiaVc9379yeO0EpJsT1bXF7P5zw
fHhCYfUByrvOEDE+Ql/0LCn2y6FyrHQ6jc4kuEpf9ZdqDw6On4WQFardROmkeN87
ThtGBKNX5n4fb1rLA/qgVlQp1vt2ULGRkiBjklMbxglIlbiyTSZmM+m+UfZJSmtV
4qvUCB7rzWd3SveRbF1fm/XNXpjFTfwxaBdBRtjuEHcTK4u+s3E=
=LwIi
-----END PGP SIGNATURE-----

--qll7qxses6t7myt2--
