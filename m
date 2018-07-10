Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F40C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A062089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JYiuUDX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A062089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeGJASF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:18:05 -0400
Received: from ozlabs.org ([203.11.71.1]:49665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754530AbeGJAR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:17:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41PjTH5nd0z9s0W;
        Tue, 10 Jul 2018 10:17:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531181877;
        bh=DkANRpM4yuiC6e6RGrIJ+oMg2keX9NKrwt6QS98q7tM=;
        h=Date:From:To:Cc:Subject:From;
        b=JYiuUDX0FkYHVDX5k9Pqv3Fz8A3da22elp0Q4VN3RezMLV7fAwhT8wLe9PnfXG1Hd
         DIQJ42vPUQHYu0xZ5IKL3hsHGeTiSr5RSEvAIdNMEAPu7r98KfR45rbOO9UbmK9VcQ
         /DsGZLJUF3ERDzIPz4HN3kR8F/zJ5tKOdBkvYMdOQ+YRUcP4lu5c7Q/zCqL8Ouq+Im
         ap9ILRQVHlm+DSOhN72Ktcb+7yiFLHh6pvAPut/bXfa/Jm2stHOHTu7FwyWFPM36aP
         TYVidAR95lL0VAZzwXqR3Q8YPZ9QyaE3F/Gst4myrHX44ALIh4bbMpfRC8yv7tV0Y3
         LhFIGJfO0vp1g==
Date:   Tue, 10 Jul 2018 10:17:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the overlayfs tree
Message-ID: <20180710101736.32d6cc6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Lv8gHqCvqsM22ljHWOuQjRX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Lv8gHqCvqsM22ljHWOuQjRX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got conflicts in:

  fs/open.c

between commit:

  d4d6f39c507e ("vfs: optionally don't account file in nr_files")
  88498a6bd8d1 ("vfs: simplify dentry_open()")

from the overlayfs tree and commit:

  5f0cc0005d2e ("introduce FMODE_OPENED")
  13fcca01ef86 ("now we can fold open_check_o_direct() into do_dentry_open(=
)")
  7dfb1eeaea37 ("introduce FMODE_CREATED and switch to it")

from the vfs tree.

I *think* I got this right, but please check.  Is there some way that
these overlayfs commits can be integrated into the vfs tree development
(or vice versa).  Also, I would expect to see *some* Reviewed-by or
Acked-by lines in all this work ...

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/open.c
index 52a1ea584669,39dcbf13031c..000000000000
--- a/fs/open.c
+++ b/fs/open.c
@@@ -731,7 -732,6 +721,7 @@@ static int do_dentry_open(struct file *
  	static const struct file_operations empty_fops =3D {};
  	int error;
 =20
- 	WARN_ON(f->f_mode & ~FMODE_NOACCOUNT);
++	WARN_ON(f->f_mode & ~ (FMODE_NOACCOUNT | FMODE_CREATED));
  	f->f_mode |=3D OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
  				FMODE_PREAD | FMODE_PWRITE;
 =20
@@@ -743,8 -743,7 +733,8 @@@
  	f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
 =20
  	if (unlikely(f->f_flags & O_PATH)) {
 +		WARN_ON(f->f_mode & FMODE_NOACCOUNT);
- 		f->f_mode =3D FMODE_PATH;
+ 		f->f_mode =3D FMODE_PATH | FMODE_OPENED;
  		f->f_op =3D &empty_fops;
  		return 0;
  	}
@@@ -890,47 -893,14 +884,44 @@@ EXPORT_SYMBOL(file_path)
  int vfs_open(const struct path *path, struct file *file,
  	     const struct cred *cred)
  {
 -	struct dentry *dentry =3D d_real(path->dentry, NULL, file->f_flags, 0);
 +	file->f_path =3D *path;
 +	return do_dentry_open(file, d_backing_inode(path->dentry), NULL, cred);
 +}
 =20
 -	if (IS_ERR(dentry))
 -		return PTR_ERR(dentry);
 +/**
 + * path_open() - Open an inode by a particular name.
 + * @path: The name of the file.
 + * @flags: The O_ flags used to open this file.
 + * @inode: The inode to open.
 + * @cred: The task's credentials used when opening this file.
 + *
 + * Context: Process context.
 + * Return: A pointer to a struct file or an IS_ERR pointer.  Cannot retur=
n NULL.
 + */
 +struct file *path_open(const struct path *path, int flags, struct inode *=
inode,
 +		       const struct cred *cred, bool account)
 +{
 +	struct file *file;
 +	int error;
 +
 +	file =3D __get_empty_filp(account);
 +	if (IS_ERR(file))
 +		return file;
 =20
 +	file->f_flags =3D flags;
  	file->f_path =3D *path;
 -	return do_dentry_open(file, d_backing_inode(dentry), NULL, cred);
 +	error =3D do_dentry_open(file, inode, NULL, cred);
 +	if (error) {
- 		put_filp(file);
++		if (file->f_mode & FMODE_OPENED)
++			fput(file);
++		else
++			put_filp(file);
 +		return ERR_PTR(error);
 +	}
 +
- 	error =3D open_check_o_direct(file);
- 	if (error) {
- 		fput(file);
- 		file =3D ERR_PTR(error);
- 	}
-=20
 +	return file;
  }
 +EXPORT_SYMBOL(path_open);
 =20
  struct file *dentry_open(const struct path *path, int flags,
  			 const struct cred *cred)

--Sig_/Lv8gHqCvqsM22ljHWOuQjRX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltD+yAACgkQAVBC80lX
0GxR+QgAod34mQiGNDHM02Dz67oe+BgAzvW0KCo6dNL8/pa54S17Zjw5eoihMhv1
wdmqirlcexjifRMSRWJ27evyQK/zO72PKFC87F5F6eL9j473uv8whh3ks8yG5zVm
c2TWXkeHJmzlnXDc9gwRbbb2fxmp0ug4uC6JqJNdIwRRV92N/0P9CdzknRIBMFPm
1tPtSOgCcZlcpk5/5hLOpqi8KGcYiq1FzOJHIwOUUAP7+LTk3aONnvEwx0XhVvp0
h6IHBDkWZpZabWrP2ARYHK2bEo8rL6YRtk7LUBxK+JiJQ3eTrOf553pN/W5mtRAO
Yt4xLuNKqh/uLBcvpN7SqaaBlRuxdQ==
=ayol
-----END PGP SIGNATURE-----

--Sig_/Lv8gHqCvqsM22ljHWOuQjRX--
