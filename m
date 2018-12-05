Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D09C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ABD20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46ABD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeLEWhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:37:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:37:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 63164267733
Received: by earth.universe (Postfix, from userid 1000)
        id D437D3C08D6; Wed,  5 Dec 2018 23:37:05 +0100 (CET)
Date:   Wed, 5 Dec 2018 23:37:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] power: reset: at91-poweroff: use one poweroff
 function for at91-poweroff
Message-ID: <20181205223705.tg57jiqhq4u73gj3@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eivayloweo7yle4y"
Content-Disposition: inline
In-Reply-To: <1541416443-4321-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eivayloweo7yle4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2018 at 11:14:23AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Use only one poweroff function and adapt it to work for both scenarios
> (with LPDDR or not). The assignement of pm_power_off was moved at the
> end of probe after all initializations are OK. This patch adapt the idea
> from commit 4e018c1e9b05 ("power: reset: at91-poweroff: use only one
> poweroff function").
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 49 ++++++++++++++++++++-----------=
------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index fb2fc8f741a1..82533f4c72fc 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -76,11 +76,6 @@ static void __init at91_wakeup_status(struct platform_=
device *pdev)
> =20
>  static void at91_poweroff(void)
>  {
> -	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
> -}
> -
> -static void at91_lpddr_poweroff(void)
> -{
>  	asm volatile(
>  		/* Align to cache lines */
>  		".balign 32\n\t"
> @@ -89,9 +84,11 @@ static void at91_lpddr_poweroff(void)
>  		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
> =20
>  		/* Power down SDRAM0 */
> +		"	tst	%0, #0\n\t"
> +		"	beq	1f\n\t"
>  		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
>  		/* Shutdown CPU */
> -		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
> +		"1:	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
> =20
>  		"	b	.\n\t"
>  		:
> @@ -177,34 +174,42 @@ static int __init at91_poweroff_probe(struct platfo=
rm_device *pdev)
>  	if (pdev->dev.of_node)
>  		at91_poweroff_dt_set_wakeup_mode(pdev);
> =20
> -	pm_power_off =3D at91_poweroff;
> -
>  	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
> -	if (!np)
> -		return 0;
> +	if (np) {
> +		mpddrc_base =3D of_iomap(np, 0);
> +		of_node_put(np);
> =20
> -	mpddrc_base =3D of_iomap(np, 0);
> -	of_node_put(np);
> +		if (!mpddrc_base) {
> +			ret =3D -ENOMEM;
> +			goto clk_disable;
> +		}
> =20
> -	if (!mpddrc_base)
> -		return 0;
> +		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
> +				 AT91_DDRSDRC_MD;
> +		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
> +		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
> +			iounmap(mpddrc_base);
> +			mpddrc_base =3D NULL;
> +		}
> +	}
> =20
> -	ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
> -	if ((ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR2) ||
> -	    (ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR3))
> -		pm_power_off =3D at91_lpddr_poweroff;
> -	else
> -		iounmap(mpddrc_base);
> +	pm_power_off =3D at91_poweroff;
> =20
>  	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(sclk);
> +	return ret;
>  }
> =20
>  static int __exit at91_poweroff_remove(struct platform_device *pdev)
>  {
> -	if (pm_power_off =3D=3D at91_poweroff ||
> -	    pm_power_off =3D=3D at91_lpddr_poweroff)
> +	if (pm_power_off =3D=3D at91_poweroff)
>  		pm_power_off =3D NULL;
> =20
> +	if (mpddrc_base)
> +		iounmap(mpddrc_base);
> +
>  	clk_disable_unprepare(sclk);
> =20
>  	return 0;
> --=20
> 2.7.4
>=20

--eivayloweo7yle4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIUwsACgkQ2O7X88g7
+prnlBAAiSmmPBfEk851yikNkNZCeUSuK7YMLJXw26Q/hzUxp+1ljI08ZXd/ZcCN
859sN7oDE7874mxcQaS0nfixyktSm87p/aIMpk6IkOyPlNs0LPrp7xpxYbR3ebHC
0TnU6dThx0CHsB4XjN3HQSNpei0lnIXwmF/7xQ2KE+kzfNdQ7tfulsHAnKrzZOAu
tLHWCK34qCj0NLiNmdFXoJWOkxeW/WNMGzLspHGGpPgC7JsG8JlWa3hBHV/LWiI2
UkMIQKin2f69WuiM4YcBurTs9zjM9TJabN7E8NWE5wV/W19jij9q1weGomI5sONC
2tPWAyTWpx9eNEAyB/u/3drZosP5Spx823TTx+ZIPHyknN57g7FXz1jBvimS9QRj
xfR1PTU9mV7RuzomE2xyv9ZiEAz/inHmTz6NdRyGTDUjps9JoPC99g3gXW1ixdva
bE8P+0XL760UUBflHihuSoFhxaHpESnlFDWNc2/QA5s1JflKEIpvjzEvQF5mpWF/
c0ny2nNWB/7sLFkNL0abTLhOkiVfZnQlWtlVh4h2DU9uclKnnGwp+YdsKeDkpmcB
7jkdkDfh9ZLZ5bhqg+qcBHFBkH7h9rcy0kORZ6IUeixfob9AzO67UFvv59JJDSji
YI9Nh2+sPIG3b6MG/2vbF4hlYq/oMZxgC5zHkSFxUUC3j9EFnus=
=dx8U
-----END PGP SIGNATURE-----

--eivayloweo7yle4y--
