Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800E82083C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OzznLqst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800E82083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeGJAWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:22:25 -0400
Received: from ozlabs.org ([203.11.71.1]:39791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754530AbeGJAWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:22:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41PjZP2Jszz9s0W;
        Tue, 10 Jul 2018 10:22:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531182141;
        bh=Ens97ad6c1sDQ4FDTKT+46uGSLdqO18h39+FtURTHlQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OzznLqstj9LP/sWN540bz4A80Tnl1i8GXI03g6LzA3Ug1K1iIT0q97S83+HK1mFwk
         aXMlQqYSNzmYatlavtghnznbvzb7j5elz/iCCZG5gS5LnCA+UtMhhtyP87rP610qbP
         BvG1O/tAM+VgIy6BrIxckPPp4Kh+/oAYHegKA/k/g/liFYDQ8BEZS/MmOhjscgjL5O
         vCU6yN9UZRHV6dxhgBKl3Vmz99T6O6WR00Y+bxqFcanQ3zbVlV7a7MwpHVj5ctD0s0
         iQkLJpfq98622GgOF9ZErYZHqFBzWYRDLAe6IZb10jHXNEsH2pDzEr1q9KJoqLHmCd
         E1NqX3CVZhf5g==
Date:   Tue, 10 Jul 2018 10:22:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the overlayfs tree
Message-ID: <20180710102220.44ebfc7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NUDafgH0O3dc96lb6xzdwU/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NUDafgH0O3dc96lb6xzdwU/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  include/linux/fs.h

between commit:

  5c299f73cc9e ("vfs: add path_open()")

from the overlayfs tree and commit:

  bfd4fa6990f0 ("turn filp_clone_open() into inline wrapper for dentry_open=
()")

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

diff --cc include/linux/fs.h
index be8de5925a12,b3a210bfea85..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -152,10 -158,10 +158,13 @@@ typedef int (dio_iodone_t)(struct kioc
  #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 =20
  /* File is capable of returning -EAGAIN if I/O will block */
--#define FMODE_NOWAIT	((__force fmode_t)0x8000000)
++#define FMODE_NOWAIT		((__force fmode_t)0x8000000)
+=20
+ /* File represents mount that needs unmounting */
 -#define FMODE_NEED_UNMOUNT     ((__force fmode_t)0x10000000)
++#define FMODE_NEED_UNMOUNT	((__force fmode_t)0x10000000)
 +
 +/* File does not contribute to nr_files count */
- #define FMODE_NOACCOUNT	((__force fmode_t)0x20000000)
++#define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 =20
  /*
   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
@@@ -2419,8 -2445,10 +2442,12 @@@ extern struct file *filp_open(const cha
  extern struct file *file_open_root(struct dentry *, struct vfsmount *,
  				   const char *, int, umode_t);
  extern struct file * dentry_open(const struct path *, int, const struct c=
red *);
 +extern struct file *path_open(const struct path *, int, struct inode *,
 +			      const struct cred *, bool);
+ static inline struct file *file_clone_open(struct file *file)
+ {
+ 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
+ }
  extern int filp_close(struct file *, fl_owner_t id);
 =20
  extern struct filename *getname_flags(const char __user *, int, int *);

--Sig_/NUDafgH0O3dc96lb6xzdwU/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltD/DwACgkQAVBC80lX
0GxoLgf/Y0ak4Mvwoe3pFrxwDlKE3okWJayV4oXKG+gGn7n8mP9nmJdJ5CxYPGXV
Cwa3Uhvr5cLx5fpy/LrwACfVybvIdwEVPcwUpye8Z7GPOIUMlSw+fk8Wjamqjh2D
3/H7uXdcuCzUq5PsPv0AkS+fp3HArOxXGklPU1PrSOs+9iqIKD+cOElZrPsdThyc
bBt2N45cRkadp/IXXkH7UeCemhlKtgdA+/dBD8ZYwUk0QzzHOV6CnBYIsOJeDG3H
SDdbs4lht7CAu5M6GKyqzgQ4+WL1K6R6tvfiD0KAi7zow40ttVbQRcRMoi4GmGBa
NSgzdDXEMK5nCh2Ypr540mGDiTBwdA==
=URye
-----END PGP SIGNATURE-----

--Sig_/NUDafgH0O3dc96lb6xzdwU/--
