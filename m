Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7056EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366062086C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qzFOwkBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeLTC22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:28:28 -0500
Received: from ozlabs.org ([203.11.71.1]:37199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbeLTC21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:28:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Kwfd1drGz9s3q;
        Thu, 20 Dec 2018 13:28:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545272905;
        bh=LV9d4xC0PxZk+oBlviKrRToDVGerSaAFwSiz1adR4F0=;
        h=Date:From:To:Cc:Subject:From;
        b=qzFOwkBV2KgZPDdu0ghh6xbT0eYN0yVInMY8DSufMfPxl85YXz3SMQWxwqsORPiMB
         l0HoxG9r1dRDoWSuVpKMrjVKemanJKxPZyZ7/Tjzj7i1HBOoyQ1hYafxP/p6Pq74Yk
         DAb/skc6geiMpw4JnwLMW9461X4B94aK19yjw5fYpHPU4Wz709QyczgeEy4ve2wUPk
         ZN3VmMGcWsWqO8mSV2e1TL632L+zeWx9uUj2rEn85xemt3stun7m27hPCkqOF/bRTJ
         Hx49LPGlDgomc2weK/5k6Hz9t3FFcDdYBEW2kFygGe97RN5+q5u6S7moZauJFrqNj6
         ErmPY9gErge0A==
Date:   Thu, 20 Dec 2018 13:28:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Machata <petrm@mellanox.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20181220132824.341c10e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cwsMIF4xqo86oD7MLEsVxTl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cwsMIF4xqo86oD7MLEsVxTl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/net/vxlan.c: In function 'vxlan_changelink':
drivers/net/vxlan.c:3763:10: error: too few arguments to function 'vxlan_fd=
b_update'
    err =3D vxlan_fdb_update(vxlan, all_zeros_mac,
          ^~~~~~~~~~~~~~~~
drivers/net/vxlan.c:830:12: note: declared here
 static int vxlan_fdb_update(struct vxlan_dev *vxlan,
            ^~~~~~~~~~~~~~~~

Caused by commit

  ce5e098f7a10 ("vxlan: changelink: Fix handling of default remotes")

from the net tree interacting with commit

  0e6160f3f5a9 ("vxlan: vxlan_fdb_notify(): Make switchdev notification con=
figurable")

from the net-next tree.

I added the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 20 Dec 2018 13:24:05 +1100
Subject: [PATCH] vxlan: fix for vxlan_fdb_update() API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/vxlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index efd709a5e3a8..5209ee9aac47 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3768,7 +3768,7 @@ static int vxlan_changelink(struct net_device *dev, s=
truct nlattr *tb[],
 					       dst->remote_vni,
 					       dst->remote_vni,
 					       dst->remote_ifindex,
-					       NTF_SELF);
+					       NTF_SELF, true);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
 				return err;
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/cwsMIF4xqo86oD7MLEsVxTl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwa/kgACgkQAVBC80lX
0GwBOwf/Tgik72mNw76kDMNQdtdYVqGCQ9bBVGXIQAvsoqkQcr0TfwmTJNPzLISx
5P2O9wT0N9ruOTW1atmEZQEU1RYRPHaZdBB7wKUvq94ovRc3DxfjPR2+9KOi9voK
ZVkiVkNUjTvTOf03IbhRqYiIsPHClPh9SUVvQT7/97fLsQci6YhM7Ahxtix1ueQU
07wDj1ROEQrKgmFyfeS7jrndCa/xOWp1bszbbFxzEoDYVxa/8duijTSywmIOeVv9
HXVrnYRId2R02JMa5SY2i1mBS1yz6TzJGXlMaUWThB0UcNQloy5CBM3mDh7s2f5o
Oh5nDZ6eNMDVZ+aZD3jhiY6zEZzCmA==
=NjDq
-----END PGP SIGNATURE-----

--Sig_/cwsMIF4xqo86oD7MLEsVxTl--
