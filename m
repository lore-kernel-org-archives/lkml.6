Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E6EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28FD204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28FD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIFC1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:27:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:27:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33383804B4B9;
        Wed,  5 Sep 2018 21:55:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52E792027EA0;
        Wed,  5 Sep 2018 21:55:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/22] KEYS: Implement PKCS#8 RSA Private Key parser
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:55:10 +0100
Message-ID: <153618451081.7946.14700559590008741878.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 21:55:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 21:55:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement PKCS#8 RSA Private Key format [RFC 5208] parser for the
asymmetric key type.  For the moment, this will only support unencrypted
DER blobs.  PEM and decryption can be added later.

PKCS#8 keys can be loaded like this:

	openssl pkcs8 -in private_key.pem -topk8 -nocrypt -outform DER | \
	  keyctl padd asymmetric foo @s

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/crypto/asymmetric-keys.txt |    2 
 crypto/asymmetric_keys/Kconfig           |   10 ++
 crypto/asymmetric_keys/Makefile          |   13 ++
 crypto/asymmetric_keys/pkcs8.asn1        |   24 ++++
 crypto/asymmetric_keys/pkcs8_parser.c    |  184 ++++++++++++++++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pkcs8.asn1
 create mode 100644 crypto/asymmetric_keys/pkcs8_parser.c

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index deb656ef008b..8763866b11cf 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -248,6 +248,8 @@ Examples of blob formats for which parsers could be implemented include:
  - X.509 ASN.1 stream.
  - Pointer to TPM key.
  - Pointer to UEFI key.
+ - PKCS#8 private key [RFC 5208].
+ - PKCS#5 encrypted private key [RFC 2898].
 
 During key instantiation each parser in the list is tried until one doesn't
 return -EBADMSG.
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index f3702e533ff4..66a7dad7ed3d 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -31,6 +31,16 @@ config X509_CERTIFICATE_PARSER
 	  data and provides the ability to instantiate a crypto key from a
 	  public key packet found inside the certificate.
 
+config PKCS8_PRIVATE_KEY_PARSER
+	tristate "PKCS#8 private key parser"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select ASN1
+	select OID_REGISTRY
+	help
+	  This option provides support for parsing PKCS#8 format blobs for
+	  private key data and provides the ability to instantiate a crypto key
+	  from that data.
+
 config PKCS7_MESSAGE_PARSER
 	tristate "PKCS#7 message parser"
 	depends on X509_CERTIFICATE_PARSER
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index d4b2e1b2dc65..c38424f55b08 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -29,6 +29,19 @@ $(obj)/x509_cert_parser.o: \
 $(obj)/x509.asn1.o: $(obj)/x509.asn1.c $(obj)/x509.asn1.h
 $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
 
+#
+# PKCS#8 private key handling
+#
+obj-$(CONFIG_PKCS8_PRIVATE_KEY_PARSER) += pkcs8_key_parser.o
+pkcs8_key_parser-y := \
+	pkcs8.asn1.o \
+	pkcs8_parser.o
+
+$(obj)/pkcs8_parser.o: $(obj)/pkcs8.asn1.h
+$(obj)/pkcs8-asn1.o: $(obj)/pkcs8.asn1.c $(obj)/pkcs8.asn1.h
+
+clean-files	+= pkcs8.asn1.c pkcs8.asn1.h
+
 #
 # PKCS#7 message handling
 #
diff --git a/crypto/asymmetric_keys/pkcs8.asn1 b/crypto/asymmetric_keys/pkcs8.asn1
new file mode 100644
index 000000000000..702c41a3c713
--- /dev/null
+++ b/crypto/asymmetric_keys/pkcs8.asn1
@@ -0,0 +1,24 @@
+--
+-- This is the unencrypted variant
+--
+PrivateKeyInfo ::= SEQUENCE {
+	version			Version,
+	privateKeyAlgorithm	PrivateKeyAlgorithmIdentifier,
+	privateKey		PrivateKey,
+	attributes		[0] IMPLICIT Attributes OPTIONAL
+}
+
+Version ::= INTEGER  ({ pkcs8_note_version })
+
+PrivateKeyAlgorithmIdentifier ::= AlgorithmIdentifier ({ pkcs8_note_algo })
+
+PrivateKey ::= OCTET STRING ({ pkcs8_note_key })
+
+Attributes ::= SET OF Attribute
+
+Attribute ::= ANY
+
+AlgorithmIdentifier ::= SEQUENCE {
+	algorithm   OBJECT IDENTIFIER ({ pkcs8_note_OID }),
+	parameters  ANY OPTIONAL
+}
diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
new file mode 100644
index 000000000000..5f6a7ecc9765
--- /dev/null
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -0,0 +1,184 @@
+/* PKCS#8 Private Key parser [RFC 5208].
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "PKCS8: "fmt
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/oid_registry.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+#include <crypto/public_key.h>
+#include "pkcs8.asn1.h"
+
+struct pkcs8_parse_context {
+	struct public_key *pub;
+	unsigned long	data;			/* Start of data */
+	enum OID	last_oid;		/* Last OID encountered */
+	enum OID	algo_oid;		/* Algorithm OID */
+	u32		key_size;
+	const void	*key;
+};
+
+/*
+ * Note an OID when we find one for later processing when we know how to
+ * interpret it.
+ */
+int pkcs8_note_OID(void *context, size_t hdrlen,
+		   unsigned char tag,
+		   const void *value, size_t vlen)
+{
+	struct pkcs8_parse_context *ctx = context;
+
+	ctx->last_oid = look_up_OID(value, vlen);
+	if (ctx->last_oid == OID__NR) {
+		char buffer[50];
+
+		sprint_oid(value, vlen, buffer, sizeof(buffer));
+		pr_info("Unknown OID: [%lu] %s\n",
+			(unsigned long)value - ctx->data, buffer);
+	}
+	return 0;
+}
+
+/*
+ * Note the version number of the ASN.1 blob.
+ */
+int pkcs8_note_version(void *context, size_t hdrlen,
+		       unsigned char tag,
+		       const void *value, size_t vlen)
+{
+	if (vlen != 1 || ((const u8 *)value)[0] != 0) {
+		pr_warn("Unsupported PKCS#8 version\n");
+		return -EBADMSG;
+	}
+	return 0;
+}
+
+/*
+ * Note the public algorithm.
+ */
+int pkcs8_note_algo(void *context, size_t hdrlen,
+		    unsigned char tag,
+		    const void *value, size_t vlen)
+{
+	struct pkcs8_parse_context *ctx = context;
+
+	if (ctx->last_oid != OID_rsaEncryption)
+		return -ENOPKG;
+
+	ctx->pub->pkey_algo = "rsa";
+	return 0;
+}
+
+/*
+ * Note the key data of the ASN.1 blob.
+ */
+int pkcs8_note_key(void *context, size_t hdrlen,
+		   unsigned char tag,
+		   const void *value, size_t vlen)
+{
+	struct pkcs8_parse_context *ctx = context;
+
+	ctx->key = value;
+	ctx->key_size = vlen;
+	return 0;
+}
+
+/*
+ * Parse a PKCS#8 private key blob.
+ */
+static struct public_key *pkcs8_parse(const void *data, size_t datalen)
+{
+	struct pkcs8_parse_context ctx;
+	struct public_key *pub;
+	long ret;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ret = -ENOMEM;
+	ctx.pub = kzalloc(sizeof(struct public_key), GFP_KERNEL);
+	if (!ctx.pub)
+		goto error;
+
+	ctx.data = (unsigned long)data;
+
+	/* Attempt to decode the private key */
+	ret = asn1_ber_decoder(&pkcs8_decoder, &ctx, data, datalen);
+	if (ret < 0)
+		goto error_decode;
+
+	ret = -ENOMEM;
+	pub = ctx.pub;
+	pub->key = kmemdup(ctx.key, ctx.key_size, GFP_KERNEL);
+	if (!pub->key)
+		goto error_decode;
+
+	pub->keylen = ctx.key_size;
+	pub->key_is_private = true;
+	return pub;
+
+error_decode:
+	kfree(ctx.pub);
+error:
+	return ERR_PTR(ret);
+}
+
+/*
+ * Attempt to parse a data blob for a key as a PKCS#8 private key.
+ */
+static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
+{
+	struct public_key *pub;
+
+	pub = pkcs8_parse(prep->data, prep->datalen);
+	if (IS_ERR(pub))
+		return PTR_ERR(pub);
+
+	pr_devel("Cert Key Algo: %s\n", pub->pkey_algo);
+	pub->id_type = "PKCS8";
+
+	/* We're pinning the module by being linked against it */
+	__module_get(public_key_subtype.owner);
+	prep->payload.data[asym_subtype] = &public_key_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = pub;
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+	return 0;
+}
+
+static struct asymmetric_key_parser pkcs8_key_parser = {
+	.owner	= THIS_MODULE,
+	.name	= "pkcs8",
+	.parse	= pkcs8_key_preparse,
+};
+
+/*
+ * Module stuff
+ */
+static int __init pkcs8_key_init(void)
+{
+	return register_asymmetric_key_parser(&pkcs8_key_parser);
+}
+
+static void __exit pkcs8_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&pkcs8_key_parser);
+}
+
+module_init(pkcs8_key_init);
+module_exit(pkcs8_key_exit);
+
+MODULE_DESCRIPTION("PKCS#8 certificate parser");
+MODULE_LICENSE("GPL");

