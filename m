Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C2C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F31220851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F31220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLKUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:21:02 -0500
Received: from sauhun.de ([88.99.104.3]:45484 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeLKUVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:21:01 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 45CE94C0E90;
        Tue, 11 Dec 2018 21:20:59 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:20:58 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     qii.wang@mediatek.com
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com
Subject: Re: [PATCH 2/5] i2c: mediatek: remove useless code and replace
 definitions
Message-ID: <20181211202058.cd4wyz4so66iqspt@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rzzha3d23dmk6e55"
Content-Disposition: inline
In-Reply-To: <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rzzha3d23dmk6e55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 09:32:51PM +0800, qii.wang@mediatek.com wrote:
> From: qii wang <qii.wang@mediatek.com>
>=20
> Completion_done is useless when we don't use its return value,
> so we remove it. Different speeds have been defined by macros,
> so we use macros definitions.

Those are two seperate patches, or?

>=20
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt6=
5xx.c
> index a74ef76..660de1e 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
> =20
>  	control_reg =3D readw(i2c->base + OFFSET_CONTROL) &
>  			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
> -	if ((i2c->speed_hz > 400000) || (left_num >=3D 1))
> +	if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >=3D 1))
>  		control_reg |=3D I2C_CONTROL_RS;
> =20
>  	if (i2c->op =3D=3D I2C_MASTER_WRRD)
> @@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>  	writew(control_reg, i2c->base + OFFSET_CONTROL);
> =20
>  	/* set start condition */
> -	if (i2c->speed_hz <=3D 100000)
> +	if (i2c->speed_hz <=3D I2C_DEFAULT_SPEED)
>  		writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
>  	else
>  		writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> @@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>  		return -ETIMEDOUT;
>  	}
> =20
> -	completion_done(&i2c->msg_complete);
> -
>  	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
>  		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
>  		mtk_i2c_init_hw(i2c);
> --=20
> 1.7.9.5
>=20

--rzzha3d23dmk6e55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQHCoACgkQFA3kzBSg
KbbLdw/+ODERxR+ceynTnAj6B+ZBYip0nSF+4P2h+GCcBlb0sM+5iW1aG9Koj2j2
QadPtWZ1riU6UfvKcoPyTmyPhZE+7B6YZ+wDVANZtXUU0FIzFPcYX7xcQ002bQ+A
1muAx5kuFfKd/uMXXF5BPcycswIo5tUJ58IFKdhl74qXPKapeKgH0ocse2vKItIs
O2pfEDqy2TCEPJLaCO2f9TC78MDuKlOs7sE0cs1S3TPCu+0dfgfQeSROQJIwcRxH
4qn6LB4dgTssaHgrmOta2UfLmA1+DI9bWBlggdpDpjVmI5I+Q8sj/7m8nuvvQWuu
axX68q4acAgOi5DIJZDKy6vhP1+VuWmdWEBCmPQtNcNRKHkyJr2twBQqH1E2uDo5
eISaxbq0dD58yYgop85/IBomC82jPCOcK9Xq7D69AtJWO42tpwoXo4FTe1nxqRNj
hmdwd72Sj8Fe7URPoKfJlWMCKPhcXeJIg7acX3c6U6GIislR+Z2B78Hwnl1CZ9B9
PkuAo0K+JqF1orCKi4YeXCZHinUc9O/kuL7w5+jrp/F0DPJYQipwi2qEYD3fbh7g
vwIJ5SC6wCc6qjW6Q1WaflkiuqbXOGt1nsbX5AGtFkovDYVtU0O/EcuNIpo7ytiE
UAGLEUY45eAFOfij9o3p9Jazw1cZgv7YMb+9ScnPFdnsMKFkykg=
=7YkG
-----END PGP SIGNATURE-----

--rzzha3d23dmk6e55--
