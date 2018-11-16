Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4282145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ue5GkmLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4282145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbeKPM3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 07:29:54 -0500
Received: from ozlabs.org ([203.11.71.1]:54957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeKPM3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 07:29:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42x23s4729z9sBN;
        Fri, 16 Nov 2018 13:19:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542334761;
        bh=zQZ3uYxMn1IQe/5Ycmzngm/FJa04co02sIwIh8akbRM=;
        h=Date:From:To:Cc:Subject:From;
        b=Ue5GkmLoZWV41gJKUCInUcnU+h7LOH+JkwZXkp0bCaEaEEqN22yD0okGqbKBl2vW4
         WyjO3//yA3pyUAt0177CPB9PEVXyA7z4ZkqCytGQlTr6Fl6kl1bgHhHtLtRl02bXFu
         rPVmhOPopijxWjs4FHu/VofuTs78yHuy1VSRuB4Pf2nu3cgDwv2BUeGId05GpO35r3
         dCjU/IFpJmEH9bYL7IatqpgsqBqs0N1jYX7PLJqRHip1eJscol4lgGLiJDJIUiuiw1
         upgeY0rkseWtODXoijAoGtxclE91gXECxdBlYriRfbLj6ZKjUq8CWmSojJw+LewJRr
         Hie6m689JfGNA==
Date:   Fri, 16 Nov 2018 13:19:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20181116131919.781539f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P0jZk+bujMBoCzwAog_dq=1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P0jZk+bujMBoCzwAog_dq=1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  block/blk.h

between commit:

  1adfc5e4136f ("block: make sure discard bio is aligned with logical block=
 size")

from Linus' tree (precedes v4.20-rc2) and commit:

  079076b3416e ("block: remove deadline __deadline manipulation helpers")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/blk.h
index 0089fefdf771,027a0ccc175e..000000000000
--- a/block/blk.h
+++ b/block/blk.h
@@@ -380,31 -233,6 +233,16 @@@ static inline void req_set_nomerge(stru
  		q->last_merge =3D NULL;
  }
 =20
- /*
-  * Steal a bit from this field for legacy IO path atomic IO marking. Note=
 that
-  * setting the deadline clears the bottom bit, potentially clearing the
-  * completed bit. The user has to be OK with this (current ones are fine).
-  */
- static inline void blk_rq_set_deadline(struct request *rq, unsigned long =
time)
- {
- 	rq->__deadline =3D time & ~0x1UL;
- }
-=20
- static inline unsigned long blk_rq_deadline(struct request *rq)
- {
- 	return rq->__deadline & ~0x1UL;
- }
-=20
 +/*
 + * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
 + * is defined as 'unsigned int', meantime it has to aligned to with logic=
al
 + * block size which is the minimum accepted unit by hardware.
 + */
 +static inline unsigned int bio_allowed_max_sectors(struct request_queue *=
q)
 +{
 +	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 +}
 +
  /*
   * Internal io_context interface
   */

--Sig_/P0jZk+bujMBoCzwAog_dq=1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvuKScACgkQAVBC80lX
0GxPlgf/RSEU1vJNGDBzP8W+mpeAWfiVVw16Ff30KnIKVhn/lFviqB2Xfy90fJKy
mdkQ2fL5SdH0k/VJ62D+hHEzuXBH6hsbp0+aKZ9vIh9kdp0JmQ/gflMP4w3wygEp
MtkCGCTJIwLpgJ4rt9lMDFbwHsyYzwGWEf8qws2hqA/7doJnJSB7Nmm8XA571alp
e0tOeyEAsVIoVtae2ACcgrQoC1dvdxZ2xtGD1lIaMTz3OIafOw/14QXiG3+zUNLs
OqrF4DJpTCuMLet6i1pccgxz96bHsor74KMwwmyVaR7YUyT+CGv5BS5CV+18d1ea
VHrybvPjBxp6Hpazanbq+RAL0eWzCg==
=OyZ0
-----END PGP SIGNATURE-----

--Sig_/P0jZk+bujMBoCzwAog_dq=1--
