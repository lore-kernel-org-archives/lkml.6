Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935488AbeE2Bau (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:30:50 -0400
Received: from ozlabs.org ([203.11.71.1]:39221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935112AbeE2Baq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:30:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 11:30:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zev Weiss <zev@bewilderbeest.net>
Subject: linux-next: manual merge of the vfs tree with the overlayfs tree
Message-ID: <20180529113025.0eb4b16d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2pXBlRdy5/s5QWPPvauDZuT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2pXBlRdy5/s5QWPPvauDZuT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/read_write.c

between commit:

  63ea46a359b2 ("vfs: dedupe: extract helper for a single dedup")

from the overlayfs tree and commit:

  227627114799 ("fs: avoid fdput() after failed fdget() in vfs_dedupe_file_=
range()")

from the vfs tree.

I can't see how to easily fix up this conflict, so I effectively dropped
the vfs tree change.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/read_write.c
index 4d61375a0de4,e83bd9744b5d..000000000000
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@@ -2055,21 -2021,46 +2055,20 @@@ int vfs_dedupe_file_range(struct file *
 =20
  		if (info->reserved) {
  			info->status =3D -EINVAL;
 -		} else if (!(is_admin || (dst_file->f_mode & FMODE_WRITE))) {
 -			info->status =3D -EINVAL;
 -		} else if (file->f_path.mnt !=3D dst_file->f_path.mnt) {
 -			info->status =3D -EXDEV;
 -		} else if (S_ISDIR(dst->i_mode)) {
 -			info->status =3D -EISDIR;
 -		} else if (dst_file->f_op->dedupe_file_range =3D=3D NULL) {
 -			info->status =3D -EINVAL;
 -		} else {
 -			deduped =3D dst_file->f_op->dedupe_file_range(file, off,
 -							len, dst_file,
 -							info->dest_offset);
 -			if (deduped =3D=3D -EBADE)
 -				info->status =3D FILE_DEDUPE_RANGE_DIFFERS;
 -			else if (deduped < 0)
 -				info->status =3D deduped;
 -			else
 -				info->bytes_deduped +=3D deduped;
 +			goto next_loop;
  		}
 =20
 -next_file:
 -		mnt_drop_write_file(dst_file);
 -next_fdput:
 -		fdput(dst_fd);
 +		deduped =3D vfs_dedupe_file_range_one(file, off, dst_file,
 +						    info->dest_offset, len);
 +		if (deduped =3D=3D -EBADE)
 +			info->status =3D FILE_DEDUPE_RANGE_DIFFERS;
 +		else if (deduped < 0)
 +			info->status =3D deduped;
 +		else
 +			info->bytes_deduped +=3D deduped;
 +
  next_loop:
 +		fdput(dst_fd);
-=20
  		if (fatal_signal_pending(current))
  			goto out;
  	}

--Sig_/2pXBlRdy5/s5QWPPvauDZuT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsMrTsACgkQAVBC80lX
0Gx9ngf/bmtt58sWoOTxsHKdxhQHENEJRD6WpWVmfM3O79PXeXQa8Eu80yYh8hMg
TPAcbifFZTqB0NGSbozfYC4fn0SABhGFJhrshl1vDlj4NtlLoB3aUTj4CFfGYp/b
Y1qaFV/NRpJwiSiZ7WxjHDsfC6miE1860/JPnnkr5/MQ13LyF0mtHs3j4oFWSO77
eGS9HHztJlZmy8PV/VhiFg8tP9IckixIuBOj6Hjh4WrUHlJZyvxoUm2UrD2f6feE
uN1S5R+/NKKuNImsLMp6vaC4HljwX9JkLWs+K+08+q/bQxqYykV3aS4gb8ajn8vo
SEaASClXXvwj24i2K/+JItTWJOEFBQ==
=VBXm
-----END PGP SIGNATURE-----

--Sig_/2pXBlRdy5/s5QWPPvauDZuT--
