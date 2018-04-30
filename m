Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbeD3Af5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 20:35:57 -0400
Received: from ozlabs.org ([203.11.71.1]:57803 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754385AbeD3Afy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 20:35:54 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 30 Apr 2018 10:35:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacek Kalwas <jacek.kalwas@intel.com>,
        Willem de Bruijn <willemb@google.com>
Subject: linux-next: manual merge of the ipsec-next tree with the net-next
 tree
Message-ID: <20180430103546.2d1b6778@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WH_Ga+fJp9VleP.IwbY10J7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WH_Ga+fJp9VleP.IwbY10J7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ipsec-next tree got a conflict in:

  net/ipv4/ip_output.c

between commit:

  bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")

from the net-next tree and commit:

  cd027a5433d6 ("udp: enable UDP checksum offload for ESP")

from the ipsec-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/ipv4/ip_output.c
index f2338e40c37d,a2dfb5a9ba76..000000000000
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@@ -909,8 -906,8 +909,8 @@@ static int __ip_append_data(struct soc
  	if (transhdrlen &&
  	    length + fragheaderlen <=3D mtu &&
  	    rt->dst.dev->features & (NETIF_F_HW_CSUM | NETIF_F_IP_CSUM) &&
 -	    !(flags & MSG_MORE) &&
 +	    (!(flags & MSG_MORE) || cork->gso_size) &&
- 	    !exthdrlen)
+ 	    (!exthdrlen || (rt->dst.dev->features & NETIF_F_HW_ESP_TX_CSUM)))
  		csummode =3D CHECKSUM_PARTIAL;
 =20
  	cork->length +=3D length;

--Sig_/WH_Ga+fJp9VleP.IwbY10J7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrmZOIACgkQAVBC80lX
0GwQcAf/WamzQmhP7QyUeCGOquwivknjlTiILKc4d513TaA30BkShVshIwbF24sf
no1ORpZt6e/NfGVN3kdy4APbh8swkQnPbrSwIDrenWyRlD7GXILpPYsd8d6jZOuL
rwwIuvbSQkjP6lC3+0vwBEoq9yGSJL9Ko7gRj1Zm2HnCOOZiwSvTmZY2mP8SP6hN
eNe2bV4vsyiFyJEgyOhmEOTqyMs38XWL0XugqZsQBxX8G9JErj9WjIVshCxIFj7k
8ZrhfZ+4MEBniJ4fp1rduZTIsBcO+uaZHHKEc+FjmOC3b1k31htnCK4rz9aX68B6
BasCwH1YPJlEtSExN4mAnPC998fGMA==
=1RBy
-----END PGP SIGNATURE-----

--Sig_/WH_Ga+fJp9VleP.IwbY10J7--
