Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787F1208E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uLvMZ46q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787F1208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbeGMCGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:06:46 -0400
Received: from ozlabs.org ([203.11.71.1]:52325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387938AbeGMCGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:06:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41RbT96w9Kz9s2M;
        Fri, 13 Jul 2018 11:54:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531446865;
        bh=cfa59YctPeC8IltDGFgpNIwqwFdvH2A6JS0TuV400lo=;
        h=Date:From:To:Cc:Subject:From;
        b=uLvMZ46qtP2Kah6nek8goey9zd297TnpeqMiAuCVqClJgvxrxa/Ta7hrXiPm1XRZU
         RQmYteS1slpsYjTzlQj6pSeWRfrl2kEgd2t8u/OU+5mV3L1LMxDTP1FqGMA7gA7bm1
         yKI8sxQifwbF7wsWf/I/06Acr9JYRufTgufyVQ+MB9De7O251+etHo5cJUwXFLvO3a
         IaGCOfbV0SBNyPQqJ3svVtsJbILnmBzhcw/0M6TNiJO3H6g3PGW/KbcloEitoeYXf9
         +AFDYzGjRFM0C+2dxpYSNwmMa/g9EIMZA4L4AfFy5gjytH/IyWT98OIP59WHpnCK7/
         tMk3WxwIRGtOw==
Date:   Fri, 13 Jul 2018 11:54:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Dave Airlie <airlied@linux.ie>
Subject: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20180713115419.1270c385@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ukd8t872aUce3nu=jWPV_hd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ukd8t872aUce3nu=jWPV_hd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Dave cc'd because this will probably turn up in the drm tree soon.]

After merging the drm-intel tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/i915/gvt/kvmgt.c: In function 'gvt_dma_map_page':
drivers/gpu/drm/i915/gvt/kvmgt.c:188:17: error: 'pfn' undeclared (first use=
 in this function); did you mean 'gfn'?
  if (!pfn_valid(pfn)) {
                 ^~~

Caused by commit

  79e542f5af79 ("drm/i915/kvmgt: Support setting dma map for huge pages")

interacting with commit

  39b4cbadb9a9 ("drm/i915/kvmgt: Check the pfn got from vfio_pin_pages")

from Linus' tree (v4.18-rc1).

I added the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 13 Jul 2018 11:48:41 +1000
Subject: [PATCH] drm/i915/kvmgt: merge fixup for "Check the pfn got from
 vfio_pin_pages"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kv=
mgt.c
index 718ab307a500..4d2f53ae9f0f 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -185,12 +185,6 @@ static int gvt_dma_map_page(struct intel_vgpu *vgpu, u=
nsigned long gfn,
 	if (ret)
 		return ret;
=20
-	if (!pfn_valid(pfn)) {
-		gvt_vgpu_err("pfn 0x%lx is not mem backed\n", pfn);
-		vfio_unpin_pages(mdev_dev(vgpu->vdev.mdev), &gfn, 1);
-		return -EINVAL;
-	}
-
 	/* Setup DMA mapping. */
 	*dma_addr =3D dma_map_page(dev, page, 0, size, PCI_DMA_BIDIRECTIONAL);
 	ret =3D dma_mapping_error(dev, *dma_addr);
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/ukd8t872aUce3nu=jWPV_hd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltIBksACgkQAVBC80lX
0Gy3/gf/ZgYmthzwh270WyxJkEcN0ex3baK1oqLrLfd7fjBLXDkphWQDOQBNMcO/
vl/NBEIKiK4iHAOxpemphYFubyc5edvOGZwCCd/kMbBHVHAzpgXNTHOiszP2zk7I
XLZomArFUkIDn3J6QKq0n41q3Mf9qTcd3t8pH4iR5lmSZCXk+2J1dyb6K3RZwdjp
xdz/Zy9Ib0MPbk9zeMnIafJ6uSZ7StN6q+C7j5quXzjd3qbFDb0VILxpwqS10xrh
VUG7qhDuxyLQg9Dru3JSt0UCjxE4bbLnWi67INfcedsslOSETbMCyI0sTgizJioa
g34xZk10I1PIse5SY6hbAomfgicVZg==
=VLDk
-----END PGP SIGNATURE-----

--Sig_/ukd8t872aUce3nu=jWPV_hd--
