Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBDC204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xQudxrvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBDC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeKDHJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 02:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeKDHJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 02:09:56 -0500
Received: from sol.hsd1.wa.comcast.net (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E7420843;
        Sat,  3 Nov 2018 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541282243;
        bh=8gloTaZTfmGRJ4PcWKBo/zpqNNtmeGWgYr1ufJp5BjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQudxrvt9NdcF0JP5WzElzuK9H0on1IBZzqwkoOsas3QwZ0Tgo0UTVo6ozUjvIwwd
         Mw2aWFWx9vLkAPoFpqGagGIXFl2hfRkwpsuHjXupadzH8EyvUNG3tnTsZYtvgY68h7
         h8xmYyOKW2x0H0oV42pUZPQh0osfktWaw3EzuUgY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: crypto_user - fix leaking uninitialized memory to userspace
Date:   Sat,  3 Nov 2018 14:56:00 -0700
Message-Id: <20181103215603.16250-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181103215603.16250-1-ebiggers@kernel.org>
References: <20181103215603.16250-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

All bytes of the NETLINK_CRYPTO report structures must be initialized,
since they are copied to userspace.  The change from strncpy() to
strlcpy() broke this.  As a minimal fix, change it back.

Fixes: 4473710df1f8 ("crypto: user - Prepare for CRYPTO_MAX_ALG_NAME expansion")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/crypto_user_base.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/crypto/crypto_user_base.c b/crypto/crypto_user_base.c
index e41f6cc33fff4..784748dbb19f0 100644
--- a/crypto/crypto_user_base.c
+++ b/crypto/crypto_user_base.c
@@ -84,7 +84,7 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_report_cipher rcipher;
 
-	strlcpy(rcipher.type, "cipher", sizeof(rcipher.type));
+	strncpy(rcipher.type, "cipher", sizeof(rcipher.type));
 
 	rcipher.blocksize = alg->cra_blocksize;
 	rcipher.min_keysize = alg->cra_cipher.cia_min_keysize;
@@ -103,7 +103,7 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_report_comp rcomp;
 
-	strlcpy(rcomp.type, "compression", sizeof(rcomp.type));
+	strncpy(rcomp.type, "compression", sizeof(rcomp.type));
 	if (nla_put(skb, CRYPTOCFGA_REPORT_COMPRESS,
 		    sizeof(struct crypto_report_comp), &rcomp))
 		goto nla_put_failure;
@@ -117,7 +117,7 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_report_acomp racomp;
 
-	strlcpy(racomp.type, "acomp", sizeof(racomp.type));
+	strncpy(racomp.type, "acomp", sizeof(racomp.type));
 
 	if (nla_put(skb, CRYPTOCFGA_REPORT_ACOMP,
 		    sizeof(struct crypto_report_acomp), &racomp))
@@ -132,7 +132,7 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_report_akcipher rakcipher;
 
-	strlcpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
+	strncpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
 
 	if (nla_put(skb, CRYPTOCFGA_REPORT_AKCIPHER,
 		    sizeof(struct crypto_report_akcipher), &rakcipher))
@@ -147,7 +147,7 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_report_kpp rkpp;
 
-	strlcpy(rkpp.type, "kpp", sizeof(rkpp.type));
+	strncpy(rkpp.type, "kpp", sizeof(rkpp.type));
 
 	if (nla_put(skb, CRYPTOCFGA_REPORT_KPP,
 		    sizeof(struct crypto_report_kpp), &rkpp))
@@ -161,10 +161,10 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_one(struct crypto_alg *alg,
 			     struct crypto_user_alg *ualg, struct sk_buff *skb)
 {
-	strlcpy(ualg->cru_name, alg->cra_name, sizeof(ualg->cru_name));
-	strlcpy(ualg->cru_driver_name, alg->cra_driver_name,
+	strncpy(ualg->cru_name, alg->cra_name, sizeof(ualg->cru_name));
+	strncpy(ualg->cru_driver_name, alg->cra_driver_name,
 		sizeof(ualg->cru_driver_name));
-	strlcpy(ualg->cru_module_name, module_name(alg->cra_module),
+	strncpy(ualg->cru_module_name, module_name(alg->cra_module),
 		sizeof(ualg->cru_module_name));
 
 	ualg->cru_type = 0;
@@ -177,7 +177,7 @@ static int crypto_report_one(struct crypto_alg *alg,
 	if (alg->cra_flags & CRYPTO_ALG_LARVAL) {
 		struct crypto_report_larval rl;
 
-		strlcpy(rl.type, "larval", sizeof(rl.type));
+		strncpy(rl.type, "larval", sizeof(rl.type));
 		if (nla_put(skb, CRYPTOCFGA_REPORT_LARVAL,
 			    sizeof(struct crypto_report_larval), &rl))
 			goto nla_put_failure;
-- 
2.19.1

