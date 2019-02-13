Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C516C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57943222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fuXDnt7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfBMGZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:25:23 -0500
Received: from ozlabs.org ([203.11.71.1]:44113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfBMGZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:25:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zqJc3Kjkz9s3l;
        Wed, 13 Feb 2019 17:25:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550039120;
        bh=KH5ptKAplq50O363m3RTOdOzo53uw8V99i7z5GP+wN4=;
        h=Date:From:To:Cc:Subject:From;
        b=fuXDnt7An8WockVzHEwAX7E6EP5S4Zh3xOvRmDpEXZHXgvazUoFNG4egVR+l/QwMR
         34EUV1rsxHOmFSvrd5/TRwEEWDZXyN7G0nvqW48nS28rQhHJouGEKkIVJohOB3FyL/
         Yt+ST5i9HvAoxXHu41DzFJekmoTyXelawOlapbWnpWZrQh5FybUfIQe4yXks9xeyzE
         UvU1P2C91UJZFWNMNIkLqyWe1S3qy1RYXWUoyL5aIjjTqxdiwtBb61fe89/NjWDoSz
         +pAz87ApK63Cj3E1/xPbvQnns3qsFb+A7ZeDEABSLaLraqtlB6zCQXwEhXG1DcM2sC
         iWWnkLcAcynUw==
Date:   Wed, 13 Feb 2019 17:25:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190213172518.50d4fec7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YHOchZ/0xpMrBCruzfM58WQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YHOchZ/0xpMrBCruzfM58WQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

fs/io_uring.c: In function 'io_async_list_note':
fs/io_uring.c:931:16: error: 'VM_MAX_READAHEAD' undeclared (first use in th=
is function); did you mean 'VM_MAYREAD'?
    max_pages =3D VM_MAX_READAHEAD >> (PAGE_SHIFT - 10);
                ^~~~~~~~~~~~~~~~
                VM_MAYREAD

Caused by commit

  4c416502dae2 ("mm: Refactor readahead defines in mm.h")

interacting with commit

  6eff5fa16a2e ("io_uring: allow workqueue item to handle multiple buffered=
 requests")

from the block tree.

I have applied this merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 13 Feb 2019 17:21:44 +1100
Subject: [PATCH] io_uring: fix up for readahead defines refactor

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1ff4acc9654d..c8272bc96d84 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -928,7 +928,7 @@ static void io_async_list_note(int rw, struct io_kiocb =
*req, size_t len)
 		/* Use 8x RA size as a decent limiter for both reads/writes */
 		max_pages =3D filp->f_ra.ra_pages;
 		if (!max_pages)
-			max_pages =3D VM_MAX_READAHEAD >> (PAGE_SHIFT - 10);
+			max_pages =3D VM_READAHEAD_PAGES;
 		max_pages *=3D 8;
=20
 		/* If max pages are exceeded, reset the state */
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/YHOchZ/0xpMrBCruzfM58WQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjuE4ACgkQAVBC80lX
0GxwaAf/bYpw9p+xNQbhPOLksKtY6LePxfnwcuBePysjuh9uWNt92N38var6cTXk
rXCfhfZmEvU54aNTWrMtKtDUpGoR2sEOdRJEK+qC1jq2XCudxl0gRO6FA2Do+lrh
oRqwR9umXK4mGeeLLDEP+i6MZDL9hZNFeztKcqx6fM6VhL6Gp1QnnOwSWgY8gIQL
ZWZMl2xMbsemx6V5TFN8ODSeQhTXvmMJZPDsJ5asPu+8dV01L7onpar9e8AX1G7K
6d7hf3/VzJMuQiENEpdpICPcwoUl85vajf/lWechpXf63ZP3hPWXh60fzaJIP6TB
tIsreEmvniFT/WegiNguVeSCobEDfA==
=tyJJ
-----END PGP SIGNATURE-----

--Sig_/YHOchZ/0xpMrBCruzfM58WQ--
