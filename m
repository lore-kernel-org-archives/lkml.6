Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CDFC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC432084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SwPWEU5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfBCWd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 17:33:58 -0500
Received: from ozlabs.org ([203.11.71.1]:53563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfBCWd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 17:33:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43t5Gq4jNbz9s4V;
        Mon,  4 Feb 2019 09:33:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549233236;
        bh=jBSbfDUkqFuN7oNDL7odT21a6csHPMacszwEpSXK/nI=;
        h=Date:From:To:Cc:Subject:From;
        b=SwPWEU5Twd8AXKonwEFxzr0qK70IWkSHIajO0O2u1GIEe0aF4JzbUafkUbDPXnzQr
         dzmyU2Pzm2XgBjhEFDwBskvbGr1JqSai+m2i/JX0RhqpGV4GHq+bRI3N304HG7Hu5r
         Q/lduVIWXSS/s+P1fWoqV7/cSj7qUDcB0iJyZB4ddMUHhrkisMHI0Sbtug48QgPW2g
         hdbKThfQXmcjOSDBkZHh28I3jUVciPzUkIY7NQq82OPzrC1gnecDcXK59BxTADLS54
         +sI7gVb1PONtL+cv6e9qs4eYVgV9epQ2Qirj12O53rzG3drZYTG9XZvJWkJu1TRlFr
         tsWtg0koDKfIw==
Date:   Mon, 4 Feb 2019 09:33:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build warning after merge of the vfs tree
Message-ID: <20190204093334.0ccc42bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Tw9z5EpDEqZrmD1hAD0N=Kv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tw9z5EpDEqZrmD1hAD0N=Kv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from include/linux/printk.h:7,
                 from include/linux/kernel.h:14,
                 from include/linux/fs_context.h:15,
                 from fs/fs_parser.c:13:
fs/fs_parser.c: In function 'fs_validate_description':
include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of=
 type 'long unsigned int', but argument 3 has type 'int' [-Wformat=3D]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^~~~~~
include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
 #define KERN_ERR KERN_SOH "3" /* error conditions */
                  ^~~~~~~~
include/linux/printk.h:303:9: note: in expansion of macro 'KERN_ERR'
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~
fs/fs_parser.c:413:6: note: in expansion of macro 'pr_err'
      pr_err("VALIDATE %s: e[%lu] enum val for %s\n",
      ^~~~~~
fs/fs_parser.c:413:31: note: format string is defined here
      pr_err("VALIDATE %s: e[%lu] enum val for %s\n",
                             ~~^
                             %u

Introduced by commit

  f512b838c104 ("vfs: Add configuration parser helpers")

--=20
Cheers,
Stephen Rothwell

--Sig_/Tw9z5EpDEqZrmD1hAD0N=Kv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxXbD4ACgkQAVBC80lX
0GyGOggAojmSbNcpsWYJ22TFTQQm67eqpcLfVY9tyfjgJIPbjvukYi3LoHpLvgC1
Qz+Sf38QrPAjom/euzOivARZJBFyASIQ+Eff3Rr2ZH8gpLWLoOJzu7fWprc5M2f9
+OgOVbUm4xkG7pMplJBOhSct4711Es0Di/AVbZ/xFCgCmABbOOwVNSxx/LeG0fv4
V8Poe6it8YpZ/W3Q6f2YTfd0foDD+/ubXi+Obs7uMFTW+Te3X4ItzL2pO7qxECB9
pWIdP44BerCn3FJPL4b7g8nE3GXfgM20autI4Le8BgZdYyVWOzEc1vNyhBRVrmsu
aQXayUyGuCb3D5vnbhdfgsm8mIFoDw==
=juti
-----END PGP SIGNATURE-----

--Sig_/Tw9z5EpDEqZrmD1hAD0N=Kv--
