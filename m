Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeBZFP0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:15:26 -0500
Received: from ozlabs.org ([103.22.144.67]:40441 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeBZFPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:15:24 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Feb 2018 16:15:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180226161516.5df31663@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zOZioeUq7Ml.JO_ap=cnu_v"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zOZioeUq7Ml.JO_ap=cnu_v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (powerpc
allyesconfig) failed like this:

security/keys/big_key.c: In function 'big_key_free_buffer':
security/keys/big_key.c:146:3: error: implicit declaration of function 'vun=
map'; did you mean 'kunmap'? [-Werror=3Dimplicit-function-declaration]
   vunmap(buf->virt);
   ^~~~~~
   kunmap
security/keys/big_key.c: In function 'big_key_alloc_buffer':
security/keys/big_key.c:187:14: error: implicit declaration of function 'vm=
ap'; did you mean 'kmap'? [-Werror=3Dimplicit-function-declaration]
  buf->virt =3D vmap(buf->pages, buf->nr_pages, VM_MAP, PAGE_KERNEL);
              ^~~~
              kmap
security/keys/big_key.c:187:46: error: 'VM_MAP' undeclared (first use in th=
is function); did you mean 'VM_SAO'?
  buf->virt =3D vmap(buf->pages, buf->nr_pages, VM_MAP, PAGE_KERNEL);
                                              ^~~~~~
                                              VM_SAO
security/keys/big_key.c:187:46: note: each undeclared identifier is reporte=
d only once for each function it appears in

Caused by commit

  d9f4bb1a0f4d ("KEYS: Use individual pages in big_key for crypto buffers")

in Linus' tree, but most likely exposed by commit

  e8bd5e5c63b6 ("headers: untangle kmemleak.h from mm.h")

in the akpm-current tree (kmemleak.h includes vmalloc.h).

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 26 Feb 2018 15:58:03 +1100
Subject: [PATCH] KEYS: include vmalloc.h for vmap etc

This was discovered after a patch that removed kmemleak.h from slab.h.

Fixes: d9f4bb1a0f4d ("KEYS: Use individual pages in big_key for crypto buff=
ers")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/keys/big_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index fa728f662a6f..e5823de23f4f 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/scatterlist.h>
 #include <linux/random.h>
+#include <linux/vmalloc.h>
 #include <keys/user-type.h>
 #include <keys/big_key-type.h>
 #include <crypto/aead.h>
--=20
2.16.1

Linus, is it worth putting this directly into your tree, or should it
just wait for the patch from Andrew's tree that exposes it?
--=20
Cheers,
Stephen Rothwell

--Sig_/zOZioeUq7Ml.JO_ap=cnu_v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqTl+QACgkQAVBC80lX
0Gzj1Af+LB4Zxk+ySZCDT2lFNvUd0JeHfq2CGqFv+f/Mbly09P0pQlS5RE3YoLEj
P5HbAaKV0Zmdt0OVf6kKtDH/We3MRK3Jz5ZaTzYSbVhOs+Au7HXhtP41kt9HzXL7
FL/1i18TRWHhpSaVMFOQBRtpyXv1hC1lFklj6i0zztkdTu+3dlXlE4NVL52TjLo4
OHHWeM2561eCFm8LovbiG175QDpLXEfW/R7reg0nFc4zHDw9bzyoRDPiFk4ZOLj1
stGc4cQjQv1mKizFLrLSRelZqW2teFWxy2Ok78mFDoB5OFrbg+PjQPH5A+5xbcrr
1UAJ+sUZtCRnbCB/37hCrT2LO6l//w==
=/TF9
-----END PGP SIGNATURE-----

--Sig_/zOZioeUq7Ml.JO_ap=cnu_v--
