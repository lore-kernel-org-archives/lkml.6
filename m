Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D08C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484BE20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kLN1ZdS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfAPCZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:25:27 -0500
Received: from ozlabs.org ([203.11.71.1]:41011 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfAPCZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:25:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fWJg5tNDz9sDr;
        Wed, 16 Jan 2019 13:25:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547605524;
        bh=QjqsECc4U44FzF2BnrUmH1TChEJHXPTFnSAWy1tmHdg=;
        h=Date:From:To:Cc:Subject:From;
        b=kLN1ZdS62GyL3O/g+USPZg7g85ipEy2ig/qIT0cqlLz7Xq0hROwE1vKH98w4BrR7A
         5ZSRxb7zyu1g2rlq1+LZURwAhqhQXBBQF9SQPArQuxrfmBco2/YmjclDiTEgD/sow2
         rj/MBpmqc1SwyLaKhfjhI9MiMk+JR6DAvjaF5fyaGRFHsmOx5rGoXEq3iWibpG6AbI
         NH+Li9HhMeISjQi1IFNsWG8HajMoms0Lr9Hp/D3aGhrhllfuUqKOxADX4cW5ww6pbg
         kXlzsNS8k/uL+blBPKf8J7ZcmULucmKopOaRbxDNeyoUsl+Ts2O3P6hHu40PngUpAS
         vu8r0j1F//a6g==
Date:   Wed, 16 Jan 2019 13:25:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: linux-next: manual merge of the block tree with the fscrypt tree
Message-ID: <20190116132522.1b756433@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NvUAs=meH/sMEJp+jrWm.nU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NvUAs=meH/sMEJp+jrWm.nU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/ext4/readpage.c

between commit:

  acc9eb0a6073 ("ext4: add fs-verity read support")

from the fscrypt tree and commit:

  eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over mu=
lti-page bvec")

from the block tree.

I fixed it up (see below - the former moved the code modified by the
latter) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ext4/readpage.c
index 0b353a0634f3,e53639784892..000000000000
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@@ -61,124 -56,6 +61,125 @@@ static inline bool ext4_bio_encrypted(s
  #endif
  }
 =20
 +/* postprocessing steps for read bios */
 +enum bio_post_read_step {
 +	STEP_INITIAL =3D 0,
 +	STEP_DECRYPT,
 +	STEP_VERITY,
 +};
 +
 +struct bio_post_read_ctx {
 +	struct bio *bio;
 +	struct work_struct work;
 +	unsigned int cur_step;
 +	unsigned int enabled_steps;
 +};
 +
 +static void __read_end_io(struct bio *bio)
 +{
 +	struct page *page;
 +	struct bio_vec *bv;
 +	int i;
++	struct bvec_iter_all iter_all;
 +
- 	bio_for_each_segment_all(bv, bio, i) {
++	bio_for_each_segment_all(bv, bio, i, iter_all) {
 +		page =3D bv->bv_page;
 +
 +		/* PG_error was set if any post_read step failed */
 +		if (bio->bi_status || PageError(page)) {
 +			ClearPageUptodate(page);
 +			SetPageError(page);
 +		} else {
 +			SetPageUptodate(page);
 +		}
 +		unlock_page(page);
 +	}
 +	if (bio->bi_private)
 +		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
 +	bio_put(bio);
 +}
 +
 +static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
 +
 +static void decrypt_work(struct work_struct *work)
 +{
 +	struct bio_post_read_ctx *ctx =3D
 +		container_of(work, struct bio_post_read_ctx, work);
 +
 +	fscrypt_decrypt_bio(ctx->bio);
 +
 +	bio_post_read_processing(ctx);
 +}
 +
 +static void verity_work(struct work_struct *work)
 +{
 +	struct bio_post_read_ctx *ctx =3D
 +		container_of(work, struct bio_post_read_ctx, work);
 +
 +	fsverity_verify_bio(ctx->bio);
 +
 +	bio_post_read_processing(ctx);
 +}
 +
 +static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 +{
 +	/*
 +	 * We use different work queues for decryption and for verity because
 +	 * verity may require reading metadata pages that need decryption, and
 +	 * we shouldn't recurse to the same workqueue.
 +	 */
 +	switch (++ctx->cur_step) {
 +	case STEP_DECRYPT:
 +		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
 +			INIT_WORK(&ctx->work, decrypt_work);
 +			fscrypt_enqueue_decrypt_work(&ctx->work);
 +			return;
 +		}
 +		ctx->cur_step++;
 +		/* fall-through */
 +	case STEP_VERITY:
 +		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
 +			INIT_WORK(&ctx->work, verity_work);
 +			fsverity_enqueue_verify_work(&ctx->work);
 +			return;
 +		}
 +		ctx->cur_step++;
 +		/* fall-through */
 +	default:
 +		__read_end_io(ctx->bio);
 +	}
 +}
 +
 +static struct bio_post_read_ctx *get_bio_post_read_ctx(struct inode *inod=
e,
 +						       struct bio *bio,
 +						       pgoff_t index)
 +{
 +	unsigned int post_read_steps =3D 0;
 +	struct bio_post_read_ctx *ctx =3D NULL;
 +
 +	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
 +		post_read_steps |=3D 1 << STEP_DECRYPT;
 +#ifdef CONFIG_FS_VERITY
 +	if (inode->i_verity_info !=3D NULL &&
 +	    (index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
 +		post_read_steps |=3D 1 << STEP_VERITY;
 +#endif
 +	if (post_read_steps) {
 +		ctx =3D mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 +		if (!ctx)
 +			return ERR_PTR(-ENOMEM);
 +		ctx->bio =3D bio;
 +		ctx->enabled_steps =3D post_read_steps;
 +		bio->bi_private =3D ctx;
 +	}
 +	return ctx;
 +}
 +
 +static bool bio_post_read_required(struct bio *bio)
 +{
 +	return bio->bi_private && !bio->bi_status;
 +}
 +
  /*
   * I/O completion handler for multipage BIOs.
   *

--Sig_/NvUAs=meH/sMEJp+jrWm.nU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+lhMACgkQAVBC80lX
0GwFNQf+JCtgpfzQTW7gsQzb5syKDYH6gI/l6aGiws6qDefqPb32lAJmjRxAZOSk
2D+T9GiZV1bpK8+XxrM/I46tYI/qeCgJwlFwO/qFE0Zl2/lsdidRvhuC0MIj3H0g
+9LnZLSn2w+IbWbeq5xbfVTdbO71xmlYw3A+3SrJBhsDx2UkJkl/R9VENLCrWfkK
92rfhnSMJ8dtoOH2SwihZnecdxXzDFTduzH33p3/DzJa4f39DNuSFGiW+r6CZxHn
oRGXaqLQTio+utjFU1U7u3hfBHyDggXJXBeYT1wkVPovaLvEHEZolqR8I/cZ5xQo
9uGWudHYBJotvMagxGl0xhYZrM9N2Q==
=EqWE
-----END PGP SIGNATURE-----

--Sig_/NvUAs=meH/sMEJp+jrWm.nU--
