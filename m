Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeBGIwA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:52:00 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:42642 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeBGIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:51:58 -0500
Date: Wed, 7 Feb 2018 09:51:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/6] pinctrl: sunxi: support pin controllers with
 holes among IRQ banks
Message-ID: <20180207085146.dvgwkdjq7ybhohwh@flea>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ux2zf7yiedaeoze7"
Content-Disposition: inline
In-Reply-To: <20180203154942.63566-2-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ux2zf7yiedaeoze7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 03, 2018 at 11:49:37PM +0800, Icenowy Zheng wrote:
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunx=
i/pinctrl-sunxi.h
> index 11b128f54ed2..fae732c8c548 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> @@ -110,7 +110,7 @@ struct sunxi_pinctrl_desc {
>  	int				npins;
>  	unsigned			pin_base;
>  	unsigned			irq_banks;
> -	unsigned			irq_bank_base;
> +	const unsigned int		*irq_bank_map;
>  	bool				irq_read_needs_mux;
>  	bool				disable_strict_mode;
>  };
> @@ -263,12 +263,21 @@ static inline u32 sunxi_pull_offset(u16 pin)
>  	return pin_num * PULL_PINS_BITS;
>  }
> =20
> -static inline u32 sunxi_irq_cfg_reg(u16 irq, unsigned bank_base)
> +static inline u32 sunxi_irq_hw_bank_num(u8 bank, const unsigned int *ban=
k_map)
> +{
> +	if (!bank_map)
> +		return bank;
> +	else
> +		return bank_map[bank];
> +}

=46rom a function API PoV, I guess it would make more sense and be
cleaner to simply pass the sunxi_pinctrl_desc structure (as the first
argument) and have the function there read that structure and act upon
it.

Giving it just a blank pointer, without any size indication, and
either dereferencing it without any boundary check, or changing the
behaviour based on whether it's null or not seems pretty fragile.

I guess you could do it in two patches. One to change the function
prototypes to call the sunxi_irq_cfg_reg function (and all its caller)
to have the prototype (struct sunxi_pinctrl_desc *desc, u16 irq).

And then in a later patch change the behaviour to introduce the map.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--ux2zf7yiedaeoze7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp6viEACgkQ0rTAlCFN
r3QE9g//ca+2HfiXxwPgoIsFYBi5mDXgmveHQPbG+0OGbEA9sJFInAqTTlEbyfdS
bzoSBq8YM/TybROB+0TWDu/WIdF51XIuHRFHXUyLbGziqYql9zcWg4vgLpirtgTj
Yg2LsMLjyOSOmYB+WlDMg0PejNmopPYCmlHj5cw9Scm7wnbdrKO3DQH+QRev/IsW
YCgdc7pCFpmUvbBDprO0AVfFyBTqXJfVaHdkE8X++JdJ22YvhjA4yN2VKNLUUdK9
2AuXN8JIzJr/QZS5ihjlmvTyRx+s064is2L+2SuezEuZuOyXxI+GSTfLgmoqQDxV
udp1rBSXTOtKudBwOSukjIVZT8Dro+h+S9vD0wN6n46fCHxc8XecEUHxwu3JRgOK
lmzd3tcEItrbrZ+yP8XwHdDKNQIduHjnPCGbsuu+WuEGV2+ZhgHUbcJtk8HrJm+g
/jQUiqNuqck1pLnfvJ/AhMQCR5bm+0PXGlBzxdfARbJjocAO7//kx80PS9sQRnx6
eXyZLq+vrEB9Zp9BfCO/2FT4iZ1oe3HL5+OW1yzlXFVjQHqyMz2YWGnGHveg0evQ
FMAj4/fe3Zf505eWZWb67YkBOujRpzKbT2f8hzvgV2hcUNEu0h52i0f0DGpWO9Ik
Aatui+23xqmOvt6clPDRWSoxcWUFdvUGz6UXwyX6ThsEEEhz8a0=
=z/dS
-----END PGP SIGNATURE-----

--ux2zf7yiedaeoze7--
