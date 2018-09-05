Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AFAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16812073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16812073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIFC2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbeIFC2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAF9A402242D;
        Wed,  5 Sep 2018 21:56:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 178692027EA0;
        Wed,  5 Sep 2018 21:56:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/22] KEYS: asym_tpm: Add support for the sign operation
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:56:42 +0100
Message-ID: <153618460258.7946.14928570863758355701.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:56:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:56:43 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

The sign operation can operate in a non-hashed mode by running the RSA
sign operation directly on the input.  This assumes that the input is
less than key_size_in_bytes - 11.  Since the TPM performs its own PKCS1
padding, it isn't possible to support 'raw' mode, only 'pkcs1'.

Alternatively, a hashed version is also possible.  In this variant the
input is hashed (by userspace) via the selected hash function first.
Then this implementation takes care of converting the hash to ASN.1
format and the sign operation is performed on the result.  This is
similar to the implementation inside crypto/rsa-pkcs1pad.c.

ASN1 templates were copied from crypto/rsa-pkcs1pad.c.  There seems to
be no easy way to expose that functionality, but likely the templates
should be shared somehow.

The sign operation is implemented via TPM_Sign operation on the TPM.
It is assumed that the TPM wrapped key provided uses
TPM_SS_RSASSAPKCS1v15_DER signature scheme.  This allows the TPM_Sign
operation to work on data up to key_len_in_bytes - 11 bytes long.

In theory, we could also use TPM_Unbind instead of TPM_Sign, but we would
have to manually pkcs1 pad the digest first.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/asym_tpm.c |  156 +++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index a5a5f913a74f..5d4c270463f6 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -435,7 +435,8 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 
 	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
 			      KEYCTL_SUPPORTS_DECRYPT |
-			      KEYCTL_SUPPORTS_VERIFY;
+			      KEYCTL_SUPPORTS_VERIFY |
+			      KEYCTL_SUPPORTS_SIGN;
 
 	ret = 0;
 error_free_tfm:
@@ -556,6 +557,156 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 	return r;
 }
 
+/*
+ * Hash algorithm OIDs plus ASN.1 DER wrappings [RFC4880 sec 5.2.2].
+ */
+static const u8 digest_info_md5[] = {
+	0x30, 0x20, 0x30, 0x0c, 0x06, 0x08,
+	0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x02, 0x05, /* OID */
+	0x05, 0x00, 0x04, 0x10
+};
+
+static const u8 digest_info_sha1[] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
+	0x2b, 0x0e, 0x03, 0x02, 0x1a,
+	0x05, 0x00, 0x04, 0x14
+};
+
+static const u8 digest_info_rmd160[] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
+	0x2b, 0x24, 0x03, 0x02, 0x01,
+	0x05, 0x00, 0x04, 0x14
+};
+
+static const u8 digest_info_sha224[] = {
+	0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x04,
+	0x05, 0x00, 0x04, 0x1c
+};
+
+static const u8 digest_info_sha256[] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
+	0x05, 0x00, 0x04, 0x20
+};
+
+static const u8 digest_info_sha384[] = {
+	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02,
+	0x05, 0x00, 0x04, 0x30
+};
+
+static const u8 digest_info_sha512[] = {
+	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03,
+	0x05, 0x00, 0x04, 0x40
+};
+
+static const struct asn1_template {
+	const char	*name;
+	const u8	*data;
+	size_t		size;
+} asn1_templates[] = {
+#define _(X) { #X, digest_info_##X, sizeof(digest_info_##X) }
+	_(md5),
+	_(sha1),
+	_(rmd160),
+	_(sha256),
+	_(sha384),
+	_(sha512),
+	_(sha224),
+	{ NULL }
+#undef _
+};
+
+static const struct asn1_template *lookup_asn1(const char *name)
+{
+	const struct asn1_template *p;
+
+	for (p = asn1_templates; p->name; p++)
+		if (strcmp(name, p->name) == 0)
+			return p;
+	return NULL;
+}
+
+/*
+ * Sign operation is performed with the private key in the TPM.
+ */
+static int tpm_key_sign(struct tpm_key *tk,
+			struct kernel_pkey_params *params,
+			const void *in, void *out)
+{
+	struct tpm_buf *tb;
+	uint32_t keyhandle;
+	uint8_t srkauth[SHA1_DIGEST_SIZE];
+	uint8_t keyauth[SHA1_DIGEST_SIZE];
+	void *asn1_wrapped = NULL;
+	uint32_t in_len = params->in_len;
+	int r;
+
+	pr_devel("==>%s()\n", __func__);
+
+	if (strcmp(params->encoding, "pkcs1"))
+		return -ENOPKG;
+
+	if (params->hash_algo) {
+		const struct asn1_template *asn1 =
+						lookup_asn1(params->hash_algo);
+
+		if (!asn1)
+			return -ENOPKG;
+
+		/* request enough space for the ASN.1 template + input hash */
+		asn1_wrapped = kzalloc(in_len + asn1->size, GFP_KERNEL);
+		if (!asn1_wrapped)
+			return -ENOMEM;
+
+		/* Copy ASN.1 template, then the input */
+		memcpy(asn1_wrapped, asn1->data, asn1->size);
+		memcpy(asn1_wrapped + asn1->size, in, in_len);
+
+		in = asn1_wrapped;
+		in_len += asn1->size;
+	}
+
+	if (in_len > tk->key_len / 8 - 11) {
+		r = -EOVERFLOW;
+		goto error_free_asn1_wrapped;
+	}
+
+	r = -ENOMEM;
+	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		goto error_free_asn1_wrapped;
+
+	/* TODO: Handle a non-all zero SRK authorization */
+	memset(srkauth, 0, sizeof(srkauth));
+
+	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+			 tk->blob, tk->blob_len, &keyhandle);
+	if (r < 0) {
+		pr_devel("loadkey2 failed (%d)\n", r);
+		goto error_free_tb;
+	}
+
+	/* TODO: Handle a non-all zero key authorization */
+	memset(keyauth, 0, sizeof(keyauth));
+
+	r = tpm_sign(tb, keyhandle, keyauth, in, in_len, out, params->out_len);
+	if (r < 0)
+		pr_devel("tpm_sign failed (%d)\n", r);
+
+	if (tpm_flushspecific(tb, keyhandle) < 0)
+		pr_devel("flushspecific failed (%d)\n", r);
+
+error_free_tb:
+	kzfree(tb);
+error_free_asn1_wrapped:
+	kfree(asn1_wrapped);
+	pr_devel("<==%s() = %d\n", __func__, r);
+	return r;
+}
+
 /*
  * Do encryption, decryption and signing ops.
  */
@@ -573,6 +724,9 @@ static int tpm_key_eds_op(struct kernel_pkey_params *params,
 	case kernel_pkey_decrypt:
 		ret = tpm_key_decrypt(tk, params, in, out);
 		break;
+	case kernel_pkey_sign:
+		ret = tpm_key_sign(tk, params, in, out);
+		break;
 	default:
 		BUG();
 	}

