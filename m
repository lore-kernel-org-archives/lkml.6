Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E3CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3832087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3832087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJJAFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeJJAFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F24736807;
        Tue,  9 Oct 2018 16:47:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DFD2600CD;
        Tue,  9 Oct 2018 16:47:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/22] crypto: rsa-pkcs1pad: Allow hash to be optional [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Denis Kenzior <denkenz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Holtmann <marcel@holtmann.org>, dhowells@redhat.com,
        denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 17:47:53 +0100
Message-ID: <153910367369.12141.13351167409478803724.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 09 Oct 2018 16:47:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

The original pkcs1pad implementation allowed to pad/unpad raw RSA
output.  However, this has been taken out in commit:
commit c0d20d22e0ad ("crypto: rsa-pkcs1pad - Require hash to be present")

This patch restored this ability as it is needed by the asymmetric key
implementation.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
---

 crypto/rsa-pkcs1pad.c |   59 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index 9893dbfc1af4..27b1e2bd4bfb 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -401,7 +401,8 @@ static int pkcs1pad_sign(struct akcipher_request *req)
 	if (!ctx->key_size)
 		return -EINVAL;
 
-	digest_size = digest_info->size;
+	if (digest_info)
+		digest_size = digest_info->size;
 
 	if (req->src_len + digest_size > ctx->key_size - 11)
 		return -EOVERFLOW;
@@ -421,8 +422,9 @@ static int pkcs1pad_sign(struct akcipher_request *req)
 	memset(req_ctx->in_buf + 1, 0xff, ps_end - 1);
 	req_ctx->in_buf[ps_end] = 0x00;
 
-	memcpy(req_ctx->in_buf + ps_end + 1, digest_info->data,
-	       digest_info->size);
+	if (digest_info)
+		memcpy(req_ctx->in_buf + ps_end + 1, digest_info->data,
+		       digest_info->size);
 
 	pkcs1pad_sg_set_buf(req_ctx->in_sg, req_ctx->in_buf,
 			ctx->key_size - 1 - req->src_len, req->src);
@@ -484,10 +486,13 @@ static int pkcs1pad_verify_complete(struct akcipher_request *req, int err)
 		goto done;
 	pos++;
 
-	if (crypto_memneq(out_buf + pos, digest_info->data, digest_info->size))
-		goto done;
+	if (digest_info) {
+		if (crypto_memneq(out_buf + pos, digest_info->data,
+				  digest_info->size))
+			goto done;
 
-	pos += digest_info->size;
+		pos += digest_info->size;
+	}
 
 	err = 0;
 
@@ -617,11 +622,14 @@ static int pkcs1pad_create(struct crypto_template *tmpl, struct rtattr **tb)
 
 	hash_name = crypto_attr_alg_name(tb[2]);
 	if (IS_ERR(hash_name))
-		return PTR_ERR(hash_name);
+		hash_name = NULL;
 
-	digest_info = rsa_lookup_asn1(hash_name);
-	if (!digest_info)
-		return -EINVAL;
+	if (hash_name) {
+		digest_info = rsa_lookup_asn1(hash_name);
+		if (!digest_info)
+			return -EINVAL;
+	} else
+		digest_info = NULL;
 
 	inst = kzalloc(sizeof(*inst) + sizeof(*ctx), GFP_KERNEL);
 	if (!inst)
@@ -641,14 +649,29 @@ static int pkcs1pad_create(struct crypto_template *tmpl, struct rtattr **tb)
 
 	err = -ENAMETOOLONG;
 
-	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
-		     "pkcs1pad(%s,%s)", rsa_alg->base.cra_name, hash_name) >=
-	    CRYPTO_MAX_ALG_NAME ||
-	    snprintf(inst->alg.base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
-		     "pkcs1pad(%s,%s)",
-		     rsa_alg->base.cra_driver_name, hash_name) >=
-	    CRYPTO_MAX_ALG_NAME)
-		goto out_drop_alg;
+	if (!hash_name) {
+		if (snprintf(inst->alg.base.cra_name,
+			     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s)",
+			     rsa_alg->base.cra_name) >= CRYPTO_MAX_ALG_NAME)
+			goto out_drop_alg;
+
+		if (snprintf(inst->alg.base.cra_driver_name,
+			     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s)",
+			     rsa_alg->base.cra_driver_name) >=
+			     CRYPTO_MAX_ALG_NAME)
+			goto out_drop_alg;
+	} else {
+		if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
+			     "pkcs1pad(%s,%s)", rsa_alg->base.cra_name,
+			     hash_name) >= CRYPTO_MAX_ALG_NAME)
+			goto out_drop_alg;
+
+		if (snprintf(inst->alg.base.cra_driver_name,
+			     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s,%s)",
+			     rsa_alg->base.cra_driver_name,
+			     hash_name) >= CRYPTO_MAX_ALG_NAME)
+			goto out_drop_alg;
+	}
 
 	inst->alg.base.cra_flags = rsa_alg->base.cra_flags & CRYPTO_ALG_ASYNC;
 	inst->alg.base.cra_priority = rsa_alg->base.cra_priority;

