Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01405C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E9A21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lHjguh9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfB0EZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:25:11 -0500
Received: from ozlabs.org ([203.11.71.1]:58493 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbfB0EZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 23:25:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 448MzQ5c1tz9s5c;
        Wed, 27 Feb 2019 15:25:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551241507;
        bh=jGesE4qyT3MmdVGYVH3fTEVgb9cX9X1gLB2LmRQAgdo=;
        h=Date:From:To:Cc:Subject:From;
        b=lHjguh9kmkbyI4ACLF2nuyTQMTaO53nbHDVvW9TmifnXXAE8ToAl6FLKY4UutSfkG
         SWijdRSy4vuzVCrT4I1LouY5cG6hUYukaiuNV2u6kbSx51jeh7HkzcaESahQ+6i0P8
         DCw3nYN1D5t38VP/U0xPp34L7iXWccgvRmbOiRnbZX3TZi0GBtirCPaIEZ4LScoCpO
         +Z4UIZjP+mqkhPdLKhCB3azaD0GL1aCIPpFJRgHej0BE0BP8DToou62Uxf5v/SsiRj
         5gm9GBnMxHqIilZoB3U9vbenNxDRUJhMILTd78ilt0QPbT0iTXOOJKu5SYQpKvRGr9
         fwGi3rgtqZyDw==
Date:   Wed, 27 Feb 2019 15:25:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
Subject: linux-next: manual merge of the vhost tree with the iommu tree
Message-ID: <20190227152506.4696a59f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ci5Ii8RGow6OGgvSL6zlwtY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ci5Ii8RGow6OGgvSL6zlwtY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got conflicts in:

  drivers/iommu/Kconfig
  drivers/iommu/Makefile

between commit:

  004240dcc222 ("iommu/hyper-v: Add Hyper-V stub IOMMU driver")

from the iommu tree and commit:

  d906f4225497 ("iommu: Add virtio-iommu driver")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iommu/Kconfig
index 6f07f3b21816,d507fd754214..000000000000
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@@ -437,13 -435,15 +437,24 @@@ config QCOM_IOMM
  	help
  	  Support for IOMMU on certain Qualcomm SoCs.
 =20
 +config HYPERV_IOMMU
 +	bool "Hyper-V x2APIC IRQ Handling"
 +	depends on HYPERV
 +	select IOMMU_API
 +	default HYPERV
 +	help
 +	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
 +	  guests to run with x2APIC mode enabled.
 +
+ config VIRTIO_IOMMU
+ 	bool "Virtio IOMMU driver"
+ 	depends on VIRTIO=3Dy
+ 	depends on ARM64
+ 	select IOMMU_API
+ 	select INTERVAL_TREE
+ 	help
+ 	  Para-virtualised IOMMU driver with virtio.
+=20
+ 	  Say Y here if you intend to run this kernel as a guest.
+=20
  endif # IOMMU_SUPPORT
diff --cc drivers/iommu/Makefile
index 8c71a15e986b,48d831a39281..000000000000
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@@ -32,4 -32,4 +32,5 @@@ obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-io
  obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
  obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
  obj-$(CONFIG_QCOM_IOMMU) +=3D qcom_iommu.o
 +obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
+ obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o

--Sig_/ci5Ii8RGow6OGgvSL6zlwtY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx2ESIACgkQAVBC80lX
0Gx+jQf/UwkI0tnYk/Qkcr86TMIKkE+nu0A5h4qNA0Dapg1q8uYSbRgznsP0HzL2
K0PkUlwaZgr+LAvxC5v9khCDhX8zQdo9NY/2om0+pm/26LEfHo8dn5AK8d/DHADY
2QZdXBC4P2hSW3rtvRJIRVeVoPJvwqLBsdFtyGtGWwK92ycm95FnQ0Z3I6+buOvc
7IC31x4HUOLPOEw837VZQam0y09UQvwfN4WYNlsx0JDnjpwBoBMTFAWJaX8k4hbu
YuXSpwc3YvJLT7vAHYpnNbOA+aaihyi8h1yuGZR6Odc99o2DpKD6xiaBYYxzl9r5
qOi6a7Aa8GmB+XyOfs1q4YgeRhAMLQ==
=Ua4K
-----END PGP SIGNATURE-----

--Sig_/ci5Ii8RGow6OGgvSL6zlwtY--
