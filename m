Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C68C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190642077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190642077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeIFC2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727756AbeIFC2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60E7940216E3;
        Wed,  5 Sep 2018 21:56:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 927532166BA1;
        Wed,  5 Sep 2018 21:56:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/22] KEYS: asym_tpm: Implement the decrypt operation
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:56:23 +0100
Message-ID: <153618458309.7946.14847260238913330761.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:56:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:56:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This patch implements the pkey_decrypt operation using the private key
blob.  The blob is first loaded into the TPM via tpm_loadkey2.  Once the
handle is obtained, tpm_unbind operation is used to decrypt the data on
the TPM and the result is returned.  The key loaded by tpm_loadkey2 is
then evicted via tpm_flushspecific operation.

This patch assumes that the SRK authorization is a well known 20-byte of
zeros and the same holds for the key authorization of the provided key.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/asym_tpm.c |   58 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index e893b5212222..6f5d5cf98910 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -341,7 +341,8 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 	info->max_enc_size = len;
 	info->max_dec_size = tk->key_len / 8;
 
-	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT;
+	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
+			      KEYCTL_SUPPORTS_DECRYPT;
 
 	ret = 0;
 error_free_tfm:
@@ -410,6 +411,58 @@ static int tpm_key_encrypt(struct tpm_key *tk,
 	return ret;
 }
 
+/*
+ * Decryption operation is performed with the private key in the TPM.
+ */
+static int tpm_key_decrypt(struct tpm_key *tk,
+			   struct kernel_pkey_params *params,
+			   const void *in, void *out)
+{
+	struct tpm_buf *tb;
+	uint32_t keyhandle;
+	uint8_t srkauth[SHA1_DIGEST_SIZE];
+	uint8_t keyauth[SHA1_DIGEST_SIZE];
+	int r;
+
+	pr_devel("==>%s()\n", __func__);
+
+	if (params->hash_algo)
+		return -ENOPKG;
+
+	if (strcmp(params->encoding, "pkcs1"))
+		return -ENOPKG;
+
+	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
+	/* TODO: Handle a non-all zero SRK authorization */
+	memset(srkauth, 0, sizeof(srkauth));
+
+	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+				tk->blob, tk->blob_len, &keyhandle);
+	if (r < 0) {
+		pr_devel("loadkey2 failed (%d)\n", r);
+		goto error;
+	}
+
+	/* TODO: Handle a non-all zero key authorization */
+	memset(keyauth, 0, sizeof(keyauth));
+
+	r = tpm_unbind(tb, keyhandle, keyauth,
+		       in, params->in_len, out, params->out_len);
+	if (r < 0)
+		pr_devel("tpm_unbind failed (%d)\n", r);
+
+	if (tpm_flushspecific(tb, keyhandle) < 0)
+		pr_devel("flushspecific failed (%d)\n", r);
+
+error:
+	kzfree(tb);
+	pr_devel("<==%s() = %d\n", __func__, r);
+	return r;
+}
+
 /*
  * Do encryption, decryption and signing ops.
  */
@@ -424,6 +477,9 @@ static int tpm_key_eds_op(struct kernel_pkey_params *params,
 	case kernel_pkey_encrypt:
 		ret = tpm_key_encrypt(tk, params, in, out);
 		break;
+	case kernel_pkey_decrypt:
+		ret = tpm_key_decrypt(tk, params, in, out);
+		break;
 	default:
 		BUG();
 	}

