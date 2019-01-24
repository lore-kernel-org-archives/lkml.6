Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BC8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F80120663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358815;
	bh=RKtcPw6A11Ir0l9fOuyX1aLbNvD+GhQwvlpn7evjnP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1PD7ZXb5TgIuS/G8hEVP94KHWUZe0fW0jUfcpLKjiarc8A2f3RrBGKV90cLPVn+X7
	 /S/WEn+jFaBFr6PzR/MPXI3UsNTOdfmhzliLjqApIfdUJ1YyJuJGDboUBL2yoN5gTn
	 3yJjJmYslH9c2NR6PuKTmlv5bJ+vglC2sanKZm08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfAXTkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731578AbfAXTkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A8F218D0;
        Thu, 24 Jan 2019 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358807;
        bh=RKtcPw6A11Ir0l9fOuyX1aLbNvD+GhQwvlpn7evjnP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w674FjnCShO/E03uEJ6n9i6SVU/89+rmO9kMHku/lq9Rx4LIvAZoNnb6MdwALe7S1
         mGbJjbRZGmQK67KLBo6tgoBHQMmlV61Zib184qBrnvDXrA0LI+qdXnC+2sTrJzVrDx
         IT/s/xpSblD1OgHhxaAfS5D9RVwTBR8Uy49orJVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        kernel-hardening@lists.openwall.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 032/127] crypto: ecc - regularize scalar for scalar multiplication
Date:   Thu, 24 Jan 2019 20:19:38 +0100
Message-Id: <20190124190213.666243105@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



