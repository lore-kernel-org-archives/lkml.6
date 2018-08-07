Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5586DC4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCA721A71
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCA721A71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHGErE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:47:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:59827 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbeHGErE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:47:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 19:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,453,1526367600"; 
   d="asc'?scan'208";a="62846199"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.143])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2018 19:34:58 -0700
Date:   Tue, 7 Aug 2018 10:26:24 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/kvmgt: Fix potential Spectre v1
Message-ID: <20180807022624.GY22630@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180803034019.GA18366@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hc4757KF+wLS/WHK"
Content-Disposition: inline
In-Reply-To: <20180803034019.GA18366@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hc4757KF+wLS/WHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.08.02 22:40:19 -0500, Gustavo A. R. Silva wrote:
> info.index can be indirectly controlled by user-space, hence leading
> to a potential exploitation of the Spectre variant 1 vulnerability.
>=20
> This issue was detected with the help of Smatch:
>=20
> drivers/gpu/drm/i915/gvt/kvmgt.c:1232 intel_vgpu_ioctl() warn:
> potential spectre issue 'vgpu->vdev.region' [r]
>=20
> Fix this by sanitizing info.index before indirectly using it to index
> vgpu->vdev.region

Thanks for catching this! Applied.

>=20
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>=20
> [1] https://marc.info/?l=3Dlinux-kernel&m=3D152449131114778&w=3D2
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/=
kvmgt.c
> index 4d2f53a..b703f20 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -43,6 +43,8 @@
>  #include <linux/mdev.h>
>  #include <linux/debugfs.h>
> =20
> +#include <linux/nospec.h>
> +
>  #include "i915_drv.h"
>  #include "gvt.h"
> =20
> @@ -1139,7 +1141,8 @@ static long intel_vgpu_ioctl(struct mdev_device *md=
ev, unsigned int cmd,
>  	} else if (cmd =3D=3D VFIO_DEVICE_GET_REGION_INFO) {
>  		struct vfio_region_info info;
>  		struct vfio_info_cap caps =3D { .buf =3D NULL, .size =3D 0 };
> -		int i, ret;
> +		unsigned int i;
> +		int ret;
>  		struct vfio_region_info_cap_sparse_mmap *sparse =3D NULL;
>  		size_t size;
>  		int nr_areas =3D 1;
> @@ -1224,6 +1227,10 @@ static long intel_vgpu_ioctl(struct mdev_device *m=
dev, unsigned int cmd,
>  				if (info.index >=3D VFIO_PCI_NUM_REGIONS +
>  						vgpu->vdev.num_regions)
>  					return -EINVAL;
> +				info.index =3D
> +					array_index_nospec(info.index,
> +							VFIO_PCI_NUM_REGIONS +
> +							vgpu->vdev.num_regions);
> =20
>  				i =3D info.index - VFIO_PCI_NUM_REGIONS;
> =20
> --=20
> 2.7.4
>=20
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--hc4757KF+wLS/WHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW2kDTwAKCRCxBBozTXgY
J58IAJ9vy8iEV8uRpctpj6P5oa6oCd1mswCeJ1Psy3HD97wVSuYiHISLTkOgSN4=
=hejq
-----END PGP SIGNATURE-----

--hc4757KF+wLS/WHK--
