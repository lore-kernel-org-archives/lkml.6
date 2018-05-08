Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeEHBH2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:07:28 -0400
Received: from ozlabs.org ([203.11.71.1]:40927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753108AbeEHBH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:07:26 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 8 May 2018 11:07:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nipun Gupta <nipun.gupta@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, Dave Airlie <airlied@linux.ie>
Subject: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20180508110716.53dfef41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k0hUUyUdcszqUbV+EP9.O15"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k0hUUyUdcszqUbV+EP9.O15
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/xen/xen_drm_front.c: In function 'xen_drv_probe':
drivers/gpu/drm/xen/xen_drm_front.c:740:10: error: 'struct bus_type' has no=
 member named 'force_dma'
  dev->bus->force_dma =3D true;
          ^~
drivers/gpu/drm/xen/xen_drm_front.c:742:8: error: too few arguments to func=
tion 'of_dma_configure'
  ret =3D of_dma_configure(dev, NULL);
        ^~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/xen/xen_drm_front.c:16:0:
include/linux/of_device.h:58:5: note: declared here
 int of_dma_configure(struct device *dev,
     ^~~~~~~~~~~~~~~~

Caused by commit

  c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")

interacting with commit

  3d6ce86ee794 ("drivers: remove force dma flag from buses")

from the dma-mapping tree.

I have added the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 8 May 2018 11:02:24 +1000
Subject: [PATCH] drm/xen-front: merge fix for "drivers: remove force dma fl=
ag from buses"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/xen/xen_drm_front.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_=
drm_front.c
index 1b0ea9ac330e..0e486cb1c10c 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -737,9 +737,8 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
 	 * is not correct: to fix this call of_dma_configure() with a NULL
 	 * node to set default DMA ops.
 	 */
-	dev->bus->force_dma =3D true;
 	dev->coherent_dma_mask =3D DMA_BIT_MASK(32);
-	ret =3D of_dma_configure(dev, NULL);
+	ret =3D of_dma_configure(dev, NULL, true);
 	if (ret < 0) {
 		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
 		return ret;
--=20
2.17.0

--=20
Cheers,
Stephen Rothwell

--Sig_/k0hUUyUdcszqUbV+EP9.O15
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrw+EQACgkQAVBC80lX
0GwnEggAigTGbaLZ40fM73MkHEMVZLhrBEMvHQ2Ir4FIpihoR+14WIxIPHlzsp7t
XbgSaxEqVwKShEWs7QV02Py3f3qPlAOr+5eLY395KIxYy1pVfYcNK9/huhWws5ec
wapfCUIAS3wOduguokR/55DbfXkwN68bOYtrdUK7CdkS10Q7kV5iwE0wyf/loJwi
HK3VjqXmlzJda7dIVf7EbCYjPdbnHqXL26mNE99ahDdWpW5Nwm8SfpkeAocr9cx3
4/jV88dxJ36lXE1j1EXOQ6OVmykCFRlsc7U1wOXfuSAIppNqc08ZgIDTsgbT2jEa
1oPWy8i6zz8wm4Lbb0J8B0iXlG1O2w==
=KvmS
-----END PGP SIGNATURE-----

--Sig_/k0hUUyUdcszqUbV+EP9.O15--
