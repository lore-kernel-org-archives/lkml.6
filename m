Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47160C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B706A21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KULyLZCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B706A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeJSIVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:21:40 -0400
Received: from ozlabs.org ([203.11.71.1]:48445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeJSIVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:21:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42bmht4k0Bz9sBn;
        Fri, 19 Oct 2018 11:18:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539908286;
        bh=EbixfPrRS3/uuriyedDq74iUF9AIz0a8b7c3i7apz8U=;
        h=Date:From:To:Cc:Subject:From;
        b=KULyLZCAP8QSYiEH4Xc38taglQr/ohygdPB2YsR52x7cOS/5zmSR+DL4pjxdtsx4v
         0/iFgui4SE5ltw1I/GhphUrCTG8/zmjlB6aJpEiRaNJ5fiL6ejAx1ZFEK7cAyKHIW6
         hIMc+drJ5Op/ymVqsA4i/NO7nHstK5a3Z7Pae4HLOjlVQCacxjbiD0oqtdHmNm5C2r
         jMu7B2eH5kSlhFxhr7v2Up8nU27LQwEh/J//4x3+eafYGSw7NdZDoy2sT1XnEgGbtK
         4LcrFwACEgFxlllGUWq3t4ovcLGbYqsi85vi6e3ZC/de4F/VYbk4d0UeqTB+fDAt2Z
         4qQfA7ChNNyuQ==
Date:   Fri, 19 Oct 2018 11:18:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20181019111805.28860f73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/25FRB+FpKCG6tOkPrliMHXx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/25FRB+FpKCG6tOkPrliMHXx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/infiniband/hw/mlx5/flow.c: In function 'mlx5_ib_handler_MLX5_IB_MET=
HOD_CREATE_FLOW':
drivers/infiniband/hw/mlx5/flow.c:163:12: error: 'struct mlx5_flow_act' has=
 no member named 'has_flow_tag'; did you mean 'flow_tag'?
   flow_act.has_flow_tag =3D true;
            ^~~~~~~~~~~~
            flow_tag

Caused by commit

  d5634fee245f ("net/mlx5: Add a no-append flow insertion mode")

interacting with commit

  ba4a41198324 ("RDMA/mlx5: Add support for flow tag to raw create flow")

from the rdma tree.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 19 Oct 2018 11:10:39 +1100
Subject: [PATCH] net/mlx5: fix up for has_flow_tag changing to a flag

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/infiniband/hw/mlx5/flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5=
/flow.c
index e57435cb6d96..f86cdcafdafc 100644
--- a/drivers/infiniband/hw/mlx5/flow.c
+++ b/drivers/infiniband/hw/mlx5/flow.c
@@ -160,7 +160,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 			ret =3D -EINVAL;
 			goto err_out;
 		}
-		flow_act.has_flow_tag =3D true;
+		flow_act.flags |=3D FLOW_ACT_HAS_TAG;
 	}
=20
 	flow_handler =3D mlx5_ib_raw_fs_rule_add(dev, fs_matcher, &flow_act,
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/25FRB+FpKCG6tOkPrliMHXx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvJIr0ACgkQAVBC80lX
0Gy3ZQf/dkbUZFpTwz6UXdJ5lIbzK7EJDhqgxc0Zc0qbgVCSjwgP2XcbQpWVCN8u
aruu20oocXNRHK8FK/T7944nyv6cJ12mBYweb7+3JpVHffKO3CTi9N7ZN+s7jCZc
ZPnVH4gQKB9CDzQ+N/VnUFPIaAhstAGTugDLk1oorKLNGRpbFMm1iAO2bbLeb0nA
D8fTe0yulgRFvsTR87Go/9izQw3Ty1MJzAmxTjlRYEbF/X99JsYwBDzKju0leOBQ
8XHJWxpns3+KIFhFmGYqSscSt6ReMYiB3yxYZAAONW99UaRHsA7M5Rd20Sz0kMeA
lypqxMvrra1Q+I0/vp/oHJPE43qYYA==
=kUuI
-----END PGP SIGNATURE-----

--Sig_/25FRB+FpKCG6tOkPrliMHXx--
