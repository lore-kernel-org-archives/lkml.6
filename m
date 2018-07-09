Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39430208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="igaSKFlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39430208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933457AbeGIAqo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:46:44 -0400
Received: from ozlabs.org ([203.11.71.1]:58751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933204AbeGIAqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:46:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41P68w53RRz9s01;
        Mon,  9 Jul 2018 10:46:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531097200;
        bh=FNL8x0kmFSba37pa9OwsRcpvdGq7rQG9lfhWkK0N6a4=;
        h=Date:From:To:Cc:Subject:From;
        b=igaSKFlGrngrx+ulKShVIKTKwcoJ9i38K4OU3jPBC76MZiVDipl/RvdJOT6qbtLhg
         ibIld9rVVBmDVWZTRWVzrSBMh2hKB/9JwxIg4sWdFb5moFkKf7fvnlV3de0VzFyIzx
         Ntd866B3NvGMC+WfKqU9j2CjFkkmxVRIfmY2Q+gQThXyxP11DMmxvFumT1j6zKv8RJ
         YGXY3sHKWUxYf9cxbDU1b5Tjjij9eWnbc5y8wlCt9vH1cGzyMe41DY2WElsonFiwDp
         LFj9GSJv5Vwb27/bD5wb7SAjFUEBs8qcLQEbNbEmJc54ysgCWOlfrlF4KhhGEllHx5
         Xqroyw3RTi3Bw==
Date:   Mon, 9 Jul 2018 10:46:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180709104638.2dbfd48e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j4u=J+N0W/DuI_wqnoij4VC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j4u=J+N0W/DuI_wqnoij4VC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/sched/act_csum.c

between commit:

  11a245e2f7bf ("net/sched: act_csum: fix NULL dereference when 'goto chain=
' is used")

from the net tree and commit:

  036bb44327f5 ("net: sched: change type of reference and bind counters")

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

diff --cc net/sched/act_csum.c
index 6e7124e57918,bd232d3bd022..000000000000
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@@ -597,9 -603,8 +603,9 @@@ static int tcf_csum_dump(struct sk_buf
  	struct tcf_csum_params *params;
  	struct tc_csum opt =3D {
  		.index   =3D p->tcf_index,
- 		.refcnt  =3D p->tcf_refcnt - ref,
- 		.bindcnt =3D p->tcf_bindcnt - bind,
+ 		.refcnt  =3D refcount_read(&p->tcf_refcnt) - ref,
+ 		.bindcnt =3D atomic_read(&p->tcf_bindcnt) - bind,
 +		.action  =3D p->tcf_action,
  	};
  	struct tcf_t t;
 =20

--Sig_/j4u=J+N0W/DuI_wqnoij4VC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltCsG4ACgkQAVBC80lX
0GzV1gf+LmaWWvp/3F3qcOeJxD4wNZC3fC3kqSobZGMHfqj7ZXvrvcYmLupQqQCl
yR5hfeYXSWo92AB2Y8n3SoqISA0LxUOFkIxASH2CkKVtGx8WLcMnCMO4ZEfy9YOK
sblxxOH80xga1Jd/kstAeWt9aub7e/DFzltdNCDJcKrKmlauCLRez3kavOLG1X3u
/ZMXyGanM1gTUM5dzT15cJC+VmQYV8MOvftIOrWqg+KPdEK1cg9doE44h3TCAtrh
6CKSryKb7rtD4Wex0RO9xUe7Dtu4Blh+mLBL+S07e1WY48Wb70B/DazhwXztoOVV
5zH/hl0EeUnoyBs1vp4wWunqIyY9bg==
=p/CG
-----END PGP SIGNATURE-----

--Sig_/j4u=J+N0W/DuI_wqnoij4VC--
