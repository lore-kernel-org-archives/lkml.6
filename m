Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92066C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B6A2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfAGRt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:49:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47466 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfAGRt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:49:27 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 90759808DB; Mon,  7 Jan 2019 18:49:19 +0100 (CET)
Date:   Mon, 7 Jan 2019 18:49:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/5] leds: Add helper for getting default pattern from
 Device Tree
Message-ID: <20190107174924.GD933@amd>
References: <1546596524-19863-1-git-send-email-krzk@kernel.org>
 <1546596524-19863-3-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <1546596524-19863-3-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Multiple LED triggers might need to access default pattern so add a
> helper for that.
>=20
>  }
>  EXPORT_SYMBOL_GPL(led_update_brightness);
> =20
> +u32 *led_get_default_pattern(struct led_classdev *led_cdev, unsigned int=
 *size)
> +{
> +	struct device_node *np =3D dev_of_node(led_cdev->dev);
> +	u32 *pattern;
> +	int count;
> +
> +	if (!np)
> +		return NULL;
> +
> +	count =3D of_property_count_u32_elems(np, "led-pattern");
> +	if (count < 0)
> +		return NULL;
> +
> +	pattern =3D kcalloc(count, sizeof(*pattern), GFP_KERNEL);
> +	if (!pattern)
> +		return NULL;
> +
> +	if (of_property_read_u32_array(np, "led-pattern", pattern, count))
> +		goto err;

Just kfree and return here. No need for goto if that is just one case.


>  /**
> + * led_get_default_pattern - return default pattern
> + *
> + * @led_cdev: the LED to get default pattern for
> + * @size:     pointer for storing the number of elements in returned arr=
ay,
> + *            modified only if return !=3D NULL
> + *
> + * Return:    Allocated array of integers with default pattern from Devi=
ceTree
> + *            or NULL.  Caller is responsible for kfree().
> + */

"DeviceTree" -> "device tree".

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwzkSQACgkQMOfwapXb+vLwSgCfdaKAiixyvS4Tz4W44YVe4BPx
GycAoKUZZI+UmdPW/GG9OipPvZBV68Mn
=zeZf
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
