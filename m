Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A1C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B68320665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nxm0+71/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B68320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJ2Hbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:31:31 -0400
Received: from ozlabs.org ([203.11.71.1]:46931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeJ2Hbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:31:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jt9M2wnRz9sB5;
        Mon, 29 Oct 2018 09:45:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540766727;
        bh=HPdfj3FJbZpziMNE7pOz9a9iE4ZZkKVsUW/P+LqDfBM=;
        h=Date:From:To:Cc:Subject:From;
        b=nxm0+71/dzBqa4ZutE0nweFQyJs0tkTwqyTmSIvlt9CIQ0n1OGCczvm1MNvcF1m4u
         NRUqcQ0LZPHjEAiPeDJeGqi2ZG6BUxMUPhx7QapP8d/ARjXCTDEOfD6GPy9v2ACflC
         XRPs+7Nitf3Rn7Dd1L+sHZSrhe9GXueNNcd7A1sleO5NCLspuBNcHC1MbuozLIkUdm
         8sZZAzWoefHzvVoEor1hU9uz0I09/Ohpm3oEzKnEIHDe+aCBOKk4I2RJmwwf29HOP5
         fbLp9yxDtOYjl6TIf+bfjiiGD2Dh3JVVDKThg7IMvQSDzsSki3bGgUBopxAxQk1/6Y
         NHoihmNHSOLdw==
Date:   Mon, 29 Oct 2018 09:45:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: linux-next: build failure in Linus' tree
Message-ID: <20181029094526.02c61d71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s3JkVEgTIGhmUYj2X2r5jo/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s3JkVEgTIGhmUYj2X2r5jo/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

After merging the origin tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/net/ethernet/mellanox/mlx4/en_rx.c:582:18: warning: 'struct iphdr' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
           struct iphdr *iph)
                  ^~~~~
drivers/net/ethernet/mellanox/mlx4/en_rx.c: In function 'get_fixed_ipv4_csu=
m':
drivers/net/ethernet/mellanox/mlx4/en_rx.c:586:20: error: dereferencing poi=
nter to incomplete type 'struct iphdr'
  __u8 ipproto =3D iph->protocol;
                    ^~

Caused by commit

  55469bc6b577 ("drivers: net: remove <net/busy_poll.h> inclusion when not =
needed")

I added the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 29 Oct 2018 09:40:39 +1100
Subject: [PATCH] drivers: net: include linux/ip.h for iphdr

Fixes: 55469bc6b577 ("drivers: net: remove <net/busy_poll.h> inclusion when=
 not needed")
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ether=
net/mellanox/mlx4/en_rx.c
index 5a6d0919533d..ffa54767dfe5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -31,6 +31,7 @@
  *
  */
=20
+#include <linux/ip.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/mlx4/cq.h>
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/s3JkVEgTIGhmUYj2X2r5jo/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWPAYACgkQAVBC80lX
0Gx7DggAgis9Oe6Hpje8T6XlIMzfb+tBhH2+JuQBcRF+w0NQF0XikoPQpAvCHDLu
B2BwgeoNSjUlT3lvpgmtX4ANHvmSQPcHP8tkdC5NKTLTDWlbjMwNzpSD777MOFJw
4NVptC99xSdNK/zo99wKpkM0MeErY15aPFh8fFpxJEbWdnjU4oa4PQWqVI2/HeXn
kmSG26uFAEW+uRIv4eUaDi/2oSZ1aBrbpLPGjvfNpfIzHOD6v0NGCuOBuZCjoqIg
aM5lvO3K3LMR1v1zcVsbJ4vib8XHw3b7/Lr+ml/3+zh84PO/ocE23AIQzK//X0Xc
w++T4ghWUOM9yUMB1MX7yZ8GHkDbEA==
=SUKT
-----END PGP SIGNATURE-----

--Sig_/s3JkVEgTIGhmUYj2X2r5jo/--
