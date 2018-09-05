Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31EE2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31EE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIFC1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:27:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727621AbeIFC1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1786804B4B9;
        Wed,  5 Sep 2018 21:55:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7B6C2166BA1;
        Wed,  5 Sep 2018 21:55:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/22] KEYS: Implement encrypt,
 decrypt and sign for software asymmetric key
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:55:04 +0100
Message-ID: <153618450412.7946.3727422000233525983.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 21:55:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 21:55:05 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the encrypt, decrypt and sign operations for the software
asymmetric key subtype.  This mostly involves offloading the call to the
crypto layer.

Note that the decrypt and sign operations require a private key to be
supplied.  Encrypt (and also verify) will work with either a public or a
private key.  A public key can be supplied with an X.509 certificate and a
private key can be supplied using a PKCS#8 blob:

	# j=`openssl pkcs8 -in ~/pkcs7/firmwarekey2.priv -topk8 -nocrypt -outform DER | keyctl padd asymmetric foo @s`
	# keyctl pkey_query $j - enc=pkcs1
	key_size=4096
	max_data_size=512
	max_sig_size=512
	max_enc_size=512
	max_dec_size=512
	encrypt=y
	decrypt=y
	sign=y
	verify=y
	# keyctl pkey_encrypt $j 0 data enc=pkcs1 >/tmp/enc
	# keyctl pkey_decrypt $j 0 /tmp/enc enc=pkcs1 >/tmp/dec
	# cmp data /tmp/dec
	# keyctl pkey_sign $j 0 data enc=pkcs1 hash=sha1 >/tmp/sig
	# keyctl pkey_verify $j 0 data /tmp/sig enc=pkcs1 hash=sha1
	#

Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/public_key.c |   82 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index f2dc27897319..f5d85b47fcc6 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -130,7 +130,11 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	info->max_sig_size = len;
 	info->max_enc_size = len;
 	info->max_dec_size = len;
-	info->supported_ops = KEYCTL_SUPPORTS_VERIFY;
+	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
+			       KEYCTL_SUPPORTS_VERIFY);
+	if (pkey->key_is_private)
+		info->supported_ops |= (KEYCTL_SUPPORTS_DECRYPT |
+					KEYCTL_SUPPORTS_SIGN);
 	ret = 0;
 
 error_free_tfm:
@@ -139,6 +143,81 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	return ret;
 }
 
+/*
+ * Do encryption, decryption and signing ops.
+ */
+static int software_key_eds_op(struct kernel_pkey_params *params,
+			       const void *in, void *out)
+{
+	const struct public_key *pkey = params->key->payload.data[asym_crypto];
+	struct akcipher_request *req;
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	struct scatterlist in_sg, out_sg;
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	int ret;
+
+	pr_devel("==>%s()\n", __func__);
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
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto error_free_tfm;
+
+	if (pkey->key_is_private)
+		ret = crypto_akcipher_set_priv_key(tfm,
+						   pkey->key, pkey->keylen);
+	else
+		ret = crypto_akcipher_set_pub_key(tfm,
+						  pkey->key, pkey->keylen);
+	if (ret)
+		goto error_free_req;
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
+	/* Perform the encryption calculation. */
+	switch (params->op) {
+	case kernel_pkey_encrypt:
+		ret = crypto_akcipher_encrypt(req);
+		break;
+	case kernel_pkey_decrypt:
+		ret = crypto_akcipher_decrypt(req);
+		break;
+	case kernel_pkey_sign:
+		ret = crypto_akcipher_sign(req);
+		break;
+	default:
+		BUG();
+	}
+
+	ret = crypto_wait_req(ret, &cwait);
+	if (ret == 0)
+		ret = req->dst_len;
+
+error_free_req:
+	akcipher_request_free(req);
+error_free_tfm:
+	crypto_free_akcipher(tfm);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+
 /*
  * Verify a signature using a public key.
  */
@@ -242,6 +321,7 @@ struct asymmetric_key_subtype public_key_subtype = {
 	.describe		= public_key_describe,
 	.destroy		= public_key_destroy,
 	.query			= software_key_query,
+	.eds_op			= software_key_eds_op,
 	.verify_signature	= public_key_verify_signature_2,
 };
 EXPORT_SYMBOL_GPL(public_key_subtype);

