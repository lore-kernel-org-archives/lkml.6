Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB765C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558BA20989
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558BA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLIIR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 03:17:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51108 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeLIIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 03:17:26 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0F7BC807E4; Sun,  9 Dec 2018 09:17:19 +0100 (CET)
Date:   Sun, 9 Dec 2018 09:17:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] leds: trigger: Add pattern initialization from
 Device Tree
Message-ID: <20181209081722.GB7561@amd>
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
 <1544185974-5932-4-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <1544185974-5932-4-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-12-07 13:32:54, Krzysztof Kozlowski wrote:
> Allow initialization of pattern used in pattern trigger from Device Tree
> property.
>=20
> This is especially useful for embedded systems where the pattern trigger
> would be used to indicate the process of boot status in a nice,
> user-friendly blinking way.  This initialization pattern will be used
> till user-space is brought up and sets its own pattern, indicating the
> boot status is for example finished.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/leds/trigger/ledtrig-pattern.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigge=
r/ledtrig-pattern.c
> index 1870cf87afe1..96309d3bc43c 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -11,6 +11,7 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/timer.h>
> =20
> @@ -331,6 +332,21 @@ static const struct attribute_group *pattern_trig_gr=
oups[] =3D {
>  	NULL,
>  };
> =20
> +static void pattern_init(struct led_classdev *led_cdev)
> +{
> +	struct device_node *np =3D dev_of_node(led_cdev->dev);
> +	const char *pattern;
> +
> +	if (!np)
> +		return;
> +
> +	if (!of_property_read_string(np, "linux,trigger-pattern", &pattern)) {
> +		if (strlen(pattern))
> +			pattern_trig_store_patterns(led_cdev, pattern,
> +						    strlen(pattern), false);
> +	}
> +}

"  if (of_...())
      return;

   if (!strlen())
       return"

Check return value of pattern_trig_store_patterns().
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwMz5IACgkQMOfwapXb+vKt0gCfRJ7ayW23MMx0p+3b3Q04WCQT
SYkAnjG0ho7SbuWAkTPa2GD8Ps1q2Prh
=hXws
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
