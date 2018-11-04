Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78975C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320902085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320902085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeKDVt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:49:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40666 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeKDVt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:49:26 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 924288092E; Sun,  4 Nov 2018 13:34:29 +0100 (CET)
Date:   Sun, 4 Nov 2018 13:34:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 11/15] x86, olpc: Use a correct version when making up a
 battery node
Message-ID: <20181104123430.GD23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-12-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fblc08uBQ7kpPybH"
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-12-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fblc08uBQ7kpPybH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:56, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/x86/platform/olpc/olpc_dt.c | 59 +++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
> index d6ee92986920..6e54e116b0c5 100644
> --- a/arch/x86/platform/olpc/olpc_dt.c
> +++ b/arch/x86/platform/olpc/olpc_dt.c
> @@ -218,10 +218,28 @@ static u32 __init olpc_dt_get_board_revision(void)
>  	return be32_to_cpu(rev);
>  }
> =20
> -void __init olpc_dt_fixup(void)
> +int olpc_dt_compatible_match(phandle node, const char *compat)
>  {
> -	int r;
>  	char buf[64];
> +	int plen;
> +	char *p;
> +	int len;
> +
> +	plen =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
> +	if (plen <=3D 0)
> +		return 0;
> +
> +	len =3D strlen(compat);
> +	for (p =3D buf; p < buf + plen; p +=3D strlen(p) + 1) {
> +		if (strcmp(p, compat) =3D=3D 0)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +void __init olpc_dt_fixup(void)
> +{
>  	phandle node;
>  	u32 board_rev;
> =20
> @@ -229,32 +247,33 @@ void __init olpc_dt_fixup(void)
>  	if (!node)
>  		return;
> =20
> -	/*
> -	 * If the battery node has a compatible property, we are running a new
> -	 * enough firmware and don't have fixups to make.
> -	 */
> -	r =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
> -	if (r > 0)
> -		return;
> -
> -	pr_info("PROM DT: Old firmware detected, applying fixes\n");
> -
> -	/* Add olpc,xo1-battery compatible marker to battery node */
> -	olpc_dt_interpret("\" /battery@0\" find-device"
> -		" \" olpc,xo1-battery\" +compatible"
> -		" device-end");
> -
>  	board_rev =3D olpc_dt_get_board_revision();
>  	if (!board_rev)
>  		return;
> =20
>  	if (board_rev >=3D olpc_board_pre(0xd0)) {
> +		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
> +			return;
> +
> +		/* Add olpc,xo1.5-battery compatible marker to battery node */
> +		olpc_dt_interpret("\" /battery@0\" find-device"
> +			" \" olpc,xo1.5-battery\" +compatible"
> +			" device-end");
> +
> +		/* We're running a very old firmware if this is missing. */
> +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
> +			return;
> +
>  		/* XO-1.5: add dcon device */
>  		olpc_dt_interpret("\" /pci/display@1\" find-device"
>  			" new-device"
>  			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
>  			" finish-device device-end");
>  	} else {
> +		/* We're running a very old firmware if this is missing. */
> +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
> +			return;
> +
>  		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
>  		olpc_dt_interpret("\" /pci/display@1,1\" find-device"
>  			" new-device"
> @@ -264,6 +283,11 @@ void __init olpc_dt_fixup(void)
>  			" \" olpc,xo1-rtc\" +compatible"
>  			" device-end");
>  	}
> +
> +	/* Add olpc,xo1-battery compatible marker to battery node */
> +	olpc_dt_interpret("\" /battery@0\" find-device"
> +		" \" olpc,xo1-battery\" +compatible"
> +		" device-end");
>  }
> =20
>  void __init olpc_dt_build_devicetree(void)
> @@ -289,6 +313,7 @@ void __init olpc_dt_build_devicetree(void)
>  /* A list of DT node/bus matches that we want to expose as platform devi=
ces */
>  static struct of_device_id __initdata of_ids[] =3D {
>  	{ .compatible =3D "olpc,xo1-battery" },
> +	{ .compatible =3D "olpc,xo1.5-battery" },
>  	{ .compatible =3D "olpc,xo1-dcon" },
>  	{ .compatible =3D "olpc,xo1-rtc" },
>  	{},

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fblc08uBQ7kpPybH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve51YACgkQMOfwapXb+vKHgACgvjiaNR9mvQBgmk3t0b2lg6q9
xV4AoIFiPzQc4fFbefN4LWGpokLZHl0K
=s/mT
-----END PGP SIGNATURE-----

--fblc08uBQ7kpPybH--
