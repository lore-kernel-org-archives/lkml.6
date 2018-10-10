Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D031B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D031B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJJOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:09:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42036 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725757AbeJJOJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:09:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DCB4A207C3; Wed, 10 Oct 2018 08:49:12 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id AC65D20726;
        Wed, 10 Oct 2018 08:49:02 +0200 (CEST)
Date:   Wed, 10 Oct 2018 08:49:02 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 2/2] net: phy: mscc: fix memory leak in
 vsc8574_config_pre_init
Message-ID: <20181010064902.qnrkoi3wdf6hlyac@qschulz>
References: <cover.1539113472.git.gustavo@embeddedor.com>
 <a7a293b1566cb37ecc873d9b186d87656d3766dc.1539113472.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5dbc5my6jlprb7l"
Content-Disposition: inline
In-Reply-To: <a7a293b1566cb37ecc873d9b186d87656d3766dc.1539113472.git.gustavo@embeddedor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q5dbc5my6jlprb7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Oct 09, 2018 at 09:39:53PM +0200, Gustavo A. R. Silva wrote:
> In case memory resources for *fw* were successfully allocated,
> release them before return.
>=20
> Addresses-Coverity-ID: 1473968 ("Resource leak")
> Fixes: 00d70d8e0e78 ("net: phy: mscc: add support for VSC8574 PHY")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/phy/mscc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index bff56c3..af9fb2d 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -1292,7 +1292,7 @@ static int vsc8574_config_pre_init(struct phy_devic=
e *phydev)
>  				dev_err(dev,
>  					"%s: failed to assert reset of micro\n",
>  					__func__);
> -				return ret;
> +				goto release_fw;
>  			}
>  		}
>  	} else {
> @@ -1338,7 +1338,7 @@ static int vsc8574_config_pre_init(struct phy_devic=
e *phydev)
> =20
>  out:
>  	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
> -
> +release_fw:
>  	release_firmware(fw);

You can reuse the out goto label instead, I would like all functions in
the driver to exit with the PHY set to access the standard page.

Thanks,
Quentin

--q5dbc5my6jlprb7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu9oN0ACgkQhLiadT7g
8aOigw/7BvC8ASIU7oRGAjQ24rM03SfBjra6yolfMIkKhkpLTDtTHmym5Qya04s4
nonW4U8aM8Skv0OUoxY9TvC7YIo/MMzTy3+H4rwwOYlVNDVpOQpyffRuadEXE3kz
hlUYbUCekGP0WSWNaaZeRcL+Ivyz9REgqAYsyevTW2JtbmjYTXoFvsT8VoD20gzE
4Q1IgC62b6DyTtrQmG3Am+CmooIUDpeuMN1wSfOJDKk3CPs8M2J6t8TVX9KlsmHB
pxk/SnwI9c48E7cT9SBWY3Q3HsbXHkQ/x5LvkXOzLa6hr4wW12a+tgQxkO/97vzJ
+3PzK/2WVrZXcR9ag6mUYFdBnAw9sSZnqvwMcnEob2kekUFhtLy3UnBO8K7xn0M4
kum4OMO+Dk0hq31Dcz7Bh82MiRvDNu88cSjNLAbQmgV7ELFCcQtxN42TsHqUXb/7
GrkxaSJzHneeBVAmOAMLrWy4/A/OENCtkySz0v4mF/DFk0ZLtZ/B0W4CS06CEwjI
6iP1kUOhXVupIXlmasphGwrY0DOUtoKsT4v5M7rZdcSOC+SREpInKZZmw3+zocgN
r1qjThW9Va+gYL6MF+HZxOcDFTHamhqmYQl6kl3T8VTu7YNWkoniglX7Rg98M/i2
QHCE6Fk/StqPOgeqZnH/DXdW8o6znggjteHTgahW9lZ8zfK6j/Y=
=ETCU
-----END PGP SIGNATURE-----

--q5dbc5my6jlprb7l--
