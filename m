Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A29222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nZhWqtph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbfBMEZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:25:29 -0500
Received: from ozlabs.org ([203.11.71.1]:60281 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731302AbfBMEZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:25:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zmfF31Ssz9s7h;
        Wed, 13 Feb 2019 15:25:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550031925;
        bh=maphy0uniNerDWnb4HcuPtkHlAk3vlmliDAOvUzD7kY=;
        h=Date:From:To:Cc:Subject:From;
        b=nZhWqtphmimX5bp2AaYklqlFi21CfhAaeBLnb7wP4gn62fmXogL0HWRZ+V64uRhqc
         xwBEfRkEfMkPzsPkyKFEwysqEQLSCpRvX6YwZslRkUITzEw0oI2fPrNxT0frC6Zlw8
         rufzq8JoAfSasxI2WH9rpnCK37wz9BrpRWOAgHb/+j6/YUhkALScgOD4Pta6/NIm2k
         /3J/sWVHuMiyoVk6vvJkk764HiGTmJpEo+HdoQ+1xUys8OMDpuvKseT3a7X6fUN3pg
         l8u9jP0sAXKvIMxm4tYUMSEj6eirZaZc7Hwn/A4zfFRfUYSrEOevF0qYHa1Z+UVXC9
         O6TvWVP8wbjkA==
Date:   Wed, 13 Feb 2019 15:25:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: linux-next: manual merge of the vhost tree with the swiotlb tree
Message-ID: <20190213152522.6c67cb50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pjW_eHSfVgjH1o=fa1_y4vI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pjW_eHSfVgjH1o=fa1_y4vI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  kernel/dma/swiotlb.c

between commit:

  71602fe6d4e9 ("swiotlb: add debugfs to track swiotlb buffer usage")

from the swiotlb tree and commits:

  88eec9b0e80a ("swiotlb: Introduce swiotlb_max_mapping_size()")
  7c1fd56c53d8 ("swiotlb: Add is_swiotlb_active() function")

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

diff --cc kernel/dma/swiotlb.c
index a01b83e95a2a,c873f9cc2146..000000000000
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@@ -678,35 -663,16 +678,49 @@@ swiotlb_dma_supported(struct device *hw
  	return __phys_to_dma(hwdev, io_tlb_end - 1) <=3D mask;
  }
 =20
 +#ifdef CONFIG_DEBUG_FS
 +
 +static int __init swiotlb_create_debugfs(void)
 +{
 +	static struct dentry *d_swiotlb_usage;
 +	struct dentry *ent;
 +
 +	d_swiotlb_usage =3D debugfs_create_dir("swiotlb", NULL);
 +
 +	if (!d_swiotlb_usage)
 +		return -ENOMEM;
 +
 +	ent =3D debugfs_create_ulong("io_tlb_nslabs", 0400,
 +				   d_swiotlb_usage, &io_tlb_nslabs);
 +	if (!ent)
 +		goto fail;
 +
 +	ent =3D debugfs_create_ulong("io_tlb_used", 0400,
 +				   d_swiotlb_usage, &io_tlb_used);
 +	if (!ent)
 +		goto fail;
 +
 +	return 0;
 +
 +fail:
 +	debugfs_remove_recursive(d_swiotlb_usage);
 +	return -ENOMEM;
 +}
 +
 +late_initcall(swiotlb_create_debugfs);
 +
 +#endif
++
+ size_t swiotlb_max_mapping_size(struct device *dev)
+ {
+ 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
+ }
+=20
+ bool is_swiotlb_active(void)
+ {
+ 	/*
+ 	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
+ 	 * address zero, io_tlb_end surely doesn't.
+ 	 */
+ 	return io_tlb_end !=3D 0;
+ }

--Sig_/pjW_eHSfVgjH1o=fa1_y4vI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjnDIACgkQAVBC80lX
0GxH6Af/ZJP1ha+yKx6yIb69Ve/OoDgXxgrLy40PLM49eWdmafMWnETZ8XpWEG7q
naF000apBc7XhRLUvN3Ws6F8Q1XVC9Cy+Mb2rtXf8MytoQRvq6N/qBVjw5RYEoNS
ry/FzVxAWHyhLa1zpRq5uiyBu2nvpbS6YxWjHev9ELEK6AaR5PplLwaH2czneqqB
AhoODBjv0lbI3YszltuR475IJY21KRFSmcxvrsgFvMY1CcdqC1deAl8GOtCs49vB
Xcp/MMUN+yj7OPCTqgO6V38K0A5FeE4eb7XaNi6xBYBWW+IXKNqhqoHbECwXXpfF
m8LThsj7GRadqhLIAYQALzCvayABGg==
=W1Nc
-----END PGP SIGNATURE-----

--Sig_/pjW_eHSfVgjH1o=fa1_y4vI--
