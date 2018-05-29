Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbeE2DmX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:42:23 -0400
Received: from ozlabs.org ([203.11.71.1]:34217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbeE2DmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:42:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 13:42:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBl?= =?UTF-8?B?bA==?=
        <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20180529134209.4b8353f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wW6_Q0.rSu9m3ivmZ58XCaX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wW6_Q0.rSu9m3ivmZ58XCaX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

net/xdp/xsk.c: In function 'xsk_poll':
net/xdp/xsk.c:207:22: error: implicit declaration of function 'datagram_pol=
l'; did you mean 'datagram_poll_mask'? [-Werror=3Dimplicit-function-declara=
tion]
  unsigned int mask =3D datagram_poll(file, sock, wait);
                      ^~~~~~~~~~~~~=20
                      datagram_poll_mask

Caused by commit

  c497176cb2e4 ("xsk: add Rx receive functions and poll support")

interacting with commit

  db5051ead64a ("net: convert datagram_poll users tp ->poll_mask")

from the vfs tree.

[Christoph, I noticed that the comment above datagram_poll in
net/core/datagram.c needs the function name updated]

I have added the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 May 2018 13:34:25 +1000
Subject: [PATCH] xsk: update for "net: convert datagram_poll users tp->poll=
_mask"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/xdp/xsk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index cce0e4f8a536..4ee140afbc61 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -201,10 +201,9 @@ static int xsk_sendmsg(struct socket *sock, struct msg=
hdr *m, size_t total_len)
 	return xsk_generic_xmit(sk, m, total_len);
 }
=20
-static unsigned int xsk_poll(struct file *file, struct socket *sock,
-			     struct poll_table_struct *wait)
+static __poll_t xsk_poll_mask(struct socket *sock, __poll_t events)
 {
-	unsigned int mask =3D datagram_poll(file, sock, wait);
+	__poll_t mask =3D datagram_poll_mask(sock, events);
 	struct sock *sk =3D sock->sk;
 	struct xdp_sock *xs =3D xdp_sk(sk);
=20
@@ -580,7 +579,7 @@ static const struct proto_ops xsk_proto_ops =3D {
 	.socketpair	=3D sock_no_socketpair,
 	.accept		=3D sock_no_accept,
 	.getname	=3D sock_no_getname,
-	.poll		=3D xsk_poll,
+	.poll_mask	=3D xsk_poll_mask,
 	.ioctl		=3D sock_no_ioctl,
 	.listen		=3D sock_no_listen,
 	.shutdown	=3D sock_no_shutdown,
--=20
2.17.0

--=20
Cheers,
Stephen Rothwell

--Sig_/wW6_Q0.rSu9m3ivmZ58XCaX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsMzBEACgkQAVBC80lX
0Gxswwf+Ozt2QOlqUAZ8aqdH44Pqo3mb6vaggSqCflmT67/qhiC12M5fiMXGqyI4
QggzQcphqCPtX+erUrM8PQAPdh5+/sjiCzTc7YgmbIk4UWqAdUlH11H96s3sEBRn
XGQ9PEU+lBbE/NjhI9v4tJL1Es1FgsM+KREPHMWj8f4L8X4O9GvNA4VQl2Ywr4wU
MsvjJtaujAZY6pgCjdx1Vvqj6zdRqf2endCt8Pph/5C7GEq9G1UZKr62hlL4/v0s
en+tVswtL0VNAk8wH4p/k6NelOzwCN+jsBsLXvlNwZArYnYnrTXCgQtMykxcg7MV
P3Lnt4NZYNu2IIT8iy7dh926qDSgzg==
=WRdG
-----END PGP SIGNATURE-----

--Sig_/wW6_Q0.rSu9m3ivmZ58XCaX--
