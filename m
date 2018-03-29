Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeC2A7M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:59:12 -0400
Received: from ozlabs.org ([103.22.144.67]:36213 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC2A7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:59:10 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 29 Mar 2018 11:58:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the vfs tree with the syscall tree
Message-ID: <20180329115815.6eaa5261@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cywNPsVnJUnYQVLoXv1XqLy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cywNPsVnJUnYQVLoXv1XqLy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/internal.h
  fs/open.c

between various commits from the syscall tree and commit:

  cab64df19466 ("fs: fold open_check_o_direct into do_dentry_open")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/internal.h
index 980d005b21b4,5e797281d941..000000000000
--- a/fs/internal.h
+++ b/fs/internal.h
@@@ -119,13 -111,6 +119,12 @@@ extern struct file *do_filp_open(int df
  extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
  		const char *, const struct open_flags *);
 =20
 +long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 +long do_faccessat(int dfd, const char __user *filename, int mode);
 +int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 +int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t g=
roup,
 +		int flag);
 +
- extern int open_check_o_direct(struct file *f);
  extern int vfs_open(const struct path *, struct file *, const struct cred=
 *);
  extern struct file *filp_clone_open(struct file *);
 =20
diff --cc fs/open.c
index d0e955b558ad,f587f3dbfc7f..000000000000
--- a/fs/open.c
+++ b/fs/open.c
@@@ -719,21 -682,6 +719,11 @@@ out
  	return error;
  }
 =20
 +SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
 +{
 +	return ksys_fchown(fd, user, group);
 +}
 +
- int open_check_o_direct(struct file *f)
- {
- 	/* NB: we're sure to have correct a_ops only after f_op->open */
- 	if (f->f_flags & O_DIRECT) {
- 		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
- 			return -EINVAL;
- 	}
- 	return 0;
- }
-=20
  static int do_dentry_open(struct file *f,
  			  struct inode *inode,
  			  int (*open)(struct inode *, struct file *),

--Sig_/cywNPsVnJUnYQVLoXv1XqLy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq8OicACgkQAVBC80lX
0GyV1QgAjarE6XGyrS02lbGmEcDkgq//kdH//4dyJbn6npSLXWtLQjxiQgRA69mm
aNmUewF84OYJRIWzDGA3Tl+j/34Ou6Wlm4By052VbKcgxrV0cAOhpeGF0xEaj5Iy
6cSh0gSB4h8KJlnqxZr1uG7GFn5bQokR/m2/+b7wI8YOYyENgz5cRhxD9MntYJon
PgfP3tcUQS1NprZ1N/YY/I2Uy9H5qq1PiJYklXw78R76eAkECrqvPdQ9Wkz8Fd3x
ZmOVXmJy3tEBw6UM91JDsx0BZyQpGo72UAPQD8OglHS7xT8kumfM2lmomeidgl8T
Vul0WZ3Bs/XF23ld2FVa/tEIuNpGDA==
=eyzU
-----END PGP SIGNATURE-----

--Sig_/cywNPsVnJUnYQVLoXv1XqLy--
