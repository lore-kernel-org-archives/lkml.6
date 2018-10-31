Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEE9C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5299A2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eMIA/z8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5299A2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeJaJSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:18:32 -0400
Received: from ozlabs.org ([203.11.71.1]:36097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbeJaJSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:18:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42l8Dj6ng1z9sC2;
        Wed, 31 Oct 2018 11:22:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540945367;
        bh=e0InvdKKGhuGEFqJNAMxflnM25cirEpI7kcZVLXekg0=;
        h=Date:From:To:Cc:Subject:From;
        b=eMIA/z8PnL6zoI5dzUKlCdoDZNmArPx2j0jR3BMQaVaLyR4DTjdxtJtOKT3FDBr7U
         3hqOpdOUnhrJsNC75KLmYlekd/GQq8Y2fOLrbjt7OuzccnS2RCiPqq04nhyiNc8Y4b
         6jJvdUrWOaGI979A+xB8bQcSEb2IRH1ADdtz8cqkW69fMHk6DPpmyWaProh37Bw/dW
         zij9Bpb9hVPrjOVfco/G1KqTUOfPo9TxFcl7eqCGEndtFSTSmKFEiSgTAJn3mHWMMn
         iyqQ2ooZNnT6ooyAA5zLgp7ov3bAELeyAIeJylWvpKfV7MEKHgZljrrILLNWU/8C98
         x4Q7sYK7qcrKA==
Date:   Wed, 31 Oct 2018 11:22:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20181031112244.71b62e67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UUSPbcXU+t.755lGC47ucM="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UUSPbcXU+t.755lGC47ucM=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xfs tree got a conflict in:

  Documentation/filesystems/porting

between commit:

  1a16dbaf798c ("Document d_splice_alias() calling conventions for ->lookup=
() users.")

from Linus' tree and commit:

  2e5dfc99f2e6 ("vfs: combine the clone and dedupe into a single remap_file=
_range")

from the xfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/filesystems/porting
index 321d74b73937,e6d4466268dd..000000000000
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@@ -623,13 -623,7 +623,18 @@@ in your dentry operations instead
  	On success you get a new struct file sharing the mount/dentry with the
  	original, on failure - ERR_PTR().
  --
 +[recommended]
 +	->lookup() instances doing an equivalent of
 +		if (IS_ERR(inode))
 +			return ERR_CAST(inode);
 +		return d_splice_alias(inode, dentry);
 +	don't need to bother with the check - d_splice_alias() will do the
 +	right thing when given ERR_PTR(...) as inode.  Moreover, passing NULL
 +	inode to d_splice_alias() will also do the right thing (equivalent of
 +	d_add(dentry, NULL); return NULL;), so that kind of special cases
 +	also doesn't need a separate treatment.
++--
+ [mandatory]
+ 	->clone_file_range() and ->dedupe_file_range have been replaced with
+ 	->remap_file_range().  See Documentation/filesystems/vfs.txt for more
+ 	information.

--Sig_/UUSPbcXU+t.755lGC47ucM=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvY9dQACgkQAVBC80lX
0GwAnAf/W1trKamURUrsaeJdnjHRf6Ln93h+z9RzjBgCx7tIRK+HvGVwQuUVgsjK
WUtZasJffW18z0jS1673oCBvKe5hhZ3AZIhuyA++m0FXfPAKYnQaCC/eJzO4yE4y
6Pp9Pheu98Z+FP8sSSLMNGo0US1cGAIX2JRLBA1gthfZtn5a6d81iNtTjd+div0H
cfF2iodUtSeE9B2blhAYeNjR9rPnSJ08L7QdB5D33nG2k78WSdnD7P+CCkE5dyV3
oPqorp0aA+7Y2gJ/b8FC1QQdJNFo+udolKFpyVOvtZE4vAgOz4kOuPT8rjhYQFet
pObV1nOay8DCtw77yWzD8OsNDg0pFQ==
=MLav
-----END PGP SIGNATURE-----

--Sig_/UUSPbcXU+t.755lGC47ucM=--
