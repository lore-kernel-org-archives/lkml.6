Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9901B204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9901B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKERzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:55:14 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:37128 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKERzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:55:14 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 34C3372CC68;
        Mon,  5 Nov 2018 11:36:38 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id D00594A4A29;
        Mon,  5 Nov 2018 11:36:37 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] crypto: ecc - check for invalid values in the key verification test
Date:   Mon,  5 Nov 2018 11:36:18 +0300
Message-Id: <20181105083618.29102-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently used scalar multiplication algorithm (Matthieu Rivain, 2011)
have invalid values for scalar == 1, n-1, and for regularized version
n-2, which was previously not checked. Verify that they are not used as
private keys.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/ecc.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index adcce310f646..ed1237115066 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -912,30 +912,43 @@ static inline void ecc_swap_digits(const u64 *in, u64 *out,
 		out[i] = __swab64(in[ndigits - 1 - i]);
 }
 
-int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
-		     const u64 *private_key, unsigned int private_key_len)
+static int __ecc_is_key_valid(const struct ecc_curve *curve,
+			      const u64 *private_key, unsigned int ndigits)
 {
-	int nbytes;
-	const struct ecc_curve *curve = ecc_get_curve(curve_id);
+	u64 one[ECC_MAX_DIGITS] = { 1, };
+	u64 res[ECC_MAX_DIGITS];
 
 	if (!private_key)
 		return -EINVAL;
 
-	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
-
-	if (private_key_len != nbytes)
+	if (curve->g.ndigits != ndigits)
 		return -EINVAL;
 
-	if (vli_is_zero(private_key, ndigits))
+	/* Make sure the private key is in the range [2, n-3]. */
+	if (vli_cmp(one, private_key, ndigits) != -1)
 		return -EINVAL;
-
-	/* Make sure the private key is in the range [1, n-1]. */
-	if (vli_cmp(curve->n, private_key, ndigits) != 1)
+	vli_sub(res, curve->n, one, ndigits);
+	vli_sub(res, res, one, ndigits);
+	if (vli_cmp(res, private_key, ndigits) != 1)
 		return -EINVAL;
 
 	return 0;
 }
 
+int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
+		     const u64 *private_key, unsigned int private_key_len)
+{
+	int nbytes;
+	const struct ecc_curve *curve = ecc_get_curve(curve_id);
+
+	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+
+	if (private_key_len != nbytes)
+		return -EINVAL;
+
+	return __ecc_is_key_valid(curve, private_key, ndigits);
+}
+
 /*
  * ECC private keys are generated using the method of extra random bits,
  * equivalent to that described in FIPS 186-4, Appendix B.4.1.
@@ -979,11 +992,8 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 	if (err)
 		return err;
 
-	if (vli_is_zero(priv, ndigits))
-		return -EINVAL;
-
-	/* Make sure the private key is in the range [1, n-1]. */
-	if (vli_cmp(curve->n, priv, ndigits) != 1)
+	/* Make sure the private key is in the valid range. */
+	if (__ecc_is_key_valid(curve, priv, ndigits))
 		return -EINVAL;
 
 	ecc_swap_digits(priv, privkey, ndigits);
-- 
2.11.0

