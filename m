Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeCZDju (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 23:39:50 -0400
Received: from ozlabs.org ([103.22.144.67]:55139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeCZDjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 23:39:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 14:38:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180326143857.6586ba97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YsRhikKWXYQpOkyGP+Ke5Tk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YsRhikKWXYQpOkyGP+Ke5Tk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c

between commit:

  140bcaa23a1c ("drm/vmwgfx: Fix black screen and device errors when runnin=
g without fbdev")

from Linus' tree and commit:

  c3b9b1657344 ("drm/vmwgfx: Improve on hibernation")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 9116fe8baebc,9e60de95b863..000000000000
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@@ -938,7 -947,8 +947,9 @@@ int vmw_kms_present(struct vmw_private=20
  int vmw_kms_update_layout_ioctl(struct drm_device *dev, void *data,
  				struct drm_file *file_priv);
  void vmw_kms_legacy_hotspot_clear(struct vmw_private *dev_priv);
 +void vmw_kms_lost_device(struct drm_device *dev);
+ int vmw_kms_suspend(struct drm_device *dev);
+ int vmw_kms_resume(struct drm_device *dev);
 =20
  int vmw_dumb_create(struct drm_file *file_priv,
  		    struct drm_device *dev,
diff --cc drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 3c824fd7cbf3,3628a9fe705f..000000000000
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@@ -2561,11 -2551,10 +2557,12 @@@ int vmw_kms_helper_resource_prepare(str
  	if (res->backup) {
  		ret =3D vmw_kms_helper_buffer_prepare(res->dev_priv, res->backup,
  						    interruptible,
- 						    res->dev_priv->has_mob);
+ 						    res->dev_priv->has_mob,
+ 						    false);
  		if (ret)
  			goto out_unreserve;
 +
 +		ctx->buf =3D vmw_dmabuf_reference(res->backup);
  	}
  	ret =3D vmw_resource_validate(res);
  	if (ret)
@@@ -2863,12 -2850,49 +2860,59 @@@ int vmw_kms_set_config(struct drm_mode_
  }
 =20
 =20
 +/**
 + * vmw_kms_lost_device - Notify kms that modesetting capabilities will be=
 lost
 + *
 + * @dev: Pointer to the drm device
 + */
 +void vmw_kms_lost_device(struct drm_device *dev)
 +{
 +	drm_atomic_helper_shutdown(dev);
 +}
++
+ /**
+  * vmw_kms_suspend - Save modesetting state and turn modesetting off.
+  *
+  * @dev: Pointer to the drm device
+  * Return: 0 on success. Negative error code on failure.
+  */
+ int vmw_kms_suspend(struct drm_device *dev)
+ {
+ 	struct vmw_private *dev_priv =3D vmw_priv(dev);
+=20
+ 	dev_priv->suspend_state =3D drm_atomic_helper_suspend(dev);
+ 	if (IS_ERR(dev_priv->suspend_state)) {
+ 		int ret =3D PTR_ERR(dev_priv->suspend_state);
+=20
+ 		DRM_ERROR("Failed kms suspend: %d\n", ret);
+ 		dev_priv->suspend_state =3D NULL;
+=20
+ 		return ret;
+ 	}
+=20
+ 	return 0;
+ }
+=20
+=20
+ /**
+  * vmw_kms_resume - Re-enable modesetting and restore state
+  *
+  * @dev: Pointer to the drm device
+  * Return: 0 on success. Negative error code on failure.
+  *
+  * State is resumed from a previous vmw_kms_suspend(). It's illegal
+  * to call this function without a previous vmw_kms_suspend().
+  */
+ int vmw_kms_resume(struct drm_device *dev)
+ {
+ 	struct vmw_private *dev_priv =3D vmw_priv(dev);
+ 	int ret;
+=20
+ 	if (WARN_ON(!dev_priv->suspend_state))
+ 		return 0;
+=20
+ 	ret =3D drm_atomic_helper_resume(dev, dev_priv->suspend_state);
+ 	dev_priv->suspend_state =3D NULL;
+=20
+ 	return ret;
+ }

--Sig_/YsRhikKWXYQpOkyGP+Ke5Tk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4a1EACgkQAVBC80lX
0GwHiggAkg6GTQwnvYCXEJOQyMko+uOufNBBG/6WC+gY7YsSXxMuthJ1malKn38A
4SGGFiWJam3DajY06HiZOuyT+5ScmAy5UVObJWRlIFnBXzZxoRVOe9uc7ypqdrQz
5BTEZZNcLti48Zqup32zyip0PBZfey36cvW4TIfWx9qIQFHp1gUYHAYkzzJMyYm1
J0WN6PcgsOx4OqUVTyBRBuJaBg+mKogV5kE8aGJ6TKkTwPKK7MfBI0CdItMx9ln+
qh6TszSaxLZ0nTM/iKSvKoHVgkN3t+ub8mDya0Yvon+4UR4YiU87oespjz3M2o8g
5nY/CjOleXDnZ+I2U95JZIM0kZbBXw==
=ftl0
-----END PGP SIGNATURE-----

--Sig_/YsRhikKWXYQpOkyGP+Ke5Tk--
