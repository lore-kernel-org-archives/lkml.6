Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D2E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D2E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965425AbeFRPHV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38527 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964906AbeFRPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6254C8057A; Mon, 18 Jun 2018 17:07:15 +0200 (CEST)
Date:   Mon, 18 Jun 2018 17:07:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        y2038@lists.linaro.org, Kees Cook <keescook@chromium.org>,
        Willy Tarreau <w@1wt.eu>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-activity: use ktime_get_boot_ns()
Message-ID: <20180618150715.GA30470@amd>
References: <20180618144210.72367-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20180618144210.72367-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> get_monotonic_boottime() is deprecated, so let's convert this to
> the simpler ktime_get_boot_ns().
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Have you tested it?

> diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigg=
er/ledtrig-activity.c
> index 5081894082bd..589c1bc4d0b9 100644
> --- a/drivers/leds/trigger/ledtrig-activity.c
> +++ b/drivers/leds/trigger/ledtrig-activity.c
> @@ -37,7 +37,6 @@ static void led_activity_function(struct timer_list *t)
>  	struct activity_data *activity_data =3D from_timer(activity_data, t,
>  							 timer);
>  	struct led_classdev *led_cdev =3D activity_data->led_cdev;
> -	struct timespec boot_time;
>  	unsigned int target;
>  	unsigned int usage;
>  	int delay;
> @@ -57,7 +56,7 @@ static void led_activity_function(struct timer_list *t)
>  		return;
>  	}
> =20
> -	get_monotonic_boottime(&boot_time);
> +	curr_boot =3D ktime_get_boot_ns();
> =20
>  	cpus =3D 0;
>  	curr_used =3D 0;
> @@ -76,7 +75,6 @@ static void led_activity_function(struct timer_list *t)
>  	 * down to 16us, ensuring we won't overflow 32-bit computations below
>  	 * even up to 3k CPUs, while keeping divides cheap on smaller systems.
>  	 */
> -	curr_boot =3D timespec_to_ns(&boot_time) * cpus;

Original code is pretty weird (notice the * cpus), so I'm
double-checking.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsnyqMACgkQMOfwapXb+vK/uQCZAYTmI74qMgeQqz0FH7Sa5OPu
rUoAn1VvVHnQiLdQXQp3rI6H+fvFl0a1
=0SR+
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
