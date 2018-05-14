Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeENB5G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 21:57:06 -0400
Received: from ozlabs.org ([203.11.71.1]:51275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbeENB5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 21:57:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 11:57:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20180514115700.0faadd6f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0zqOct13ybwqAHaIe_T.X2i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0zqOct13ybwqAHaIe_T.X2i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/lib/bpf/libbpf.c

between commit:

  3597683c9da6 ("tools: bpf: handle NULL return in bpf_prog_load_xattr()")

from the bpf tree and commit:

  17387dd5ac2c ("tools: bpf: don't complain about no kernel version for net=
working code")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/lib/bpf/libbpf.c
index 8da4eeb101a6,df54c4c9e48a..000000000000
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@@ -2163,9 -2193,12 +2193,12 @@@ int bpf_prog_load_xattr(const struct bp
 =20
  	if (!attr)
  		return -EINVAL;
+ 	if (!attr->file)
+ 		return -EINVAL;
 =20
- 	obj =3D bpf_object__open(attr->file);
+ 	obj =3D __bpf_object__open(attr->file, NULL, 0,
+ 				 bpf_prog_type__needs_kver(attr->prog_type));
 -	if (IS_ERR(obj))
 +	if (IS_ERR_OR_NULL(obj))
  		return -ENOENT;
 =20
  	bpf_object__for_each_program(prog, obj) {

--Sig_/0zqOct13ybwqAHaIe_T.X2i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr47OwACgkQAVBC80lX
0GxZUQgAiLxjLkXzSOpYKbMoc4IeL0Lb9efzWO+2C8SR61CaUptHmUh8X4bNP2v+
+QKj/i0Y+yyU9Z9SMbhtFpA0toFxNBMRTTvyO+6H4g9Wh1g3goHGjo6t05pvoIAF
ogBVyk6xF94JSQ6avm9UyxrI67bksiAsck3q+Jk6Nzuzo7cjmR4Ge7ALrzZDGk2B
nHlBnki4p6t42WHcD5vwdI8xd20FIm1wKBElvwS4f6mOz/II6ujbL4ILf0PjNpZ4
3g1fqqcRiWYWiGx1JkBiH+vvINwpVgr7Lok9tSgkiynmc/VZIPguUeAgAW53rxve
Fzj4ZN3ricH72G5kXzUGLGnlH/CHnw==
=JkS+
-----END PGP SIGNATURE-----

--Sig_/0zqOct13ybwqAHaIe_T.X2i--
