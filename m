Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8333A218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AuoEYhBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfBRBHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:07:49 -0500
Received: from ozlabs.org ([203.11.71.1]:46249 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbfBRBHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:07:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442m1s40Xtz9sD4;
        Mon, 18 Feb 2019 12:07:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550452065;
        bh=ThsEqpPOmuuxB37cyJtoHXDF4hiul+WoFtf5Uh8P90s=;
        h=Date:From:To:Cc:Subject:From;
        b=AuoEYhBDFbMDJCZ80O1dS63KxR/a3zXXRn/XgLhXJcL2GcTNPDsrZWKimiIUpyiQq
         /g/MYsUyuWHYFfLUIfF/Cox8aR4T4dMV0iiT3PvKk31RKFVzQj+S/mRfoCqwPUUYWF
         E7H+Ny/rtevRa1WELBhUwzlqJ0xFsOYF79PtuTLARQVpzNToehKMtqBEgpI1Zn0sOH
         UA0HHNwkx6oLliRpcPGCJleJownutdh3+3n9+NFM8XNfCnHF1wwGcptHzaiD6z6QyF
         NcvDORr7fiKXt4Nrp5QV3hrJoMK+jR40ZsIBeYGZIZeF+Ix/M5Ozw+KWLcBH3CawoL
         tm4x8UFo2EIaQ==
Date:   Mon, 18 Feb 2019 12:07:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: linux-next: manual merge of the block tree with the btrfs-kdave
 tree
Message-ID: <20190218120735.67e66a4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FHDvkV7m/TIxxek_3E7SJx2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FHDvkV7m/TIxxek_3E7SJx2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Today's linux-next merge of the block tree got a conflict in:

  fs/btrfs/extent_io.c

between commit:

  2ce8afc500de ("btrfs: extent_io: Kill the forward declaration of flush_wr=
ite_bio")

from the btrfs-kdave tree and commit:

  c3a7ce738009 ("btrfs: use mp_bvec_last_segment to get bio's last page")

from the block tree.

I fixed it up (the former moved the function updated by the latter - see
below) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/extent_io.c
index ca259c75bbcd,4ed58c9a94a9..000000000000
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@@ -147,38 -147,7 +147,39 @@@ static int add_extent_changeset(struct=20
  	return ret;
  }
 =20
 -static void flush_write_bio(struct extent_page_data *epd);
 +static int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 +				       unsigned long bio_flags)
 +{
 +	blk_status_t ret =3D 0;
 +	struct bio_vec *bvec =3D bio_last_bvec_all(bio);
- 	struct page *page =3D bvec->bv_page;
++	struct bio_vec bv;
 +	struct extent_io_tree *tree =3D bio->bi_private;
 +	u64 start;
 +
- 	start =3D page_offset(page) + bvec->bv_offset;
++	mp_bvec_last_segment(bvec, &bv);
++	start =3D page_offset(bv.bv_page) + bv.bv_offset;
 +
 +	bio->bi_private =3D NULL;
 +
 +	if (tree->ops)
 +		ret =3D tree->ops->submit_bio_hook(tree->private_data, bio,
 +					   mirror_num, bio_flags, start);
 +	else
 +		btrfsic_submit_bio(bio);
 +
 +	return blk_status_to_errno(ret);
 +}
 +
 +static void flush_write_bio(struct extent_page_data *epd)
 +{
 +	if (epd->bio) {
 +		int ret;
 +
 +		ret =3D submit_one_bio(epd->bio, 0, 0);
 +		BUG_ON(ret < 0); /* -ENOMEM */
 +		epd->bio =3D NULL;
 +	}
 +}
 =20
  int __init extent_io_init(void)
  {

--Sig_/FHDvkV7m/TIxxek_3E7SJx2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxqBVcACgkQAVBC80lX
0GxNOQgAgRzFCxEgSwd6QltNhrPO3XwVPJMFi9rG+Bht42HA2zdFydjImsH66kbK
3PM33jgjWDxREWFnr7BNHn1pO30jt/7l3Dey9KnXDzA+0thpygqsdrZ1tEJ3Hy04
Cpr7AgLjekU6T0VA2MnjY5puJfG8pfzIXlpWKm7lgOK9g3/QKPkDmuuyClvchLnM
Eu2VlXg2xg03rP4IHp0T64sd40n0HkAFh/c+/THueVFHBYYPdb1OzD6i3F5NZXRt
QTjivDVMAlqLP3+IONyCi2bYGsxqG3lql3ipKn8g30YGLgXoIJJisclmnhoNbUOK
Xn3NuYmLMoc7YetLFAOHnLRO/xvI2Q==
=x32q
-----END PGP SIGNATURE-----

--Sig_/FHDvkV7m/TIxxek_3E7SJx2--
