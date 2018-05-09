Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeEIEMw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:12:52 -0400
Received: from ozlabs.org ([203.11.71.1]:55089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeEIEMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:12:50 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 14:12:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Boris Pismenny <borisp@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180509141247.455427de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3V_aOjATl7XD_M8hTO3yGI6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3V_aOjATl7XD_M8hTO3yGI6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/tls/tls_main.c

between commit:

  98f0a39529e5 ("tls: fix use after free in tls_sk_proto_close")

from the net tree and commit:

  f66de3ee2c16 ("net/tls: Split conf to rx + tx")

from the net-next tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/tls/tls_main.c
index 20cd93be6236,4b57ddd72f34..000000000000
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@@ -254,8 -252,12 +254,9 @@@ static void tls_sk_proto_close(struct s
  	lock_sock(sk);
  	sk_proto_close =3D ctx->sk_proto_close;
 =20
- 	if (ctx->conf =3D=3D TLS_BASE || ctx->conf =3D=3D TLS_HW_RECORD) {
 -	if (ctx->tx_conf =3D=3D TLS_HW_RECORD && ctx->rx_conf =3D=3D TLS_HW_RECO=
RD)
 -		goto skip_tx_cleanup;
 -
 -	if (ctx->tx_conf =3D=3D TLS_BASE && ctx->rx_conf =3D=3D TLS_BASE) {
 -		kfree(ctx);
 -		ctx =3D NULL;
++	if ((ctx->tx_conf =3D=3D TLS_BASE && ctx->rx_conf =3D=3D TLS_BASE) ||
++	    (ctx->tx_conf =3D=3D TLS_HW_RECORD && ctx->rx_conf =3D=3D TLS_HW_REC=
ORD)) {
 +		free_ctx =3D true;
  		goto skip_tx_cleanup;
  	}
 =20

--Sig_/3V_aOjATl7XD_M8hTO3yGI6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrydT8ACgkQAVBC80lX
0GxRewf/WxbRG9dTk487Io4Tu6m4KnRXGy+bapkJk+5cNyXE/PjnYoyHE9WxbbY5
KUK4bZh5VXvrw9A4dZYTApHCFMsFRqAOeW3IEmWHqH3KFkiaSmvEp+wvopTesttF
Lpausf14KFKgDHftZH/zp5d2AI77tt32HOTSo8kwyM3+EGqWKhFbl4xBCXOqLytL
Wl6C+yRgkiEidsihHMO4Z275mfNtaZqju+NGfuuoPCR7ijaHvkMwUWE6BvEBnTJz
r9ctc5CzRzj0p4VXYU4bDFgTo2Y27Wp6RT+rPWwdNGaePICqnJ+ppnx1NC6iJzIl
46lQUgqQnn8Fe/AYhJma+Xm97GjWiw==
=IbfP
-----END PGP SIGNATURE-----

--Sig_/3V_aOjATl7XD_M8hTO3yGI6--
