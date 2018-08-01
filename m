Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D9AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE74220840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbeHAUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:21:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34499 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733127AbeHAUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:21:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E46A6806C8; Wed,  1 Aug 2018 20:34:06 +0200 (CEST)
Date:   Wed, 1 Aug 2018 20:34:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Suman Anna <s-anna@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.9 131/144] media: omap3isp: fix unbalanced
 dma_iommu_mapping
Message-ID: <20180801183402.GA26087@amd>
References: <20180801164949.023217860@linuxfoundation.org>
 <20180801164958.444609965@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20180801164958.444609965@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-01 18:52:38, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let
me know.

How was this tested?

> From: Suman Anna <s-anna@ti.com>
>=20
> [ Upstream commit b7e1e6859fbf60519fd82d7120cee106a6019512 ]
>=20
> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
> ARM DMA backend. The current code creates a dma_iommu_mapping and
> attaches this to the ISP device, but never detaches the mapping in
> either the probe failure paths or the driver remove path resulting
> in an unbalanced mapping refcount and a memory leak. Fix this properly.
>=20
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>

Changelog implies I tested this, but I certainly did not test it in
v4.9.

								Pavel

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/platform/omap3isp/isp.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -1941,6 +1941,7 @@ error_csiphy:
> =20
>  static void isp_detach_iommu(struct isp_device *isp)
>  {
> +	arm_iommu_detach_device(isp->dev);
>  	arm_iommu_release_mapping(isp->mapping);
>  	isp->mapping =3D NULL;
>  	iommu_group_remove_device(isp->dev);
> @@ -1974,8 +1975,7 @@ static int isp_attach_iommu(struct isp_d
>  	mapping =3D arm_iommu_create_mapping(&platform_bus_type, SZ_1G, SZ_2G);
>  	if (IS_ERR(mapping)) {
>  		dev_err(isp->dev, "failed to create ARM IOMMU mapping\n");
> -		ret =3D PTR_ERR(mapping);
> -		goto error;
> +		return PTR_ERR(mapping);
>  	}
> =20
>  	isp->mapping =3D mapping;
> @@ -1990,7 +1990,8 @@ static int isp_attach_iommu(struct isp_d
>  	return 0;
> =20
>  error:
> -	isp_detach_iommu(isp);
> +	arm_iommu_release_mapping(isp->mapping);
> +	isp->mapping =3D NULL;
>  	return ret;
>  }
> =20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlth/RoACgkQMOfwapXb+vKLBQCff+7jJv5rOYbpz/5MeqXsiqsV
V04Anit/jaSFDI5PdnV6iuwPB8F00T/X
=DIXv
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
