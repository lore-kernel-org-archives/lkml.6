Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC164C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981E62073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981E62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeIFC2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE80640201BD;
        Wed,  5 Sep 2018 21:55:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5A6F2166BA1;
        Wed,  5 Sep 2018 21:55:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/22] KEYS: asym_tpm: Implement encryption operation
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:55:50 +0100
Message-ID: <153618455041.7946.3760011164296173162.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:55:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:55:51 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This patch impelements the pkey_encrypt operation.  The public key
portion extracted from the TPM key blob is used.  The operation is
performed entirely in software using the crypto API.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/asym_tpm.c |   84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 837472d107d5..8edca3c4c193 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -165,6 +165,8 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 	info->max_enc_size = len;
 	info->max_dec_size = tk->key_len / 8;
 
+	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT;
+
 	ret = 0;
 error_free_tfm:
 	crypto_free_akcipher(tfm);
@@ -172,6 +174,87 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 	return ret;
 }
 
+/*
+ * Encryption operation is performed with the public key.  Hence it is done
+ * in software
+ */
+static int tpm_key_encrypt(struct tpm_key *tk,
+			   struct kernel_pkey_params *params,
+			   const void *in, void *out)
+{
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	struct crypto_akcipher *tfm;
+	struct akcipher_request *req;
+	struct crypto_wait cwait;
+	struct scatterlist in_sg, out_sg;
+	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
+	uint32_t der_pub_key_len;
+	int ret;
+
+	pr_devel("==>%s()\n", __func__);
+
+	ret = determine_akcipher(params->encoding, params->hash_algo, alg_name);
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
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto error_free_tfm;
+
+	sg_init_one(&in_sg, in, params->in_len);
+	sg_init_one(&out_sg, out, params->out_len);
+	akcipher_request_set_crypt(req, &in_sg, &out_sg, params->in_len,
+				   params->out_len);
+	crypto_init_wait(&cwait);
+	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+
+	ret = crypto_akcipher_encrypt(req);
+	ret = crypto_wait_req(ret, &cwait);
+
+	if (ret == 0)
+		ret = req->dst_len;
+
+	akcipher_request_free(req);
+error_free_tfm:
+	crypto_free_akcipher(tfm);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Do encryption, decryption and signing ops.
+ */
+static int tpm_key_eds_op(struct kernel_pkey_params *params,
+			  const void *in, void *out)
+{
+	struct tpm_key *tk = params->key->payload.data[asym_crypto];
+	int ret = -EOPNOTSUPP;
+
+	/* Perform the encryption calculation. */
+	switch (params->op) {
+	case kernel_pkey_encrypt:
+		ret = tpm_key_encrypt(tk, params, in, out);
+		break;
+	default:
+		BUG();
+	}
+
+	return ret;
+}
+
 /*
  * Parse enough information out of TPM_KEY structure:
  * TPM_STRUCT_VER -> 4 bytes
@@ -329,6 +412,7 @@ struct asymmetric_key_subtype asym_tpm_subtype = {
 	.describe		= asym_tpm_describe,
 	.destroy		= asym_tpm_destroy,
 	.query			= tpm_key_query,
+	.eds_op			= tpm_key_eds_op,
 };
 EXPORT_SYMBOL_GPL(asym_tpm_subtype);
 

