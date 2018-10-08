Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A162088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mV2COWGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A162088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeJHPOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:14:14 -0400
Received: from ozlabs.org ([203.11.71.1]:43555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbeJHPON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:14:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TCYB5nd5z9sCr;
        Mon,  8 Oct 2018 19:03:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538985824;
        bh=yr323gT+aF0XYv2zEtWp6k+ruYn3j68ScNUKbgQGCM8=;
        h=Date:From:To:Cc:Subject:From;
        b=mV2COWGnAjj52QSB/RhtF3Yv0vV4hyqI0pD3L7mcQl+8WS5a2glyaqUJ270p3nikj
         jar2vVy3v5GRC5IuWDg5QQ1c/AwxTz/dHzvtckyl5SE2XK75X2671wfwipr4WL3sEK
         z/f3v6dGCJBy+sQnvH2LiQ3cLizVNFifYSXSs5aVox17EKikWqjtopUHiJwAgwUZID
         HFJQWVA81ElnZ8hrNgl00HSwS5b+kw2eAbsfDTp/tK8r/MrjLiUoVvzbyQpCV4ghTB
         Sk9L3Tcb2BtJOmxR98IaOC3twT6LNX30XH7EN11/U4TouL398xMASG4UiIUzXalbsb
         Pl5W5f4qJKXgg==
Date:   Mon, 8 Oct 2018 19:03:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20181008190341.5e396491@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TSb.kuN_b+qfmosvMOwws=y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TSb.kuN_b+qfmosvMOwws=y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

arch/x86/mm/kaslr.c:26:10: fatal error: linux/bootmem.h: No such file or di=
rectory
 #include <linux/bootmem.h>
          ^~~~~~~~~~~~~~~~~

Caused by patch

  "mm: remove include/linux/bootmem.h"

interacting with commit

  3a387c6d96e6 ("x86/kaslr, ACPI/NUMA: Fix KASLR build error")

from the tip tree.

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Oct 2018 18:57:00 +1100
Subject: [PATCH] x86/kaslr, ACPI/NUMA: fix for linux/bootmem.h removal

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index b3471388288d..ad80bdc690c1 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -23,7 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/random.h>
-#include <linux/bootmem.h>
+#include <linux/memblock.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/TSb.kuN_b+qfmosvMOwws=y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu7D10ACgkQAVBC80lX
0Gxs1wgAhN0k56uPNNqElIsc/tF2wGbnr4EqUSzFmRVck/kvGqtiuC8dcek7kh57
DcVxoVG6DZa7wpD6slEldACbSwS1xU82M0D6z2pppnHYqlHRq0cGfpAjzBkSVgmw
QFYiS3dyldFKlckrDi/U2g+30j5WKIF2lpDMJZxzZSr/UwppUJeIOfoKrrv58qcA
5Te52Bh/DHnnOahUZGSs/m15mbG+EUUSXiBNx1JYz2aEY0/jZI9rrt3ih9NEabsF
GsVLiRo59CBghIBqt1UIL9JS6lbepvoj5FRf0roBxQnYNqhu4/1tjrG8G+uOXpqc
4ga1W8vmuWVMncKsq8xBBSCUVAxlfw==
=2pwn
-----END PGP SIGNATURE-----

--Sig_/TSb.kuN_b+qfmosvMOwws=y--
