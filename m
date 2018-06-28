Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4D5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C20275EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C20275EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965310AbeF1PXW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:23:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53459 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965279AbeF1PWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:22:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9728320737; Thu, 28 Jun 2018 17:22:04 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id 60EC6203B4;
        Thu, 28 Jun 2018 17:22:04 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Ofer Heifetz <oferh@marvell.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, igall@marvell.com,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH 2/5] crypto: inside-secure - hmac(md5) support
Date:   Thu, 28 Jun 2018 17:21:54 +0200
Message-Id: <20180628152157.23769-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628152157.23769-1-antoine.tenart@bootlin.com>
References: <20180628152157.23769-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofer Heifetz <oferh@marvell.com>

This patch adds support for the hmac(md5) algorithm in the Inside Secure
SafeXcel cryptographic engine driver.

Signed-off-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c      |  3 +-
 drivers/crypto/inside-secure/safexcel.h      |  1 +
 drivers/crypto/inside-secure/safexcel_hash.c | 57 ++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 54f5d2c131a9..ea8070c33743 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -406,7 +406,7 @@ static int safexcel_hw_init(struct safexcel_crypto_priv *priv)
 		val |= EIP197_PROTOCOL_ENCRYPT_ONLY | EIP197_PROTOCOL_HASH_ONLY;
 		val |= EIP197_PROTOCOL_ENCRYPT_HASH | EIP197_PROTOCOL_HASH_DECRYPT;
 		val |= EIP197_ALG_AES_ECB | EIP197_ALG_AES_CBC;
-		val |= EIP197_ALG_MD5;
+		val |= EIP197_ALG_MD5 | EIP197_ALG_HMAC_MD5;
 		val |= EIP197_ALG_SHA1 | EIP197_ALG_HMAC_SHA1;
 		val |= EIP197_ALG_SHA2 | EIP197_ALG_HMAC_SHA2;
 		writel(val, EIP197_PE(priv) + EIP197_PE_EIP96_FUNCTION_EN(pe));
@@ -848,6 +848,7 @@ static struct safexcel_alg_template *safexcel_algs[] = {
 	&safexcel_alg_sha256,
 	&safexcel_alg_sha384,
 	&safexcel_alg_sha512,
+	&safexcel_alg_hmac_md5,
 	&safexcel_alg_hmac_sha1,
 	&safexcel_alg_hmac_sha224,
 	&safexcel_alg_hmac_sha256,
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index fcd26ae70166..19610b03bceb 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -698,6 +698,7 @@ extern struct safexcel_alg_template safexcel_alg_sha224;
 extern struct safexcel_alg_template safexcel_alg_sha256;
 extern struct safexcel_alg_template safexcel_alg_sha384;
 extern struct safexcel_alg_template safexcel_alg_sha512;
+extern struct safexcel_alg_template safexcel_alg_hmac_md5;
 extern struct safexcel_alg_template safexcel_alg_hmac_sha1;
 extern struct safexcel_alg_template safexcel_alg_hmac_sha224;
 extern struct safexcel_alg_template safexcel_alg_hmac_sha256;
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 4fec8fe07044..46aac55c0b31 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -1619,3 +1619,60 @@ struct safexcel_alg_template safexcel_alg_md5 = {
 		},
 	},
 };
+
+static int safexcel_hmac_md5_init(struct ahash_request *areq)
+{
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+
+	safexcel_md5_init(areq);
+	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	return 0;
+}
+
+static int safexcel_hmac_md5_setkey(struct crypto_ahash *tfm, const u8 *key,
+				     unsigned int keylen)
+{
+	return safexcel_hmac_alg_setkey(tfm, key, keylen, "safexcel-md5",
+					MD5_DIGEST_SIZE);
+}
+
+static int safexcel_hmac_md5_digest(struct ahash_request *areq)
+{
+	int ret = safexcel_hmac_md5_init(areq);
+
+	if (ret)
+		return ret;
+
+	return safexcel_ahash_finup(areq);
+}
+
+struct safexcel_alg_template safexcel_alg_hmac_md5 = {
+	.type = SAFEXCEL_ALG_TYPE_AHASH,
+	.engines = EIP97IES | EIP197B | EIP197D,
+	.alg.ahash = {
+		.init = safexcel_hmac_md5_init,
+		.update = safexcel_ahash_update,
+		.final = safexcel_ahash_final,
+		.finup = safexcel_ahash_finup,
+		.digest = safexcel_hmac_md5_digest,
+		.setkey = safexcel_hmac_md5_setkey,
+		.export = safexcel_ahash_export,
+		.import = safexcel_ahash_import,
+		.halg = {
+			.digestsize = MD5_DIGEST_SIZE,
+			.statesize = sizeof(struct safexcel_ahash_export_state),
+			.base = {
+				.cra_name = "hmac(md5)",
+				.cra_driver_name = "safexcel-hmac-md5",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct safexcel_ahash_ctx),
+				.cra_init = safexcel_ahash_cra_init,
+				.cra_exit = safexcel_ahash_cra_exit,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
-- 
2.17.1

