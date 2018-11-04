Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966E3ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFE020854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFE020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeKDWtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 17:49:36 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:44590 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbeKDWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 17:49:36 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 28A6572CC68;
        Sun,  4 Nov 2018 16:34:32 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0227D4A4A29;
        Sun,  4 Nov 2018 16:34:31 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] crypto: ecc - regularize scalar for scalar multiplication
Date:   Sun,  4 Nov 2018 16:34:20 +0300
Message-Id: <20181104133420.15783-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ecc_point_mult is supposed to be used with a regularized scalar,
otherwise, it's possible to deduce the position of the top bit of the
scalar with timing attack.

ecc_point_mult is already using a regular algorithm (i.e. having an
operation flow independent of the input scalar) but regularization step
is forgotten.

Regularization step is based on micro-ecc by Kenneth MacKay.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/ecc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 8facafd67802..adcce310f646 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -842,15 +842,23 @@ static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
 
 static void ecc_point_mult(struct ecc_point *result,
 			   const struct ecc_point *point, const u64 *scalar,
-			   u64 *initial_z, u64 *curve_prime,
+			   u64 *initial_z, const struct ecc_curve *curve,
 			   unsigned int ndigits)
 {
 	/* R0 and R1 */
 	u64 rx[2][ECC_MAX_DIGITS];
 	u64 ry[2][ECC_MAX_DIGITS];
 	u64 z[ECC_MAX_DIGITS];
+	u64 sk[2][ECC_MAX_DIGITS];
+	u64 *curve_prime = curve->p;
 	int i, nb;
-	int num_bits = vli_num_bits(scalar, ndigits);
+	int num_bits;
+	int carry;
+
+	carry = vli_add(sk[0], scalar, curve->n, ndigits);
+	vli_add(sk[1], sk[0], curve->n, ndigits);
+	scalar = sk[!carry];
+	num_bits = sizeof(u64) * ndigits * 8 + 1;
 
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
@@ -1004,7 +1012,7 @@ int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
 		goto out;
 	}
 
-	ecc_point_mult(pk, &curve->g, priv, NULL, curve->p, ndigits);
+	ecc_point_mult(pk, &curve->g, priv, NULL, curve, ndigits);
 	if (ecc_point_is_zero(pk)) {
 		ret = -EAGAIN;
 		goto err_free_point;
@@ -1090,7 +1098,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto err_alloc_product;
 	}
 
-	ecc_point_mult(product, pk, priv, rand_z, curve->p, ndigits);
+	ecc_point_mult(product, pk, priv, rand_z, curve, ndigits);
 
 	ecc_swap_digits(product->x, secret, ndigits);
 
-- 
2.11.0

