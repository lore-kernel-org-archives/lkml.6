Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A71C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA7A20672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s/mQNPYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA7A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeLEFPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:15:01 -0500
Received: from ozlabs.org ([203.11.71.1]:35093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbeLEFPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:15:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 438n3j1mcZz9s7W;
        Wed,  5 Dec 2018 16:14:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543986897;
        bh=akqao4mi5gEhxJ5tv6cSID9UwuSgw1NqMnZeA92sbaw=;
        h=Date:From:To:Cc:Subject:From;
        b=s/mQNPYOiK1IaXlxiAbywJP4YogGhYJKIp/ZQbn95QQ4b3ekqTVP65wAdizwNl+ks
         DVqxA1t62L3bqmMRS5JzjlwsTkh4AzIuxUrQIXsiwRPJsAGFWZ2USeUqoJd9SXTz9e
         oOSgQu1Lhh+2KgahQG2sogenQ5CEjtD34xmipy0QMijfDQU7Nec+OFGGg+8Di/lu9R
         jcyu1SrHF5koQBQu9eggGj4IVQ42/pxfdWdTKaazvn/XlMaqi061ujMxrP/QM55ZpV
         +vaiJIsHpuHgiXszGuBJ1xNUiuzOoq8ot9JzBg3MNBda3gHorgf6iJcMpozzzFmdTc
         5VzUex0H0X8Nw==
Date:   Wed, 5 Dec 2018 16:14:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20181205161456.4c618021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/doMXrjp=Qr9qoVF6H1H_LKx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/doMXrjp=Qr9qoVF6H1H_LKx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arm-linux-gnueabi-ld: kernel/sysctl.o: in function `.LANCHOR0':
sysctl.c:(.data+0x7b4): undefined reference to `fragment_stall_order_sysctl=
_handler'

Caused by commit

  a247ff3201c1 ("mm: stall movable allocations until kswapd progresses duri=
ng serious external fragmentation event")

The fragment_stall_order_sysctl_handler() definition is protected by
CONFIG_NUMA, so I added this fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 5 Dec 2018 16:05:51 +1100
Subject: [PATCH] mm: fix for "stall movable allocations until kswapd
 progresses during serious external fragmentation event"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2f445c82fe38..93352cfb3239 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1487,6 +1487,7 @@ static struct ctl_table vm_table[] =3D {
 		.extra1		=3D &one,
 		.extra2		=3D &one_thousand,
 	},
+#ifdef CONFIG_NUMA
 	{
 		.procname	=3D "fragment_stall_order",
 		.data		=3D &fragment_stall_order,
@@ -1496,6 +1497,7 @@ static struct ctl_table vm_table[] =3D {
 		.extra1		=3D &zero,
 		.extra2		=3D &max_order,
 	},
+#endif
 	{
 		.procname	=3D "percpu_pagelist_fraction",
 		.data		=3D &percpu_pagelist_fraction,
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/doMXrjp=Qr9qoVF6H1H_LKx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwHXtAACgkQAVBC80lX
0GxgYAf/SsV09yhOh0VoHt8RGp6TBmhrrVUeIXMY2bMfXlD3/Sz/xTF1Qht9gHZv
mQp/TtX6iFlgv+ycIYeC+B1M4NJQpswO/UK7jRzxYmSN3EXtCyEFiTY4EdS+o5up
+MLPpB/tAS+fT7hW74l5jTw7wsAqmw9bT+GWi7YEBTEIzXG3V6JAIq8NsPNa4NlJ
EPi69Kbs9WFQyN1EC117XSE6geKNgplweND0WWJL5FXaxkxjvl4u3Gax4brOZ+Xd
eW9Y4ADsZXiasDC+cP+mN1R8R+p8vbUuBNM+v03QzP1DG2r2b6wcSHb3DRgO+f3e
do5T6K803sgq5ZFcsODf8FnMxYmZwQ==
=4NCk
-----END PGP SIGNATURE-----

--Sig_/doMXrjp=Qr9qoVF6H1H_LKx--
