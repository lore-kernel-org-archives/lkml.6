Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E285C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119ED2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119ED2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeIFC2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B1E5402242D;
        Wed,  5 Sep 2018 21:56:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82EFE63F20;
        Wed,  5 Sep 2018 21:56:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/22] KEYS: asym_tpm: Add loadkey2 and flushspecific
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:56:10 +0100
Message-ID: <153618457002.7946.741829373041553399.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:56:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:56:11 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This commit adds TPM_LoadKey2 and TPM_FlushSpecific operations.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---

 crypto/asymmetric_keys/asym_tpm.c |   94 +++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 8edca3c4c193..6a2d33014ecc 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -7,11 +7,105 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/tpm.h>
+#include <linux/tpm_command.h>
 #include <crypto/akcipher.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 #include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
+#include <keys/trusted.h>
 #include <crypto/asym_tpm_subtype.h>
 
+#define TPM_ORD_FLUSHSPECIFIC	186
+#define TPM_ORD_LOADKEY2	65
+#define TPM_LOADKEY2_SIZE		59
+#define TPM_FLUSHSPECIFIC_SIZE		18
+
+#define TPM_RT_KEY                      0x00000001
+
+/*
+ * Load a TPM key from the blob provided by userspace
+ */
+static int tpm_loadkey2(struct tpm_buf *tb,
+			uint32_t keyhandle, unsigned char *keyauth,
+			const unsigned char *keyblob, int keybloblen,
+			uint32_t *newhandle)
+{
+	unsigned char nonceodd[TPM_NONCE_SIZE];
+	unsigned char enonce[TPM_NONCE_SIZE];
+	unsigned char authdata[SHA1_DIGEST_SIZE];
+	uint32_t authhandle = 0;
+	unsigned char cont = 0;
+	uint32_t ordinal;
+	int ret;
+
+	ordinal = htonl(TPM_ORD_LOADKEY2);
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
+			   keybloblen, keyblob, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	/* build the request buffer */
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
+	store32(tb, TPM_LOADKEY2_SIZE + keybloblen);
+	store32(tb, TPM_ORD_LOADKEY2);
+	store32(tb, keyhandle);
+	storebytes(tb, keyblob, keybloblen);
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
+	ret = TSS_checkhmac1(tb->data, ordinal, nonceodd, keyauth,
+			     SHA1_DIGEST_SIZE, 0, 0);
+	if (ret < 0) {
+		pr_info("TSS_checkhmac1 failed (%d)\n", ret);
+		return ret;
+	}
+
+	*newhandle = LOAD32(tb->data, TPM_DATA_OFFSET);
+	return 0;
+}
+
+/*
+ * Execute the FlushSpecific TPM command
+ */
+static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
+{
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_COMMAND);
+	store32(tb, TPM_FLUSHSPECIFIC_SIZE);
+	store32(tb, TPM_ORD_FLUSHSPECIFIC);
+	store32(tb, handle);
+	store32(tb, TPM_RT_KEY);
+
+	return trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+}
+
 /*
  * Maximum buffer size for the BER/DER encoded public key.  The public key
  * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048

