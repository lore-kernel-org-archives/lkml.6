Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A12C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD93B26B5C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p+79d71d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD93B26B5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964828AbeF0AHc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:07:32 -0400
Received: from ozlabs.org ([203.11.71.1]:51825 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754987AbeF0AH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:07:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41FjsC1VHLz9s0n;
        Wed, 27 Jun 2018 10:07:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530058047;
        bh=JKg29/Xv6h0/mNcKmft0LF5JZzG3awp3lXB4bvcPYSk=;
        h=Date:From:To:Cc:Subject:From;
        b=p+79d71dADf8/nnaFGXpw+TInvltVtX+W/rd7nCG1W/sfEKSo4bfM/IGVxNf9Bp4R
         5b1+px7Dce3IWaCBzGwqyNgUZS7JMbJxA8Bdptd6JslDsY/s4ZL22dSnAeOvo5Wi5+
         G2NJJFS315MyLe1xuoDpHZV2aRUdYM9uzm4WV6Ebo4C8ZwykKXuwX6ca4IKeOoDsib
         j2AaKJdnB/34dnSkbpj5l4dqHAoDjaJudrZxw3r/3Fvk2HpvXUPRstVWgzhgllhv8t
         JAGAp+KqwLvHc6ELh24ugGv4Bqix79USKasbeOg7Sw+AHiGkL/1AVUnDTZ2oq5gBNU
         3E3R4x2uKXDYA==
Date:   Wed, 27 Jun 2018 10:07:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: manual merge of the rdma tree with the rdma-fixes tree
Message-ID: <20180627100726.0092e8b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1OCkAc=bknYCZvLm7YUd7s2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1OCkAc=bknYCZvLm7YUd7s2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/core/uverbs_cmd.c

between commit:

  940efcc8889f ("RDMA/uverbs: Protect from attempts to create flows on unsu=
pported QP")

from the rdma-fixes tree and commit:

  e99028ad76e7 ("RDMA/uverbs: Check existence of create_flow callback")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/core/uverbs_cmd.c
index 87ffeebc0b28,5fc14fde274c..000000000000
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@@ -3559,11 -3554,11 +3554,16 @@@ int ib_uverbs_ex_create_flow(struct ib_
  		goto err_uobj;
  	}
 =20
 +	if (qp->qp_type !=3D IB_QPT_UD && qp->qp_type !=3D IB_QPT_RAW_PACKET) {
 +		err =3D -EINVAL;
 +		goto err_put;
 +	}
 +
+ 	if (!qp->device->create_flow) {
+ 		err =3D -EOPNOTSUPP;
+ 		goto err_put;
+ 	}
+=20
  	flow_attr =3D kzalloc(struct_size(flow_attr, flows,
  				cmd.flow_attr.num_of_specs), GFP_KERNEL);
  	if (!flow_attr) {

--Sig_/1OCkAc=bknYCZvLm7YUd7s2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsy1T4ACgkQAVBC80lX
0GyvCwf+NUrHCFgXKoyY1uGsJgyqvjNg3Me4Rnf6CcNiqLoayMim+nC17+gN6+OE
ssK4Cjr3EZvWXz+P+h0AMfTu2mQDtppqIYlvnhmSsqKZrjeL4XrUNLdcNFNnSgDL
PW59mFsNprLOKstL87t4khOTel8aJsK6Xughx6n/VI/ZBcOXpHBrBLdPVtKf1Qkp
PHIRi0EOBHb74MXUZPpK39q9kduQkLyz38tXHxkmVrKkczBnh6elavYA4QY2k2HW
4RolMP2xbnXNy+1GMcmy+RUBdzHyyur+sXtK6lZXwj0gSgivoezxI8PdsgfvERcb
6yBfFk4s21LNhzleXtBiO64G3pFuBQ==
=H7tt
-----END PGP SIGNATURE-----

--Sig_/1OCkAc=bknYCZvLm7YUd7s2--
