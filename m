Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3EEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3E32073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3E32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeIFC1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:27:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACC0540216E3;
        Wed,  5 Sep 2018 21:55:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE891202706C;
        Wed,  5 Sep 2018 21:55:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/22] KEYS: Add parser for TPM-based keys
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:55:37 +0100
Message-ID: <153618453731.7946.4588780807259491173.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:55:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:55:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

For TPM based keys, the only standard seems to be described here:
http://david.woodhou.se/draft-woodhouse-cert-best-practice.html#rfc.section.4.4

Quote from the relevant section:
"Rather, a common form of storage for "wrapped" keys is to encode the
binary TCPA_KEY structure in a single ASN.1 OCTET-STRING, and store the
result in PEM format with the tag "-----BEGIN TSS KEY BLOB-----". "

This patch implements the above behavior.  It is assumed that the PEM
encoding is stripped out by userspace and only the raw DER/BER format is
provided.  This is similar to how PKCS7, PKCS8 and X.509 keys are
handled.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/Kconfig      |    9 +++
 crypto/asymmetric_keys/Makefile     |   11 ++++
 crypto/asymmetric_keys/tpm.asn1     |    5 ++
 crypto/asymmetric_keys/tpm_parser.c |  102 +++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 crypto/asymmetric_keys/tpm.asn1
 create mode 100644 crypto/asymmetric_keys/tpm_parser.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index b75555c7d8ae..88353a9ebc9b 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -52,6 +52,15 @@ config PKCS8_PRIVATE_KEY_PARSER
 	  private key data and provides the ability to instantiate a crypto key
 	  from that data.
 
+config TPM_KEY_PARSER
+	tristate "TPM private key parser"
+	depends on ASYMMETRIC_TPM_KEY_SUBTYPE
+	select ASN1
+	help
+	  This option provides support for parsing TPM format blobs for
+	  private key data and provides the ability to instantiate a crypto key
+	  from that data.
+
 config PKCS7_MESSAGE_PARSER
 	tristate "PKCS#7 message parser"
 	depends on X509_CERTIFICATE_PARSER
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 73fbe650ff1d..28b91adba2ae 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -75,3 +75,14 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+#
+# TPM private key parsing
+#
+obj-$(CONFIG_TPM_KEY_PARSER) += tpm_key_parser.o
+tpm_key_parser-y := \
+	tpm.asn1.o \
+	tpm_parser.o
+
+$(obj)/tpm_parser.o: $(obj)/tpm.asn1.h
+$(obj)/tpm.asn1.o: $(obj)/tpm.asn1.c $(obj)/tpm.asn1.h
diff --git a/crypto/asymmetric_keys/tpm.asn1 b/crypto/asymmetric_keys/tpm.asn1
new file mode 100644
index 000000000000..d7f194232f30
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm.asn1
@@ -0,0 +1,5 @@
+--
+-- Unencryted TPM Blob.  For details of the format, see:
+-- http://david.woodhou.se/draft-woodhouse-cert-best-practice.html#I-D.mavrogiannopoulos-tpmuri
+--
+PrivateKeyInfo ::= OCTET STRING ({ tpm_note_key })
diff --git a/crypto/asymmetric_keys/tpm_parser.c b/crypto/asymmetric_keys/tpm_parser.c
new file mode 100644
index 000000000000..96405d8dcd98
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm_parser.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) "TPM-PARSER: "fmt
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+#include <crypto/asym_tpm_subtype.h>
+#include "tpm.asn1.h"
+
+struct tpm_parse_context {
+	const void	*blob;
+	u32		blob_len;
+};
+
+/*
+ * Note the key data of the ASN.1 blob.
+ */
+int tpm_note_key(void *context, size_t hdrlen,
+		   unsigned char tag,
+		   const void *value, size_t vlen)
+{
+	struct tpm_parse_context *ctx = context;
+
+	ctx->blob = value;
+	ctx->blob_len = vlen;
+
+	return 0;
+}
+
+/*
+ * Parse a TPM-encrypted private key blob.
+ */
+static struct tpm_key *tpm_parse(const void *data, size_t datalen)
+{
+	struct tpm_parse_context ctx;
+	long ret;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* Attempt to decode the private key */
+	ret = asn1_ber_decoder(&tpm_decoder, &ctx, data, datalen);
+	if (ret < 0)
+		goto error;
+
+	return tpm_key_create(ctx.blob, ctx.blob_len);
+
+error:
+	return ERR_PTR(ret);
+}
+/*
+ * Attempt to parse a data blob for a key as a TPM private key blob.
+ */
+static int tpm_key_preparse(struct key_preparsed_payload *prep)
+{
+	struct tpm_key *tk;
+
+	/*
+	 * TPM 1.2 keys are max 2048 bits long, so assume the blob is no
+	 * more than 4x that
+	 */
+	if (prep->datalen > 256 * 4)
+		return -EMSGSIZE;
+
+	tk = tpm_parse(prep->data, prep->datalen);
+
+	if (IS_ERR(tk))
+		return PTR_ERR(tk);
+
+	/* We're pinning the module by being linked against it */
+	__module_get(asym_tpm_subtype.owner);
+	prep->payload.data[asym_subtype] = &asym_tpm_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = tk;
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+	return 0;
+}
+
+static struct asymmetric_key_parser tpm_key_parser = {
+	.owner	= THIS_MODULE,
+	.name	= "tpm_parser",
+	.parse	= tpm_key_preparse,
+};
+
+static int __init tpm_key_init(void)
+{
+	return register_asymmetric_key_parser(&tpm_key_parser);
+}
+
+static void __exit tpm_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&tpm_key_parser);
+}
+
+module_init(tpm_key_init);
+module_exit(tpm_key_exit);
+
+MODULE_DESCRIPTION("TPM private key-blob parser");
+MODULE_LICENSE("GPL v2");

