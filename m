Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeE3VWM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:22:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38506 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbeE3VWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:22:09 -0400
X-Google-Smtp-Source: ADUXVKL0tJNX/Idf2jiVFV9Nd4eW65QV0eyqXmoBnW9gfQvTl1PmO9gEljg+uSNU9gwFB/XOe92bNw==
Date: Wed, 30 May 2018 14:22:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] lib/bch: Remove VLA usage
Message-ID: <20180530212206.GA36883@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
allocates a fixed size stack array to cover the range needed for
bch. This was done instead of a preallocation on the SLAB due to
performance reasons, shown by Ivan Djelic:

 little-endian, type sizes: int=4 long=8 longlong=8
 cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
 calibration: iter=4.9143µs niter=2034 nsamples=200 m=13 t=4

   Buffer allocation |  Encoding throughput (Mbit/s)
 ---------------------------------------------------
  on-stack, VLA      |   3988
  on-stack, fixed    |   4494
  kmalloc            |   1967

So this change actually improves performance too, it seems.

The resulting stack allocation can get rather large; without
CONFIG_BCH_CONST_PARAMS, it will allocate 4096 bytes, which
trips the stack size checking:

lib/bch.c: In function ‘encode_bch’:
lib/bch.c:261:1: warning: the frame size of 4432 bytes is larger than 2048 bytes [-Wframe-larger-than=]

Even the default case for "allmodconfig" (with CONFIG_BCH_CONST_M=14 and
CONFIG_BCH_CONST_T=4) would have started throwing a warning:

lib/bch.c: In function ‘encode_bch’:
lib/bch.c:261:1: warning: the frame size of 2288 bytes is larger than 2048 bytes [-Wframe-larger-than=]

But this is how large it's always been; it was just hidden from
the checker because it was a VLA. So the Makefile has been adjusted to
silence this warning for anything smaller than 4500 bytes, which should
provide room for normal cases, but still low enough to catch any future
pathological situations.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: switch to fixed-size stack array
---
 lib/Makefile |  1 +
 lib/bch.c    | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index ce20696d5a92..24331b122d7f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon/
 obj-$(CONFIG_BCH) += bch.o
+CFLAGS_bch.o := $(call cc-option,-Wframe-larger-than=4500)
 obj-$(CONFIG_LZO_COMPRESS) += lzo/
 obj-$(CONFIG_LZO_DECOMPRESS) += lzo/
 obj-$(CONFIG_LZ4_COMPRESS) += lz4/
diff --git a/lib/bch.c b/lib/bch.c
index bc89dfe4d1b3..07ee4f95d94c 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -78,15 +78,22 @@
 #define GF_M(_p)               (CONFIG_BCH_CONST_M)
 #define GF_T(_p)               (CONFIG_BCH_CONST_T)
 #define GF_N(_p)               ((1 << (CONFIG_BCH_CONST_M))-1)
+#define BCH_MAX_M              (CONFIG_BCH_CONST_M)
 #else
 #define GF_M(_p)               ((_p)->m)
 #define GF_T(_p)               ((_p)->t)
 #define GF_N(_p)               ((_p)->n)
+#define BCH_MAX_M              15
 #endif
 
+#define BCH_MAX_T              (((1 << BCH_MAX_M) - 1) / BCH_MAX_M)
+
 #define BCH_ECC_WORDS(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 32)
 #define BCH_ECC_BYTES(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 8)
 
+#define BCH_ECC_MAX_WORDS      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 32)
+#define BCH_ECC_MAX_BYTES      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 8)
+
 #ifndef dbg
 #define dbg(_fmt, args...)     do {} while (0)
 #endif
@@ -187,7 +194,8 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 	const unsigned int l = BCH_ECC_WORDS(bch)-1;
 	unsigned int i, mlen;
 	unsigned long m;
-	uint32_t w, r[l+1];
+	uint32_t w, r[BCH_ECC_MAX_WORDS];
+	const size_t r_bytes = BCH_ECC_BYTES(bch);
 	const uint32_t * const tab0 = bch->mod8_tab;
 	const uint32_t * const tab1 = tab0 + 256*(l+1);
 	const uint32_t * const tab2 = tab1 + 256*(l+1);
@@ -198,7 +206,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 		/* load ecc parity bytes into internal 32-bit buffer */
 		load_ecc8(bch, bch->ecc_buf, ecc);
 	} else {
-		memset(bch->ecc_buf, 0, sizeof(r));
+		memset(bch->ecc_buf, 0, r_bytes);
 	}
 
 	/* process first unaligned data bytes */
@@ -215,7 +223,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 	mlen  = len/4;
 	data += 4*mlen;
 	len  -= 4*mlen;
-	memcpy(r, bch->ecc_buf, sizeof(r));
+	memcpy(r, bch->ecc_buf, r_bytes);
 
 	/*
 	 * split each 32-bit word into 4 polynomials of weight 8 as follows:
@@ -241,7 +249,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 
 		r[l] = p0[l]^p1[l]^p2[l]^p3[l];
 	}
-	memcpy(bch->ecc_buf, r, sizeof(r));
+	memcpy(bch->ecc_buf, r, r_bytes);
 
 	/* process last unaligned bytes */
 	if (len)
@@ -434,7 +442,7 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
 {
 	const int m = GF_M(bch);
 	unsigned int tmp, mask;
-	int rem, c, r, p, k, param[m];
+	int rem, c, r, p, k, param[BCH_MAX_M];
 
 	k = 0;
 	mask = 1 << m;
@@ -1114,7 +1122,7 @@ static int build_deg2_base(struct bch_control *bch)
 {
 	const int m = GF_M(bch);
 	int i, j, r;
-	unsigned int sum, x, y, remaining, ak = 0, xi[m];
+	unsigned int sum, x, y, remaining, ak = 0, xi[BCH_MAX_M];
 
 	/* find k s.t. Tr(a^k) = 1 and 0 <= k < m */
 	for (i = 0; i < m; i++) {
@@ -1254,7 +1262,6 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
 	struct bch_control *bch = NULL;
 
 	const int min_m = 5;
-	const int max_m = 15;
 
 	/* default primitive polynomials */
 	static const unsigned int prim_poly_tab[] = {
@@ -1270,7 +1277,7 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
 		goto fail;
 	}
 #endif
-	if ((m < min_m) || (m > max_m))
+	if ((m < min_m) || (m > BCH_MAX_M))
 		/*
 		 * values of m greater than 15 are not currently supported;
 		 * supporting m > 15 would require changing table base type
-- 
2.17.0


-- 
Kees Cook
Pixel Security
