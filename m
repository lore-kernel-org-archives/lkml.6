Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C98C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C7520892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="geQobWWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C7520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeG3Gpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:45:32 -0400
Received: from ozlabs.org ([203.11.71.1]:49707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbeG3Gpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:45:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41f73f1k8Xz9rvt;
        Mon, 30 Jul 2018 15:12:14 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532927539;
        bh=hdGy2g0+LOIMrlHmLMmch8ZNMX8s9gcOw+aAMas49BU=;
        h=Date:From:To:Cc:Subject:From;
        b=geQobWWo4lxG9Ic3I5oiKhvsOxtHSlLFLT3Qs/DVOz4Lh/a3ZXheoy4mOZOc+CROO
         v5jTpHLhylRH/rl/LZPQ5vHwUf/FNdsW1idPev93xBBi0AOkuBdRYaxGtjf5Y9hgQj
         7H2RPIRUbBHvCenffVmneErpdMoTnTdie3cF6GQaJBksxhtrOAoMYWFbx2uEK0bWD8
         40lrRUVRreAWkyddyZe/xiqr/QAfMQBEBSZZCyuuzQqahY7jnnWFTtHJp7/eIb+PhX
         zB/LzUZzG7/Ce3WzGKVs1ALQnFmI7+erYKhqpTJqEEwP5MhnsAgheef5ttk+3sPmml
         b66EZ5ApA8Qhg==
Date:   Mon, 30 Jul 2018 15:12:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: linux-next: build failure after merge of the xen-tip tree
Message-ID: <20180730151213.4b1e1af4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/73HHtKXX1qw=vgpi/4uaEGA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/73HHtKXX1qw=vgpi/4uaEGA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the xen-tip tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/xen/gntdev-dmabuf.c:360:12: error: initialization from incompatible=
 pointer type [-Werror=3Dincompatible-pointer-types]
  .attach =3D dmabuf_exp_ops_attach,
            ^~~~~~~~~~~~~~~~~~~~~

Caused by commit

  a240d6e42e28 ("xen/gntdev: Implement dma-buf export functionality")

interacting with commit

  a19741e5e5a9 ("dma_buf: remove device parameter from attach callback v2")

from the drm tree.

I have added the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Jul 2018 15:08:21 +1000
Subject: [PATCH] xen/gntdev: fix up for attach callback API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/xen/gntdev-dmabuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index faaa4d3970ea..744cfe9b0311 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -217,7 +217,6 @@ dmabuf_pages_to_sgt(struct page **pages, unsigned int n=
r_pages)
 }
=20
 static int dmabuf_exp_ops_attach(struct dma_buf *dma_buf,
-				 struct device *target_dev,
 				 struct dma_buf_attachment *attach)
 {
 	struct gntdev_dmabuf_attachment *gntdev_dmabuf_attach;
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/73HHtKXX1qw=vgpi/4uaEGA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlteni0ACgkQAVBC80lX
0GwDxwgAk1uyJwmu37U9AWLxDpWymcewjFApvhkWp/9YTADWVlUtm/4WnXziEUYN
g5455MQIMNr9WGJSzWlONVZPvDHZq/xq04DSGzwNA+FwQo4r87oaW6agVlUQfVt6
oAWjU9OPkRViphl2BWVdRNZjEGf8OdShCUKXdm8A5YkxOg0FB7ibEWc+VKwJmy5j
CCEOyth8nd41mnTMEGJoVbcR86xg58Th3wEWaj2QBPsxhlG9LiheYvJhZd3BH5SL
XgiTBwl5p8iirAYF+yIY/SahQQcY/ptuF25VbL6sEfudIIKLG5yiP/jZ3lu5C8rR
4KKLGfFAvJzrYAMektpcS22I5qcsBw==
=HLLG
-----END PGP SIGNATURE-----

--Sig_/73HHtKXX1qw=vgpi/4uaEGA--
