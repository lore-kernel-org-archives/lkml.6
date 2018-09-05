Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325692077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325692077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeIFC2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbeIFC2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFEF740241E8;
        Wed,  5 Sep 2018 21:56:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2372166BA1;
        Wed,  5 Sep 2018 21:56:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/22] KEYS: asym_tpm: Implement signature verification
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:56:29 +0100
Message-ID: <153618458953.7946.5116691522328819991.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 21:56:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 21:56:30 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This patch implements the verify_signature operation.  The public key
portion extracted from the TPM key blob is used.  The operation is
performed entirely in software using the crypto API.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/asym_tpm.c |  106 +++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 6f5d5cf98910..a38ba375675e 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -15,6 +15,7 @@
 #include <keys/asymmetric-subtype.h>
 #include <keys/trusted.h>
 #include <crypto/asym_tpm_subtype.h>
+#include <crypto/public_key.h>
 
 #define TPM_ORD_FLUSHSPECIFIC	186
 #define TPM_ORD_LOADKEY2	65
@@ -286,12 +287,16 @@ static uint32_t derive_pub_key(const void *pub_key, uint32_t len, uint8_t *buf)
 static int determine_akcipher(const char *encoding, const char *hash_algo,
 			      char alg_name[CRYPTO_MAX_ALG_NAME])
 {
-	/* TODO: We don't support hashing yet */
-	if (hash_algo)
-		return -ENOPKG;
-
 	if (strcmp(encoding, "pkcs1") == 0) {
-		strcpy(alg_name, "pkcs1pad(rsa)");
+		if (!hash_algo) {
+			strcpy(alg_name, "pkcs1pad(rsa)");
+			return 0;
+		}
+
+		if (snprintf(alg_name, CRYPTO_MAX_ALG_NAME, "pkcs1pad(rsa,%s)",
+			     hash_algo) >= CRYPTO_MAX_ALG_NAME)
+			return -EINVAL;
+
 		return 0;
 	}
 
@@ -342,7 +347,8 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 	info->max_dec_size = tk->key_len / 8;
 
 	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
-			      KEYCTL_SUPPORTS_DECRYPT;
+			      KEYCTL_SUPPORTS_DECRYPT |
+			      KEYCTL_SUPPORTS_VERIFY;
 
 	ret = 0;
 error_free_tfm:
@@ -487,6 +493,93 @@ static int tpm_key_eds_op(struct kernel_pkey_params *params,
 	return ret;
 }
 
+/*
+ * Verify a signature using a public key.
+ */
+static int tpm_key_verify_signature(const struct key *key,
+				    const struct public_key_signature *sig)
+{
+	const struct tpm_key *tk = key->payload.data[asym_crypto];
+	struct crypto_wait cwait;
+	struct crypto_akcipher *tfm;
+	struct akcipher_request *req;
+	struct scatterlist sig_sg, digest_sg;
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
+	uint32_t der_pub_key_len;
+	void *output;
+	unsigned int outlen;
+	int ret;
+
+	pr_devel("==>%s()\n", __func__);
+
+	BUG_ON(!tk);
+	BUG_ON(!sig);
+	BUG_ON(!sig->s);
+
+	if (!sig->digest)
+		return -ENOPKG;
+
+	ret = determine_akcipher(sig->encoding, sig->hash_algo, alg_name);
+	if (ret < 0)
+		return ret;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
+					 der_pub_key);
+
+	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
+	if (ret < 0)
+		goto error_free_tfm;
+
+	ret = -ENOMEM;
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto error_free_tfm;
+
+	ret = -ENOMEM;
+	outlen = crypto_akcipher_maxsize(tfm);
+	output = kmalloc(outlen, GFP_KERNEL);
+	if (!output)
+		goto error_free_req;
+
+	sg_init_one(&sig_sg, sig->s, sig->s_size);
+	sg_init_one(&digest_sg, output, outlen);
+	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
+				   outlen);
+	crypto_init_wait(&cwait);
+	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+
+	/* Perform the verification calculation.  This doesn't actually do the
+	 * verification, but rather calculates the hash expected by the
+	 * signature and returns that to us.
+	 */
+	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
+	if (ret)
+		goto out_free_output;
+
+	/* Do the actual verification step. */
+	if (req->dst_len != sig->digest_size ||
+	    memcmp(sig->digest, output, sig->digest_size) != 0)
+		ret = -EKEYREJECTED;
+
+out_free_output:
+	kfree(output);
+error_free_req:
+	akcipher_request_free(req);
+error_free_tfm:
+	crypto_free_akcipher(tfm);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	if (WARN_ON_ONCE(ret > 0))
+		ret = -EINVAL;
+	return ret;
+}
+
 /*
  * Parse enough information out of TPM_KEY structure:
  * TPM_STRUCT_VER -> 4 bytes
@@ -645,6 +738,7 @@ struct asymmetric_key_subtype asym_tpm_subtype = {
 	.destroy		= asym_tpm_destroy,
 	.query			= tpm_key_query,
 	.eds_op			= tpm_key_eds_op,
+	.verify_signature	= tpm_key_verify_signature,
 };
 EXPORT_SYMBOL_GPL(asym_tpm_subtype);
 

