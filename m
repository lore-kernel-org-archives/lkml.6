Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59323C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1325C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RdhHspqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1325C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeGJBRs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:17:48 -0400
Received: from ozlabs.org ([203.11.71.1]:51567 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754581AbeGJBRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:17:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41PkpF0Y3Yz9rxs;
        Tue, 10 Jul 2018 11:17:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531185461;
        bh=Il3l69rXyZGeugcue/xE4ItwQ1/ZRYS7DDus1nBRiHc=;
        h=Date:From:To:Cc:Subject:From;
        b=RdhHspqqXeUpKSbIXDk8yY61C6BO05R7De9abwstlPbaPspv40SoEykzp3GscFMtH
         Ft6mHgxr3vzL+90dxb0h7UKUb+j+JekXb9wgJmOiYCqeRj1HbYuG81Pb/8PAGqKvAL
         CG790tYjEYi4evGKjBZCFY0ovYbU5bUCLlMQNW38awtf0CPlBL+GahjSfNqproIXMJ
         Ge0iA2q474B46I6WnSlnaOO+tcDfWYO9YwmRHUQVBlECD9VCxKDx6+bXMlHFLGdbpe
         AvZYBu82Foj5n21MgyWsuw+0ypqaLIF/bk3g69ReVxSMOaWz1PnR8r2FMoLElXNrL8
         0IuBE+7ZZte+g==
Date:   Tue, 10 Jul 2018 11:17:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: manual merge of the rdma tree with the rdma-fixes tree
Message-ID: <20180710111740.5f345088@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Te+p1LKerFUhZtZMfBnBc/9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Te+p1LKerFUhZtZMfBnBc/9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/core/uverbs_cmd.c

between commit:

  4fae7f170416 ("RDMA/uverbs: Fix slab-out-of-bounds in ib_uverbs_ex_create=
_flow")

from the rdma-fixes tree and commit:

  2cc1e3b80942 ("IB/uverbs: Replace file->ucontext with file in uverbs_cmd.=
c")

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
index cc06e8404e9b,d048cabc4246..000000000000
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@@ -3559,11 -3505,11 +3505,16 @@@ int ib_uverbs_ex_create_flow(struct ib_
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
@@@ -3583,15 -3529,13 +3534,15 @@@
  	flow_attr->flags =3D kern_flow_attr->flags;
  	flow_attr->size =3D sizeof(*flow_attr);
 =20
 -	kern_spec =3D kern_flow_attr + 1;
 +	kern_spec =3D kern_flow_attr->flow_specs;
  	ib_spec =3D flow_attr + 1;
  	for (i =3D 0; i < flow_attr->num_of_specs &&
 -	     cmd.flow_attr.size > offsetof(struct ib_uverbs_flow_spec, reserved)=
 &&
 -	     cmd.flow_attr.size >=3D
 -	     ((struct ib_uverbs_flow_spec *)kern_spec)->size; i++) {
 -		err =3D kern_spec_to_ib_spec(file, kern_spec, ib_spec, uflow_res);
 +			cmd.flow_attr.size >=3D sizeof(*kern_spec) &&
 +			cmd.flow_attr.size >=3D kern_spec->size;
 +	     i++) {
 +		err =3D kern_spec_to_ib_spec(
- 				file->ucontext, (struct ib_uverbs_flow_spec *)kern_spec,
++				file, (struct ib_uverbs_flow_spec *)kern_spec,
 +				ib_spec, uflow_res);
  		if (err)
  			goto err_free;
 =20

--Sig_/Te+p1LKerFUhZtZMfBnBc/9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltECTQACgkQAVBC80lX
0Gwx0wf/T1xiq4+0+/x3zkIaiz4fgpeOo7TCASY5+s3c+UBoxI9ZvLyWKaqiE3Z+
wrRnEAckCBYX78e0BDFXVkj+2Ca03/e+9WRxeoC5eYYvbujXAeE4ySmGxXfjO18B
G6QINMvKxPdilfxLfH5SofdViJiVs5TlGxOKoOjo0IaHZJcgY2gx9wOHmeIdNjeI
VJs2CYK8law/Gmx+3Zc1xIqNnsA3iUi4WNSeoyNPv8Aki8gMblFGs6mXThLHn1UT
Hf3jfC6Q7hy7L4Fnnl0TiPg+oKgJBTVWMjThSalRJVnuhgmoRmLdJbEAyZTi3ema
6/PAewnTtEkBRFUY8y2XcaPy/oarTw==
=lZby
-----END PGP SIGNATURE-----

--Sig_/Te+p1LKerFUhZtZMfBnBc/9--
