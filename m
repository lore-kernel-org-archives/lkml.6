Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776ABC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A0620853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rMq9o3HE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A0620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJOOs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:48:56 -0400
Received: from ozlabs.org ([203.11.71.1]:37075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeJOOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:48:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YTw660xsz9sCw;
        Mon, 15 Oct 2018 18:04:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539587095;
        bh=QtK7IDnptwHrMAlCyw+S20+oefX5FIbchigU8Mr4YRI=;
        h=Date:From:To:Cc:Subject:From;
        b=rMq9o3HEI3w0SeNQJF/7wZZxfIjqdH0gKKBzY/LRPCIWk7SAnImWCZdnPHkRa4n3r
         DShjYzTAMmL02XU3fSEJ6iRNWg4e0Yr2kF0bZCNaUAcbIBPdKeZx+CciSaPHBS6YUS
         lROZTOUWj7mm6YPVnNIGxq4gadbUXM/zk+yQDuDHIIoGVTMphhwyrONxhqpYWN9SQ5
         +OOqmfKmFoPtZKL2xUUBRacrwdHz4yu+HIxdHyaDI0+gX/tgZhUR4XCBWVJ0V3bQzI
         3jTbc2ndpKBz9Mkn21UBkjzddG82e0wZ5SLU3bYQfMqVwD7iwFx0YtHjOMg6JlQ62m
         UshCOq+IynjaQ==
Date:   Mon, 15 Oct 2018 18:04:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm tree with Linus' tree
Message-ID: <20181015180437.6d06093c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KzZK94x7vinDrGnT1Sd+l_N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KzZK94x7vinDrGnT1Sd+l_N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/arm64/kernel/setup.c

between commit:

  d91680e687f4 ("arm64: Fix /proc/iomem for reserved but not memory regions=
")

from Linus' tree and patch:

  "memblock: replace alloc_bootmem_low with memblock_alloc_low (2)"

from the akpm tree.

I fixed it up (the new patch hunk for this file is below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index d0f62dd24c90..c8ba593cc3ac 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -217,8 +217,8 @@ static void __init request_standard_resources(void)
 	kernel_data.end     =3D __pa_symbol(_end - 1);
=20
 	num_standard_resources =3D memblock.memory.cnt;
-	standard_resources =3D alloc_bootmem_low(num_standard_resources *
-					       sizeof(*standard_resources));
+	standard_resources =3D memblock_alloc_low(num_standard_resources *
+						sizeof(*standard_resources), 0);
=20
 	for_each_memblock(memory, region) {
 		res =3D &standard_resources[i++];

--Sig_/KzZK94x7vinDrGnT1Sd+l_N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvEPAUACgkQAVBC80lX
0GxCsAf/WM9qbi0CPLZQx2iVHFlhVD39DIRrMoSCKX+/axVhmlFowNhmRdy+f2Sm
Mjo8M6kH3JX1LfiF6zai59NTfqRUh5RsQRFwKuyWhDZG/WJgeRa2QZprToslffBO
k2fO0zba+FN5lSWkk7RFCCus7qZdgyMx4DWucgNLfu/43nwKM1cH/Q2aRVeKcSjy
z6OUAi0l1ZPtTW4NVvg7D4baYpkohCLLoPsYcY3Ro7cBuhcLC6rhFieRCabCJLry
ArB5ayk1Bs8ktQDAzK6cOMS9Cl3TKv22ZT4wtQgJmYzPl8C6FELLnMp/4u6Rkaas
AHSGKQwi1+h3N0yOtpPxzlIPBAjjjw==
=vnxe
-----END PGP SIGNATURE-----

--Sig_/KzZK94x7vinDrGnT1Sd+l_N--
