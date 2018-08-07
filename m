Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC354C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768E221A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vJeU05Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768E221A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbeHGDXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:23:35 -0400
Received: from ozlabs.org ([203.11.71.1]:35149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbeHGDXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:23:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kxLV5jrvz9s3x;
        Tue,  7 Aug 2018 11:11:46 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533604306;
        bh=m+b8rZ4vnP5sCMkPoa9ptsVv7xV6GX3mUvFiqjAYnTg=;
        h=Date:From:To:Cc:Subject:From;
        b=vJeU05UpH1C+S5BoJEOiGe8KooSuBVAbZbaYuBSm62yzYtfaAA5CKZ2YkH6YBvYBY
         Dy2Appci7vtRhM4ufrI7sRwUNwk9TUDxSdEQaLmtl5F059Mv1oaBk6VJaCbzUJYOJi
         urBbFsEB6cCQPetRJJ7zGhEv9VPK5ToI1LCKL38YFloDtYNrdVxpKtY904wBNrX1k9
         Z9ZR8LuSJfODSH4xxXPHt/q3Af8DgWqKuKbFTMzKgEatcBIyHGJvumkkHaigzp/1wy
         Y16/eGC43dD3nxpdpr/8xxvnDijY7Ag1Zq4MUA32WPemd9STqCO8oW4EUL01bHgTx0
         HSspVYUx6+36A==
Date:   Tue, 7 Aug 2018 11:11:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180807111146.0249b0ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+Gx.D8jzJE5QnZLV1jF+R/L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+Gx.D8jzJE5QnZLV1jF+R/L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/usr/bin/ld: /home/sfr/next/tmp/ccWnssuq.o: in function `dump_attr_TIMESTAM=
P_INFO':
test-fsinfo.c:(.text+0x5d4): undefined reference to `pow'
/usr/bin/ld: test-fsinfo.c:(.text+0x618): undefined reference to `pow'
/usr/bin/ld: test-fsinfo.c:(.text+0x65c): undefined reference to `pow'
/usr/bin/ld: test-fsinfo.c:(.text+0x6a0): undefined reference to `pow'

Caused by commit

  90b413cb970a ("vfs: syscall: Add fsinfo() to query filesystem information=
")

interacting with commit

  8377bd2b9ee1 ("kbuild: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS")

from the kbuild tree.

I have added the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 7 Aug 2018 11:01:32 +1000
Subject: [PATCH] vfs: samples: fix up for HOSTLOADLIBES rename

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 samples/statx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/statx/Makefile b/samples/statx/Makefile
index 05b4d30cdd3c..6a862bbc0627 100644
--- a/samples/statx/Makefile
+++ b/samples/statx/Makefile
@@ -7,6 +7,6 @@ always :=3D $(hostprogs-y)
 HOSTCFLAGS_test-statx.o +=3D -I$(objtree)/usr/include
=20
 HOSTCFLAGS_test-fsinfo.o +=3D -I$(objtree)/usr/include
-HOSTLOADLIBES_test-fsinfo +=3D -lm
+HOSTLDLIBS_test-fsinfo +=3D -lm
=20
 HOSTCFLAGS_test-fs-query.o +=3D -I$(objtree)/usr/include
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/+Gx.D8jzJE5QnZLV1jF+R/L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlto8dIACgkQAVBC80lX
0GymeAf/byxau9b+ze3ax4fKj0msRJDYXZomQ2D09KGMc1G6Due2wIfbqy/UHbZU
08DMzaLmeE5k5CQpU6y75GUF2fFL/gGfiYr2/CaL6gs7aij4M2gJE3ialRvkIfZa
8pkuBJo06eK10FjEMogdbfGzKNjS9oGBRLKXmyzfCFdjUA/GgFLb2/Rrav9+HiVR
0o71vxMROtgedJQNJ71rqhwsOgKAAYrCJs4EzMXHAowjQD5XnnryVZNX4AIM3+eL
TG/mPHByDFfuy2uh4P6dLsnQ32QA+2ukg51CyMYzAMB0JYP2KAjfkvPbrt+MfVUF
Vi3cIobz1rMCkuE2kMwGTbjPb4XGdA==
=NMCN
-----END PGP SIGNATURE-----

--Sig_/+Gx.D8jzJE5QnZLV1jF+R/L--
