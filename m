Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeC1HVd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:21:33 -0400
Received: from ozlabs.org ([103.22.144.67]:47283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbeC1HVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:21:31 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 28 Mar 2018 18:19:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the syscalls tree
Message-ID: <20180328181956.309565cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RS8HspKY6+BbNneaSS/2p3T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RS8HspKY6+BbNneaSS/2p3T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Today's linux-next merge of the userns tree got a conflict in:

  ipc/msg.c

between commit:

  370c8f44ce16 ("ipc: add msgget syscall wrapper")

from the syscalls tree and commit:

  50ab44b1c5d1 ("ipc: Directly call the security hook in ipc_ops.associate")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc ipc/msg.c
index 9de48065c1ac,d667dd8e97ab..000000000000
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@@ -253,17 -272,7 +272,7 @@@ static void freeque(struct ipc_namespac
  	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
  }
 =20
- /*
-  * Called with msg_ids.rwsem and ipcp locked.
-  */
- static inline int msg_security(struct kern_ipc_perm *ipcp, int msgflg)
- {
- 	struct msg_queue *msq =3D container_of(ipcp, struct msg_queue, q_perm);
-=20
- 	return security_msg_queue_associate(msq, msgflg);
- }
-=20
 -SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
 +long ksys_msgget(key_t key, int msgflg)
  {
  	struct ipc_namespace *ns;
  	static const struct ipc_ops msg_ops =3D {

--Sig_/RS8HspKY6+BbNneaSS/2p3T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq7QhwACgkQAVBC80lX
0Gx/Ugf/Szx1s7HTiBPJztfWDpJMHwPbQA5u09OL5aOM+BI+t0HmLvVM8wChCz4g
m6fQo30Y8n6u5QyOX0aEeCMHz03LWZa0zdU1qwNKxCgZiLCxpAAoFnqhxBRszAvr
ZBS6AO1zwso3ongGm8VdnDBbGvPGGdcOeNZVvdXLKLqN6Va9zQaxR6w+j1ci4XwI
VQMwtB447WCwvfZKdsUpNJKaZBy8zk15HfzVcGzsgDMZZQ4vV0p7h9IR3r8nQZV7
5cOd8kzN81Yipx99nl2kVhz/fG6lLWVa3KqYSfEKjiTFH+oWYuGKq/TVSWP46Xfv
jbIJzCD/DJCQzdqBOmcTpS6KTF54cw==
=xJ1I
-----END PGP SIGNATURE-----

--Sig_/RS8HspKY6+BbNneaSS/2p3T--
