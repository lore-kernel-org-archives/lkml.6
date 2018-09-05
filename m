Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3CDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382C52073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382C52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeIFC12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:27:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18D7340241C0;
        Wed,  5 Sep 2018 21:55:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0F821049471;
        Wed,  5 Sep 2018 21:55:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/22] crypto: rsa-pkcs1pad: Allow hash to be optional
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:55:17 +0100
Message-ID: <153618451735.7946.814440477794930423.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 21:55:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 21:55:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
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

