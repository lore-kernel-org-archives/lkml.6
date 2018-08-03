Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A3C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD662170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD662170D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeHCD3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:29:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:54759 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbeHCD3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:29:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 18:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="asc'?scan'208";a="72164885"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.143])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2018 18:35:41 -0700
Date:   Fri, 3 Aug 2018 09:27:15 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] drm/i915/gvt: fix memory leak in intel_vgpu_ioctl()
Message-ID: <20180803012715.GB3035@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <1533256879-10220-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <1533256879-10220-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.08.03 08:41:19 +0800, Yi Wang wrote:
> The 'sparse' variable may leak when return in function
> intel_vgpu_ioctl(), and this patch fixes this.
>=20
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---

Looks fine to me, will queue this up.

Thanks for the patch!

>  drivers/gpu/drm/i915/gvt/kvmgt.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/=
kvmgt.c
> index df4e4a0..6a6f199 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1200,6 +1200,7 @@ static long intel_vgpu_ioctl(struct mdev_device *md=
ev, unsigned int cmd,
>  					return ret;
>  				break;
>  			default:
> +				kfree(sparse);
>  				return -EINVAL;
>  			}
>  		}
> @@ -1215,6 +1216,7 @@ static long intel_vgpu_ioctl(struct mdev_device *md=
ev, unsigned int cmd,
>  						  sizeof(info), caps.buf,
>  						  caps.size)) {
>  					kfree(caps.buf);
> +					kfree(sparse);
>  					return -EFAULT;
>  				}
>  				info.cap_offset =3D sizeof(info);
> @@ -1223,6 +1225,7 @@ static long intel_vgpu_ioctl(struct mdev_device *md=
ev, unsigned int cmd,
>  			kfree(caps.buf);
>  		}
> =20
> +		kfree(sparse);
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
>  	} else if (cmd =3D=3D VFIO_DEVICE_GET_IRQ_INFO) {
> --=20
> 1.8.3.1
>=20

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW2OvcwAKCRCxBBozTXgY
J2hFAKCT6/4vyk8ccIjt3kxtrY5uYpKnJACghGDMTrpFL0cw2KzVbwwPk6dDfkc=
=WZ0c
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
