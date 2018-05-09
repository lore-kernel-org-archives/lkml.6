Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeEIFDC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:03:02 -0400
Received: from ozlabs.org ([203.11.71.1]:35527 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeEIFDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:03:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 15:02:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>, Dave Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nipun Gupta <nipun.gupta@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20180509150255.38a5b1cc@canb.auug.org.au>
In-Reply-To: <20180508110716.53dfef41@canb.auug.org.au>
References: <20180508110716.53dfef41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KgYm4F6hqbL=bzBEBhDHv1q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KgYm4F6hqbL=bzBEBhDHv1q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 8 May 2018 11:07:16 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the drm-intel tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/xen/xen_drm_front.c: In function 'xen_drv_probe':
> drivers/gpu/drm/xen/xen_drm_front.c:740:10: error: 'struct bus_type' has =
no member named 'force_dma'
>   dev->bus->force_dma =3D true;
>           ^~
> drivers/gpu/drm/xen/xen_drm_front.c:742:8: error: too few arguments to fu=
nction 'of_dma_configure'
>   ret =3D of_dma_configure(dev, NULL);
>         ^~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/xen/xen_drm_front.c:16:0:
> include/linux/of_device.h:58:5: note: declared here
>  int of_dma_configure(struct device *dev,
>      ^~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
>=20
> interacting with commit
>=20
>   3d6ce86ee794 ("drivers: remove force dma flag from buses")
>=20
> from the dma-mapping tree.
>=20
> I have added the following merge fix patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 8 May 2018 11:02:24 +1000
> Subject: [PATCH] drm/xen-front: merge fix for "drivers: remove force dma =
flag from buses"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/xen/xen_drm_front.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xe=
n_drm_front.c
> index 1b0ea9ac330e..0e486cb1c10c 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> @@ -737,9 +737,8 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
>  	 * is not correct: to fix this call of_dma_configure() with a NULL
>  	 * node to set default DMA ops.
>  	 */
> -	dev->bus->force_dma =3D true;
>  	dev->coherent_dma_mask =3D DMA_BIT_MASK(32);
> -	ret =3D of_dma_configure(dev, NULL);
> +	ret =3D of_dma_configure(dev, NULL, true);
>  	if (ret < 0) {
>  		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
>  		return ret;
> --=20
> 2.17.0

This is now needed for the merge of the drm and dma-mapping trees.
--=20
Cheers,
Stephen Rothwell

--Sig_/KgYm4F6hqbL=bzBEBhDHv1q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrygP8ACgkQAVBC80lX
0Gxhwgf/T7Nc4rfcR5P7lf9exue4dBbXIfSn+uGfH+69hBX/mxk8TqNto57cvzF3
14T35gjljpqLqPq6aodcDcPSeEIt/TPMDDLUWD54xhUQBY93jNnTWUjPIZ8Og6Th
3xm4y6Zi4prGInvjAqVMGyV41+TUQExUE5KSXkM47MQai0j4LXtevHn2dqWO2WcN
txeGMMqCkB9qpjUKM1QxLG68Pce4BAh59ZzxSQw8dLHxPPC1ln96Q0K6pl9KKx3a
xf8Od8+DDUFc1PmhEcWWCksW1QXWYrD6BEGhNq5/dSLP3FM8Dx80F68XrrnAj8tZ
h2HmzMwzXL30uV/gMT56Mh6EHFbmkw==
=mWda
-----END PGP SIGNATURE-----

--Sig_/KgYm4F6hqbL=bzBEBhDHv1q--
