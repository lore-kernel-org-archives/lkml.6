Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDBEC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B657C219C5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UafRQXt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B657C219C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHFCoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:44:13 -0400
Received: from ozlabs.org ([203.11.71.1]:60461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeHFCoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:44:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kJdc1CX7z9s3x;
        Mon,  6 Aug 2018 10:37:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533515860;
        bh=aFZC4SWpK26UmfDM6fen4lMjtOdRC6Y9kSwiJOm/Jco=;
        h=Date:From:To:Cc:Subject:From;
        b=UafRQXt27MI81o/hYDI8f6enbANFzhwmmUHRV/xD29QkZ+52Ay/PnzC1tr3iusmSd
         0IF3h2Z5qD9Z0wnNCGJyEXeFUEQUhiOs4lC8DfXM+piJh6uSGdqdhXONGTLjBPGt8r
         W4Gzmj4suW8J7gTYAGNPKrh24VKjqeSHIXYz6PNox2p8Nhu9m/mRunn7Paaq3uSSdK
         dof2Kv+6HeFqzYWItRi2eey29ivQXMuopD31Q5/BbRyUuHUdtkM/u37tvw7LMd+sp5
         jCc2zOhr8n++prc6q5c+BIj+gUQ3KrPJQs576bLvwsZkd1ZUu5KKCPyjj5LJWU0e1C
         QbCHjyOKb4duw==
Date:   Mon, 6 Aug 2018 10:37:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180806103738.794c479d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O6PynJXjSVInLzFtS633g8e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O6PynJXjSVInLzFtS633g8e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

samples/statx/test-fsinfo.c:26:10: fatal error: linux/fsinfo.h: No such fil=
e or directory
 #include <linux/fsinfo.h>
          ^~~~~~~~~~~~~~~~

Caused by commit

  90b413cb970a ("vfs: syscall: Add fsinfo() to query filesystem information=
")

I guess that headers_install (or whatever its called) has not bee run
before the sample code is built.

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 Aug 2018 10:29:34 +1000
Subject: [PATCH] vfs: don;t build new sample programs yet

It seems that headers_install is not done before the samples
are build so some needed include files are not in the right place.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 samples/statx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/statx/Makefile b/samples/statx/Makefile
index 05b4d30cdd3c..0b4d01822eca 100644
--- a/samples/statx/Makefile
+++ b/samples/statx/Makefile
@@ -1,5 +1,5 @@
 # List of programs to build
-hostprogs-$(CONFIG_SAMPLE_STATX) :=3D test-statx test-fsinfo test-fs-query
+hostprogs-$(CONFIG_SAMPLE_STATX) :=3D test-statx
=20
 # Tell kbuild to always build the programs
 always :=3D $(hostprogs-y)
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/O6PynJXjSVInLzFtS633g8e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltnmFMACgkQAVBC80lX
0GwI7QgAlA5YvG8c85Dk4oGHwVCuNQciHk7BTFnkB7ZGvO93dT4YQKCgMCnPUUXB
H6XP/ZyUjb0WDBz8Zczk6Iqskmc+hRxQZKMCTsl52SQIvGi5dhLJwhU1JVwZmgMR
qBp4GBOAmblyymvRuEszRUD2jmvcMFDckL6/kajfWMTNTeKK4YZ0n7aRRBLseCpZ
Gz/Dh+lz7ZCIAA8vyIPo4y0iYZ1TzbWurpJqISVjBck1BR78ENlpCL8+fYIGAjYG
M0NocKMj6Fu9WviVHrxblTxPY+i00Mm7uyvVqycKxONabrGCIeXJPCPf0LVEbDyF
9ixIsARgQZist1ZrJ3cUeOdJ4Up8wQ==
=8B9i
-----END PGP SIGNATURE-----

--Sig_/O6PynJXjSVInLzFtS633g8e--
