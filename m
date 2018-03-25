Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCYWRJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:17:09 -0400
Received: from ozlabs.org ([103.22.144.67]:60331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbeCYWRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:17:05 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 09:16:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Machata <petrm@mellanox.com>, Stefano Brivio <sbrivio@redhat.com>
Subject: linux-next: manual merge of the ipsec tree with the net tree
Message-ID: <20180326091610.148fc62d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AGKA7W5SO0LhGtX/vHyOH=f"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AGKA7W5SO0LhGtX/vHyOH=f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

Today's linux-next merge of the ipsec tree got a conflict in:

  net/ipv4/ip_tunnel.c

between commit:

  f6cc9c054e77 ("ip_tunnel: Emit events for post-register MTU changes")

from the net tree and commit:

  24fc79798b8d ("ip_tunnel: Clamp MTU to bounds on new link")

from the ipsec tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/ipv4/ip_tunnel.c
index 7b85ffad5d74,7c76dd17b6b9..000000000000
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@@ -1117,10 -1108,13 +1117,15 @@@ int ip_tunnel_newlink(struct net_devic
  		eth_hw_addr_random(dev);
 =20
  	mtu =3D ip_tunnel_bind_dev(dev);
- 	if (!tb[IFLA_MTU]) {
+ 	if (tb[IFLA_MTU]) {
+ 		unsigned int max =3D 0xfff8 - dev->hard_header_len - nt->hlen;
+=20
+ 		dev->mtu =3D clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
+ 				 (unsigned int)(max - sizeof(struct iphdr)));
+ 	} else {
 -		dev->mtu =3D mtu;
 +		err =3D dev_set_mtu(dev, mtu);
 +		if (err)
 +			goto err_dev_set_mtu;
  	}
 =20
  	ip_tunnel_add(itn, nt);

--Sig_/AGKA7W5SO0LhGtX/vHyOH=f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4H6oACgkQAVBC80lX
0GxzLAf/WJixZ/2PDm7qU4hfAgAnRJhWcx3SH+xi/W2LIA5GmUVVgb4IlomYFoPC
fc2fVdmqtAt3mhyEjuIoRudcu1TYFXaH4y9MJssCgTrIjdhrIjnylHIm0e9JiaYe
cfh+tBHgcmIXGS9e2tGty40ANGtCdiC3hATxcroEHBp5uwvB/lUBx0HtQj7Wfx7X
OoJwmTpmHIodVev2hcJVwUr1xWoYs6bCFxEEJxNkXpBoL7RzYc87DvHkomzfhJzp
kcg98cY+w9LRNRXBqlFw3xJxILQ2mQjI6FezKP9FB5GkPQfYsmmc9Z9OmUPRTvy9
k8a9FqtFP96sJenxgAQZkk6zuDu5Ew==
=aR5m
-----END PGP SIGNATURE-----

--Sig_/AGKA7W5SO0LhGtX/vHyOH=f--
