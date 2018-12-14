Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12344C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1E820811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MNLc+GMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1E820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeLNCXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:23:20 -0500
Received: from ozlabs.org ([203.11.71.1]:51589 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeLNCXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:23:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43GDqS39Q2z9s4s;
        Fri, 14 Dec 2018 13:23:16 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544754196;
        bh=jix4i77ESnwSLqH+A75ZOcU861BTOyBxhJSi0lweZrc=;
        h=Date:From:To:Cc:Subject:From;
        b=MNLc+GMFFRIOQbiK/8C78h/644hQRSpsJRtEanpYTxcmUG6UA21Beu52ck2CyzibS
         r1YV56LA5qZVLwJyEkppVYkt0js9U0OPuHaZEHCcXWail/3RiO32HerUAt4RQ9Hdhd
         3qAucgF3WI8KLUJ3D18mdJuOvoB3sV29VUQIrW0gLdqsCEB+c2QjdrWU/MmEYZyw2z
         fnntrKfzhBwcn5DFaATCiGk4nPT7cNqF8R+1bAqMCOuJcZCB3DhlqsRFvQAozkVLZB
         jb69nxmgRuzwgyZllWMB2PUj6PG0sD1oBNiWM2RD4w9p4mMrmbnskn06N76tU1xPrA
         7EC/z01I2q7jw==
Date:   Fri, 14 Dec 2018 13:23:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the block tree with the scsi-fixes tree
Message-ID: <20181214132315.601d020f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MP+fv/9tCmEqLKxW+OW4IcR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MP+fv/9tCmEqLKxW+OW4IcR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  drivers/scsi/sd.c

between commit:

  61cce6f6eece ("scsi: sd: use mempool for discard special page")

from the scsi-fixes tree and commit:

  159b2cbf59f4 ("scsi: return blk_status_t from scsi_init_io and ->init_com=
mand")

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

diff --cc drivers/scsi/sd.c
index bd0a5c694a97,4a6ed2fc8c71..000000000000
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@@ -760,10 -759,9 +760,10 @@@ static blk_status_t sd_setup_unmap_cmnd
  	unsigned int data_len =3D 24;
  	char *buf;
 =20
 -	rq->special_vec.bv_page =3D alloc_page(GFP_ATOMIC | __GFP_ZERO);
 +	rq->special_vec.bv_page =3D mempool_alloc(sd_page_pool, GFP_ATOMIC);
  	if (!rq->special_vec.bv_page)
- 		return BLKPREP_DEFER;
+ 		return BLK_STS_RESOURCE;
 +	clear_highpage(rq->special_vec.bv_page);
  	rq->special_vec.bv_offset =3D 0;
  	rq->special_vec.bv_len =3D data_len;
  	rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
@@@ -794,10 -793,9 +795,10 @@@ static blk_status_t sd_setup_write_same
  	u32 nr_sectors =3D blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
  	u32 data_len =3D sdp->sector_size;
 =20
 -	rq->special_vec.bv_page =3D alloc_page(GFP_ATOMIC | __GFP_ZERO);
 +	rq->special_vec.bv_page =3D mempool_alloc(sd_page_pool, GFP_ATOMIC);
  	if (!rq->special_vec.bv_page)
- 		return BLKPREP_DEFER;
+ 		return BLK_STS_RESOURCE;
 +	clear_highpage(rq->special_vec.bv_page);
  	rq->special_vec.bv_offset =3D 0;
  	rq->special_vec.bv_len =3D data_len;
  	rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
@@@ -825,10 -824,9 +827,10 @@@ static blk_status_t sd_setup_write_same
  	u32 nr_sectors =3D blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
  	u32 data_len =3D sdp->sector_size;
 =20
 -	rq->special_vec.bv_page =3D alloc_page(GFP_ATOMIC | __GFP_ZERO);
 +	rq->special_vec.bv_page =3D mempool_alloc(sd_page_pool, GFP_ATOMIC);
  	if (!rq->special_vec.bv_page)
- 		return BLKPREP_DEFER;
+ 		return BLK_STS_RESOURCE;
 +	clear_highpage(rq->special_vec.bv_page);
  	rq->special_vec.bv_offset =3D 0;
  	rq->special_vec.bv_len =3D data_len;
  	rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;

--Sig_/MP+fv/9tCmEqLKxW+OW4IcR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwTFBMACgkQAVBC80lX
0GxqRwf/XLCJ4f42zhZWrE+ELAXs/HnBUF4h+4N9VaWVcOkXxRnOMKCcs8k+wwi8
h8EZJ/ATLVH3COzMgHE0Td6mEYAArYmkDCUX0eeFNmWkxe6ZblULtE66+Xivy2N3
R5eCJN/JZdr8uz1RQDk6bR9Pvmzrj4Cj3ymFS7IoliCJwWlI0sb/PaMIrJqhGSwn
OYSLL79p6zwu2twiU4QaexrZ/JuRGeLRj9HrAsKtpO7Nd0VCkDvc2zy2BEaTRxbg
Yp9UDwn1z/tB/1z65jy8n7CkRZkBhlkLPR4mm8QDeBGLPHyU2JiFPT2ciiZsnHE+
ofvCQFHUtlZdfBgeAl+G4aSMU5XSgQ==
=RHIN
-----END PGP SIGNATURE-----

--Sig_/MP+fv/9tCmEqLKxW+OW4IcR--
