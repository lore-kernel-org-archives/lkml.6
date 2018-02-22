Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeBVDbe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 22:31:34 -0500
Received: from ozlabs.org ([103.22.144.67]:41683 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbeBVDbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 22:31:33 -0500
Date: Thu, 22 Feb 2018 14:30:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>, Michal Hocko <mhocko@suse.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180222143057.3a1b3746@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U4bFNs3421_eRfec8XKlgdf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U4bFNs3421_eRfec8XKlgdf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

[As reported by Randy for uml ...]

After merging the akpm-current tree, today's linux-next build (sparc
defconfig) failed like this:

/home/sfr/next/next/mm/page_alloc.c: In function 'memmap_init_zone':
/home/sfr/next/next/mm/page_alloc.c:5450:11: error: implicit declaration of=
 function 'memblock_next_valid_pfn'; did you mean 'memblock_virt_alloc_low'=
? [-Werror=3Dimplicit-function-declaration]
     pfn =3D memblock_next_valid_pfn(pfn, end_pfn) - 1;
           ^~~~~~~~~~~~~~~~~~~~~~~
           memblock_virt_alloc_low

Caused by commit

  c3d8f8809701 ("mm: page_alloc: skip over regions of invalid pfns on UMA")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 22 Feb 2018 14:20:45 +1100
Subject: [PATCH] mm: page_alloc: skip over regions of invalid pfns on UMA f=
ix

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/memblock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index c2f1a6996fad..90e6845f44be 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -423,6 +423,11 @@ static inline phys_addr_t memblock_alloc(phys_addr_t s=
ize, phys_addr_t align)
 {
 	return 0;
 }
+static inline unsigned long memblock_next_valid_pfn(unsigned long pfn,
+						    unsigned long max_pfn)
+{
+	return pfn;
+}
 #endif /* CONFIG_HAVE_MEMBLOCK */
=20
 #endif /* __KERNEL__ */
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/U4bFNs3421_eRfec8XKlgdf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqOOXEACgkQAVBC80lX
0GxtNwgAoSMjAWoDKc8lymht2Fd2bguHwjB0iYacmZe5YiUqbFxsdB5GJU3OyGng
UGRc+9JrrC6Q8NU9T0DNovFWVL6Ts6+Pg2KdgRkNj8YmgpHlgmPQ4DPGmXn1Cj0X
Iz0v2sCJ7BXtGBtH3eHhS20/QeF8MFTChXnMST2S/2MWk7TxpMV479BGku4+kNaB
7Qh/qq3+juWwYH7GhLxtJMAFZudJE7aSWc11zpB0NR7fgknLLw4MZg9I5H5TOeDG
xDcu3IcaNpCm3XgRSTT7AdD3UYXz/WYZJaY+xmxNlvFjtPfyeR0xVTfCSvK97NQ6
EhvCxw5gJJHZWV+CUc8Doppupy+8EQ==
=LakX
-----END PGP SIGNATURE-----

--Sig_/U4bFNs3421_eRfec8XKlgdf--
