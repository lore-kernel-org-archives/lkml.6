Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16611ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB894214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB894214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeIQM2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:28:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:6203 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbeIQM2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:28:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 00:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,384,1531810800"; 
   d="asc'?scan'208";a="80999593"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.143])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2018 00:01:59 -0700
Date:   Mon, 17 Sep 2018 14:51:54 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180917065154.GI20737@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180913054745.6353-1-kraxel@redhat.com>
 <20180913054745.6353-2-kraxel@redhat.com>
 <20180913115139.02775316@t450s.home>
 <20180914122552.3xmepqo7azzmx7ky@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ztQAJXOExAP3xDFw"
Content-Disposition: inline
In-Reply-To: <20180914122552.3xmepqo7azzmx7ky@sirius.home.kraxel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ztQAJXOExAP3xDFw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.09.14 14:25:52 +0200, Gerd Hoffmann wrote:
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82e81..901f279033 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -200,12 +200,25 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
>  #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
> +#define VFIO_DEVICE_FLAGS_CAPS	(1 << 5)	/* cap_offset present */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
> +	__u32   cap_offset;	/* Offset within info struct of first cap */
>  };
>  #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
> =20
>  /*
> + * FIXME: docs ...
> + */
> +#define VFIO_DEVICE_INFO_CAP_EDID	1
> +
> +struct vfio_device_info_edid_cap {
> +	struct vfio_info_cap_header header;
> +	__u32   max_x;     /* Max display height (zero =3D=3D no limit) */
> +	__u32   max_y;     /* Max display height (zero =3D=3D no limit) */
> +};

As current virtual display for Intel vGPU is still emulating against real HW
pipeline with same limitations, asked display developers that whether or not
specific mode can work might still depend on current or future HW behavior.
So could we add some hints on what kind of edid mode vfio device can operat=
e?
Some may support arbitrary modes, but some may only support standard modes.

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--ztQAJXOExAP3xDFw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW59PCQAKCRCxBBozTXgY
J+kDAKCKYbg9KWlqpyBdoAPq7DrRX4Hc+gCeKuUMUbnP/MdFCEyU7rXcN5UVYdw=
=wOHc
-----END PGP SIGNATURE-----

--ztQAJXOExAP3xDFw--
