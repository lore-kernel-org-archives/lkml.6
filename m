Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D6F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hOuNiFht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbfBVFSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:18:21 -0500
Received: from ozlabs.org ([203.11.71.1]:34461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfBVFSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:18:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 445KP55lp1z9sB3;
        Fri, 22 Feb 2019 16:18:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550812698;
        bh=FDdgx9tbGbVqtG0sey29xJfSjXdGxRZzsBxQQ7G3bEg=;
        h=Date:From:To:Cc:Subject:From;
        b=hOuNiFhtx1NIpFFyCYoHTO5Tis+DMUQ3XcQfi8XdU1umqyNjX1rUqB3Te3+55ul9j
         H4CUlvUVvHEHl5yqpCx8u6MQvnOhRK5n053aTr6Au6FeWs6abPkfqEcMug2Zp8Y2jt
         z3fO3SCd7HqYo6RdXcvxMFdYv7yv1IU0VN+n7mjr38lGwQz/eTVTRelazCjm/OXNhO
         faIVWELAfyGh7BrFOD3K1Z/Css4cZ5H3YOwbLr7Z/onqOgDoDtAUxDsU+KKb9x8M6X
         sv1llFEFUiatL5BhKoCOw8nnY2Q6SewJAYO6xElbA96w/BdJzd0Gck5a3j4T3MTs3K
         yF9HMUFmbO5bQ==
Date:   Fri, 22 Feb 2019 16:18:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: linux-next: build failure after merge of the rpmsg tree
Message-ID: <20190222161817.32e35462@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JoWa1Oe7L4C9vpen.7AKQrX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JoWa1Oe7L4C9vpen.7AKQrX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

After merging the rpmsg tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/remoteproc/remoteproc_virtio.c: In function 'rproc_add_virtio_dev':
drivers/remoteproc/remoteproc_virtio.c:374:11: error: 'DMA_MEMORY_EXCLUSIVE=
' undeclared (first use in this function); did you mean 'WQ_FLAG_EXCLUSIVE'?
           DMA_MEMORY_EXCLUSIVE);
           ^~~~~~~~~~~~~~~~~~~~
           WQ_FLAG_EXCLUSIVE
drivers/remoteproc/remoteproc_virtio.c:374:11: note: each undeclared identi=
fier is reported only once for each function it appears in
drivers/remoteproc/remoteproc_virtio.c:371:10: error: too many arguments to=
 function 'dma_declare_coherent_memory'
    ret =3D dma_declare_coherent_memory(dev, pa,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/remoteproc/remoteproc_virtio.c:20:
include/linux/dma-mapping.h:748:5: note: declared here
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory=
 pool")

interacting with commit

  82c5de0ab8db ("dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag")

from the dma-mapping tree.

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 22 Feb 2019 16:14:45 +1100
Subject: [PATCH] remoteproc: fix for "dma-mapping: remove the DMA_MEMORY_EX=
CLUSIVE flag"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/remoteproc/remoteproc_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/re=
moteproc_virtio.c
index 337327d21c1c..44774de6f17b 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -370,8 +370,7 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int =
id)
 			/* Associate vdev buffer memory pool to vdev subdev */
 			ret =3D dma_declare_coherent_memory(dev, pa,
 							   mem->da,
-							   mem->len,
-							   DMA_MEMORY_EXCLUSIVE);
+							   mem->len);
 			if (ret < 0) {
 				dev_err(dev, "Failed to associate buffer\n");
 				goto out;
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/JoWa1Oe7L4C9vpen.7AKQrX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvhhkACgkQAVBC80lX
0Gzkwwf8DtD4mgKzuojN7KZyCx3TWRyJv/uXSmqMCKmF4IYqlcwmZpplRY1+ApWf
ARnY6gTaT2oGgV1iM3tWgAK79IEFbIvajU/4rUu6uUyE7kTpoVHd0BGaHs2XbN3B
JiRVVyFkLXadi9VnFDjMmlFlx7+8kMKrOMp8yDWg8p/3uEGw+s/H4hmKt3zMc56X
x8g2VaCIxTRz2VCEp4bmlOwdZWCTU2BlwxFRPAoPSDhzN0nimkVhMwOBUh4QUdm8
xPPObcmMvgHph130AYKKOL6vXq7rlkd9gj3JcNj2pG0pQzejOwWXHgzkf9F7Nk6S
XOHau6VcxDyKIjtA8KV4m9IzSoeiAg==
=8C/E
-----END PGP SIGNATURE-----

--Sig_/JoWa1Oe7L4C9vpen.7AKQrX--
