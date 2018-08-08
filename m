Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99791C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6247221A38
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6247221A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbeHHWUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:20:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38327 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeHHWUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:20:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 906958064C; Wed,  8 Aug 2018 21:59:09 +0200 (CEST)
Date:   Wed, 8 Aug 2018 21:59:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: lm3697: Introduce the lm3697 driver
Message-ID: <20180808195909.GC20912@amd>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180807160442.8937-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <20180807160442.8937-2-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduce the lm3697 LED driver for
> backlighting and display.
>=20
> Datasheet location:
> http://www.ti.com/lit/ds/symlink/lm3697.pdf
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

> +
> +#define LM3697_HVLED1_2_3_A		0
> +#define LM3697_HVLED1_B_HVLED2_3_A	1
> +#define LM3697_HVLED2_B_HVLED1_3_A	2
> +#define LM3697_HVLED1_2_B_HVLED3_A	3
> +#define LM3697_HVLED3_B_HVLED1_2_A	4
> +#define LM3697_HVLED1_3_B_HVLED2_A	5
> +#define LM3697_HVLED1_A_HVLED2_3_B	6
> +#define LM3697_HVLED1_2_3_B		7

That's rather long and verbose way to describe a bitmap, right?

> +static const struct regmap_config lm3697_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register =3D LM3697_CTRL_ENABLE,
> +	.reg_defaults =3D lm3697_reg_defs,
> +	.num_reg_defaults =3D ARRAY_SIZE(lm3697_reg_defs),
> +	.cache_type =3D REGCACHE_RBTREE,
> +};

Is rbtree good idea? You don't have that many registers.

> +static int lm3697_init(struct lm3697 *priv)
> +{
> +	int ret;
> +
=2E...
> +		regmap_write(priv->regmap, LM3697_RESET, LM3697_SW_RESET);

No error checking required here?

> +	if (priv->control_bank_config < LM3697_HVLED1_2_3_A ||
> +	    priv->control_bank_config > LM3697_HVLED1_2_3_B) {
> +		dev_err(&priv->client->dev, "Control bank configuration is out of rang=
e\n");
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	device_for_each_child_node(priv->dev, child) {
> +		led =3D &priv->leds[i];
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &led->control_bank);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "reg DT property missing\n");
> +			goto child_out;
> +		}
> +
> +		fwnode_property_read_string(child, "linux,default-trigger",
> +					    &led->led_dev.default_trigger);
> +
> +		ret =3D fwnode_property_read_string(child, "label", &name);
> +		if (ret)
> +			snprintf(led->label, sizeof(led->label),
> +				"%s::", priv->client->name);
> +		else
> +			snprintf(led->label, sizeof(led->label),
> +				 "%s:%s", priv->client->name, name);
> +
> +
> +		led->priv =3D priv;
> +		led->led_dev.name =3D led->label;
> +		led->led_dev.brightness_set_blocking =3D lm3697_brightness_set;
> +
> +		ret =3D devm_led_classdev_register(priv->dev, &led->led_dev);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "led register err: %d\n", ret);
> +			goto child_out;
> +		}
> +
> +		if (priv->control_bank_config =3D=3D LM3697_HVLED1_2_3_A ||
> +		    priv->control_bank_config =3D=3D LM3697_HVLED1_2_3_B)
> +			goto child_out;

This checks if we have just one bank, I see it. Should it also check
the led actually uses the correct bank?

> +		i++;
> +		fwnode_handle_put(child);
> +	}
> +
> +child_out:
> +	fwnode_handle_put(child);

Is not the fwnode_handle_put() done twice for non-error case?

> +	ret =3D lm3697_init(led);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}

The if is not needed here.

> +static int lm3697_remove(struct i2c_client *client)
> +{
> +	struct lm3697 *led =3D i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret =3D regmap_update_bits(led->regmap, LM3697_CTRL_ENABLE,
> +				 LM3697_CTRL_A_B_EN, 0);
> +	if (ret) {
> +		dev_err(&led->client->dev, "Failed to disable regulator\n");
> +		return ret;

Misleading, this does nothing with regulators.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrS40ACgkQMOfwapXb+vL+tgCfWiL4OedfDaGO5nplfYMJD/P5
Ph0AoLvOkyCnWOFDRqOxI/NCkQr1vKOl
=UFS0
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
