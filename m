Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC3C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A50F20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A50F20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeLLMWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:22:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48836 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeLLMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:22:29 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3993B808A8; Wed, 12 Dec 2018 13:22:24 +0100 (CET)
Date:   Wed, 12 Dec 2018 13:22:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] leds: Add helper for getting default pattern from
 Device Tree
Message-ID: <20181212122227.GB11088@amd>
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
 <1544613406-27026-3-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <1544613406-27026-3-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-12-12 12:16:43, Krzysztof Kozlowski wrote:
> Multiple LED triggers might need to access default pattern so add a
> helper for that.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

>=20
> New patch in the series
>=20
> ---
>  drivers/leds/led-class.c | 25 +++++++++++++++++++++++++
>  include/linux/leds.h     |  3 +++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 3c7e3487b373..44b95e6480f6 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -17,6 +17,7 @@
>  #include <linux/leds.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
> @@ -244,6 +245,30 @@ static int led_classdev_next_name(const char *init_n=
ame, char *name,
>  }
> =20
>  /**
> + * led_classdev_get_default_pattern - return default pattern
> + *
> + * @led_cdev: the led_classdev structure for this device
> + *
> + * Return: Null terminated string with default pattern from DeviceTree o=
r NULL
> + */

Is it valid kerneldoc? Note that core still owns the string so that
caller is not expected to free it?

> +const char *led_classdev_get_default_pattern(struct led_classdev *led_cd=
ev)
> +{
> +	struct device_node *np =3D dev_of_node(led_cdev->dev);
> +	const char *pattern;
> +
> +	if (!np)
> +		return NULL;
> +
> +	if (of_property_read_string(np, "led-pattern", &pattern))
> +		return NULL;
> +
> +	if (!strlen(pattern))
> +		return NULL;
> +
> +	return pattern;
> +}
> +
> +/**
>   * of_led_classdev_register - register a new object of led_classdev clas=
s.
>   *
>   * @parent: parent of LED device
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 5263f87e1d2c..9da2bfa183ea 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -129,6 +129,9 @@ struct led_classdev {
>  	struct mutex		led_access;
>  };
> =20
> +extern const char *
> +led_classdev_get_default_pattern(struct led_classdev *led_cdev);
> +
>  extern int of_led_classdev_register(struct device *parent,
>  				    struct device_node *np,
>  				    struct led_classdev *led_cdev);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwQ/YMACgkQMOfwapXb+vLbXQCeOrSfPUqCFsd0ECVrOCUM3f+G
WmEAnRjThNENbuJyDkq3HyF/myVYs3V5
=djrX
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
