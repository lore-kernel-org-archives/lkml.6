Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134B0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB642073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB642073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIFC1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:27:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:27:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C09F805A6D8;
        Wed,  5 Sep 2018 21:55:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F8C2166BA1;
        Wed,  5 Sep 2018 21:55:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/22] KEYS: asym_tpm: extract key size & public key
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:55:30 +0100
Message-ID: <153618453075.7946.11830230385214262822.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 21:55:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 21:55:32 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

The parsed BER/DER blob obtained from user space contains a TPM_Key
structure.  This structure has some information about the key as well as
the public key portion.

This patch extracts this information for future use.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/asym_tpm.c |  112 +++++++++++++++++++++++++++++++++++++
 include/crypto/asym_tpm_subtype.h |    3 +
 2 files changed, 115 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index d0b2b97e8e54..308c51e055a4 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/tpm.h>
+#include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
 #include <crypto/asym_tpm_subtype.h>
 
@@ -37,6 +38,110 @@ static void asym_tpm_destroy(void *payload0, void *payload3)
 	kfree(tk);
 }
 
+/*
+ * Parse enough information out of TPM_KEY structure:
+ * TPM_STRUCT_VER -> 4 bytes
+ * TPM_KEY_USAGE -> 2 bytes
+ * TPM_KEY_FLAGS -> 4 bytes
+ * TPM_AUTH_DATA_USAGE -> 1 byte
+ * TPM_KEY_PARMS -> variable
+ * UINT32 PCRInfoSize -> 4 bytes
+ * BYTE* -> PCRInfoSize bytes
+ * TPM_STORE_PUBKEY
+ * UINT32 encDataSize;
+ * BYTE* -> encDataSize;
+ *
+ * TPM_KEY_PARMS:
+ * TPM_ALGORITHM_ID -> 4 bytes
+ * TPM_ENC_SCHEME -> 2 bytes
+ * TPM_SIG_SCHEME -> 2 bytes
+ * UINT32 parmSize -> 4 bytes
+ * BYTE* -> variable
+ */
+static int extract_key_parameters(struct tpm_key *tk)
+{
+	const void *cur = tk->blob;
+	uint32_t len = tk->blob_len;
+	const void *pub_key;
+	uint32_t sz;
+	uint32_t key_len;
+
+	if (len < 11)
+		return -EBADMSG;
+
+	/* Ensure this is a legacy key */
+	if (get_unaligned_be16(cur + 4) != 0x0015)
+		return -EBADMSG;
+
+	/* Skip to TPM_KEY_PARMS */
+	cur += 11;
+	len -= 11;
+
+	if (len < 12)
+		return -EBADMSG;
+
+	/* Make sure this is an RSA key */
+	if (get_unaligned_be32(cur) != 0x00000001)
+		return -EBADMSG;
+
+	/* Make sure this is TPM_ES_RSAESPKCSv15 encoding scheme */
+	if (get_unaligned_be16(cur + 4) != 0x0002)
+		return -EBADMSG;
+
+	/* Make sure this is TPM_SS_RSASSAPKCS1v15_DER signature scheme */
+	if (get_unaligned_be16(cur + 6) != 0x0003)
+		return -EBADMSG;
+
+	sz = get_unaligned_be32(cur + 8);
+	if (len < sz + 12)
+		return -EBADMSG;
+
+	/* Move to TPM_RSA_KEY_PARMS */
+	len -= 12;
+	cur += 12;
+
+	/* Grab the RSA key length */
+	key_len = get_unaligned_be32(cur);
+
+	switch (key_len) {
+	case 512:
+	case 1024:
+	case 1536:
+	case 2048:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Move just past TPM_KEY_PARMS */
+	cur += sz;
+	len -= sz;
+
+	if (len < 4)
+		return -EBADMSG;
+
+	sz = get_unaligned_be32(cur);
+	if (len < 4 + sz)
+		return -EBADMSG;
+
+	/* Move to TPM_STORE_PUBKEY */
+	cur += 4 + sz;
+	len -= 4 + sz;
+
+	/* Grab the size of the public key, it should jive with the key size */
+	sz = get_unaligned_be32(cur);
+	if (sz > 256)
+		return -EINVAL;
+
+	pub_key = cur + 4;
+
+	tk->key_len = key_len;
+	tk->pub_key = pub_key;
+	tk->pub_key_len = sz;
+
+	return 0;
+}
+
 /* Given the blob, parse it and load it into the TPM */
 struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len)
 {
@@ -64,8 +169,15 @@ struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len)
 
 	tk->blob_len = blob_len;
 
+	r = extract_key_parameters(tk);
+	if (r < 0)
+		goto error_extract;
+
 	return tk;
 
+error_extract:
+	kfree(tk->blob);
+	tk->blob_len = 0;
 error_memdup:
 	kfree(tk);
 error:
diff --git a/include/crypto/asym_tpm_subtype.h b/include/crypto/asym_tpm_subtype.h
index 03550b850998..48198c36d6b9 100644
--- a/include/crypto/asym_tpm_subtype.h
+++ b/include/crypto/asym_tpm_subtype.h
@@ -7,6 +7,9 @@
 struct tpm_key {
 	void *blob;
 	u32 blob_len;
+	uint16_t key_len; /* Size in bits of the key */
+	const void *pub_key; /* pointer inside blob to the public key bytes */
+	uint16_t pub_key_len; /* length of the public key */
 };
 
 struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len);

