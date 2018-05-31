Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbeEaEXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:23:07 -0400
Received: from ozlabs.org ([203.11.71.1]:34731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeEaEXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:23:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 14:23:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20180531142302.5f7b4302@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/E9yY+xHMizQK4H0o/i4mX_J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E9yY+xHMizQK4H0o/i4mX_J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/md/dm-writecache.c: In function 'writecache_dtr':
drivers/md/dm-writecache.c:1799:3: error: implicit declaration of function =
'bioset_free'; did you mean 'bvec_free'? [-Werror=3Dimplicit-function-decla=
ration]
   bioset_free(wc->bio_set);
   ^~~~~~~~~~~
   bvec_free
drivers/md/dm-writecache.c: In function 'writecache_ctr':
drivers/md/dm-writecache.c:1929:17: error: implicit declaration of function=
 'bioset_create'; did you mean 'bioset_exit'? [-Werror=3Dimplicit-function-=
declaration]
   wc->bio_set =3D bioset_create(BIO_POOL_SIZE,
                 ^~~~~~~~~~~~~
                 bioset_exit
drivers/md/dm-writecache.c:1929:15: warning: assignment makes pointer from =
integer without a cast [-Wint-conversion]
   wc->bio_set =3D bioset_create(BIO_POOL_SIZE,
               ^

Caused by commit

  2105231db61b ("dm: add writecache target")

interacting with commit

  dad08527525f ("block: Drop bioset_create()")

from the block tree.

Can we please consider not immediately dropping APIs if at all
possible. :-(

I have added the following merge fix patch (hopefully this is enough):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 31 May 2018 14:06:10 +1000
Subject: [PATCH] dm: fixup for "block: Drop bioset_create()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/md/dm-writecache.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 844c4fb2fcfc..b95f1f0e199d 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -211,7 +211,7 @@ struct dm_writecache {
 	struct completion flush_completion;
 	struct bio *flush_bio;
=20
-	struct bio_set *bio_set;
+	struct bio_set bio_set;
 	mempool_t *copy_pool;
=20
 	struct dm_kcopyd_client *dm_kcopyd;
@@ -1494,7 +1494,7 @@ static void __writecache_writeback_pmem(struct dm_wri=
tecache *wc, struct writeba
=20
 		max_pages =3D e->wc_list_contiguous;
=20
-		bio =3D bio_alloc_bioset(GFP_NOIO, max_pages, wc->bio_set);
+		bio =3D bio_alloc_bioset(GFP_NOIO, max_pages, &wc->bio_set);
 		wb =3D container_of(bio, struct writeback_struct, bio);
 		wb->wc =3D wc;
 		wb->bio.bi_end_io =3D writecache_writeback_endio;
@@ -1795,8 +1795,7 @@ static void writecache_dtr(struct dm_target *ti)
 	if (wc->flush_thread)
 		kthread_stop(wc->flush_thread);
=20
-	if (wc->bio_set)
-		bioset_free(wc->bio_set);
+	bioset_exit(&wc->bio_set);
=20
 	mempool_destroy(wc->copy_pool);
=20
@@ -1926,11 +1925,10 @@ static int writecache_ctr(struct dm_target *ti, uns=
igned argc, char **argv)
 	}
=20
 	if (WC_MODE_PMEM(wc)) {
-		wc->bio_set =3D bioset_create(BIO_POOL_SIZE,
+		r =3D bioset_init(&wc->bio_set, BIO_POOL_SIZE,
 					    offsetof(struct writeback_struct, bio),
 					    BIOSET_NEED_BVECS);
-		if (!wc->bio_set) {
-			r =3D -ENOMEM;
+		if (r) {
 			ti->error =3D "Could not allocate bio set";
 			goto bad;
 		}
--=20
2.17.0

--=20
Cheers,
Stephen Rothwell

--Sig_/E9yY+xHMizQK4H0o/i4mX_J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPeKYACgkQAVBC80lX
0Gy7wwf/TnICOqQee8ZqT7bd0u7ZttT8GmGALvURYsXkoK20VqLi/kMW3FAk4pkB
USc7/smHg8fPT/gUisjtqp58UV8TMz1Q+no/CPaat12+23v+zfQ9nEF083x/dEo6
I+CLXnFn32xVN1iRRt000UxdCHACl3iG5sNr7g2sjglW/4hkmihVFhMDTxKcyBN5
fluPiCrK2Trvei5u52QPCi9P7nWea92Eci9ryJMjRKHv4zAqSFqbsWT/Ugzr1IhV
d/XjFUO3vWmTsSZw+yC3iiDn6lBn4TDId64Verwo9RAhZRyGh/8sjG8w5lt1R/yE
3ZNWHL39b0ICota+2Wrph/TxSWFplw==
=6mT+
-----END PGP SIGNATURE-----

--Sig_/E9yY+xHMizQK4H0o/i4mX_J--
