Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeCZXDM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 19:03:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41836 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbeCZXDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 19:03:10 -0400
X-Google-Smtp-Source: AIpwx48okaRoDzDx+etZ1jWVenu93RlLeH1cfeEbowvtJGCgAlaB9olMgj/6+gZu9ROhlj5q1/t+tw==
Date: Mon, 26 Mar 2018 16:03:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "crypto/ecc: Remove stack VLA usage"
Message-ID: <20180326230308.GA27259@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 14de52112ee70ca289fa77bf2d9cbc79fd2c811f.

The solution was incomplete and inefficient. This will be fixed
correctly in the next patch.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ecc.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 9c066b5ac12d..18f32f2a5e1c 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1025,7 +1025,9 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 {
 	int ret = 0;
 	struct ecc_point *product, *pk;
-	u64 *priv, *rand_z;
+	u64 priv[ndigits];
+	u64 rand_z[ndigits];
+	unsigned int nbytes;
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
 	if (!private_key || !public_key || !curve) {
@@ -1033,22 +1035,14 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto out;
 	}
 
-	priv = kmalloc_array(ndigits, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
-	rand_z = kmalloc_array(ndigits, sizeof(*rand_z), GFP_KERNEL);
-	if (!rand_z) {
-		ret = -ENOMEM;
-		goto kfree_out;
-	}
+	get_random_bytes(rand_z, nbytes);
 
 	pk = ecc_alloc_point(ndigits);
 	if (!pk) {
 		ret = -ENOMEM;
-		goto kfree_out;
+		goto out;
 	}
 
 	product = ecc_alloc_point(ndigits);
@@ -1057,8 +1051,6 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto err_alloc_product;
 	}
 
-	get_random_bytes(rand_z, ndigits << ECC_DIGITS_TO_BYTES_SHIFT);
-
 	ecc_swap_digits(public_key, pk->x, ndigits);
 	ecc_swap_digits(&public_key[ndigits], pk->y, ndigits);
 	ecc_swap_digits(private_key, priv, ndigits);
@@ -1073,9 +1065,6 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 	ecc_free_point(product);
 err_alloc_product:
 	ecc_free_point(pk);
-kfree_out:
-	kzfree(priv);
-	kzfree(rand_z);
 out:
 	return ret;
 }
-- 
2.7.4


-- 
Kees Cook
Pixel Security
