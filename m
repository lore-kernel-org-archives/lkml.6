Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1B2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C52075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="doQUnijb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09C52075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeGRHa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:30:29 -0400
Received: from ozlabs.org ([203.11.71.1]:50599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbeGRHa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:30:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Vntk54RCz9s3R;
        Wed, 18 Jul 2018 16:54:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531896846;
        bh=siapxFyWZ315mbR97mIxBsou0ozZvgFxdUw3/8hyItU=;
        h=Date:From:To:Cc:Subject:From;
        b=doQUnijb39kWP2t3HjOR977N76FITl5mDmTvyugEJEalAlvHZ/+U5ZCLa2bHRAQWU
         MEnfgLfokMQjk2C8ZpucRgf6XiPO/wHmxRyekkhYMCsg9B2Azs2aCYZSa82o7KL8jA
         hE8hqQzpCdajuZvFqbtcOE8SYLbfPGUa+PLxz1WCyWliLnOh+ogUPt7EDAlAl4Mr/u
         Brl83jUNuPsWqI8/jnXYx7ETjx8vk/fcrCxENRSvgNKeBOrHR9MLJRo2nvgiPfD7tZ
         mUbrgxLkeXUnslbbN+aWvIJ4cvPT1OSnWMdEbs9uq8KB624qtpMrN/5OIW6CXOd5kb
         F9gDbgCQaHHKQ==
Date:   Wed, 18 Jul 2018 16:54:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Varsha Rao <rvarsha016@gmail.com>
Subject: linux-next: build failure after merge of the ida tree
Message-ID: <20180718165406.6f262266@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g/JeRb=JJkWClj_fS6cOuos"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g/JeRb=JJkWClj_fS6cOuos
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

After merging the ida tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

net/netfilter/nf_tables_api.c: In function 'nf_tables_set_alloc_name':
net/netfilter/nf_tables_api.c:3014:8: error: implicit declaration of functi=
on 'ida_get_new_above'; did you mean 'idr_get_next_ul'? [-Werror=3Dimplicit=
-function-declaration]
    n =3D ida_get_new_above(&inuse, tmp, &id);
        ^~~~~~~~~~~~~~~~~
        idr_get_next_ul

Caused by commit

  3f2668c1e101 ("ida: Remove old API")

interacting with commit

  9679150a0bd5 ("netfilter: nf_tables: Use id allocation")

from the netfilter-next tree.

I took a guess and applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 18 Jul 2018 16:42:26 +1000
Subject: [PATCH] ida: merge fix for ida_get_new_above() removal

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/netfilter/nf_tables_api.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b7b5fbcda8dd..151b89174979 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2995,7 +2995,7 @@ static int nf_tables_set_alloc_name(struct nft_ctx *c=
tx, struct nft_set *set,
 {
 	const struct nft_set *i;
 	const char *p;
-	unsigned int n =3D 0, id =3D 0;
+	int id =3D 0;
 	DEFINE_IDA(inuse);
=20
 	p =3D strchr(name, '%');
@@ -3011,22 +3011,22 @@ static int nf_tables_set_alloc_name(struct nft_ctx =
*ctx, struct nft_set *set,
 			if (!sscanf(i->name, name, &tmp))
 				continue;
=20
-			n =3D ida_get_new_above(&inuse, tmp, &id);
-			if (n < 0) {
-				if (n =3D=3D -EAGAIN)
+			id =3D ida_alloc_min(&inuse, tmp, GFP_KERNEL);
+			if (id < 0) {
+				if (id =3D=3D -EAGAIN)
 					return -ENOMEM;
=20
-				return n;
+				return id;
 			}
 		}
=20
-		n =3D ida_get_new_above(&inuse, 0, &id);
+		id =3D ida_alloc(&inuse, GFP_KERNEL);
 		ida_destroy(&inuse);
=20
-		if (n < 0) {
-			if (n =3D=3D -EAGAIN)
+		if (id < 0) {
+			if (id =3D=3D -EAGAIN)
 				return -ENOMEM;
-			return n;
+			return id;
 		}
=20
 	}

--=20
Cheers,
Stephen Rothwell

--Sig_/g/JeRb=JJkWClj_fS6cOuos
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltO5A4ACgkQAVBC80lX
0GxYLwgAi8GHzgBSZNAP+pjRXGhrfF977sexbevOQDEYzzo4QEcHHf8X6q3oO57K
VGdBTB8fYLTb2Mn5MW++a6++NLKPUFl9YORxTBwmUvtioIjkZybUvgGpzPgaG+xC
QTG7tL5wtQoMZOwO8OgLhhxxAGNDR8jyZa+kvPPDAHRhYCKRir8HGh7hse/ZCUdv
DiIysMlgIawjcNCJw4jkvD1XD21vO+IXQElz3ofy+87owKO2T9kAZcSy+3bjY4Qv
yTg5Uj/nlOMZBgjPKPIZg+XbdxUIP6vImK4O8+UFk9pfarrPXKQTOGMapIn0tWIl
IcFbu8wvblmap9UQtL+iKAEMPt2ZTg==
=DMq5
-----END PGP SIGNATURE-----

--Sig_/g/JeRb=JJkWClj_fS6cOuos--
