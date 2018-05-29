Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937033AbeE2WmN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:42:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35172 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933907AbeE2WmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:42:11 -0400
X-Google-Smtp-Source: ADUXVKI9CowKQcxDZik+ktNswQovs35Vuehak3I1XRM1spTwny3rHcS4w12kJ9zCuyG7nI19B6nUyA==
Date: Tue, 29 May 2018 15:42:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        Ivan Djelic <ivan.djelic@parrot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bch: Remove VLA usage
Message-ID: <20180529224207.GA13354@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this removes
the on-stack working buffers in favor of pre-allocated working buffers
(which were already used in other places). Since these routines must
already be serialized (since they work on bch->ecc_buf), adding the usage
of bch->ecc_work would be similarly safe. Additionally, since "max m" is
only 15, this was adjusted to just use a fixed size array in those cases.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is directed at linux-mtd because it's the only user of this library
and it's how it originally entered the kernel tree...
---
 include/linux/bch.h |  4 ++--
 lib/bch.c           | 27 +++++++++++++++------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/bch.h b/include/linux/bch.h
index 295b4ef153bb..4d46e6a73319 100644
--- a/include/linux/bch.h
+++ b/include/linux/bch.h
@@ -39,7 +39,7 @@
  * @a_log_tab:  Galois field GF(2^m) log lookup table
  * @mod8_tab:   remainder generator polynomial lookup tables
  * @ecc_buf:    ecc parity words buffer
- * @ecc_buf2:   ecc parity words buffer
+ * @ecc_work:   ecc parity words working buffer
  * @xi_tab:     GF(2^m) base for solving degree 2 polynomial roots
  * @syn:        syndrome buffer
  * @cache:      log-based polynomial representation buffer
@@ -57,7 +57,7 @@ struct bch_control {
 	uint16_t       *a_log_tab;
 	uint32_t       *mod8_tab;
 	uint32_t       *ecc_buf;
-	uint32_t       *ecc_buf2;
+	uint32_t       *ecc_work;
 	unsigned int   *xi_tab;
 	unsigned int   *syn;
 	int            *cache;
diff --git a/lib/bch.c b/lib/bch.c
index bc89dfe4d1b3..f14eac93ecc4 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -78,10 +78,12 @@
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
 
 #define BCH_ECC_WORDS(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 32)
@@ -187,7 +189,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 	const unsigned int l = BCH_ECC_WORDS(bch)-1;
 	unsigned int i, mlen;
 	unsigned long m;
-	uint32_t w, r[l+1];
+	uint32_t w;
 	const uint32_t * const tab0 = bch->mod8_tab;
 	const uint32_t * const tab1 = tab0 + 256*(l+1);
 	const uint32_t * const tab2 = tab1 + 256*(l+1);
@@ -198,7 +200,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 		/* load ecc parity bytes into internal 32-bit buffer */
 		load_ecc8(bch, bch->ecc_buf, ecc);
 	} else {
-		memset(bch->ecc_buf, 0, sizeof(r));
+		memset(bch->ecc_work, 0, bch->ecc_bytes);
 	}
 
 	/* process first unaligned data bytes */
@@ -215,7 +217,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 	mlen  = len/4;
 	data += 4*mlen;
 	len  -= 4*mlen;
-	memcpy(r, bch->ecc_buf, sizeof(r));
+	memcpy(bch->ecc_work, bch->ecc_buf, bch->ecc_bytes);
 
 	/*
 	 * split each 32-bit word into 4 polynomials of weight 8 as follows:
@@ -229,6 +231,8 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 	 * xxxxxxxx  yyyyyyyy  zzzzzzzz  tttttttt  mod g = r0^r1^r2^r3
 	 */
 	while (mlen--) {
+		uint32_t *r = bch->ecc_work;
+
 		/* input data is read in big-endian format */
 		w = r[0]^cpu_to_be32(*pdata++);
 		p0 = tab0 + (l+1)*((w >>  0) & 0xff);
@@ -241,7 +245,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 
 		r[l] = p0[l]^p1[l]^p2[l]^p3[l];
 	}
-	memcpy(bch->ecc_buf, r, sizeof(r));
+	memcpy(bch->ecc_buf, bch->ecc_work, bch->ecc_bytes);
 
 	/* process last unaligned bytes */
 	if (len)
@@ -434,7 +438,7 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
 {
 	const int m = GF_M(bch);
 	unsigned int tmp, mask;
-	int rem, c, r, p, k, param[m];
+	int rem, c, r, p, k, param[BCH_MAX_M];
 
 	k = 0;
 	mask = 1 << m;
@@ -1009,10 +1013,10 @@ int decode_bch(struct bch_control *bch, const uint8_t *data, unsigned int len,
 		}
 		/* load received ecc or assume it was XORed in calc_ecc */
 		if (recv_ecc) {
-			load_ecc8(bch, bch->ecc_buf2, recv_ecc);
+			load_ecc8(bch, bch->ecc_work, recv_ecc);
 			/* XOR received and calculated ecc */
 			for (i = 0, sum = 0; i < (int)ecc_words; i++) {
-				bch->ecc_buf[i] ^= bch->ecc_buf2[i];
+				bch->ecc_buf[i] ^= bch->ecc_work[i];
 				sum |= bch->ecc_buf[i];
 			}
 			if (!sum)
@@ -1114,7 +1118,7 @@ static int build_deg2_base(struct bch_control *bch)
 {
 	const int m = GF_M(bch);
 	int i, j, r;
-	unsigned int sum, x, y, remaining, ak = 0, xi[m];
+	unsigned int sum, x, y, remaining, ak = 0, xi[BCH_MAX_M];
 
 	/* find k s.t. Tr(a^k) = 1 and 0 <= k < m */
 	for (i = 0; i < m; i++) {
@@ -1254,7 +1258,6 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
 	struct bch_control *bch = NULL;
 
 	const int min_m = 5;
-	const int max_m = 15;
 
 	/* default primitive polynomials */
 	static const unsigned int prim_poly_tab[] = {
@@ -1270,7 +1273,7 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
 		goto fail;
 	}
 #endif
-	if ((m < min_m) || (m > max_m))
+	if ((m < min_m) || (m > BCH_MAX_M))
 		/*
 		 * values of m greater than 15 are not currently supported;
 		 * supporting m > 15 would require changing table base type
@@ -1300,7 +1303,7 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
 	bch->a_log_tab = bch_alloc((1+bch->n)*sizeof(*bch->a_log_tab), &err);
 	bch->mod8_tab  = bch_alloc(words*1024*sizeof(*bch->mod8_tab), &err);
 	bch->ecc_buf   = bch_alloc(words*sizeof(*bch->ecc_buf), &err);
-	bch->ecc_buf2  = bch_alloc(words*sizeof(*bch->ecc_buf2), &err);
+	bch->ecc_work  = bch_alloc(words*sizeof(*bch->ecc_work), &err);
 	bch->xi_tab    = bch_alloc(m*sizeof(*bch->xi_tab), &err);
 	bch->syn       = bch_alloc(2*t*sizeof(*bch->syn), &err);
 	bch->cache     = bch_alloc(2*t*sizeof(*bch->cache), &err);
@@ -1349,7 +1352,7 @@ void free_bch(struct bch_control *bch)
 		kfree(bch->a_log_tab);
 		kfree(bch->mod8_tab);
 		kfree(bch->ecc_buf);
-		kfree(bch->ecc_buf2);
+		kfree(bch->ecc_work);
 		kfree(bch->xi_tab);
 		kfree(bch->syn);
 		kfree(bch->cache);
-- 
2.17.0


-- 
Kees Cook
Pixel Security
