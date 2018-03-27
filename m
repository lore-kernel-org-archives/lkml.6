Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeC0CkQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:40:16 -0400
Received: from ozlabs.org ([103.22.144.67]:51463 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeC0CkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:40:14 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 27 Mar 2018 13:39:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Denis Semakin <d.semakin@omprussia.ru>
Subject: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20180327133923.53b8954d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/621_aMtf8JsobZ0xa4VbrsT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/621_aMtf8JsobZ0xa4VbrsT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

/home/sfr/next/next/drivers/md/dm-table.c: In function 'dm_table_set_restri=
ctions':
/home/sfr/next/next/drivers/md/dm-table.c:1899:3: error: implicit declarati=
on of function 'queue_flag_set_unlocked'; did you mean 'lookup_one_len_unlo=
cked'? [-Werror=3Dimplicit-function-declaration]
   queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
   ^~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  9723d9db1a84 ("dm: add support for secure erase forwarding")

interacting with commit

  8a0ac14b8da9 ("block: Move the queue_flag_*() functions from a public int=
o a private header file")

from the block tree.

I have added the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 27 Mar 2018 13:36:49 +1100
Subject: [PATCH] dm: merge fix for queue_flag_set_unlocked to
 blk_queue_flag_set API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index d5db9df7ea4b..0589a4da12bb 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1896,7 +1896,7 @@ void dm_table_set_restrictions(struct dm_table *t, st=
ruct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
=20
 	if (dm_table_supports_secure_erase(t))
-		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
+		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
=20
 	if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_WC))) {
 		wc =3D true;
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/621_aMtf8JsobZ0xa4VbrsT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq5rtsACgkQAVBC80lX
0GxwCwf/XVi8A8EsALHwrXTc5gc9QxUo+yYPq66htfJHZNlPu/TG2z6uksFFs66N
S2V2DC1iVZIeAxAv+6GEAFhA7SKkF/Z1ts95tEH7DKVRXB0V2RpfJhUEPWJLHlmI
9sSC0gv1Di7FC28oJ6uG0UBW9XNLBiNJz54H6IrWfyIVc7pad0z/njrQiXreSsej
TPIQkpbg/YjSFG0Ozs86r7svg2kH0CF0Y6M0TdTgT4JEeFjvXEvpWG9pYSxbDSqX
154HpHG/FEyp2yZezq6jITdmhM3tI4d4U14S2625APnq1AIrkE7bXdTDX9+M00vV
TjR3gT4MqoHDvyaAcMrhHV6EJsjQLQ==
=A5rF
-----END PGP SIGNATURE-----

--Sig_/621_aMtf8JsobZ0xa4VbrsT--
