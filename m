Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A06208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpKBnu2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A06208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeGKKHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbeGKKHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:07:54 -0400
Received: from mail.kernel.org (host-091-097-006-190.ewe-ip-backbone.de [91.97.6.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C38208E5;
        Wed, 11 Jul 2018 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531303461;
        bh=oAShqgIPIEU7/5IKqIUnURXor5nEos/wZNhkG4KTWp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpKBnu2xN1Xws2h1aW8zslT78tgdYV3EBmblkyC4xF7vv+zhJBVEWE1mKLzhGYa/P
         lD0PgdBMQyqnGQWGZUcuoRhfvr5LJOAMz1xDrVtKO6ETEsInTFaMNVc5HhSDCE9zxn
         sAjEYDxSsCgwa2huXE9kyOAgpKkRXCS28JE/A4u8=
Date:   Wed, 11 Jul 2018 12:04:18 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stefan Popa <stefan.popa@analog.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: adp5061: Fix a couple off by ones
Message-ID: <20180711100418.p2t4mfvgyjbzrxwy@earth.universe>
References: <20180711075808.gpa3362vbins7crx@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2y7tqp2z4gc4cr77"
Content-Disposition: inline
In-Reply-To: <20180711075808.gpa3362vbins7crx@kili.mountain>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2y7tqp2z4gc4cr77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 11, 2018 at 10:58:13AM +0300, Dan Carpenter wrote:
> We end up reading one element beyond the end of the adp5061_vmax[] array
> here.
>=20
> Fixes: fe8e81b7e899 ("adp5061: New driver for ADP5061 I2C battery charger=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, queued.

-- Sebastian

> diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp506=
1.c
> index c00a02ef7424..939fd3d8fb1a 100644
> --- a/drivers/power/supply/adp5061.c
> +++ b/drivers/power/supply/adp5061.c
> @@ -266,8 +266,8 @@ static int adp5061_get_max_voltage(struct adp5061_sta=
te *st,
>  		return ret;
> =20
>  	regval =3D ((regval & ADP5061_TERM_SET_VTRM_MSK) >> 2) - 0x0F;
> -	if (regval > ARRAY_SIZE(adp5061_vmax))
> -		regval =3D ARRAY_SIZE(adp5061_vmax);
> +	if (regval >=3D ARRAY_SIZE(adp5061_vmax))
> +		regval =3D ARRAY_SIZE(adp5061_vmax) - 1;
> =20
>  	val->intval =3D adp5061_vmax[regval] * 1000;
> =20
> @@ -344,8 +344,8 @@ static int adp5061_get_const_chg_current(struct adp50=
61_state *st,
>  		return ret;
> =20
>  	regval =3D ((regval & ADP5061_CHG_CURR_ICHG_MSK) >> 2);
> -	if (regval > ARRAY_SIZE(adp5061_const_ichg))
> -		regval =3D ARRAY_SIZE(adp5061_const_ichg);
> +	if (regval >=3D ARRAY_SIZE(adp5061_const_ichg))
> +		regval =3D ARRAY_SIZE(adp5061_const_ichg) - 1;
> =20
>  	val->intval =3D adp5061_const_ichg[regval] * 1000;
> =20

--2y7tqp2z4gc4cr77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltF1h8ACgkQ2O7X88g7
+pr4dBAAg7979N/X+zW3Pki8PNMR9SSiBEjTVg1Ul27hbS5O326rMBRARiWdabPv
LnofakYcx0CMDBRhJAAe0HIpzG6gFu+8MN4mY17IwD8GVk3eiHb83DQB0gKhp78+
jFKMF7DeJwQbRmKkk73nXyw7eliVhwJXD3T4dNTispJhgyYHOHYiQy0bDHX6ZdO/
Czk9F7vcdZt55glN3O+8wLofNMYpgg/vJTM8u9Lr58jCGnTyeLaQWk6jhKqeAuPe
95r62972SpdRFiaukBWJ5WV6zvVUmvS9YV3Avia3gcGeNgI90A0EEPYAoPouzNMz
hK+2eT0480As347XSotFbC9AtBRoIjvPD0XJDnbbVLCc5Xxz3fgX9fB4PLxcSRXt
hJAp0T8+NEEu6P/JdyCjpUpp+yOoaURWhGkBexFHTxTddcjFASSzYeEXXpiWm5KD
Dbv/MP+TDFDMx6CP5SoGfjHUnJV7k0CPOOCdG4edYfAEFZM04VnxH8RWhyEd3xWi
nV8AAb96ReH2l1zNI0VDxzgoMiTZ+MVYtzPd6egdE5WG6Cin3SIZahJ8BaKLLE6O
bV7whatfzPo4b54S3VP8JVye/aaoMvDD2SwoyNaQVuLx4iTIaxoQm5MR8AS4F20s
bkYH8Q69zuPAk9FhOb8zxiM2QaoLlBXWfh4SxTyTQaKvZZ/O8xk=
=xmKy
-----END PGP SIGNATURE-----

--2y7tqp2z4gc4cr77--
