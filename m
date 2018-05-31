Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeEaEek (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:34:40 -0400
Received: from ozlabs.org ([203.11.71.1]:40929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbeEaEei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:34:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 14:34:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>, Xiao Ni <xni@redhat.com>
Subject: linux-next: manual merge of the md tree with the block tree
Message-ID: <20180531143436.79769901@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5UIs6+1gRyTV7MEtY2ve6Tn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5UIs6+1gRyTV7MEtY2ve6Tn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the md tree got a conflict in:

  drivers/md/md.c

between commit:

  afeee514ce7f ("md: convert to bioset_init()/mempool_init()")

from the block tree and commit:

  5a409b4f56d5 ("MD: fix lock contention for flush bios")

from the md tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/md/md.c
index fc692b7128bb,6b4e2f29fe4e..000000000000
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@@ -5498,16 -5518,34 +5519,32 @@@ int md_run(struct mddev *mddev
  		sysfs_notify_dirent_safe(rdev->sysfs_state);
  	}
 =20
 -	if (mddev->bio_set =3D=3D NULL) {
 -		mddev->bio_set =3D bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 -		if (!mddev->bio_set)
 -			return -ENOMEM;
 +	if (!bioset_initialized(&mddev->bio_set)) {
 +		err =3D bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVEC=
S);
 +		if (err)
 +			return err;
  	}
 -	if (mddev->sync_set =3D=3D NULL) {
 -		mddev->sync_set =3D bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 -		if (!mddev->sync_set) {
 -			err =3D -ENOMEM;
 +	if (!bioset_initialized(&mddev->sync_set)) {
 +		err =3D bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVE=
CS);
 +		if (err)
  			goto abort;
 -		}
  	}
+ 	if (mddev->flush_pool =3D=3D NULL) {
+ 		mddev->flush_pool =3D mempool_create(NR_FLUSH_INFOS, flush_info_alloc,
+ 						flush_info_free, mddev);
+ 		if (!mddev->flush_pool) {
+ 			err =3D -ENOMEM;
+ 			goto abort;
+ 		}
+ 	}
+ 	if (mddev->flush_bio_pool =3D=3D NULL) {
+ 		mddev->flush_bio_pool =3D mempool_create(NR_FLUSH_BIOS, flush_bio_alloc,
+ 						flush_bio_free, mddev);
+ 		if (!mddev->flush_bio_pool) {
+ 			err =3D -ENOMEM;
+ 			goto abort;
+ 		}
+ 	}
 =20
  	spin_lock(&pers_lock);
  	pers =3D find_pers(mddev->level, mddev->clevel);
@@@ -5667,8 -5705,22 +5704,16 @@@
  	return 0;
 =20
  abort:
+ 	if (mddev->flush_bio_pool) {
+ 		mempool_destroy(mddev->flush_bio_pool);
+ 		mddev->flush_bio_pool =3D NULL;
+ 	}
+ 	if (mddev->flush_pool){
+ 		mempool_destroy(mddev->flush_pool);
+ 		mddev->flush_pool =3D NULL;
+ 	}
 -	if (mddev->bio_set) {
 -		bioset_free(mddev->bio_set);
 -		mddev->bio_set =3D NULL;
 -	}
 -	if (mddev->sync_set) {
 -		bioset_free(mddev->sync_set);
 -		mddev->sync_set =3D NULL;
 -	}
 +	bioset_exit(&mddev->bio_set);
 +	bioset_exit(&mddev->sync_set);
 =20
  	return err;
  }
@@@ -5881,8 -5933,22 +5926,16 @@@ void md_stop(struct mddev *mddev
  	 * This is called from dm-raid
  	 */
  	__md_stop(mddev);
+ 	if (mddev->flush_bio_pool) {
+ 		mempool_destroy(mddev->flush_bio_pool);
+ 		mddev->flush_bio_pool =3D NULL;
+ 	}
+ 	if (mddev->flush_pool) {
+ 		mempool_destroy(mddev->flush_pool);
+ 		mddev->flush_pool =3D NULL;
+ 	}
 -	if (mddev->bio_set) {
 -		bioset_free(mddev->bio_set);
 -		mddev->bio_set =3D NULL;
 -	}
 -	if (mddev->sync_set) {
 -		bioset_free(mddev->sync_set);
 -		mddev->sync_set =3D NULL;
 -	}
 +	bioset_exit(&mddev->bio_set);
 +	bioset_exit(&mddev->sync_set);
  }
 =20
  EXPORT_SYMBOL_GPL(md_stop);

--Sig_/5UIs6+1gRyTV7MEtY2ve6Tn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPe1wACgkQAVBC80lX
0Gz2bwf+PCE25jCiwAIwNY+2/CL2tRnZd2K4Tesx1Ers98JabUeBpMbcbCEyKQmx
NI9lKpyfBEhT1c50Dc3pSTqQSGxkHMyxC7kGihp545LdRrM/Gx7JixKyARndYw+y
85QJY4TbpLWHy9K/mTW1zrJl7XdZXQz2dX6ITCR01eV4BaINZIQuTKJYDs8izVZf
e9YMS1mpdIuWCGR6B9gWAim2C6xnxWf8R6v0FcyGVWCPCCNaVDYbB4eVtHVPD7RU
ot7gOyaOPmb5lWhYHBwL9L2mYtu/rcrt6jUX1ruDGNs/mYlvL4fPOMXc10QdU8l4
pS68GSUKo/T13PYEBpYqfvcyTrsUnw==
=l15y
-----END PGP SIGNATURE-----

--Sig_/5UIs6+1gRyTV7MEtY2ve6Tn--
