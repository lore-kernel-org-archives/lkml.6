Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C4E2170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C4E2170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeHHJuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:50:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:13628 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeHHJuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:50:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 00:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="asc'?scan'208";a="81619004"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.143])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2018 00:31:58 -0700
Date:   Wed, 8 Aug 2018 15:23:20 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] drm/i915/gvt: fix memory leak in intel_vgpu_ioctl()
Message-ID: <20180808072320.GP22630@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <1533256879-10220-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b0R8ugpUbPHtGZft"
Content-Disposition: inline
In-Reply-To: <1533256879-10220-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b0R8ugpUbPHtGZft
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

Unfortunately this would cause a double-free error in normal path, as we
tried to free sparse after use to add caps. So may be better to fix free
in error path and move normal free of sparse in final point, e.g

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kv=
mgt.c
index 68df9aa88890..47b897b6ea93 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1257,11 +1257,13 @@ static long intel_vgpu_ioctl(struct mdev_device *md=
ev, unsigned int cmd,
 					&sparse->header, sizeof(*sparse) +
 					(sparse->nr_areas *
 						sizeof(*sparse->areas)));
-				kfree(sparse);
-				if (ret)
+				if (ret) {
+					kfree(sparse);
 					return ret;
+				}
 				break;
 			default:
+				kfree(sparse);
 				return -EINVAL;
 			}
 		}
@@ -1277,6 +1279,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev=
, unsigned int cmd,
 						  sizeof(info), caps.buf,
 						  caps.size)) {
 					kfree(caps.buf);
+					kfree(sparse);
 					return -EFAULT;
 				}
 				info.cap_offset =3D sizeof(info);
@@ -1285,6 +1288,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev=
, unsigned int cmd,
 			kfree(caps.buf);
 		}
=20
+		kfree(sparse);
 		return copy_to_user((void __user *)arg, &info, minsz) ?
 			-EFAULT : 0;
 	} else if (cmd =3D=3D VFIO_DEVICE_GET_IRQ_INFO) {



--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--b0R8ugpUbPHtGZft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW2qaaAAKCRCxBBozTXgY
J1/iAKCXRN8Z4nUqYzICnKwjDuszqfNHzgCeMtnse5wwkdV+bxW7mTmN1m0M0J4=
=Nbo5
-----END PGP SIGNATURE-----

--b0R8ugpUbPHtGZft--
