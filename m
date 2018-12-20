Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA64C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFB420869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J7yUWcDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbeLTE6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 23:58:03 -0500
Received: from ozlabs.org ([203.11.71.1]:48823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbeLTE6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 23:58:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Kzz92FV8z9s55;
        Thu, 20 Dec 2018 15:57:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545281879;
        bh=PUXdGYn7f3L53xZ59rot1M6T4YtSfVbiCwy2AOhO25Q=;
        h=Date:From:To:Cc:Subject:From;
        b=J7yUWcDuPus3xPqcN25+SGB2KL0ohn3JdeSFZhcg0FDleFbJrSYfLVHNhgShpLloy
         4ISFL0cfngQU3+vWmudkIeQy7vPEOb8sayin1gm03HQPNGGvwfTHQW5lSW3GwCjpPW
         PK1Sn5nzq4A5T/eG3Zlmq1+kUMTCo9OouSAsUgw6vj5w5EgqWF4612YMgXmiktkN3b
         Z8DRg77h+2Zg7xBR1oYGzIaCOW9ho0Iqs4YyIc7wvJ4VfpdlOOlr6pRQdPC8HLwmg/
         KQXopjeEZk4H4NfAwWUmsF2wcu9WHmahmQL3zKWShhStRd99V3Sv4fenBnvUTCR5SP
         uUFTwIzVECG3w==
Date:   Thu, 20 Dec 2018 15:57:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20181220155756.52a49829@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0BAu8TO/WPePY_5xpeRdHwh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0BAu8TO/WPePY_5xpeRdHwh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  Makefile

between commits:

  65bba0423ecf ("kbuild: fix UML build error with CONFIG_GCC_PLUGINS")
  059bc9fc375e ("kbuild: make 'archprepare' depend on 'scripts'")
  ce2fd53a10c7 ("kbuild: descend into scripts/gcc-plugins/ via scripts/Make=
file")

from the kbuild tree and commit:

  6ac389346e69 ("Revert "kbuild/Makefile: Prepare for using macros in inlin=
e assembly code to work around asm() related GCC inlining bugs"")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Makefile
index 6ae8a5382d5d,885c74b192f9..000000000000
--- a/Makefile
+++ b/Makefile
@@@ -1104,12 -1104,9 +1104,10 @@@ prepare2: prepare3 outputmakefile asm-g
  prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelea=
se.h
  	$(cmd_crmodverdir)
 =20
- macroprepare: prepare1 archmacros
-=20
- archprepare: archheaders archscripts macroprepare scripts
 -archprepare: archheaders archscripts prepare1 scripts_basic
++archprepare: archheaders archscripts prepare1 scripts
 =20
 -prepare0: archprepare gcc-plugins
 +prepare0: archprepare
 +	$(Q)$(MAKE) $(build)=3Dscripts/mod
  	$(Q)$(MAKE) $(build)=3D.
 =20
  # All the preparing..

--Sig_/0BAu8TO/WPePY_5xpeRdHwh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwbIVQACgkQAVBC80lX
0Gy4eQgAnX0GejxgKTDls2aCJcoce3Pyyc1tYENRHS3qJR1z/c+a+c+NOKPc3zxP
WtzWqb7LEzMaEbDHMO8jV+FMbL2tSMp9TP7Lum5wDA2V2MfBPLc988xqX9WFLpSm
kx3WIswrd0rfFX6/9C1rEga5gZhfooIezoSBOw7a2BVzAylKIxhR5pzb8e+GJU/q
LDvjBMwv0eYsaNoK2hO9ZrVib/4pXI7/y4vy0USjO+d7lIGqHMM1PQEu1ZFd0IDi
47fTwjrhEGHF3L0pvr5EWg6rNfE9lu3MDkfJPjdNGRvbVo3polLk+599BAmhGo07
tBTMnIxAXjgUr6ve+S98+meAmMxpFw==
=21V6
-----END PGP SIGNATURE-----

--Sig_/0BAu8TO/WPePY_5xpeRdHwh--
