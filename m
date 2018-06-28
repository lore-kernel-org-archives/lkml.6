Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A69C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C21827A78
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FlPywRpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21827A78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936296AbeF1XrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:47:13 -0400
Received: from ozlabs.org ([203.11.71.1]:53683 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935342AbeF1XrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:47:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41GxJs6KfJz9s0n;
        Fri, 29 Jun 2018 09:47:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530229630;
        bh=/ezACb89BeygFLyBVOUIkHBA6g7nf4/XS1kVOEsNhxI=;
        h=Date:From:To:Cc:Subject:From;
        b=FlPywRpcoO+yv2OAc9IT9dfjOi8/+ZXbYannmhSu7r9tUQjoHhPFL42QePSmgE3gw
         s/lbru6N//PqUBtWQBwoRdo/Vnsa1SZSPJHoLahr//81Lvdx3IamdYyKLaLSqrS3oC
         t+GyO+j2FNr/WFEicMwtB03MhqbNVAON5nZnzttR+Wn4W7tmxqk9cwIQ67wrv4lJmy
         IfFr9G2cYBcM7ayM8HMPR8cGi5+a0jwGGgAvcGVbwL55yFjHNKO73uFkU3IvfkWDC5
         L32BtPeQTS5ct6qzmda8B/O6iOarnYPBYj5JnkCp8DPohKXyQN2NImd1AK7qfjItnG
         Q6tKm5kyd1kfg==
Date:   Fri, 29 Jun 2018 09:46:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: linux-next: manual merge of the mips tree with the mips-fixes tree
Message-ID: <20180629094649.7b07c105@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H5SGwxAQR3IJPVy27cngqGl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H5SGwxAQR3IJPVy27cngqGl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/kernel/process.c

between commit:

  b63e132b6433 ("MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()")

from the mips-fixes tree and commit:

  8c8d953c2800 ("MIPS: Schedule on CPUs we need to lose FPU for a mode swit=
ch")

from the mips tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/mips/kernel/process.c
index 9670e70139fd,fe6001d748cf..000000000000
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@@ -29,7 -29,7 +29,8 @@@
  #include <linux/kallsyms.h>
  #include <linux/random.h>
  #include <linux/prctl.h>
 +#include <linux/nmi.h>
+ #include <linux/cpu.h>
 =20
  #include <asm/asm.h>
  #include <asm/bootinfo.h>

--Sig_/H5SGwxAQR3IJPVy27cngqGl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1c2kACgkQAVBC80lX
0GzeFQgAofOO+fgBPL2RwvXKhV7Rj0jSVcrfhUll5BSwGuyLuEWgkhm67KpJqydP
tGb4IoUGrTQ5CVzg51iQRS+qZfl3yGZMyzG/4iAEgJN+uOAY2Ovk13RnLjTANr34
hlTPWlvGa4gSW2WJk2Ay41xAQhywdgolsPZPuQrbQrn+uUqkVoCR9z+lKGNmDKiF
FqGqQs7NXAXkqPpKhHqJ48sMQBK8fTtA1jA2daM/HX8O9YgRQA1mdYudfyVz2QPV
0uobmdAanvcuNTSbMiYDfQj1vnRZrrhMQ/fTHgsjHagBkgeakEaF7m1bJ6lCnJyM
6jGX5WWocK2/PJLFXkfYaBDiF3LhSw==
=xKOi
-----END PGP SIGNATURE-----

--Sig_/H5SGwxAQR3IJPVy27cngqGl--
