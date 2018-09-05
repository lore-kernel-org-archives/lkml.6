Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8F4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEBB2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEBB2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIFC0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:26:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbeIFC0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59BF140216E3;
        Wed,  5 Sep 2018 21:54:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F394112D16C;
        Wed,  5 Sep 2018 21:54:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/22] KEYS: Provide missing asymmetric key subops for new
 key type ops
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:54:37 +0100
Message-ID: <153618447788.7946.12036865757091293640.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the missing asymmetric key subops for new key type ops.  This
include query, encrypt, decrypt and create signature.  Verify signature
already exists.  Also provided are accessor functions for this:

	int query_asymmetric_key(const struct key *key,
				 struct kernel_pkey_query *info);

	int encrypt_blob(struct kernel_pkey_params *params,
			 const void *data, void *enc);
	int decrypt_blob(struct kernel_pkey_params *params,
			 const void *enc, void *data);
	int create_signature(struct kernel_pkey_params *params,
			     const void *data, void *enc);

The public_key_signature struct gains an encoding field to carry the
encoding for verify_signature().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/crypto/asymmetric-keys.txt |   24 ++++++--
 crypto/asymmetric_keys/asymmetric_keys.h |    3 +
 crypto/asymmetric_keys/asymmetric_type.c |   43 ++++++++++++++
 crypto/asymmetric_keys/signature.c       |   95 ++++++++++++++++++++++++++++++
 include/crypto/public_key.h              |   13 +++-
 include/keys/asymmetric-subtype.h        |    9 +++
 6 files changed, 180 insertions(+), 7 deletions(-)

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index 5969bf42562a..deb656ef008b 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -183,6 +183,10 @@ and looks like the following:
 
 		void (*describe)(const struct key *key, struct seq_file *m);
 		void (*destroy)(void *payload);
+		int (*query)(const struct kernel_pkey_params *params,
+			     struct kernel_pkey_query *info);
+		int (*eds_op)(struct kernel_pkey_params *params,
+			      const void *in, void *out);
 		int (*verify_signature)(const struct key *key,
 					const struct public_key_signature *sig);
 	};
@@ -207,12 +211,22 @@ There are a number of operations defined by the subtype:
      asymmetric key will look after freeing the fingerprint and releasing the
      reference on the subtype module.
 
- (3) verify_signature().
+ (3) query().
 
-     Optional.  These are the entry points for the key usage operations.
-     Currently there is only the one defined.  If not set, the caller will be
-     given -ENOTSUPP.  The subtype may do anything it likes to implement an
-     operation, including offloading to hardware.
+     Mandatory.  This is a function for querying the capabilities of a key.
+
+ (4) eds_op().
+
+     Optional.  This is the entry point for the encryption, decryption and
+     signature creation operations (which are distinguished by the operation ID
+     in the parameter struct).  The subtype may do anything it likes to
+     implement an operation, including offloading to hardware.
+
+ (5) verify_signature().
+
+     Optional.  This is the entry point for signature verification.  The
+     subtype may do anything it likes to implement an operation, including
+     offloading to hardware.
 
 
 ==========================
diff --git a/crypto/asymmetric_keys/asymmetric_keys.h b/crypto/asymmetric_keys/asymmetric_keys.h
index ca8e9ac34ce6..7be1ccf4fa9f 100644
--- a/crypto/asymmetric_keys/asymmetric_keys.h
+++ b/crypto/asymmetric_keys/asymmetric_keys.h
@@ -16,3 +16,6 @@ extern struct asymmetric_key_id *asymmetric_key_hex_to_key_id(const char *id);
 extern int __asymmetric_key_hex_to_key_id(const char *id,
 					  struct asymmetric_key_id *match_id,
 					  size_t hexlen);
+
+extern int asymmetric_key_eds_op(struct kernel_pkey_params *params,
+				 const void *in, void *out);
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 26539e9a8bda..69a0788a7de5 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <keys/system_keyring.h>
+#include <keys/user-type.h>
 #include "asymmetric_keys.h"
 
 MODULE_LICENSE("GPL");
@@ -538,6 +539,45 @@ static struct key_restriction *asymmetric_lookup_restriction(
 	return ret;
 }
 
+int asymmetric_key_eds_op(struct kernel_pkey_params *params,
+			  const void *in, void *out)
+{
+	const struct asymmetric_key_subtype *subtype;
+	struct key *key = params->key;
+	int ret;
+
+	pr_devel("==>%s()\n", __func__);
+
+	if (key->type != &key_type_asymmetric)
+		return -EINVAL;
+	subtype = asymmetric_key_subtype(key);
+	if (!subtype ||
+	    !key->payload.data[0])
+		return -EINVAL;
+	if (!subtype->eds_op)
+		return -ENOTSUPP;
+
+	ret = subtype->eds_op(params, in, out);
+
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int asymmetric_key_verify_signature(struct kernel_pkey_params *params,
+					   const void *in, const void *in2)
+{
+	struct public_key_signature sig = {
+		.s_size		= params->in2_len,
+		.digest_size	= params->in_len,
+		.encoding	= params->encoding,
+		.hash_algo	= params->hash_algo,
+		.digest		= (void *)in,
+		.s		= (void *)in2,
+	};
+
+	return verify_signature(params->key, &sig);
+}
+
 struct key_type key_type_asymmetric = {
 	.name			= "asymmetric",
 	.preparse		= asymmetric_key_preparse,
@@ -548,6 +588,9 @@ struct key_type key_type_asymmetric = {
 	.destroy		= asymmetric_key_destroy,
 	.describe		= asymmetric_key_describe,
 	.lookup_restriction	= asymmetric_lookup_restriction,
+	.asym_query		= query_asymmetric_key,
+	.asym_eds_op		= asymmetric_key_eds_op,
+	.asym_verify_signature	= asymmetric_key_verify_signature,
 };
 EXPORT_SYMBOL_GPL(key_type_asymmetric);
 
diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/signature.c
index 28198314bc39..ad95a58c6642 100644
--- a/crypto/asymmetric_keys/signature.c
+++ b/crypto/asymmetric_keys/signature.c
@@ -16,7 +16,9 @@
 #include <linux/export.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/keyctl.h>
 #include <crypto/public_key.h>
+#include <keys/user-type.h>
 #include "asymmetric_keys.h"
 
 /*
@@ -36,6 +38,99 @@ void public_key_signature_free(struct public_key_signature *sig)
 }
 EXPORT_SYMBOL_GPL(public_key_signature_free);
 
+/**
+ * query_asymmetric_key - Get information about an aymmetric key.
+ * @params: Various parameters.
+ * @info: Where to put the information.
+ */
+int query_asymmetric_key(const struct kernel_pkey_params *params,
+			 struct kernel_pkey_query *info)
+{
+	const struct asymmetric_key_subtype *subtype;
+	struct key *key = params->key;
+	int ret;
+
+	pr_devel("==>%s()\n", __func__);
+
+	if (key->type != &key_type_asymmetric)
+		return -EINVAL;
+	subtype = asymmetric_key_subtype(key);
+	if (!subtype ||
+	    !key->payload.data[0])
+		return -EINVAL;
+	if (!subtype->query)
+		return -ENOTSUPP;
+
+	ret = subtype->query(params, info);
+
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(query_asymmetric_key);
+
+/**
+ * encrypt_blob - Encrypt data using an asymmetric key
+ * @params: Various parameters
+ * @data: Data blob to be encrypted, length params->data_len
+ * @enc: Encrypted data buffer, length params->enc_len
+ *
+ * Encrypt the specified data blob using the private key specified by
+ * params->key.  The encrypted data is wrapped in an encoding if
+ * params->encoding is specified (eg. "pkcs1").
+ *
+ * Returns the length of the data placed in the encrypted data buffer or an
+ * error.
+ */
+int encrypt_blob(struct kernel_pkey_params *params,
+		 const void *data, void *enc)
+{
+	params->op = kernel_pkey_encrypt;
+	return asymmetric_key_eds_op(params, data, enc);
+}
+EXPORT_SYMBOL_GPL(encrypt_blob);
+
+/**
+ * decrypt_blob - Decrypt data using an asymmetric key
+ * @params: Various parameters
+ * @enc: Encrypted data to be decrypted, length params->enc_len
+ * @data: Decrypted data buffer, length params->data_len
+ *
+ * Decrypt the specified data blob using the private key specified by
+ * params->key.  The decrypted data is wrapped in an encoding if
+ * params->encoding is specified (eg. "pkcs1").
+ *
+ * Returns the length of the data placed in the decrypted data buffer or an
+ * error.
+ */
+int decrypt_blob(struct kernel_pkey_params *params,
+		 const void *enc, void *data)
+{
+	params->op = kernel_pkey_decrypt;
+	return asymmetric_key_eds_op(params, enc, data);
+}
+EXPORT_SYMBOL_GPL(decrypt_blob);
+
+/**
+ * create_signature - Sign some data using an asymmetric key
+ * @params: Various parameters
+ * @data: Data blob to be signed, length params->data_len
+ * @enc: Signature buffer, length params->enc_len
+ *
+ * Sign the specified data blob using the private key specified by params->key.
+ * The signature is wrapped in an encoding if params->encoding is specified
+ * (eg. "pkcs1").  If the encoding needs to know the digest type, this can be
+ * passed through params->hash_algo (eg. "sha1").
+ *
+ * Returns the length of the data placed in the signature buffer or an error.
+ */
+int create_signature(struct kernel_pkey_params *params,
+		     const void *data, void *enc)
+{
+	params->op = kernel_pkey_sign;
+	return asymmetric_key_eds_op(params, data, enc);
+}
+EXPORT_SYMBOL_GPL(create_signature);
+
 /**
  * verify_signature - Initiate the use of an asymmetric key to verify a signature
  * @key: The asymmetric key to verify against
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index e0b681a717ba..3a1047a0195c 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -14,6 +14,8 @@
 #ifndef _LINUX_PUBLIC_KEY_H
 #define _LINUX_PUBLIC_KEY_H
 
+#include <linux/keyctl.h>
+
 /*
  * Cryptographic data for the public-key subtype of the asymmetric key type.
  *
@@ -40,6 +42,7 @@ struct public_key_signature {
 	u8 digest_size;		/* Number of bytes in digest */
 	const char *pkey_algo;
 	const char *hash_algo;
+	const char *encoding;
 };
 
 extern void public_key_signature_free(struct public_key_signature *sig);
@@ -65,8 +68,14 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
-extern int verify_signature(const struct key *key,
-			    const struct public_key_signature *sig);
+extern int query_asymmetric_key(const struct kernel_pkey_params *,
+				struct kernel_pkey_query *);
+
+extern int encrypt_blob(struct kernel_pkey_params *, const void *, void *);
+extern int decrypt_blob(struct kernel_pkey_params *, const void *, void *);
+extern int create_signature(struct kernel_pkey_params *, const void *, void *);
+extern int verify_signature(const struct key *,
+			    const struct public_key_signature *);
 
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
diff --git a/include/keys/asymmetric-subtype.h b/include/keys/asymmetric-subtype.h
index e0a9c2368872..9ce2f0fae57e 100644
--- a/include/keys/asymmetric-subtype.h
+++ b/include/keys/asymmetric-subtype.h
@@ -17,6 +17,8 @@
 #include <linux/seq_file.h>
 #include <keys/asymmetric-type.h>
 
+struct kernel_pkey_query;
+struct kernel_pkey_params;
 struct public_key_signature;
 
 /*
@@ -34,6 +36,13 @@ struct asymmetric_key_subtype {
 	/* Destroy a key of this subtype */
 	void (*destroy)(void *payload_crypto, void *payload_auth);
 
+	int (*query)(const struct kernel_pkey_params *params,
+		     struct kernel_pkey_query *info);
+
+	/* Encrypt/decrypt/sign data */
+	int (*eds_op)(struct kernel_pkey_params *params,
+		      const void *in, void *out);
+
 	/* Verify the signature on a key of this subtype (optional) */
 	int (*verify_signature)(const struct key *key,
 				const struct public_key_signature *sig);

