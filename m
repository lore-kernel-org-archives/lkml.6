Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAFAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7787320866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfAPS1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:27:08 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:4805 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbfAPS1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:27:08 -0500
Received: from tack (unknown [IPv6:2a02:8108:4840:8f74:a08c:f56:b2dd:7ae0])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 7A011B0058E;
        Wed, 16 Jan 2019 19:27:00 +0100 (CET)
Date:   Wed, 16 Jan 2019 19:26:58 +0100
From:   Alban <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Aban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] nvmem: Add nvmem_cell_get_optional and
 devm_nvmem_cell_get_optional
Message-ID: <20190116192658.7df211e8@tack>
In-Reply-To: <de4aa31e-2d9e-a7bd-270e-f00ac3e88988@linaro.org>
References: <20190106192820.12558-1-albeu@free.fr>
        <20190106192820.12558-4-albeu@free.fr>
        <de4aa31e-2d9e-a7bd-270e-f00ac3e88988@linaro.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/BnuoXlM.vOTuMS9AUjPKwOp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BnuoXlM.vOTuMS9AUjPKwOp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jan 2019 12:40:53 +0000
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 06/01/2019 19:28, Alban Bedel wrote:
> > Add helper functions to make the driver code simpler when a cell is
> > optional. Using these functions just return NULL when the cell doesn't
> > exists or if nvmem is disabled.
> >=20
> > Signed-off-by: Alban Bedel<albeu@free.fr>
> > ---
> >   drivers/nvmem/core.c           | 48 ++++++++++++++++++++++++++++++++++
> >   include/linux/nvmem-consumer.h | 16 ++++++++++++
> >   2 files changed, 64 insertions(+)
> >=20
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index f8c43da6f2ca..8e1b52559467 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -1083,6 +1083,30 @@ struct nvmem_cell *nvmem_cell_get(struct device =
*dev, const char *id)
> >   }
> >   EXPORT_SYMBOL_GPL(nvmem_cell_get);
> >  =20
> > +/**
> > + * nvmem_cell_get_optional() - Get an optional nvmem cell of device fr=
om
> > + * a given id.
> > + *
> > + * @dev: Device that requests the nvmem cell.
> > + * @cell_id: nvmem cell name to get.
> > + *
> > + * Return: Will be NULL if no cell with the given name is defined,
> > + * an ERR_PTR() on error or a valid pointer to a struct nvmem_cell.
> > + * The nvmem_cell will be freed by the nvmem_cell_put().
> > + */
> > +struct nvmem_cell *nvmem_cell_get_optional(struct device *dev,
> > +					   const char *cell_id)
> > +{
> > +	struct nvmem_cell *cell;
> > +
> > +	cell =3D nvmem_cell_get(dev, cell_id);
> > +	if (IS_ERR(cell) && PTR_ERR(cell) =3D=3D -ENOENT)
> > +		return NULL; =20
>=20
> What is the real use-case here, it does not make sense to me to add this=
=20
> additional call just to return NULL when cell is not found!

It also return NULL when nvmem is not compiled in. I quiet like such
convenience functions as they make the driver code much simpler and
the intent explicit. It replace:

	data->cell =3D devm_nvmem_cell_get(dev, "my-cell");
	if (IS_ERR(data->cell) {
		if (PTR_ERR(data->cell) =3D=3D -ENOENT ||
		    PTR_ERR(data->cell) =3D=3D -EOPNOTSUPP)
			data->cell =3D NULL;
		else
			return PTR_ERR(data->cell);
	}

with:

	data->cell =3D dev_nvmem_cell_get_optional(dev, "my-cell");
	if (IS_ERR(cell))
		return PTR_ERR(data->cell);

It's your call if you find that useful or not.

Alban

--Sig_/BnuoXlM.vOTuMS9AUjPKwOp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE0W61GceYqNjiMSkodJSaS524LbwFAlw/d3IACgkQdJSaS524
Lby4OhAAk2EKLbGZ6IvsG+YelauFhWszQp2IRXo9Ff4Vwy5SyOcPw/yLuhvlXIRX
4GTn7p6E/zNceO2bAnFcM4z4pp/qZqRMBSX4uQnQhDhs+oTRfwGWd4pZmGvJvjg+
pGBGJn1aHBXzFM7cKB7dD54AiM6diesX946xAV55wr0FHQdZtSasntKeg6DnJn+R
vlQf8vy2YzN6HDVDB7NVvqD/x6LYGXDcfWUtZ3f2q79Qh0sM6VKsp94AKMhjWo1/
xeIsTX489ZZJOho62nszYDX7aFN5vPvIRKW/2AR4OnjUUofpmFUJvvCBWZWtbZtY
zJ6OsSHSCum/wvTmQgAnydICGEQu0O5bR/MduOaObamZ9prhHnaXHf4B3OPDOjWg
TF78q4gW+AJXvO24Sbzw6Iib+J2NpQ9+r7kHXCkhY4XnyY12rqavm5gZaICDl9Dx
qRNHbacs8lzMx4vVNST8zFZ8/1hGP4VQrLyq4Fh4dVTa8XAV6ax30eje1DzU/aDs
SpQJrMf2WJePsOC3MJ3pHEjjHl7AHma9A8VEWKSHOqIU2YSpL/5KOVAdhAlIPXfX
T7ddt1AfpnnlBsgYS8Fu4vItBqdm//hJcC5j1iak2yoi3m2+/Jq1RyPmXQn/O9r9
XE/04nOvE2+uVR9NWrob8yc+F9/Kz9lmzgA6bQVdMuB8g8alA1w=
=p3qI
-----END PGP SIGNATURE-----

--Sig_/BnuoXlM.vOTuMS9AUjPKwOp--
