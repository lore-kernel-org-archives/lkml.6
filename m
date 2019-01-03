Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68BF20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fTPJ81hE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfACBjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:39:43 -0500
Received: from ozlabs.org ([203.11.71.1]:47433 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfACBjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:39:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43VVvt1T7Bz9s55;
        Thu,  3 Jan 2019 12:39:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546479579;
        bh=ekc/WB7o4RKRNfbxR/1ZteF1xXfrwKZOWdbkS+dJfls=;
        h=Date:From:To:Cc:Subject:From;
        b=fTPJ81hEammlFXKlK3I8JK7z8qE/pGajBySisKLgRJ7YSneeKUN7mZzp4hKFx01Uk
         F2lPppFxLBiunfJ0NpjaitoiZuJDVWqbbY8VQyykBr6D/p80PTjq64jp33aa3EQppt
         7y0OR4nCBCGWbQJvOvn7kCzkEzN9b+kKXTyEQQ6D0T4ak0mtMRsnRVunEun7gLcjkk
         q6D/5aX1I2JrDH9VJa8R1iFQZ1ct2yzm+BWCVgVjwpB1sJK09h9ih+ZnGXA8W7iQuC
         ZynlPtSfQeft463aqIuMUmWcz62tuDHwtcuZtRPwOZmWaf5ZqvdYjji1bgDOoblo/U
         07dOGa0kB6SEw==
Date:   Thu, 3 Jan 2019 12:39:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tiwei Bie <tiwei.bie@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: linux-next: manual merge of the vhost tree with Linus' tree
Message-ID: <20190103123937.086f3f2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c1fo5Pc/xT6f1LO7bjciH/H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c1fo5Pc/xT6f1LO7bjciH/H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/virtio/virtio_ring.c

between commit:

  138fd2514863 ("virtio_ring: add _split suffix for split ring functions")
and various other commits

from Linus' tree and commit:

  7f86a211fabe ("virtio: use dependent_ptr_mb")

from the vhost tree.

I fixed it up (I think, basically I added the changes form the latter
to the _split and _packed versions of the function - see below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755484e3..982e1ed4ecdf 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -676,6 +676,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtque=
ue *_vq,
 	void *ret;
 	unsigned int i;
 	u16 last_used;
+	bool more;
=20
 	START_USE(vq);
=20
@@ -684,14 +685,15 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
 		return NULL;
 	}
=20
-	if (!more_used_split(vq)) {
+	more =3D more_used_split(vq);
+	if (!more) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
 	}
=20
 	/* Only get used array entries after they have been exposed by host. */
-	virtio_rmb(vq->weak_barriers);
+	vq =3D dependent_ptr_mb(vq, more);
=20
 	last_used =3D (vq->last_used_idx & (vq->split.vring.num - 1));
 	i =3D virtio32_to_cpu(_vq->vdev,
@@ -1340,6 +1342,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virt=
queue *_vq,
 	struct vring_virtqueue *vq =3D to_vvq(_vq);
 	u16 last_used, id;
 	void *ret;
+	bool more;
=20
 	START_USE(vq);
=20
@@ -1348,14 +1351,15 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
 		return NULL;
 	}
=20
-	if (!more_used_packed(vq)) {
+	more =3D more_used_packed(vq);
+	if (!more) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
 	}
=20
 	/* Only get used elements after they have been exposed by host. */
-	virtio_rmb(vq->weak_barriers);
+	vq =3D dependent_ptr_mb(vq, more);
=20
 	last_used =3D vq->last_used_idx;
 	id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);

--Sig_/c1fo5Pc/xT6f1LO7bjciH/H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwtZ9kACgkQAVBC80lX
0GzWoggAmzv1Bs4k/SwmgHbQJ/TWgg/pwNQbxNoBFKJl/8LTZjpTCkDDwjW2uDfS
MQ2Z4rDIzuf/onMuemTw452dQU3YdSQ3OwN5rrvY2nUhxqzClKPGrs/yz9RM4mVH
pcT8ThdyurXDlWL48+dFKBPTg1sJY3SY5HuV09Bpq/8TprExJmRf73c89VqmsUqP
SsQ6QiQZhaKAqbMHrmpugQgUw0LNsdhUaYXeAOnjetmjG4BQr0RpWWkUEoNTZUFT
m5M2CdjCOK1UX7543zF43EQk+kWOZ4TxI3Eer1WpxzbgEcW924ye2i2jSEnWUYgS
2/qu8w1ABMY5ZM7BW/UGVHPZIIsWNQ==
=1cID
-----END PGP SIGNATURE-----

--Sig_/c1fo5Pc/xT6f1LO7bjciH/H--
