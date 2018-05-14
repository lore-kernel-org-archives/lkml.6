Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeENDqn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:46:43 -0400
Received: from ozlabs.org ([203.11.71.1]:36255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbeENDqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:46:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 13:46:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nitzan Carmi <nitzanc@mellanox.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Subject: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20180514134636.61831bcc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=MXtluWoWD1TnJVOJ94aOq1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=MXtluWoWD1TnJVOJ94aOq1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  drivers/nvme/host/core.c

between commit:

  12d9f07022dc ("nvme: fix use-after-free in nvme_free_ns_head")

from Linus' tree and commit:

  d9cf21bae6cf ("nvme: Avoid flush dependency in delete controller flow")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/nvme/host/core.c
index 99b857e5a7a9,c3cea8a29843..000000000000
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@@ -351,8 -349,7 +351,8 @@@ static void nvme_free_ns_head(struct kr
  	nvme_mpath_remove_disk(head);
  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
  	list_del_init(&head->entry);
- 	cleanup_srcu_struct(&head->srcu);
+ 	cleanup_srcu_struct_quiesced(&head->srcu);
 +	nvme_put_subsystem(head->subsys);
  	kfree(head);
  }
 =20

--Sig_/=MXtluWoWD1TnJVOJ94aOq1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr5BpwACgkQAVBC80lX
0GwlxAf/b4IxOHL6BjlJGOQEDsvCDL5p2PX8Fb3b+boAU9pavH8Ubsq9jYKaUZbe
WtuhmNpnaqQ2qtj+aMT+VCRXP+rQpHsNJZsxhi8esF+dIVtyXbcnHMH3a+zmFZle
ItwYavJr20Hb2hcrvoKForXHSxC567XvVq/5pLaRWW98Th2GLk0KHRcCGCxzopkc
hdrCGUJTJlCkEm6zKvyBTx58lFJp9SaOp6AuVMoVUfXC9aQxKmHHh7O0bmTEP81X
GnqBheDDGHSzucMWRU1huN8MUaWva2PFLiultXPcHLO9+928jXT2ddMLf1hhRsYK
aIV5h7XHZ/5pJc7YzpiIzGfVBWDeoA==
=rUci
-----END PGP SIGNATURE-----

--Sig_/=MXtluWoWD1TnJVOJ94aOq1--
