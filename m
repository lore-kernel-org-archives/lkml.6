Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1056AC64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D64206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dSwaYVw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D64206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJCHSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:18:34 -0400
Received: from ozlabs.org ([203.11.71.1]:52727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeJCHSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:18:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Pxmv405cz9s3l;
        Wed,  3 Oct 2018 10:32:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538526751;
        bh=4zqHunzS/FlxvyFQ7EifBUOBNQJYA6u8YmM7LPEkhkg=;
        h=Date:From:To:Cc:Subject:From;
        b=dSwaYVw3FvOml+bgh8UpYRlR6/e/QcOgR2l4jAPEfJQ1nEAK/uEWp93/hnl83aSEN
         GPpq5FdLN0Z6MWxt+HjTch2fyXmOXEV+lC9GXm/SUAt0ID7Uh6NTnFmEpEu/65QU3d
         mqxh+VVGqOfFKixbO1K2gJa8s2SREIKcRD0MZyrjC8M5mkv9vL7S3PgIt5gUQbPaLX
         AaCo4gh7adSgmg86vCIFq8tTcMYpsRVyzYxeD6AhI/By/1JtIKvYM+oZMWrPLMwZze
         FrayArX2CrFFX/NDVkgzE7J+bk/aFXtolsZK+0JJKmzaDKKy1SshFt+WK9EDG9bkMX
         MHCJdBKGpAKow==
Date:   Wed, 3 Oct 2018 10:32:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Rosenberg <drosen@google.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20181003103222.6e1655cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7RqvNtTlGblUa5KMJ2piGck"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7RqvNtTlGblUa5KMJ2piGck
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/home/sfr/next/next/fs/f2fs/super.c: In function 'f2fs_remount':
/home/sfr/next/next/fs/f2fs/super.c:1589:16: error: 'MS_RDONLY' undeclared =
(first use in this function); did you mean 'IS_RDONLY'?
  if ((*flags & MS_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
                ^~~~~~~~~
                IS_RDONLY

Caused by commit

  dcf8001d292b ("vfs: Suppress MS_* flag defs within the kernel unless expl=
icitly enabled")

interacting with commit

  f80f781514ef ("f2fs: checkpoint disabling")

from the f2fs tree.

I have added the following merge fix patch for today.  If it is correct,
I assume that it could be applied to f2fs tree as the the other uses of
MS_RDONLY have already been changed to SB_RDONLY.  (There is another
use of MS_READONLY in this function that is already cleaned up in the
vfs tree commit.)

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 3 Oct 2018 10:27:04 +1000
Subject: [PATCH] f2fs: update for MS_* flags mostly going away

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6ed77589ff2b..b612a9e4a35e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1586,7 +1586,7 @@ static int f2fs_remount(struct super_block *sb, int *=
flags,
 		goto restore_opts;
 	}
=20
-	if ((*flags & MS_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
+	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err =3D -EINVAL;
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"disabling checkpoint not compatible with read-only");
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/7RqvNtTlGblUa5KMJ2piGck
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0DhcACgkQAVBC80lX
0GyWhQf9EIw/aOB1iDx/v9NLBCqbMNUvpyC6UOsetVp1oRAXBdznh9E0klSLMT/c
sKieccmNuqVvj5jCcpDs6A3xfulwGRtEBiIE8VV3HtCrjCG/PRcANaxBwjI9vLdi
/wfdIm7JeoJeXGI2QdSj6D/O5ATsqJrKM/sBeYiR5RQSGr7/T8YfG3u75c6bI3rK
DgJiOSbeXV+CFA1mgyx93QEid1cU9mK2MOi4U2ob3PYyqDZpxSkldd9Vg5x0gISc
vbL+mRDG1wcrc3W9VqGPER/n5CmIIRcD8WQ2I006YFxgHoph50MxHAKXS7zGjiPF
D+QD5eWnfVaa9xzTm+TB3D+PYwMjAw==
=M5no
-----END PGP SIGNATURE-----

--Sig_/7RqvNtTlGblUa5KMJ2piGck--
