Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2797A21714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2797A21714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeHXNju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:39:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35796 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:39:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D927383DCC; Fri, 24 Aug 2018 12:05:52 +0200 (CEST)
Date:   Fri, 24 Aug 2018 12:05:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: lm3697: Introduce the lm3697 driver
Message-ID: <20180824100549.GC4045@amd>
References: <20180817151528.21623-1-dmurphy@ti.com>
 <20180817151528.21623-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20180817151528.21623-2-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +/**
> + * struct lm3697 -
> + * @enable_gpio - Hardware enable gpio
> + * @regulator - LED supply regulator pointer
> + * @client - Pointer to the I2C client
> + * @regmap - Devices register map
> + * @dev - Pointer to the devices device struct
> + * @lock - Lock for reading/writing the device
> + * @leds - Array of LED strings.
> + */

extra .

> +	ret =3D regmap_write(led->priv->regmap, brt_msb_reg, brt_val);
> +	if (ret) {
> +		dev_err(&led->priv->client->dev, "Cannot write MSB\n");
> +		goto out;
> +	}
> +out:

I'd avoid this goto.

> +static int lm3697_set_control_bank(struct lm3697 *priv)
> +{
> +	u8 control_bank_config =3D 0;
> +	struct lm3697_led *led;
> +	int ret, i;
> +
> +	led =3D &priv->leds[0];
> +	if (led->control_bank =3D=3D LM3697_CONTROL_A)
> +		led =3D &priv->leds[1];

I'd expect CONTROL_A to correspond to leds[0]...?

> +	for (i =3D 0; i < LM3697_MAX_LED_STRINGS; i++) {
> +		if (led->hvled_strings[i] =3D=3D LM3697_HVLED_ASSIGNMENT)
> +			control_bank_config |=3D 1 << i;
> +	}

Extra {}s.

> +	priv->regulator =3D devm_regulator_get(&priv->client->dev, "vled");
> +	if (IS_ERR(priv->regulator))
> +		priv->regulator =3D NULL;

If vled regulator is specified in dt and _get fails, is it worth a
warning?

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlt/2H0ACgkQMOfwapXb+vLSQACfbOzfw9WCO0CVnAcjrNIxSKyz
eS8An0UchEiAIjiBDMn9u7bzWP9+Sx9C
=7GoP
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
