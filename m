Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757031AbeBPBEq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 20:04:46 -0500
Received: from ozlabs.org ([103.22.144.67]:57163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757014AbeBPBEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 20:04:45 -0500
Date: Fri, 16 Feb 2018 12:04:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: manual merge of the xen-tip tree with Linus' tree
Message-ID: <20180216120432.2f4e9c89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RcypGp7ov+IO3ZI01VUMiJ6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RcypGp7ov+IO3ZI01VUMiJ6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xen-tip tree got a conflict in:

  drivers/xen/pvcalls-front.c

between commit:

  a9a08845e9ac ("vfs: do bulk POLL* -> EPOLL* replacement")

from Linus' tree and commit:

  1e7dbff356e5 ("pvcalls-front: introduce a per sock_mapping refcount")

from the xen-tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/xen/pvcalls-front.c
index 753d9cb437d0,ca5b77309c7d..000000000000
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@@ -963,20 -942,13 +942,13 @@@ __poll_t pvcalls_front_poll(struct fil
  {
  	struct pvcalls_bedata *bedata;
  	struct sock_mapping *map;
 -	int ret;
 +	__poll_t ret;
 =20
- 	pvcalls_enter();
- 	if (!pvcalls_front_dev) {
- 		pvcalls_exit();
+ 	map =3D pvcalls_enter_sock(sock);
+ 	if (IS_ERR(map))
 -		return POLLNVAL;
 +		return EPOLLNVAL;
- 	}
  	bedata =3D dev_get_drvdata(&pvcalls_front_dev->dev);
 =20
- 	map =3D (struct sock_mapping *) sock->sk->sk_send_head;
- 	if (!map) {
- 		pvcalls_exit();
- 		return EPOLLNVAL;
- 	}
  	if (map->active_socket)
  		ret =3D pvcalls_front_poll_active(file, bedata, map, wait);
  	else

--Sig_/RcypGp7ov+IO3ZI01VUMiJ6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqGLiAACgkQAVBC80lX
0Gzl/Qf9EJ+rGIkbV3fwxNFrDlDNfH5Ceme9hgscpX7pXg0Lvhg9XfkYSkkkYrIW
mcQrsYhHspRS0DoU0CKIrHDhl2dd8X04yHkY3QU5kiVghJ+fQT7F6VtqOXOhL6sB
tpnd4N4JgZZF770nClQRPwDOaYkmy0uhSABPaUWx9isL2NQPjSXQnnUy0oxC8uj3
zyoLEut/+XGMiGD2x5vH34q6sszQMWwW3hiwdCHcvQ7GrDKsM/SxkRC8WNplTvNC
KG3FOWyv46B3Jhvxs55xU/STkDfIgYRiVIQ3Go/Ng+gsVqHmB4cGkcKm6XfLcUIA
6KdHzfF98oxm5gy2Gq5Pu+ZFeM3JJA==
=5iqi
-----END PGP SIGNATURE-----

--Sig_/RcypGp7ov+IO3ZI01VUMiJ6--
