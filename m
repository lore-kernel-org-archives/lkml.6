Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbeE2Jhc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:37:32 -0400
Received: from ozlabs.org ([203.11.71.1]:49705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932354AbeE2JhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:37:16 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 19:37:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the vfs tree
Message-ID: <20180529193713.317619d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZrbYxbM/.RU+1pgQj4E_.=e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZrbYxbM/.RU+1pgQj4E_.=e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/proc/base.c

between commit:

  0168b9e38c42 ("procfs: switch instantiate_t to d_splice_alias()")

from the vfs tree and commit:

  a1cb629945be ("proc: skip branch in /proc/*/* lookup")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/proc/base.c
index af128b374143,9b02b88e0b91..000000000000
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@@ -2479,17 -2457,14 +2451,14 @@@ static struct dentry *proc_pident_looku
  	for (p =3D ents; p < last; p++) {
  		if (p->len !=3D dentry->d_name.len)
  			continue;
- 		if (!memcmp(dentry->d_name.name, p->name, p->len))
+ 		if (!memcmp(dentry->d_name.name, p->name, p->len)) {
 -			error =3D proc_pident_instantiate(dir, dentry, task, p);
++			res =3D proc_pident_instantiate(dentry, task, p);
  			break;
+ 		}
  	}
- 	if (p >=3D last)
- 		goto out;
-=20
- 	res =3D proc_pident_instantiate(dentry, task, p);
- out:
  	put_task_struct(task);
  out_no_task:
 -	return ERR_PTR(error);
 +	return res;
  }
 =20
  static int proc_pident_readdir(struct file *file, struct dir_context *ctx,

--Sig_/ZrbYxbM/.RU+1pgQj4E_.=e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNH0kACgkQAVBC80lX
0Gzerwf/eH1X4aMft7XXlVcUNdzE4TbP/5c3DR6uYrDsP8FmWpU9KS2nbia18a05
Q45scT7fFWiRMuQQIAZV4z3JMJNBPzoTKEN/ruuQajE6LYht0AkuwNgYwFIWKZH2
xsK+1u0gK8cHXanWGdwFwE0USRtcYUZdpVrsisaJ2z86yMlbhSlXZYhEZdgc9GON
YyZMR4AILnzt/+ICDrbJ0xbWQAfKnkEUY/L9QeckiGk+X1MJu/Mi9r+U3wXT7++l
Mjj5/pFUVL2nAxpl+SxMVCTS6erDi4OA1k5WB5AsXAtjY/GIYzJxpQwdtBEkb0Tq
pfS7R64mmVOYf9qtw1OopIRGGFoICw==
=bEu0
-----END PGP SIGNATURE-----

--Sig_/ZrbYxbM/.RU+1pgQj4E_.=e--
