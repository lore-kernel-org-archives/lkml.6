Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43856C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CAE20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h+RKq05+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CAE20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbeLJXNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:13:25 -0500
Received: from ozlabs.org ([203.11.71.1]:40235 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeLJXNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:13:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DJlk3Yt6z9s4s;
        Tue, 11 Dec 2018 10:13:22 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544483602;
        bh=HFQ+rMfvFmZjZzpMfZy+HVrnkQF3H3JXVDFgdR87BZg=;
        h=Date:From:To:Cc:Subject:From;
        b=h+RKq05+AZis9qW1pld4cCXW25Dy3TD5AtABgUH1M0A87oKjOwntesZEqi/Mg1QxX
         T05JHJbRxlIqepDDUo4qjqgG93E5jovYjQrYp4niuWZtigt5mbQyQ8xx8Xvm3bOWKr
         EU75p2Pw/kzrn4B070Wc+SwtJZBDjzUMy2Hl8PlUmRnYVPEq+CR4Wjls1zGa8RpFST
         NR3J3rc+4Z+lKXO/4gDMM2gEizT/TQggMUyAtZ+Kv60AFH6ul3dUT0jww3AsadUgas
         0D32y0M+SwFs2oP4iebWuc9h//PTsb8bK/jVaaO85IxbI+vZ4jgHS7MnPXb34O7CRL
         GuKQG3D5Y5Z/w==
Date:   Tue, 11 Dec 2018 10:13:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the f2fs tree with the fscrypt tree
Message-ID: <20181211101322.438946fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mzvSQGkDD/xe951vhGipX7/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mzvSQGkDD/xe951vhGipX7/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the f2fs tree got a conflict in:

  fs/f2fs/dir.c

between commit:

  848a010287e6 ("f2fs: use IS_ENCRYPTED() to check encryption status")

from the fscrypt tree and commit:

  4e240d1bab1e ("f2fs: check memory boundary by insane namelen")

from the f2fs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/dir.c
index cf9e2564388d,c0c845da12fa..000000000000
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@@ -808,7 -808,18 +808,18 @@@ int f2fs_fill_dentries(struct dir_conte
  		de_name.name =3D d->filename[bit_pos];
  		de_name.len =3D le16_to_cpu(de->name_len);
 =20
+ 		/* check memory boundary before moving forward */
+ 		bit_pos +=3D GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+ 		if (unlikely(bit_pos > d->max)) {
+ 			f2fs_msg(sbi->sb, KERN_WARNING,
+ 				"%s: corrupted namelen=3D%d, run fsck to fix.",
+ 				__func__, le16_to_cpu(de->name_len));
+ 			set_sbi_flag(sbi, SBI_NEED_FSCK);
+ 			err =3D -EINVAL;
+ 			goto out;
+ 		}
+=20
 -		if (f2fs_encrypted_inode(d->inode)) {
 +		if (IS_ENCRYPTED(d->inode)) {
  			int save_len =3D fstr->len;
 =20
  			err =3D fscrypt_fname_disk_to_usr(d->inode,

--Sig_/mzvSQGkDD/xe951vhGipX7/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwO8xIACgkQAVBC80lX
0Gy9JggAm9oZZAeRq13RI5i6WlpVoydGB0NRXvHe+d/ThDkZhonr0FoQBKgYM20U
LXdp6oryxnL5XxREFtEaJR3HwBNLnDZtaGLFmmaQrnbwz3vh0CCqgh6F1xWRW3lP
FaDUMUUK7MKlyzKDXvjPmIzT8euCbRtDvvOZpGw7nWCBFBhLQZaFKezehGTifBAk
Vr0vJpRflY1WIKHzBAp4zybC2oHx6jf4t02kYBSSMXkZ9iOLye8xrVOgShcKf1uq
X3iCRiNGdpLx/xri9dw/GvShfyP4UdTm9cvQ8Fb8PSNXeQO6hvQKZi7vsiHRj3/U
OZu0lid6qy4UfKLIfDyiAIbjp48ItA==
=s6Vc
-----END PGP SIGNATURE-----

--Sig_/mzvSQGkDD/xe951vhGipX7/--
