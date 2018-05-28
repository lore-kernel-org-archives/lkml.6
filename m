Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936577AbeE1XxG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 19:53:06 -0400
Received: from ozlabs.org ([203.11.71.1]:38411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936541AbeE1XxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 19:53:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 09:52:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>, David Sterba <dsterba@suse.cz>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>
Subject: linux-next: manual merge of the overlayfs tree with the btrfs-kdave
 tree
Message-ID: <20180529095250.097524cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XlVtWaiTkhi=Q4vmBquEQMt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XlVtWaiTkhi=Q4vmBquEQMt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

Today's linux-next merge of the overlayfs tree got a conflict in:

  fs/btrfs/ioctl.c

between commit:

  0b4dc087e29a ("Btrfs: dedupe_file_range ioctl: remove 16MiB restriction")

from the btrfs-kdave tree and commits:

  83d499febfac ("vfs: dedpue: return loff_t")
  7765f19ed5f9 ("vfs: dedupe: rationalize args")

from the overlayfs tree.

[I note the typo in the subject of commit 83d499febfac]

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/ioctl.c
index 4d88d54d042d,70eac76804df..000000000000
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@@ -3637,14 -3192,20 +3637,15 @@@ out_free
  	return ret;
  }
 =20
- ssize_t btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
- 				struct file *dst_file, u64 dst_loff)
 -#define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 -
+ loff_t btrfs_dedupe_file_range(struct file *src_file, loff_t loff,
+ 			       struct file *dst_file, loff_t dst_loff,
+ 			       loff_t olen)
  {
  	struct inode *src =3D file_inode(src_file);
  	struct inode *dst =3D file_inode(dst_file);
  	u64 bs =3D BTRFS_I(src)->root->fs_info->sb->s_blocksize;
- 	ssize_t res;
+ 	int res;
 =20
 -	if (olen > BTRFS_MAX_DEDUPE_LEN)
 -		olen =3D BTRFS_MAX_DEDUPE_LEN;
 -
  	if (WARN_ON_ONCE(bs < PAGE_SIZE)) {
  		/*
  		 * Btrfs does not support blocksize < page_size. As a

--Sig_/XlVtWaiTkhi=Q4vmBquEQMt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsMllIACgkQAVBC80lX
0GzHYQf/bTxDXA8buRp/5DNnq73+rUwPtK5SYt5CCCR1NFlI5uOhHzWeHNd7AvE+
DjVVqI+3KVD/ArZpt/xqH2NWpYx9FvQZw68p4nuRA/gPdnrbROJX9jCRNtBQybuF
Nx0gOMuafnDlLS2/R0/zvVoCdudkQ5GwFvkcajpz5Qy+rI53Qagv914AA3f8O5S4
eMYtF564mf6wZBlFOWUOa2dkzRflVze0gVCZ20F9MW8CxPyGJUSTiJOSNFlE+mtD
U4yp0ehcY00AMDQkPhtL2QzHNamEtKFUf29cHfoXObtJRS8U7pOkG4hG7wnLxdso
RptAMTM3m4k3msX620BVa6I/cYHLyw==
=mKvG
-----END PGP SIGNATURE-----

--Sig_/XlVtWaiTkhi=Q4vmBquEQMt--
