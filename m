Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B67217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iMxQk1nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfBLFUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:20:09 -0500
Received: from ozlabs.org ([203.11.71.1]:41399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfBLFUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:20:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43z9vm11yNz9s3x;
        Tue, 12 Feb 2019 16:20:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549948804;
        bh=PXcPRKwX2FxTek5U65nhmrJsk37fDAIoXelA/qoSBgo=;
        h=Date:From:To:Cc:Subject:From;
        b=iMxQk1nx5x/ffgWFuXaijoYdQr+mKmB2Sp/UVe4B0zRj3ScEnfMmylX1w4v8xSd6z
         gd4VM9kEzS3D1xnbJr1uJEg0jzSxhH7wx02iXEvb0avUYpcAfp1inJtxyH59aqDN9r
         A4jW1XP6Gj38zCY53DnUpy+b80X7HjdOy86A9MiK+djQet2sZskinug0q2nRvTOfyX
         PIEK258tq5LEs7j2RCveAoavj5FYHQ840OmKE0LIeWRvTw0QsnM+NxRA70uB3PHXoj
         akAaFIUIIDxI7Dlyf9/MWHJu7MAKErD8m1IwjBotCI/4f4ZPja2HkVARTkZY7d3ycP
         QFh+WVpz6hxcQ==
Date:   Tue, 12 Feb 2019 16:20:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the xarray tree
Message-ID: <20190212162003.1aa1ffbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zp94lxzFZ8Wtk+cbgvBz+cv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zp94lxzFZ8Wtk+cbgvBz+cv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the xarray tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/list.h:9,
                 from include/linux/module.h:9,
                 from drivers/infiniband/core/device.c:34:
drivers/infiniband/core/device.c: In function 'assign_name':
include/linux/kernel.h:22:18: warning: passing argument 3 of 'xa_alloc' mak=
es pointer from integer without a cast [-Wint-conversion]
 #define INT_MAX  ((int)(~0U>>1))
                  ^~~~~~~~~~~~~~~
drivers/infiniband/core/device.c:591:43: note: in expansion of macro 'INT_M=
AX'
  ret =3D xa_alloc(&devices, &device->index, INT_MAX, device, GFP_KERNEL);
                                           ^~~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/module.h:17,
                 from drivers/infiniband/core/device.c:34:
include/linux/xarray.h:796:9: note: expected 'void *' but argument is of ty=
pe 'int'
   void *entry, struct xa_limit limit, gfp_t gfp)
   ~~~~~~^~~~~
drivers/infiniband/core/device.c:591:52: error: incompatible type for argum=
ent 4 of 'xa_alloc'
  ret =3D xa_alloc(&devices, &device->index, INT_MAX, device, GFP_KERNEL);
                                                    ^~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/module.h:17,
                 from drivers/infiniband/core/device.c:34:
include/linux/xarray.h:796:32: note: expected 'struct xa_limit' but argumen=
t is of type 'struct ib_device *'
   void *entry, struct xa_limit limit, gfp_t gfp)
                ~~~~~~~~~~~~~~~~^~~~~
In file included from include/linux/list.h:9,
                 from include/linux/module.h:9,
                 from drivers/infiniband/core/device.c:34:
include/linux/kernel.h:22:18: warning: passing argument 3 of 'xa_alloc' mak=
es pointer from integer without a cast [-Wint-conversion]
 #define INT_MAX  ((int)(~0U>>1))
                  ^~~~~~~~~~~~~~~
drivers/infiniband/core/device.c:594:44: note: in expansion of macro 'INT_M=
AX'
   ret =3D xa_alloc(&devices, &device->index, INT_MAX, device,
                                            ^~~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/module.h:17,
                 from drivers/infiniband/core/device.c:34:
include/linux/xarray.h:796:9: note: expected 'void *' but argument is of ty=
pe 'int'
   void *entry, struct xa_limit limit, gfp_t gfp)
   ~~~~~~^~~~~
drivers/infiniband/core/device.c:594:53: error: incompatible type for argum=
ent 4 of 'xa_alloc'
   ret =3D xa_alloc(&devices, &device->index, INT_MAX, device,
                                                     ^~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/module.h:17,
                 from drivers/infiniband/core/device.c:34:
include/linux/xarray.h:796:32: note: expected 'struct xa_limit' but argumen=
t is of type 'struct ib_device *'
   void *entry, struct xa_limit limit, gfp_t gfp)
                ~~~~~~~~~~~~~~~~^~~~~
In file included from include/linux/list.h:9,
                 from include/linux/module.h:9,
                 from drivers/infiniband/core/device.c:34:
drivers/infiniband/core/device.c: In function 'assign_client_id':
include/linux/kernel.h:22:18: warning: passing argument 3 of 'xa_alloc' mak=
es pointer from integer without a cast [-Wint-conversion]
 #define INT_MAX  ((int)(~0U>>1))
                  ^~~~~~~~~~~~~~~
drivers/infiniband/core/device.c:826:47: note: in expansion of macro 'INT_M=
AX'
  ret =3D xa_alloc(&clients, &client->client_id, INT_MAX, client,
                                               ^~~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/module.h:17,
                 from drivers/infiniband/core/device.c:34:
include/linux/xarray.h:796:9: note: expected 'void *' but argument is of ty=
pe 'int'
   void *entry, struct xa_limit limit, gfp_t gfp)
   ~~~~~~^~~~~
drivers/infiniband/core/device.c:826:56: error: incompatible type for argum=
ent 4 of 'xa_alloc'
  ret =3D xa_alloc(&clients, &client->client_id, INT_MAX, client,
                                                        ^~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/module.h:17,
                 from drivers/infiniband/core/device.c:34:
include/linux/xarray.h:796:32: note: expected 'struct xa_limit' but argumen=
t is of type 'struct ib_client *'
   void *entry, struct xa_limit limit, gfp_t gfp)
                ~~~~~~~~~~~~~~~~^~~~~

Caused by commit

  a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")

interacting with commits

  e59178d895af ("RDMA/devices: Use xarray to store the clients")
  0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")

from the rdma tree.

Its a bit of a pain modifying a published API like this :-(

I have added the following merge fixup patch for today (I assume some
of the assignments are also now redundant).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 12 Feb 2019 16:09:58 +1100
Subject: [PATCH] RDMA/devices: fix up for xa_alloc API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/infiniband/core/device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 3325be4f91a5..283ecc2aee89 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -588,11 +588,12 @@ static int assign_name(struct ib_device *device, cons=
t char *name)
=20
 	/* Cyclically allocate a user visible ID for the device */
 	device->index =3D last_id;
-	ret =3D xa_alloc(&devices, &device->index, INT_MAX, device, GFP_KERNEL);
+	ret =3D xa_alloc(&devices, &device->index, device,
+		       XA_LIMIT(last_id, INT_MAX), GFP_KERNEL);
 	if (ret =3D=3D -ENOSPC) {
 		device->index =3D 0;
-		ret =3D xa_alloc(&devices, &device->index, INT_MAX, device,
-			       GFP_KERNEL);
+		ret =3D xa_alloc(&devices, &device->index, device,
+			       XA_LIMIT(0, INT_MAX), GFP_KERNEL);
 	}
 	if (ret)
 		goto out;
@@ -823,8 +824,8 @@ static int assign_client_id(struct ib_client *client)
 		client->client_id =3D
 			list_last_entry(&client_list, struct ib_client, list)
 				->client_id;
-	ret =3D xa_alloc(&clients, &client->client_id, INT_MAX, client,
-		       GFP_KERNEL);
+	ret =3D xa_alloc(&clients, &client->client_id, client,
+		       XA_LIMIT(client->client_id, INT_MAX), GFP_KERNEL);
 	if (ret)
 		goto out;
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/zp94lxzFZ8Wtk+cbgvBz+cv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxiV4MACgkQAVBC80lX
0Gy/fQf/R8zSv4ADGK5tjOwla8mCRTPX9jLAuOoym0LcigxKAbGRYgMtRvPLhS2N
Opla/Q3fs1UeiGeO4CskTKDRvCzAQiVrDEAfyOUyBmN/jykspcRMOpmenl2rNzVG
1gYV6HVL3VqkQgHVYvmuR0wxlsVYKWE8siTL1kibdw+WYj/RYbQLfm1hgGu7CkzN
P3FlsbXkzsWb1Yw1ccsze1lBLrgMqlvCCVZ9462ROWVHwQMn7+hKs8UqUGtmW5Ou
pzklJE1CvnG9l9Mdgmq5b0RmdP/BekKck6grBMDCqb8ot8UOfi+RFJ6v53JOQZed
Gs7m88whOKDxdsN/R4gFZtyPGBMtAA==
=yFml
-----END PGP SIGNATURE-----

--Sig_/zp94lxzFZ8Wtk+cbgvBz+cv--
