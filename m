Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeBUM0q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:26:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51116 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeBUM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:26:45 -0500
Date: Wed, 21 Feb 2018 12:26:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: support ROHM BD28623 codec
Message-ID: <20180221122639.GH8334@sirena.org.uk>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-3-suzuki.katsuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D6IIOQQv2Iwyp54J"
Content-Disposition: inline
In-Reply-To: <20180221043311.25840-3-suzuki.katsuhiro@socionext.com>
X-Cookie: Condense soup, not books!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D6IIOQQv2Iwyp54J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 01:33:11PM +0900, Katsuhiro Suzuki wrote:

> +++ b/sound/soc/codecs/bd28623.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BD28623MUV class D speaker amplifier codec driver.
> + *

Please make the entire comment C++ so this looks intentional.

> +		dev_err(dev, "Failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	gpiod_set_value(bd->reset_gpio, 0);

Since this GPIO is not needed in atomic contexts you should use the
_cansleep() versions of the GPIO functions - it doesn't cost you
anything and means that if for some reason someone wired this up to a
GPIO that can't be used in atomic context the driver will just work.

> +	bd->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						 GPIOD_OUT_HIGH);

> +	bd->mute_gpio = devm_gpiod_get_optional(dev, "mute",
> +						GPIOD_OUT_HIGH);

These properties were documented as mandatory in the binding but are
optional here.  It's fine that they're optional but I'd expect the
binding to be consistent with this.

> +static int bd28623_remove(struct platform_device *pdev)
> +{
> +	struct bd28623_priv *bd = platform_get_drvdata(pdev);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(bd->supplies), bd->supplies);
> +
> +	return 0;
> +}

We don't enable the supplies explicitly as part of the probe function so
it feels wrong to disable on remove() - I'm sure it is fine in practice
as-is but I'd have to think too hard to confirm that.  I'd put this in a
component level remove function instead so that it's consistent.

--D6IIOQQv2Iwyp54J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNZX8ACgkQJNaLcl1U
h9DNAQf9FMSYO+XzOf0FlGdUNepbhpojEFe1cMVQrWpLcByW145hU9fzr1zi6Bj4
A2orZHrJcODhcCmwqVJ3UX0mlKlYuDKN+DfQ2QXGIg3Hic3FXEBN9XySXB3eto5d
rwpyHRJBNTZUC7R81N9Bg2zYqhcQjynZu1smSas4iBCTlAGZK3J/Ukwhz3ycL/fr
YU7P0QjjqH9Z3eLHrk7WVuIYLDjH7n/BbiZfKVFX/4c9Rhu3o7o5iYEHYSGnFfnx
PaPnLnkgFd8inLLG6WcujCQqN1RGw8ZACSLRNB9MRDsqIlEkuGSmc+rliW190zYI
IaPz4u38Uz6EF/CWa8XjNYJltC73Ww==
=UtZM
-----END PGP SIGNATURE-----

--D6IIOQQv2Iwyp54J--
