Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C080C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B9B258EC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B9B258EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeFYMSs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:18:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39403 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbeFYMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:18:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BE224804DF; Mon, 25 Jun 2018 14:18:45 +0200 (CEST)
Date:   Mon, 25 Jun 2018 14:18:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jacek.anaszewski@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180625121845.GA32505@amd>
References: <046c0cf717cbdfd55dcdc2bb7463642734e2ca4c.1529902636.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <046c0cf717cbdfd55dcdc2bb7463642734e2ca4c.1529902636.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-06-25 13:03:19, Baolin Wang wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> Some LED controllers have support for autonomously controlling
> brightness over time, according to some preprogrammed pattern or
> function.
>=20
> This adds a new optional operator that LED class drivers can implement
> if they support such functionality as well as a new device attribute to
> configure the pattern for a given LED.

Thanks for doing this!

> index 5f67f7a..fe90a12 100644
> --- a/Documentation/ABI/testing/sysfs-class-led
> +++ b/Documentation/ABI/testing/sysfs-class-led
> @@ -61,3 +61,19 @@ Description:
>  		gpio and backlight triggers. In case of the backlight trigger,
>  		it is useful when driving a LED which is intended to indicate
>  		a device in a standby like state.
> +
> +What: /sys/class/leds/<led>/pattern
> +Date: June 2018
> +KernelVersion: 4.18
> +Description:
> +	Specify a pattern for the LED, for LED hardware that support
> +	altering the brightness as a function of time.
> +
> +	The pattern is given by a series of tuples, of brightness and
> +	duration (ms). The LED is expected to traverse the series and
> +	each brightness value for the specified duration.
> +
> +	As LED hardware might have different capabilities and precision
> +	the requested pattern might be slighly adjusted by the driver
> +	and the resulting pattern of such operation should be returned
> +	when this file is read.

I'd add "Duration of 0 means brightness should immediately change to
new value."

> +	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> +	struct led_pattern *pattern =3D NULL;
> +	unsigned long val;
> +	char *sbegin;
> +	char *elem;
> +	char *s;
> +	int ret, len =3D 0;
> +	bool odd =3D true;
> +
> +	s =3D sbegin =3D kstrndup(buf, size, GFP_KERNEL);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	/* Trim trailing newline */
> +	s[strcspn(s, "\n")] =3D '\0';

Is substring function best to use here? Will it do the right thing
when \n is not present?

> +	/* If the remaining string is empty, clear the pattern */
> +	if (!s[0]) {
> +		ret =3D led_cdev->pattern_clear(led_cdev);
> +		goto out;
> +	}
> +
> +	pattern =3D kcalloc(size, sizeof(*pattern), GFP_KERNEL);
> +	if (!pattern) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Parse out the brightness & delta_t touples and check for repeat */
> +	while ((elem =3D strsep(&s, " ")) !=3D NULL) {
> +		ret =3D kstrtoul(elem, 10, &val);
> +		if (ret)
> +			goto out;
> +
> +		if (odd) {
> +			pattern[len].brightness =3D val;
> +		} else {
> +			/* Ensure we don't have any delta_t =3D=3D 0 */
> +			if (!val) {
> +				ret =3D -EINVAL;
> +				goto out;
> +			}

I believe we should support delta_t of 0 for "change immediately".

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsw3aUACgkQMOfwapXb+vLt+QCcCQM6p1A9z775Txs04aCXPq42
CmkAn1DZXhwYTIju7ZPCqHgm2PV/X9pe
=+BsR
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
