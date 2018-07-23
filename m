Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CFC20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i6y9ga3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CFC20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbeGWKm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:42:56 -0400
Received: from ozlabs.org ([203.11.71.1]:53147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388137AbeGWKmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:42:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YxNm4sHqz9s3N;
        Mon, 23 Jul 2018 19:42:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532338953;
        bh=fvTd2y/z7yO7wVj4yp1cuknSbMgmiKdgnv5hWh8cttg=;
        h=Date:From:To:Cc:Subject:From;
        b=i6y9ga3kV+gdLjtpf65cN0jcCydSQVdRAmGy2NI7Ps2k2M2/ZVFMNw1GK2gYn7I5w
         EJhaJFttBvoNS1eMcaTBXbDyD049GiuIsdSA9d8Lz77qog+3FBIJYTizHvUZ4h79bi
         BOWW90I086HzyN8Jq1N/6wWECVNKrjI4Zr9Jc3q4N3Ly1Pp4NfodC1RugWAj95YvYV
         XpDGQWsyjtzaKBSS4tQVOrf1dcUfOprwIiDleyJ39vekOtxMf0qk39siI+3y5G/aDg
         hYyUHQKdp1MC9ZzJgjypY3bRjYflavZfrzLicPywWY4yBl2On4wCIE69jBMVD4YQW/
         RxkJoehmmcquQ==
Date:   Mon, 23 Jul 2018 19:42:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180723194231.3d8f0439@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NHprnNiS2jM/SsWHL+q63Cu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NHprnNiS2jM/SsWHL+q63Cu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (sparc (32 bit)
defconfig) failed like this:

In file included from kernel/crash_core.c:9:0:
kernel/crash_core.c: In function 'crash_save_vmcoreinfo_init':
include/linux/crash_core.h:44:66: error: lvalue required as unary '&' opera=
nd
  vmcoreinfo_append_str("SYMBOL(%s)=3D%lx\n", #name, (unsigned long)&name)
                                                                  ^
kernel/crash_core.c:404:2: note: in expansion of macro 'VMCOREINFO_SYMBOL'
  VMCOREINFO_SYMBOL(swapper_pg_dir);
  ^~~~~~~~~~~~~~~~~

Caused by commit

  e527c514996a ("proc/kcore: add vmcoreinfo note to /proc/kcore")

It seems that sparc does not declare swapper_pg_dir for 32 but builds,
they just define it to be NULL.  As do some others:

$ git grep -w 'define.*swapper_pg_dir'
arch/arm/include/asm/pgtable-nommu.h:#define swapper_pg_dir ((pgd_t *) 0)
arch/c6x/include/asm/pgtable.h:#define swapper_pg_dir ((pgd_t *) 0)
arch/h8300/include/asm/pgtable.h:#define swapper_pg_dir ((pgd_t *) 0)
arch/m68k/include/asm/pgtable_no.h:#define swapper_pg_dir ((pgd_t *) 0)
arch/microblaze/include/asm/pgtable.h:#define swapper_pg_dir ((pgd_t *) NUL=
L)
arch/sparc/include/asm/pgtable_32.h:#define swapper_pg_dir NULL
arch/xtensa/include/asm/pgtable.h:# define swapper_pg_dir NULL

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/NHprnNiS2jM/SsWHL+q63Cu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVowcACgkQAVBC80lX
0Gwk/gf/S8czSjJdefz5x1juG2ZcS/h8NUij56ml9wY897HxNUhK46y5njdTZkY5
VECtk9Z060MqHiHgGtLDZ/wZH/32glvkvjwLpY+ap3CuuuV/Fx3TFLIUVtgPgQ08
w6SikG+54oZHnyre/YmTmLFN2Jlz1r9f4WeB6oEk645IaUXrQVsEXoPQ6Seynbq4
e/3CuEZf/5FYmQ7TtZ56WN6RxM9vC+5DAWVcYuXUskHHM7rN7g4uu9kT4XEqpmyo
Dtd4FZuXpX8GjiOqzqyauByQ+QxKEuEuxgKWNbySKMVe4v0+pE2M/VJB6ygTyqy9
IK8oSsY7yL/ydsYWlAm58swesaEYYg==
=af6O
-----END PGP SIGNATURE-----

--Sig_/NHprnNiS2jM/SsWHL+q63Cu--
