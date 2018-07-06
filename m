Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE4BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEBD22439
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEBD22439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeGFPF4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:05:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49258 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeGFPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:05:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6A60C271227
Date:   Fri, 6 Jul 2018 17:05:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: stop using getnstimeofday64()
Message-ID: <20180706150550.pimear2arcldfua6@earth.universe>
References: <20180618142352.3556062-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2lia7tdfe3hg3oc"
Content-Disposition: inline
In-Reply-To: <20180618142352.3556062-1-arnd@arndb.de>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x2lia7tdfe3hg3oc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 18, 2018 at 04:23:29PM +0200, Arnd Bergmann wrote:
> getnstimeofday64() is deprecated in favor of the ktime_get() family.
>=20
> The direct replacement would be ktime_get_real_ts64(), but we only need
> the seconds value, and it seems better to use boottime than real time
> to avoid unexpected behavior with a concurrent settimeofday().
>=20
> ktime_get_seconds() might also work, but it seems better to use
> boottime than monotonic time since I assume that the charging
> process continues during suspend.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index d9c6c7bedd85..02356f9b5f22 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -379,15 +379,13 @@ static int ab8500_fg_is_low_curr(struct ab8500_fg *=
di, int curr)
>   */
>  static int ab8500_fg_add_cap_sample(struct ab8500_fg *di, int sample)
>  {
> -	struct timespec64 ts64;
> +	time64_t now =3D ktime_get_boottime_seconds();
>  	struct ab8500_fg_avg_cap *avg =3D &di->avg_cap;
> =20
> -	getnstimeofday64(&ts64);
> -
>  	do {
>  		avg->sum +=3D sample - avg->samples[avg->pos];
>  		avg->samples[avg->pos] =3D sample;
> -		avg->time_stamps[avg->pos] =3D ts64.tv_sec;
> +		avg->time_stamps[avg->pos] =3D now;
>  		avg->pos++;
> =20
>  		if (avg->pos =3D=3D NBR_AVG_SAMPLES)
> @@ -400,7 +398,7 @@ static int ab8500_fg_add_cap_sample(struct ab8500_fg =
*di, int sample)
>  		 * Check the time stamp for each sample. If too old,
>  		 * replace with latest sample
>  		 */
> -	} while (ts64.tv_sec - VALID_CAPACITY_SEC > avg->time_stamps[avg->pos]);
> +	} while (now - VALID_CAPACITY_SEC > avg->time_stamps[avg->pos]);
> =20
>  	avg->avg =3D avg->sum / avg->nbr_samples;
> =20
> @@ -439,14 +437,14 @@ static void ab8500_fg_clear_cap_samples(struct ab85=
00_fg *di)
>  static void ab8500_fg_fill_cap_sample(struct ab8500_fg *di, int sample)
>  {
>  	int i;
> -	struct timespec64 ts64;
> +	time64_t now;
>  	struct ab8500_fg_avg_cap *avg =3D &di->avg_cap;
> =20
> -	getnstimeofday64(&ts64);
> +	now =3D ktime_get_boottime_seconds();
> =20
>  	for (i =3D 0; i < NBR_AVG_SAMPLES; i++) {
>  		avg->samples[i] =3D sample;
> -		avg->time_stamps[i] =3D ts64.tv_sec;
> +		avg->time_stamps[i] =3D now;
>  	}
> =20
>  	avg->pos =3D 0;
> --=20
> 2.9.0
>=20

--x2lia7tdfe3hg3oc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/hUsACgkQ2O7X88g7
+pqvkg//UIsF/KAGv1UsFobuKa+uH1YkkFzf9/j/ZkG1XzEp1tdg6piwei/zUlXG
l4QFp5GkGXaCbwRc6TCsLqAPVAUYt8ANAjfz/Tzap1BCHYgIjWaGPRoibDPc7uaR
7sBoZC8TB2aiowYZ7BKz4hclT1HVhnwKswxESHhv3fQWRLdks+456eOlPnegYGF1
Zp2MA17aE/0/XkF2HpCSqFXpONngiHiggoHqKTlwccwUFwuh0KkgrWJWkVtD1PpP
m12H2sGrOr6TZC2lquNgILPtoTbSlHDsdC00i8rmcNUmGetiwfo5eTLAZrKL/uQZ
+7KR4Nh71IVS3kusLKEZehGCJEFo7P/sseOfcaJunD0wTGVizKASCyL5GpOqes42
Skic4UYnBnisWBsqGCKdL9tZz2rlz1TwbmFnMzg5Ij875ZEJkieObMCTXPpq4wAM
Xn9uIGL3D1POByM9kxXe32H4+McO4UrG1PYW2vMjr88tZze6d6+RVWmAWe6+Q/JW
G6dHKyknEMH4xy1jNC/+WXJoXiFKhyFuLAl7oQU2ifB3lZQ9yfugJBnXyRY/eroD
NTpvfJ84GFuAT0pxGArXHnPHQ4FxxWlTvxbF4kxuShcTLqft38Vs4SEQmMbaDAwh
F7+w4L8Bn8BL3B1jF2M/M/w/+HdME/eAK4wQ4e/quOmd2UMA9dk=
=a2CD
-----END PGP SIGNATURE-----

--x2lia7tdfe3hg3oc--
