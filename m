Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C4CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DC12175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HlseNXcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfA2FRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:17:47 -0500
Received: from ozlabs.org ([203.11.71.1]:60865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfA2FRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:17:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pZWX0Sxpz9sDK;
        Tue, 29 Jan 2019 16:17:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548739064;
        bh=FPH4wv6wMY+KvUrKh9gt8UdG7QmMcqt610Q918tPsF0=;
        h=Date:From:To:Cc:Subject:From;
        b=HlseNXcDFCHeUR0jj+JD3JGOyIX9+1rWLXkvfbOWM6K2gm6fwVMh2qkDKtexzugsE
         QdDIGSQWZZcsbiIDO5i6GGCd85zb/7chjSPATFSg5vb4sfk3s46K3uDKucFVa/x0oo
         rsSzmqsqueDXI7Skb7sqOkNHo3b6pyNfefHii5+SgiFuFk3UdC0RYvgcO6XU+LYJk5
         1TDQqjQhz6JCETFJqu0z3vt+9FnJ+cqkGmllw/6TWXiI/vxPhbWG8biWHzdc4/fq47
         WGOxAewYDJ5q2Yc/R1V67f+rYW9KjURBs/ykZ9wNXh7zVylCCxCo7fcFa8Fgr6AzpM
         3/mW9BRTtZ8DQ==
Date:   Tue, 29 Jan 2019 16:17:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20190129161742.6b1b7338@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7Kh.mcqnnU1QXqo=E9drG_l"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7Kh.mcqnnU1QXqo=E9drG_l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/net/ethernet/freescale/enetc/enetc.c: In function 'enetc_alloc_txbd=
r':
drivers/net/ethernet/freescale/enetc/enetc.c:685:17: error: implicit declar=
ation of function 'vzalloc'; did you mean 'kzalloc'? [-Werror=3Dimplicit-fu=
nction-declaration]
  txr->tx_swbd =3D vzalloc(txr->bd_count * sizeof(struct enetc_tx_swbd));
                 ^~~~~~~
                 kzalloc
drivers/net/ethernet/freescale/enetc/enetc.c:685:15: warning: assignment to=
 'struct enetc_tx_swbd *' from 'int' makes pointer from integer without a c=
ast [-Wint-conversion]
  txr->tx_swbd =3D vzalloc(txr->bd_count * sizeof(struct enetc_tx_swbd));
               ^
drivers/net/ethernet/freescale/enetc/enetc.c:691:3: error: implicit declara=
tion of function 'vfree'; did you mean 'kfree'? [-Werror=3Dimplicit-functio=
n-declaration]
   vfree(txr->tx_swbd);
   ^~~~~
   kfree
drivers/net/ethernet/freescale/enetc/enetc.c: In function 'enetc_alloc_rxbd=
r':
drivers/net/ethernet/freescale/enetc/enetc.c:749:15: warning: assignment to=
 'struct enetc_rx_swbd *' from 'int' makes pointer from integer without a c=
ast [-Wint-conversion]
  rxr->rx_swbd =3D vzalloc(rxr->bd_count * sizeof(struct enetc_rx_swbd));
               ^

Caused by commit

  d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")

I have added the following fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Jan 2019 16:13:08 +1100
Subject: [PATCH] enetc: include linux/vmalloc.h for vzalloc etc

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drive=
rs")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/eth=
ernet/freescale/enetc/enetc.c
index 37b587c541ee..5bb9eb35d76d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -5,6 +5,7 @@
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <linux/of_mdio.h>
+#include <linux/vmalloc.h>
=20
 /* ENETC overhead: optional extension BD + 1 BD gap */
 #define ENETC_TXBDS_NEEDED(val)	((val) + 2)
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/7Kh.mcqnnU1QXqo=E9drG_l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxP4fYACgkQAVBC80lX
0GxDEAf+NFmYzu1g8eLByZEyiJurOZroXbfuOcn8cfI6i7zpeHWAJTHVKWSjcXlp
H/N/7jpgHba1UwHiD7yqw4YC3z2xzO3rEtJOFDlpiq0+usVceozKNkmvAyWuTGww
Es7JoU04+2cq+s9UdJzZujBSAXq3TKuDjEnQZkwmETlCcGdWoOX4C9zo7jciC/fE
471DKDOPRXsoEcH5kfR5Tdndcg/i4ZwMOkpikuq2/a0z/jKzkKrP994/unP59NTJ
rLCAdzuOnK4LpEVtW6NNG7Rf3SHN/lUZAenBc7q7Ep051QZ8861HGk4Y6nj7XpKc
yRYc8kwaQcRDCjFrEBzU8UyOfuht2A==
=ycni
-----END PGP SIGNATURE-----

--Sig_/7Kh.mcqnnU1QXqo=E9drG_l--
