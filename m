Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8EDC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218012087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218012087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeJJAFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJJAFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC41F30B96E1;
        Tue,  9 Oct 2018 16:47:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B4B35D6A6;
        Tue,  9 Oct 2018 16:47:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/22] KEYS: Provide software public key query function [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Denis Kenzior <denkenz@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>, dhowells@redhat.com,
        denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 17:47:23 +0100
Message-ID: <153910364343.12141.6212013403882194768.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 09 Oct 2018 16:47:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a query function for the software public key implementation.  This
permits information about such a key to be obtained using
query_asymmetric_key() or KEYCTL_PKEY_QUERY.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Denis Kenzior <denkenz@gmail.com>
Tested-by: Denis Kenzior <denkenz@gmail.com>
---

 crypto/asymmetric_keys/public_key.c |   99 +++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 17 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index e929fe1e4106..761bfab352dc 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -59,6 +59,81 @@ static void public_key_destroy(void *payload0, void *payload3)
 	public_key_signature_free(payload3);
 }
 
+/*
+ * Determine the crypto algorithm name.
+ */
+static
+int software_key_determine_akcipher(const char *encoding,
+				    const char *hash_algo,
+				    const struct public_key *pkey,
+				    char alg_name[CRYPTO_MAX_ALG_NAME])
+{
+	int n;
+
+	if (strcmp(encoding, "pkcs1") == 0) {
+		/* The data wangled by the RSA algorithm is typically padded
+		 * and encoded in some manner, such as EMSA-PKCS1-1_5 [RFC3447
+		 * sec 8.2].
+		 */
+		if (!hash_algo)
+			n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+				     "pkcs1pad(%s)",
+				     pkey->pkey_algo);
+		else
+			n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+				     "pkcs1pad(%s,%s)",
+				     pkey->pkey_algo, hash_algo);
+		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
+	}
+
+	if (strcmp(encoding, "raw") == 0) {
+		strcpy(alg_name, pkey->pkey_algo);
+		return 0;
+	}
+
+	return -ENOPKG;
+}
+
+/*
+ * Query information about a key.
+ */
+static int software_key_query(const struct kernel_pkey_params *params,
+			      struct kernel_pkey_query *info)
+{
+	struct crypto_akcipher *tfm;
+	struct public_key *pkey = params->key->payload.data[asym_crypto];
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	int ret, len;
+
+	ret = software_key_determine_akcipher(params->encoding,
+					      params->hash_algo,
+					      pkey, alg_name);
+	if (ret < 0)
+		return ret;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ret = crypto_akcipher_set_pub_key(tfm, pkey->key, pkey->keylen);
+	if (ret < 0)
+		goto error_free_tfm;
+
+	len = crypto_akcipher_maxsize(tfm);
+	info->key_size = len * 8;
+	info->max_data_size = len;
+	info->max_sig_size = len;
+	info->max_enc_size = len;
+	info->max_dec_size = len;
+	info->supported_ops = KEYCTL_SUPPORTS_VERIFY;
+	ret = 0;
+
+error_free_tfm:
+	crypto_free_akcipher(tfm);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+
 /*
  * Verify a signature using a public key.
  */
@@ -69,8 +144,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 	struct crypto_akcipher *tfm;
 	struct akcipher_request *req;
 	struct scatterlist sig_sg, digest_sg;
-	const char *alg_name;
-	char alg_name_buf[CRYPTO_MAX_ALG_NAME];
+	char alg_name[CRYPTO_MAX_ALG_NAME];
 	void *output;
 	unsigned int outlen;
 	int ret;
@@ -81,21 +155,11 @@ int public_key_verify_signature(const struct public_key *pkey,
 	BUG_ON(!sig);
 	BUG_ON(!sig->s);
 
-	if (!sig->digest)
-		return -ENOPKG;
-
-	alg_name = sig->pkey_algo;
-	if (strcmp(sig->pkey_algo, "rsa") == 0) {
-		/* The data wangled by the RSA algorithm is typically padded
-		 * and encoded in some manner, such as EMSA-PKCS1-1_5 [RFC3447
-		 * sec 8.2].
-		 */
-		if (snprintf(alg_name_buf, CRYPTO_MAX_ALG_NAME,
-			     "pkcs1pad(rsa,%s)", sig->hash_algo
-			     ) >= CRYPTO_MAX_ALG_NAME)
-			return -EINVAL;
-		alg_name = alg_name_buf;
-	}
+	ret = software_key_determine_akcipher(sig->encoding,
+					      sig->hash_algo,
+					      pkey, alg_name);
+	if (ret < 0)
+		return ret;
 
 	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
 	if (IS_ERR(tfm))
@@ -167,6 +231,7 @@ struct asymmetric_key_subtype public_key_subtype = {
 	.name_len		= sizeof("public_key") - 1,
 	.describe		= public_key_describe,
 	.destroy		= public_key_destroy,
+	.query			= software_key_query,
 	.verify_signature	= public_key_verify_signature_2,
 };
 EXPORT_SYMBOL_GPL(public_key_subtype);

