Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA8ECDE4F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD3E2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD3E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeJJAG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeJJAG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E3BF356E8;
        Tue,  9 Oct 2018 16:49:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A412B1778F;
        Tue,  9 Oct 2018 16:49:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/22] KEYS: asym_tpm: Implement tpm_unbind [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Denis Kenzior <denkenz@gmail.com>,
        James Morris <james.morris@microsoft.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Holtmann <marcel@holtmann.org>, dhowells@redhat.com,
        denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 17:49:05 +0100
Message-ID: <153910374590.12141.16983394369161634140.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 09 Oct 2018 16:49:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
---

 crypto/asymmetric_keys/asym_tpm.c |   82 +++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 6a2d33014ecc..e893b5212222 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -18,8 +18,10 @@
 
 #define TPM_ORD_FLUSHSPECIFIC	186
 #define TPM_ORD_LOADKEY2	65
+#define TPM_ORD_UNBIND		30
 #define TPM_LOADKEY2_SIZE		59
 #define TPM_FLUSHSPECIFIC_SIZE		18
+#define TPM_UNBIND_SIZE			63
 
 #define TPM_RT_KEY                      0x00000001
 
@@ -106,6 +108,86 @@ static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
 	return trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 }
 
+/*
+ * Decrypt a blob provided by userspace using a specific key handle.
+ * The handle is a well known handle or previously loaded by e.g. LoadKey2
+ */
+static int tpm_unbind(struct tpm_buf *tb,
+			uint32_t keyhandle, unsigned char *keyauth,
+			const unsigned char *blob, uint32_t bloblen,
+			void *out, uint32_t outlen)
+{
+	unsigned char nonceodd[TPM_NONCE_SIZE];
+	unsigned char enonce[TPM_NONCE_SIZE];
+	unsigned char authdata[SHA1_DIGEST_SIZE];
+	uint32_t authhandle = 0;
+	unsigned char cont = 0;
+	uint32_t ordinal;
+	uint32_t datalen;
+	int ret;
+
+	ordinal = htonl(TPM_ORD_UNBIND);
+	datalen = htonl(bloblen);
+
+	/* session for loading the key */
+	ret = oiap(tb, &authhandle, enonce);
+	if (ret < 0) {
+		pr_info("oiap failed (%d)\n", ret);
+		return ret;
+	}
+
+	/* generate odd nonce */
+	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
+	if (ret < 0) {
+		pr_info("tpm_get_random failed (%d)\n", ret);
+		return ret;
+	}
+
+	/* calculate authorization HMAC value */
+	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
+			   nonceodd, cont, sizeof(uint32_t), &ordinal,
+			   sizeof(uint32_t), &datalen,
+			   bloblen, blob, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	/* build the request buffer */
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
+	store32(tb, TPM_UNBIND_SIZE + bloblen);
+	store32(tb, TPM_ORD_UNBIND);
+	store32(tb, keyhandle);
+	store32(tb, bloblen);
+	storebytes(tb, blob, bloblen);
+	store32(tb, authhandle);
+	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
+	store8(tb, cont);
+	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+
+	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	if (ret < 0) {
+		pr_info("authhmac failed (%d)\n", ret);
+		return ret;
+	}
+
+	datalen = LOAD32(tb->data, TPM_DATA_OFFSET);
+
+	ret = TSS_checkhmac1(tb->data, ordinal, nonceodd,
+			     keyauth, SHA1_DIGEST_SIZE,
+			     sizeof(uint32_t), TPM_DATA_OFFSET,
+			     datalen, TPM_DATA_OFFSET + sizeof(uint32_t),
+			     0, 0);
+	if (ret < 0) {
+		pr_info("TSS_checkhmac1 failed (%d)\n", ret);
+		return ret;
+	}
+
+	memcpy(out, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t),
+	       min(outlen, datalen));
+
+	return datalen;
+}
+
 /*
  * Maximum buffer size for the BER/DER encoded public key.  The public key
  * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048

