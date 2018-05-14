Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeENInO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:43:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52256 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeENInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:43:11 -0400
X-Google-Smtp-Source: AB8JxZrS8Uj+QqzMs8GLSDfGdQMOvHwjQZm33EZqvDr9RcfpW5yJdRlEgWZx6QHN/ysnORc+1IP7Zw==
Date: Mon, 14 May 2018 10:43:08 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Emil Goode <emil.fsw@goode.io>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: Fix compiler errors
Message-ID: <20180514084308.GA18312@ulmo>
References: <20180326144314.xeuocqp5fjpfjm3q@lianli>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20180326144314.xeuocqp5fjpfjm3q@lianli>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 04:44:14PM +0200, Emil Goode wrote:
> The compiler is complaining with the following errors:
>=20
> drivers/gpu/host1x/cdma.c:94:48: error:
> 	passing argument 3 of =E2=80=98dma_alloc_wc=E2=80=99 from incompatible p=
ointer type
> 	[-Werror=3Dincompatible-pointer-types]
>=20
> drivers/gpu/host1x/cdma.c:113:48: error:
> 	passing argument 3 of =E2=80=98dma_alloc_wc=E2=80=99 from incompatible p=
ointer type
> 	[-Werror=3Dincompatible-pointer-types]
>=20
> The expected pointer type of the third argument to dma_alloc_wc() is
> dma_addr_t but phys_addr_t is passed. Fix this by adding casts to the
> expected pointer type.
>=20
> Signed-off-by: Emil Goode <emil.fsw@goode.io>
> ---
>  drivers/gpu/host1x/cdma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 28541b280739..5e8b321a751e 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -91,8 +91,8 @@ static int host1x_pushbuffer_init(struct push_buffer *p=
b)
> =20
>  		size =3D iova_align(&host1x->iova, size);
> =20
> -		pb->mapped =3D dma_alloc_wc(host1x->dev, size, &pb->phys,
> -					  GFP_KERNEL);
> +		pb->mapped =3D dma_alloc_wc(host1x->dev, size,
> +					  (dma_addr_t *)&pb->phys, GFP_KERNEL);
>  		if (!pb->mapped)
>  			return -ENOMEM;
> =20
> @@ -110,8 +110,8 @@ static int host1x_pushbuffer_init(struct push_buffer =
*pb)
>  		if (err)
>  			goto iommu_free_iova;
>  	} else {
> -		pb->mapped =3D dma_alloc_wc(host1x->dev, size, &pb->phys,
> -					  GFP_KERNEL);
> +		pb->mapped =3D dma_alloc_wc(host1x->dev, size,
> +					  (dma_addr_t *)&pb->phys, GFP_KERNEL);
>  		if (!pb->mapped)
>  			return -ENOMEM;
> =20

This doesn't seem right. There's no guarantee that phys_addr_t and
dma_addr_t will be compatible, so the above isn't always correct. Also,
I don't see a need for pb->phys to ever be phys_addr_t. It's allocated
through dma_alloc_wc() exclusively, so it should just be dma_addr_t.

Note that the !pb->phys check in host1x_pushbuffer_destroy() becomes
technically wrong if pb->phys is dma_addr_t (0 is a perfectly valid
value for dma_addr_t), so make sure to flip that to !pb->mapped instead.
pb->mapped and pb->phys are always set in tandem, and checking mapped
for non-NULL is the right check to test whether the pair is valid or
not.

Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5TBkACgkQ3SOs138+
s6G56g//VpYNFTGEXoQtF3mu6srEPteFaOn/GAVW/kBSUvL+ujF7mZQYM67KdBPH
/ZxRkc+2oCZ025a91uVMWj8Qz8H3hUlSEZx4Ep7OQrJqlL9FO8cROnfAKt0Xq6zT
PYsQGPecBeGURZ3G+QDT5gb3DBLdzF7GoTO0Aj7wrzG1A0QHqtgjcvQj1vhxrDPw
T1iOZpax8iZdmZwLJRmGmGi/TUPd9LghmSy7Uy3zFwxU3Fzue9Y7qZ+jdtImD4bJ
6ZkkVTyz2cbuUQo3P7nU6ic2LXnr8LTPCuIvKHN/OSjQWUOOhCWf/i0uS/qLlNeU
RulA6dvHr29QqAFITwvULHApPTxz8u4Hu0lsvISWyIkXNUeg9iRmravS2JqDHFRp
upFEdX3tdlFJFtlveIvBfuoCHwWQrzhGK4dIC4x2XMxBz5MPuvDMyAIil0HUCj6W
pOLsbn57GKe9jr5UlpNNUFpm0epbNj/kIRVV6lsMoHzUQYwDyBNVyeWPpp04Ldov
yRG+O4KG9ejXPkQp2X5vtl+zvFMx64ENVYISywbd9s7963+u96VyV8UgKmC/3bOO
T+gZ9TOiTjWv0xKe3PmpHbaHxhgWmrO0V8uVCA/kNzhXfpTUEE/TLI0WZoQuRRzW
iU4or6UysrLgMBl8lQTS35qgruAjQM38VxOeCai9DiIQHb4BTBQ=
=Q7XC
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
