Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA502184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hBIV6Sxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfBRAGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:06:00 -0500
Received: from ozlabs.org ([203.11.71.1]:41915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfBRAF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:05:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442kfX1wxkz9sD4;
        Mon, 18 Feb 2019 11:05:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550448356;
        bh=V9UIvlY7FSCVHIa04gqtLgyTlTchajySJ9gkIsm0EN8=;
        h=Date:From:To:Cc:Subject:From;
        b=hBIV6SxpmmMkQEzSgkkAn5Emshe1KlEi+TW1nSJgUwd2mYW0L1Zva0KvVe+A/K58x
         HS973FM2AnwVXnMMqb3vvfXNnpx8cvWRc41XcLiKf89UFgoW3zzH8TQox0GkSiIp3f
         /Xb2sUTuwZWmQMjzApgkuBr3F6j4XnsvzSnI0L9ghgeodXBzCEv2H8cqz0fBi8528R
         V3/WiplXmlOY9yH2xgUW/LtOZ+mjVwuBFmh09URWa/PtI/KvftHS3l9kDu9x4zV3id
         qrxXiGuiz+FUM9vD8FFFZqOPO0jbzujrPgP5O0t8G25OMV4muxAspdJFWSZm0IXf5r
         bCG+zvUtN+T5A==
Date:   Mon, 18 Feb 2019 11:05:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Bodong Wang <bodong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20190218110549.7f22feda@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q772.c5OJB2.0jT1oZW0s8h"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q772.c5OJB2.0jT1oZW0s8h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/infiniband/hw/mlx5/ib_rep.c

between commits:

  459cc69fa4c1 ("RDMA: Provide safe ib_alloc_device() function")
  fc9e4477f924 ("RDMA/mlx5: Fix memory leak in case we fail to add an IB de=
vice")

from the rdma tree and commit:

  f0666f1f22b5 ("IB/mlx5: Use unified register/load function for uplink and=
 VF vports")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/mlx5/ib_rep.c
index 95ac97af6166,4700cffb5a00..000000000000
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@@ -48,29 -49,15 +49,15 @@@ static const struct mlx5_ib_profile vf_
  static int
  mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep=
 *rep)
  {
+ 	const struct mlx5_ib_profile *profile;
  	struct mlx5_ib_dev *ibdev;
 =20
+ 	if (rep->vport =3D=3D MLX5_VPORT_UPLINK)
+ 		profile =3D &uplink_rep_profile;
+ 	else
+ 		profile =3D &vf_rep_profile;
+=20
 -	ibdev =3D (struct mlx5_ib_dev *)ib_alloc_device(sizeof(*ibdev));
 +	ibdev =3D ib_alloc_device(mlx5_ib_dev, ib_dev);
  	if (!ibdev)
  		return -ENOMEM;
 =20
@@@ -78,10 -65,8 +65,10 @@@
  	ibdev->mdev =3D dev;
  	ibdev->num_ports =3D max(MLX5_CAP_GEN(dev, num_ports),
  			       MLX5_CAP_GEN(dev, num_vhca_ports));
- 	if (!__mlx5_ib_add(ibdev, &rep_profile)) {
 -	if (!__mlx5_ib_add(ibdev, profile))
++	if (!__mlx5_ib_add(ibdev, profile)) {
 +		ib_dealloc_device(&ibdev->ib_dev);
  		return -EINVAL;
 +	}
 =20
  	rep->rep_if[REP_IB].priv =3D ibdev;
 =20

--Sig_/q772.c5OJB2.0jT1oZW0s8h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxp9t0ACgkQAVBC80lX
0Gx2Tgf/QsivLKhd4IM2EscttulgCDFRn9pTOQ3e63SxivauN73WD/lt2p2MvUMt
mzRm2XbJATNNoUebRydhBnxf4q+g7Ofx3rO/g7FNqnkb/FLj1XcRfs3gpl+2Zju/
TzFF0VgJyb0PbX+YnW58c4ldAsmn/3SYOjzqKIbmekLtOvIR4GSn2iLpqxzltu0K
w/T4vsDzf7tFdNAlKkvu1i4ImVxuRqrnx79RnFQ2oqNwA+4PF6uA+obgTHNtjF+5
54wH+Ay+K8DcuGMV7Eeh4I+3XjjmSNxehEJNvd1IllLIQd7MGF2hAf/+oRY6IxHJ
KsVBjxJMd7gYQ9T4Zgz5psYl4eSpYg==
=4jXy
-----END PGP SIGNATURE-----

--Sig_/q772.c5OJB2.0jT1oZW0s8h--
