Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEED5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A0F2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N/Y/6Vkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A0F2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHaCLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:11:36 -0400
Received: from ozlabs.org ([203.11.71.1]:43389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeHaCLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:11:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 421c6W6CJ9z9s3C;
        Fri, 31 Aug 2018 08:07:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535666836;
        bh=NoeGDppzS2tn4kpHldAx8UClqgwEVGKiDGl2ntH54aQ=;
        h=Date:From:To:Cc:Subject:From;
        b=N/Y/6VkmIVH2if98W6YP2DBOkf2jKR0cZ3GCBSmcbvR3fhU0qgCFtlogxqQv8mgRF
         F4C00XRbXoppWpKIuMM2JXIjl36UQKDIb2hFuYggX6XsoZ4I+gzZhOrZWD9Uh40bPT
         O7mFfJi2tb9Ub78DJmHlVALemgANameto/UFmhJOLyckEib1sZZq96zKCMzWwIiP9M
         Pxp1co+2I/296XO4q1cObzdPjM5PL++ordxq5cZc74B8feJmKl0bcEEd7rBmXQWc3c
         8WixAttsG57vx21zg5QritUlsfsiY08R/p7amaNHMFTKJR+y2CEygBTFDbv2MakmJF
         psX5/vrkwuUEg==
Date:   Fri, 31 Aug 2018 08:07:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus <torvalds@linux-foundation.org>
Cc:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: disabling -Wstringop-truncation
Message-ID: <20180831080714.4f94fba9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//=6y5f=6kt6eD++85cbr2_u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//=6y5f=6kt6eD++85cbr2_u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

I am now mainly using gcc v8.2 for my builds and -Wstringop-truncation
causes so many warnings that I am sure to miss others, so I have
applied the below to my fixes tree until the noise reduces.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 31 Aug 2018 07:47:28 +1000
Subject: [PATCH] disable stringop truncation warnings for now

They are too noisy
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 2b458801ba74..a34a9283ee90 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,9 @@ KBUILD_CFLAGS +=3D $(call cc-option,-Wdeclaration-after=
-statement,)
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS +=3D $(call cc-disable-warning, pointer-sign)
=20
+# disable stringop warnings in gcc 8+
+KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-truncation)
+
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+=3D $(call cc-option,-fno-strict-overflow)
=20
--=20
2.19.0.rc1

--=20
Cheers,
Stephen Rothwell

--Sig_//=6y5f=6kt6eD++85cbr2_u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluIapIACgkQAVBC80lX
0Gw02wf7B7iA9KVuFSStUCH1Id8PyDxA2+P2NZIzdDajaE/2rYvhMY7P9Y9wxzfx
OLg4HypjuK2jexPkW+x+2TnE9WpTrtslPbl4dgTe7ARSzjHxdVGv+xJa+F/NyOZ0
twg2i2DLANpnOR1OVsQk2r1YEAuDwJLYytJUihA/0BwrQiDljktNhkrDDL139dLp
aQlD+ygH7aSOKJgrPIfRG5fUwrHbarwtHKAWOYapPAd0k25jep83eOT9Sc7ZsR0F
x8q2/qViHG8zHKv+fnYv59mo9pJzOPdHRnOI9USvkTcqG4WCKPpkYulDKCpbk6ck
tgmlUaXGbME0sf6eDxdsCTQYCALGDg==
=G3Mj
-----END PGP SIGNATURE-----

--Sig_//=6y5f=6kt6eD++85cbr2_u--
