Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755498AbeEAAKm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:10:42 -0400
Received: from ozlabs.org ([203.11.71.1]:60769 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeEAAKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:10:40 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 1 May 2018 10:10:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@oracle.com>
Subject: linux-next: manual merge of the rdma tree with the rdma-fixes tree
Message-ID: <20180501101017.517b38af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Wl9dmyWBlHaq7dgRMcNuJ32"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wl9dmyWBlHaq7dgRMcNuJ32
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/sw/rxe/rxe_resp.c

between commit:

  9fd4350ba895 ("B/rxe: avoid double kfree_skb")

from the rdma-fixes tree and commit:

  2e47350789eb ("IB/rxe: optimize the function duplicate_request")

from the rdma tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/sw/rxe/rxe_resp.c
index 955ff3b6da9c,c45c1ff24497..000000000000
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@@ -1121,23 -1123,13 +1120,12 @@@ static enum resp_states duplicate_reque
  		/* Find the operation in our list of responder resources. */
  		res =3D find_resource(qp, pkt->psn);
  		if (res) {
- 			struct sk_buff *skb_copy;
-=20
- 			skb_copy =3D skb_clone(res->atomic.skb, GFP_ATOMIC);
- 			if (skb_copy) {
- 				rxe_add_ref(qp); /* for the new SKB */
- 			} else {
- 				pr_warn("Couldn't clone atomic resp\n");
- 				rc =3D RESPST_CLEANUP;
- 				goto out;
- 			}
-=20
+ 			skb_get(res->atomic.skb);
  			/* Resend the result. */
  			rc =3D rxe_xmit_packet(to_rdev(qp->ibqp.device), qp,
- 					     pkt, skb_copy);
+ 					     pkt, res->atomic.skb);
  			if (rc) {
  				pr_err("Failed resending result. This flow is not handled - skb ignor=
ed\n");
- 				rxe_drop_ref(qp);
 -				kfree_skb(res->atomic.skb);
  				rc =3D RESPST_CLEANUP;
  				goto out;
  			}

--Sig_/Wl9dmyWBlHaq7dgRMcNuJ32
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrnsGkACgkQAVBC80lX
0GwYKggAieq6QngquggXeIH9/2RF2XQaDmmbOBIpVKsZPF25aO89hyHbRklwdPdF
/sZ2+BZ3OjKrJc/OjLWiApCHUHOGoEqDrkLji1gYuOX3PT6iGPTBZSAFsFFKZgZv
sFuJd0faDPmhFfr7mrbUqm6c0gJEc5+e5SDXixyNJ340tus0lYXS9QLZZny0WZzt
YhKySTSBryciFj1BOdH8Ev9bI9Uk6KVWTSq4i1xMBdW4s5ZmPN8Fg5SHkGMPc0zQ
q/gBydvibmHWAUUruKqlfcH4gZJqYGc1zQxmVQdFCCVqieZvaeHyAAfKyoNP2KSL
mSiloMgyIjN+FUUaXj2RpePsdhs+zg==
=3GkS
-----END PGP SIGNATURE-----

--Sig_/Wl9dmyWBlHaq7dgRMcNuJ32--
