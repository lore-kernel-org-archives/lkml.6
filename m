Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A757BC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE7B20848
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zRR0srys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE7B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeKDHJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 02:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeKDHJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 02:09:56 -0500
Received: from sol.hsd1.wa.comcast.net (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6454820847;
        Sat,  3 Nov 2018 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541282243;
        bh=zf8UElsAJpAqEIkJfSUprYWwvwwGW2YxzJo1avyyVI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRR0srysZvvv/1lfQEoKIxvLPZ54ftO2s7zR/doQ7Bk1Cq/uF3qJnKP9GjrGOM9Dm
         3F4nrGvbkNHDG0JN/I8349tGeC9fGXguroIvYq1k8Nafi/2EMtYMgQ5ZjIP8XA6Iuz
         wYny0Y3YQwNduNlcAyZF6HJht9WVhPy4W60F2DSs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] crypto: crypto_user_stat - Zeroize whole structure given to user space
Date:   Sat,  3 Nov 2018 14:56:01 -0700
Message-Id: <20181103215603.16250-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181103215603.16250-1-ebiggers@kernel.org>
References: <20181103215603.16250-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

For preventing uninitialized data to be given to user-space (and so leak
potential useful data), the crypto_stat structure must be correctly
initialized.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: cac5818c25d0 ("crypto: user - Implement a generic crypto statistics")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
[EB: also fix it in crypto_reportstat_one()]
[EB: use sizeof(var) rather than sizeof(type)]
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/crypto_user_stat.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 021ad06bbb628..1dfaa0ccd555b 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -37,6 +37,8 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&raead, 0, sizeof(raead));
+
 	strncpy(raead.type, "aead", sizeof(raead.type));
 
 	v32 = atomic_read(&alg->encrypt_cnt);
@@ -65,6 +67,8 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rcipher, 0, sizeof(rcipher));
+
 	strlcpy(rcipher.type, "cipher", sizeof(rcipher.type));
 
 	v32 = atomic_read(&alg->encrypt_cnt);
@@ -93,6 +97,8 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rcomp, 0, sizeof(rcomp));
+
 	strlcpy(rcomp.type, "compression", sizeof(rcomp.type));
 	v32 = atomic_read(&alg->compress_cnt);
 	rcomp.stat_compress_cnt = v32;
@@ -120,6 +126,8 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&racomp, 0, sizeof(racomp));
+
 	strlcpy(racomp.type, "acomp", sizeof(racomp.type));
 	v32 = atomic_read(&alg->compress_cnt);
 	racomp.stat_compress_cnt = v32;
@@ -147,6 +155,8 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rakcipher, 0, sizeof(rakcipher));
+
 	strncpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
 	v32 = atomic_read(&alg->encrypt_cnt);
 	rakcipher.stat_encrypt_cnt = v32;
@@ -177,6 +187,8 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 	struct crypto_stat rkpp;
 	u32 v;
 
+	memset(&rkpp, 0, sizeof(rkpp));
+
 	strlcpy(rkpp.type, "kpp", sizeof(rkpp.type));
 
 	v = atomic_read(&alg->setsecret_cnt);
@@ -203,6 +215,8 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rhash, 0, sizeof(rhash));
+
 	strncpy(rhash.type, "ahash", sizeof(rhash.type));
 
 	v32 = atomic_read(&alg->hash_cnt);
@@ -227,6 +241,8 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rhash, 0, sizeof(rhash));
+
 	strncpy(rhash.type, "shash", sizeof(rhash.type));
 
 	v32 = atomic_read(&alg->hash_cnt);
@@ -251,6 +267,8 @@ static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rrng, 0, sizeof(rrng));
+
 	strncpy(rrng.type, "rng", sizeof(rrng.type));
 
 	v32 = atomic_read(&alg->generate_cnt);
@@ -275,6 +293,8 @@ static int crypto_reportstat_one(struct crypto_alg *alg,
 				 struct crypto_user_alg *ualg,
 				 struct sk_buff *skb)
 {
+	memset(ualg, 0, sizeof(*ualg));
+
 	strlcpy(ualg->cru_name, alg->cra_name, sizeof(ualg->cru_name));
 	strlcpy(ualg->cru_driver_name, alg->cra_driver_name,
 		sizeof(ualg->cru_driver_name));
@@ -291,6 +311,7 @@ static int crypto_reportstat_one(struct crypto_alg *alg,
 	if (alg->cra_flags & CRYPTO_ALG_LARVAL) {
 		struct crypto_stat rl;
 
+		memset(&rl, 0, sizeof(rl));
 		strlcpy(rl.type, "larval", sizeof(rl.type));
 		if (nla_put(skb, CRYPTOCFGA_STAT_LARVAL,
 			    sizeof(struct crypto_stat), &rl))
-- 
2.19.1

