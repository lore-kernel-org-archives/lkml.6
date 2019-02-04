Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE1C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D642147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kxERU+3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfBDEev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:34:51 -0500
Received: from ozlabs.org ([203.11.71.1]:48333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbfBDEeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:34:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43tFHC1F21z9s3x;
        Mon,  4 Feb 2019 15:34:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549254887;
        bh=+NJpJHJyEpFrxleHMDBCQcLtqjY/cqtq923r1lzp0ik=;
        h=Date:From:To:Cc:Subject:From;
        b=kxERU+3ws0F1dmPY3IbpjJVUtH9sxdLG0ihTPpxx9atkNaga4i5FBAfLdSgkzF02P
         BsmeBAW4ARQ3HwcKiyTZw+z60n6rayUzoHlqowrAVr5GVq54p7ax7IV+RZLedMSUcL
         bqyCI16XRywG0OSgMI6556+MDjEN6Nvlr/dXdOuZQcP2eZfPeha0uqhTL4WqUo0ts8
         KV2+MxEXLmIquWXEKrJq+snsOimsobdk4bp0UDMUwH7ZmX/XtUYoVLDKCCzyU895S2
         rUD1/XRMU4mjXMY7XJJ1EhccI8X/qW6k1p62H44jUHHIToBc0VS+gyS6njBEVUzPAy
         ixV19AikfLOaQ==
Date:   Mon, 4 Feb 2019 15:34:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20190204153446.03ffb5e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/p4WyhcwF87_CCDBil/U8v7g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p4WyhcwF87_CCDBil/U8v7g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (sparc64
defconfig) failed like this:

/home/sfr/next/next/net/core/sock.c: In function 'sock_setsockopt':
/home/sfr/next/next/net/core/sock.c:1146:2: error: duplicate case value
  case SO_BINDTOIFINDEX:
  ^~~~
/home/sfr/next/next/net/core/sock.c:891:2: note: previously used here
  case SO_TIMESTAMP_NEW:
  ^~~~
/home/sfr/next/next/net/core/sock.c: In function 'sock_getsockopt':
/home/sfr/next/next/net/core/sock.c:1493:2: error: duplicate case value
  case SO_BINDTOIFINDEX:
  ^~~~
/home/sfr/next/next/net/core/sock.c:1293:2: note: previously used here
  case SO_TIMESTAMP_NEW:
  ^~~~

Caused by commit

  887feae36aee ("socket: Add SO_TIMESTAMP[NS]_NEW")

I applied the following fix patch (I just update the clashing id rather
than update them all, but the latter may be better).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 4 Feb 2019 15:24:11 +1100
Subject: [PATCH] socket: fix for Add SO_TIMESTAMP[NS]_NEW

Fixes: 887feae36aee ("socket: Add SO_TIMESTAMP[NS]_NEW")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/uapi/asm/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi=
/asm/socket.h
index 8c9f74a66b55..88fe4f978aca 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -108,7 +108,7 @@
 #define SO_TIMESTAMPNS_OLD       0x0021
 #define SO_TIMESTAMPING_OLD      0x0023
=20
-#define SO_TIMESTAMP_NEW         0x0041
+#define SO_TIMESTAMP_NEW         0x0046
 #define SO_TIMESTAMPNS_NEW       0x0042
 #define SO_TIMESTAMPING_NEW      0x0043
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/p4WyhcwF87_CCDBil/U8v7g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxXwOYACgkQAVBC80lX
0GxRzgf+Mua9He8p3RVJFI8H+Newl2TzzXODR3x+tqg6QAUFC6Nx2XsEW35LIl//
eEER5nBqeSyEFIw5GKFfIZ6OmPbqXTZa+YcAuQelxb6rTvYsMepVBSGa41grL52T
jTGmSCkr6BW+sHmirM3DRbzzuCS8tBddcsZCF8IgEJzOaDvOr46Fs2qPUcWK2Z+B
muYQArx2V0wnI8zDec0pvxpgs7g/b1vvMUKPXMfjMWhduQnrBKEVHjnDPez9sXHa
j9jbBbI6I2oiOsWxm1LOAUvVLffw3SZstk4odTrxOfPke6/wpzlp6gN5xhqjRtGN
Xrv9xdBtXCfzmdVb8TdwukGr1JwB1A==
=TCyT
-----END PGP SIGNATURE-----

--Sig_/p4WyhcwF87_CCDBil/U8v7g--
