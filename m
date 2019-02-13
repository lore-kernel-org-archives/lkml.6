Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70243C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33451222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b67TbY3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfBMGDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:03:51 -0500
Received: from ozlabs.org ([203.11.71.1]:60007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfBMGDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:03:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zpql4dDgz9s7T;
        Wed, 13 Feb 2019 17:03:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550037828;
        bh=9ddDtZlO/UxzMME3Y1BpK99ao8Wzq07MFJ0C7wB9Vy0=;
        h=Date:From:To:Cc:Subject:From;
        b=b67TbY3FErGrMogwIHKAKInKSJnVOdu/dKL4ACh+TVUONIItlYypCqhdwqkRtBq71
         eB/6k2NW7h29Nz/WH3NeClUO+EpyOZJOgTN848NGM3dcUm2TYZ5KFzYw/nNswSSlrW
         RrGcZZWP9jda+mW2zAGy0w9OT0SkEwB45OIWnfUecQxcgbLBFkJy9oHQaGM0Ta4AYO
         eHV3sacafe/Tu/6zvtO10SZcX3cp2Cg6iJyz9gOIv/2m+UjJZFTjolikOoA8mrkjxx
         MDVKeKhiYTeUw+qEejWg+5p6IFBLvap6P0gKmrVLJATwYURA+V9t/nGZFdHuv0QqzG
         pgnx/exazPusg==
Date:   Wed, 13 Feb 2019 17:03:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: linux-next: manual merge of the akpm-current tree with the kspp
 tree
Message-ID: <20190213170345.656c3030@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3Gc2sE8KC2b8Gtu8=f2jYIg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3Gc2sE8KC2b8Gtu8=f2jYIg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  scripts/gcc-plugins/Kconfig

between commit:

  9219e54be983 ("gcc-plugins: structleak: Generalize to all variable types")

from the kspp tree and commit:

  7fabedf42152 ("kasan: remove use after scope bugs detection.")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc scripts/gcc-plugins/Kconfig
index d0cc92e48f6f,d9fd9988ef27..000000000000
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@@ -67,22 -67,13 +67,18 @@@ config GCC_PLUGIN_LATENT_ENTROP
  	   * https://pax.grsecurity.net/
 =20
  config GCC_PLUGIN_STRUCTLEAK
 -	bool "Force initialization of variables containing userspace addresses"
 +	bool "Zero initialize stack variables"
- 	# Currently STRUCTLEAK inserts initialization out of live scope of
- 	# variables from KASAN point of view. This leads to KASAN false
- 	# positive reports. Prohibit this combination for now.
- 	depends on !KASAN_EXTRA
  	help
 -	  This plugin zero-initializes any structures containing a
 -	  __user attribute. This can prevent some classes of information
 -	  exposures.
 -
 -	  This plugin was ported from grsecurity/PaX. More information at:
 +	  While the kernel is built with warnings enabled for any missed
 +	  stack variable initializations, this warning is silenced for
 +	  anything passed by reference to another function, under the
 +	  occasionally misguided assumption that the function will do
 +	  the initialization. As this regularly leads to exploitable
 +	  flaws, this plugin is available to identify and zero-initialize
 +	  such variables, depending on the chosen level of coverage.
 +
 +	  This plugin was originally ported from grsecurity/PaX. More
 +	  information at:
  	   * https://grsecurity.net/
  	   * https://pax.grsecurity.net/
 =20

--Sig_/3Gc2sE8KC2b8Gtu8=f2jYIg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjs0EACgkQAVBC80lX
0GzayQf/V98XM0JTiHCheBVhkf9RjTLiVDFPwM5mGCWbvTlYEQlfH174/b9qzkok
YqT2Y8oUBScvB9s8xEP0tcnbw9ZfKLm9LPRNIOvu+fWnrebCX7zYtbzRwUAgROu7
xFAVrftk+vH0Ij+cgCUPbAUN5pmx1axchaN5O/JTYNRAqRroOjqWBMJsr2aAHc/S
3li0xUAXO7oFNSVjlMqKg/3DtKqxMbVmVNWjGXv1JtAcZ13Ug+2paPF3IEQLCLMb
rx0bH+4yVFQNAzPk3bg2T+WTdRSOVZpulqALscri2+2oiVVndDZgv3LzOPIjq6wL
Yg/JNtpoeYUhgQ07E6MTW6qHBEnR/A==
=M/Xn
-----END PGP SIGNATURE-----

--Sig_/3Gc2sE8KC2b8Gtu8=f2jYIg--
