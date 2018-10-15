Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88599C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1832145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L3u2ynmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1832145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeJOPGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:06:40 -0400
Received: from ozlabs.org ([203.11.71.1]:41097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeJOPGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:06:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YVJX2hDbz9s1x;
        Mon, 15 Oct 2018 18:22:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539588156;
        bh=CVMQPH/Zbj1hFK4iDgaTn5dVaahm54TiBz4tjkUrPxk=;
        h=Date:From:To:Cc:Subject:From;
        b=L3u2ynmIoLqFMhy7jzQ1Rmsy/TMd6N+76pOTSBRBCd0FTXtU1lhbB++P4Kb6L0sUy
         ic5xNBQlEcEwPkfEG8QI45UqcyCvH4rPRVDbGd2/9F15LKrouJC+VL5fkxKMrmRSb1
         wjMJH5cXmOtNprXzcoRhM5W/8Mn3sHOU3Lvxq2NK4VUN808E2FNykIdj5RmKRh0cUo
         qNmZjXlGidTdOfnlcMFrRalLeiyEZmwd+p0i4UT75p9Q1qpMSlHDPDUnWnqttcy8sW
         jiTnMum/3CX5Wsj1uORv0EsLkYc4UYBr4pp6y380iuZm5ztItWuYgLrD3054k62yyp
         FH818h9Zb002Q==
Date:   Mon, 15 Oct 2018 18:22:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm tree with Linus' tree
Message-ID: <20181015182234.66638c37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bxVPt/rE9KO+6_+BubvaSW3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bxVPt/rE9KO+6_+BubvaSW3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/arm64/kernel/setup.c

between commit:

  d91680e687f4 ("arm64: Fix /proc/iomem for reserved but not memory regions=
")

from Linus' tree and patch:

  "memblock: stop using implicit alignment to SMP_CACHE_BYTES"

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/setup.c
index 811e3267412a,9084fec753f5..000000000000
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@@ -215,12 -211,8 +215,13 @@@ static void __init request_standard_res
  	kernel_data.start   =3D __pa_symbol(_sdata);
  	kernel_data.end     =3D __pa_symbol(_end - 1);
 =20
 +	num_standard_resources =3D memblock.memory.cnt;
 +	standard_resources =3D memblock_alloc_low(num_standard_resources *
- 						sizeof(*standard_resources), 0);
++						sizeof(*standard_resources),
++						SMP_CACHE_BYTES);
 +
  	for_each_memblock(memory, region) {
 -		res =3D memblock_alloc_low(sizeof(*res), SMP_CACHE_BYTES);
 +		res =3D &standard_resources[i++];
  		if (memblock_is_nomap(region)) {
  			res->name  =3D "reserved";
  			res->flags =3D IORESOURCE_MEM;

--Sig_/bxVPt/rE9KO+6_+BubvaSW3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvEQDoACgkQAVBC80lX
0GybwQf/cQBug8TGVqSUlnmyPiqUMn1xfexhce2JLNkXcSMg8dsBW+0pvwRK6Cy6
Yry50ezirLh8ytG0VYryLF+kLkaHzirH6UGCNAZvFfXaI2VIxqu9IbVwBXonWIzU
DMkFpMagmLFNMWI9+VMfEdVjd/FeUwcwEfNZGwNtIT/k5e313Gg/bIR4SAojNjsA
+67I5RUd7D+3m0iDAxTZ0BsIeW7wkEFeZiuwV410rFbFvDLuSJ2vauf24KOPurf7
WWg6XHb/iE40vTii90paIy2dmRS1YWxWilzbzF2ww7uCCS55/LBc1NaHhtc+/kw9
hYQNplWWjOOEN8ABx/i56T1F4yGB5w==
=Lj2L
-----END PGP SIGNATURE-----

--Sig_/bxVPt/rE9KO+6_+BubvaSW3--
