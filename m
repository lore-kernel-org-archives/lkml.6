Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6579C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE382087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE382087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJJAGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:06:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbeJJAGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCC2B83F46;
        Tue,  9 Oct 2018 16:48:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3196718123;
        Tue,  9 Oct 2018 16:48:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/22] KEYS: asym_tpm: Implement pkey_query [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Denis Kenzior <denkenz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Holtmann <marcel@holtmann.org>, dhowells@redhat.com,
        denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 17:48:25 +0100
Message-ID: <153910370539.12141.18085968275706786505.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 09 Oct 2018 16:48:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This commit implements the pkey_query operation.  This is accomplished
by utilizing the public key portion to obtain max encryption size
information for the operations that utilize the public key (encrypt,
verify).  The private key size extracted from the TPM_Key data structure
is used to fill the information where the private key is used (decrypt,
sign).

The kernel uses a DER/BER format for public keys and does not support
setting the key via the raw binary form.  To get around this a simple
DER/BER formatter is implemented which stores the DER/BER formatted key
and exponent in a temporary buffer for use by the crypto API.

The only exponent supported currently is 65537.  This holds true for
other Linux TPM tools such as 'create_tpm_key' and
trousers-openssl_tpm_engine.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
---

 crypto/asymmetric_keys/asym_tpm.c |  135 +++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 308c51e055a4..837472d107d5 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -7,10 +7,24 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/tpm.h>
+#include <crypto/akcipher.h>
 #include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
 #include <crypto/asym_tpm_subtype.h>
 
+/*
+ * Maximum buffer size for the BER/DER encoded public key.  The public key
+ * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048
+ * bit key and e is usually 65537
+ * The encoding overhead is:
+ * - max 4 bytes for SEQUENCE
+ *   - max 4 bytes for INTEGER n type/length
+ *     - 257 bytes of n
+ *   - max 2 bytes for INTEGER e type/length
+ *     - 3 bytes of e
+ */
+#define PUB_KEY_BUF_SIZE (4 + 4 + 257 + 2 + 3)
+
 /*
  * Provide a part of a description of the key for /proc/keys.
  */
@@ -38,6 +52,126 @@ static void asym_tpm_destroy(void *payload0, void *payload3)
 	kfree(tk);
 }
 
+/* How many bytes will it take to encode the length */
+static inline uint32_t definite_length(uint32_t len)
+{
+	if (len <= 127)
+		return 1;
+	if (len <= 255)
+		return 2;
+	return 3;
+}
+
+static inline uint8_t *encode_tag_length(uint8_t *buf, uint8_t tag,
+					 uint32_t len)
+{
+	*buf++ = tag;
+
+	if (len <= 127) {
+		buf[0] = len;
+		return buf + 1;
+	}
+
+	if (len <= 255) {
+		buf[0] = 0x81;
+		buf[1] = len;
+		return buf + 2;
+	}
+
+	buf[0] = 0x82;
+	put_unaligned_be16(len, buf + 1);
+	return buf + 3;
+}
+
+static uint32_t derive_pub_key(const void *pub_key, uint32_t len, uint8_t *buf)
+{
+	uint8_t *cur = buf;
+	uint32_t n_len = definite_length(len) + 1 + len + 1;
+	uint32_t e_len = definite_length(3) + 1 + 3;
+	uint8_t e[3] = { 0x01, 0x00, 0x01 };
+
+	/* SEQUENCE */
+	cur = encode_tag_length(cur, 0x30, n_len + e_len);
+	/* INTEGER n */
+	cur = encode_tag_length(cur, 0x02, len + 1);
+	cur[0] = 0x00;
+	memcpy(cur + 1, pub_key, len);
+	cur += len + 1;
+	cur = encode_tag_length(cur, 0x02, sizeof(e));
+	memcpy(cur, e, sizeof(e));
+	cur += sizeof(e);
+
+	return cur - buf;
+}
+
+/*
+ * Determine the crypto algorithm name.
+ */
+static int determine_akcipher(const char *encoding, const char *hash_algo,
+			      char alg_name[CRYPTO_MAX_ALG_NAME])
+{
+	/* TODO: We don't support hashing yet */
+	if (hash_algo)
+		return -ENOPKG;
+
+	if (strcmp(encoding, "pkcs1") == 0) {
+		strcpy(alg_name, "pkcs1pad(rsa)");
+		return 0;
+	}
+
+	if (strcmp(encoding, "raw") == 0) {
+		strcpy(alg_name, "rsa");
+		return 0;
+	}
+
+	return -ENOPKG;
+}
+
+/*
+ * Query information about a key.
+ */
+static int tpm_key_query(const struct kernel_pkey_params *params,
+			 struct kernel_pkey_query *info)
+{
+	struct tpm_key *tk = params->key->payload.data[asym_crypto];
+	int ret;
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	struct crypto_akcipher *tfm;
+	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
+	uint32_t der_pub_key_len;
+	int len;
+
+	/* TPM only works on private keys, public keys still done in software */
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
+	len = crypto_akcipher_maxsize(tfm);
+
+	info->key_size = tk->key_len;
+	info->max_data_size = tk->key_len / 8;
+	info->max_sig_size = len;
+	info->max_enc_size = len;
+	info->max_dec_size = tk->key_len / 8;
+
+	ret = 0;
+error_free_tfm:
+	crypto_free_akcipher(tfm);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+
 /*
  * Parse enough information out of TPM_KEY structure:
  * TPM_STRUCT_VER -> 4 bytes
@@ -194,6 +328,7 @@ struct asymmetric_key_subtype asym_tpm_subtype = {
 	.name_len		= sizeof("asym_tpm") - 1,
 	.describe		= asym_tpm_describe,
 	.destroy		= asym_tpm_destroy,
+	.query			= tpm_key_query,
 };
 EXPORT_SYMBOL_GPL(asym_tpm_subtype);
 

