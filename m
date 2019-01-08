Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA10EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A461E2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975632;
	bh=UyuG+mvMzQt2zRN7FIuJCF69QmsxcHhrEJcp6tZC0mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jfX2iMPPYvYiHFfAlPTJTUUtPZXrfby40HLuT1o1v3kay90ajQOuXBru6iyWG3DPf
	 +Eh5vB01uY5UipJ+rFcSb6TphqUVv4ulLa9HvzleVkkOqCaj8G4bSDA+5O6YbEaKGG
	 iXsgKAVjh9fO/7h4LurkuhJSoLz/ip2hbLHY3qmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfAHT1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfAHT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A29F217D9;
        Tue,  8 Jan 2019 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975625;
        bh=UyuG+mvMzQt2zRN7FIuJCF69QmsxcHhrEJcp6tZC0mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8atheOzAkyGz6RTsjcomNEgNPWxrH4vVD58TVR2WV9IYQo1lbv2W3z7K39H7IHjU
         s+xjvG38nlThS1Ea5f20oYsY6BYOnZHEZQKMuksEd8ZRYKPaKL1/fWsh7xLxkNV+DG
         L7Vn9HJItzJPk6wG6DjVsoeSH8BTenZOPXn21g5w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        kernel-hardening@lists.openwall.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 020/117] crypto: ecc - regularize scalar for scalar multiplication
Date:   Tue,  8 Jan 2019 14:24:48 -0500
Message-Id: <20190108192628.121270-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Chikunov <vt@altlinux.org>

[ Upstream commit 3da2c1dfdb802b184eea0653d1e589515b52d74b ]

ecc_point_mult is supposed to be used with a regularized scalar,
otherwise, it's possible to deduce the position of the top bit of the
scalar with timing attack. This is important when the scalar is a
private key.

ecc_point_mult is already using a regular algorithm (i.e. having an
operation flow independent of the input scalar) but regularization step
is not implemented.

Arrange scalar to always have fixed top bit by adding a multiple of the
curve order (n).

References:
The constant time regularization step is based on micro-ecc by Kenneth
MacKay and also referenced in the literature (Bernstein, D. J., & Lange,
T. (2017). Montgomery curves and the Montgomery ladder. (Cryptology
ePrint Archive; Vol. 2017/293). s.l.: IACR. Chapter 4.6.2.)

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Cc: kernel-hardening@lists.openwall.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

