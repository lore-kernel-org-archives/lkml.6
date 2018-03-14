Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeCNFqU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:46:20 -0400
Received: from ozlabs.org ([103.22.144.67]:58339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbeCNFqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:46:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 16:45:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180314164549.47d578b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VF1mgEl0+YgMEvP1CANfpkC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VF1mgEl0+YgMEvP1CANfpkC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/kernel.h:15:0,
                 from include/linux/list.h:9,
                 from mm/hugetlb.c:5:
mm/hugetlb.c: In function 'hugetlb_reserve_pages':
include/linux/build_bug.h:36:33: error: void value not ignored as it ought =
to be
 #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
                                 ^
include/linux/mmdebug.h:52:34: note: in expansion of macro 'BUILD_BUG_ON_IN=
VALID'
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
                                  ^~~~~~~~~~~~~~~~~~~~
mm/hugetlb.c:4379:6: note: in expansion of macro 'VM_WARN'
  if (VM_WARN(from > to, "%s called with a negative range\n", __func__))
      ^~~~~~~
scripts/Makefile.build:324: recipe for target 'mm/hugetlb.o' failed

Caused by commit

  df9b0bfadaa3 ("hugetlbfs-check-for-pgoff-value-overflow-v3-fix")

I have applied the following patch (a partial revert of the above):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Mar 2018 16:38:50 +1100
Subject: [PATCH] pertially revert
 "hugetlbfs-check-for-pgoff-value-overflow-v3-fix"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3b31dcfb7621..218679138255 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4376,8 +4376,11 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct resv_map *resv_map;
 	long gbl_reserve;
=20
-	if (VM_WARN(from > to, "%s called with a negative range\n", __func__))
+	/* This should never happen */
+	if (from > to) {
+		VM_WARN(1, "%s called with a negative range\n", __func__);
 		return -EINVAL;
+	}
=20
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/VF1mgEl0+YgMEvP1CANfpkC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqotw0ACgkQAVBC80lX
0Gx66Af/Wt6kIzV/WDHSN1Ke43ppzR8mv+t5O64NFjdSkHOYeBdqOFCzNSgKGeAy
M448qnQx9YmAGy6tUGVyP/DwT4ye1NUO/FWkh25PDAcO4aijOV80rDbXsbNEBOEb
1IZ91+fKIqszTVUm4wvM7jQ5klgvSdSPdOzAatWWLA7WsWc/B1JCnRzcHEQLlrz2
wHVKOTyXW5N7kAem41xyGeE37FU4/nzrP3Jwv4kXEq6L5zYC1+lHmJlOH86Tms8J
qd00/vujNnKiEfYm+eNE8vNewxpyrSSIeJKND/C5m+oCZkgCM0GJaL4SLqhEpqtJ
NRYzYAlvwn4iVEpyup8teeLy/cFEiA==
=cbPU
-----END PGP SIGNATURE-----

--Sig_/VF1mgEl0+YgMEvP1CANfpkC--
