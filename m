Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F17C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7D3204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pox2AKVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7D3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeKDHJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 02:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeKDHJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 02:09:56 -0500
Received: from sol.hsd1.wa.comcast.net (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C4020848;
        Sat,  3 Nov 2018 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541282243;
        bh=+rk4VpdyoY6VvOX/WJPgp95sk+iRq7vKVQ/0NLzV96A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pox2AKVUp1RHNbtiJ8RlD8fABR0cb1TZ6KgqsMtoG/AT0xWbs4oNwm3395Lbuu9YA
         da4+NbSmI+AUkigYg9ETs4Upramydvxr8u9pPO0MaoTZsEVFTSDXTl3tSy9YstY+uu
         YS8x1pqZcl/vRZtAvuJwGgXu9K4PdZg0KX95Dr38=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: crypto_user - remove redundant reporting functions
Date:   Sat,  3 Nov 2018 14:56:02 -0700
Message-Id: <20181103215603.16250-4-ebiggers@kernel.org>
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

The acomp, akcipher, and kpp algorithm types already have .report
methods defined, so there's no need to duplicate this functionality in
crypto_user itself; the duplicate functions are actually never executed.
Remove the unused code.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/crypto_user_base.c | 59 ---------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/crypto/crypto_user_base.c b/crypto/crypto_user_base.c
index 784748dbb19f0..1ecd9b08e38f4 100644
--- a/crypto/crypto_user_base.c
+++ b/crypto/crypto_user_base.c
@@ -113,51 +113,6 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 	return -EMSGSIZE;
 }
 
-static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
-{
-	struct crypto_report_acomp racomp;
-
-	strncpy(racomp.type, "acomp", sizeof(racomp.type));
-
-	if (nla_put(skb, CRYPTOCFGA_REPORT_ACOMP,
-		    sizeof(struct crypto_report_acomp), &racomp))
-		goto nla_put_failure;
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
-{
-	struct crypto_report_akcipher rakcipher;
-
-	strncpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
-
-	if (nla_put(skb, CRYPTOCFGA_REPORT_AKCIPHER,
-		    sizeof(struct crypto_report_akcipher), &rakcipher))
-		goto nla_put_failure;
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
-{
-	struct crypto_report_kpp rkpp;
-
-	strncpy(rkpp.type, "kpp", sizeof(rkpp.type));
-
-	if (nla_put(skb, CRYPTOCFGA_REPORT_KPP,
-		    sizeof(struct crypto_report_kpp), &rkpp))
-		goto nla_put_failure;
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
 static int crypto_report_one(struct crypto_alg *alg,
 			     struct crypto_user_alg *ualg, struct sk_buff *skb)
 {
@@ -202,20 +157,6 @@ static int crypto_report_one(struct crypto_alg *alg,
 			goto nla_put_failure;
 
 		break;
-	case CRYPTO_ALG_TYPE_ACOMPRESS:
-		if (crypto_report_acomp(skb, alg))
-			goto nla_put_failure;
-
-		break;
-	case CRYPTO_ALG_TYPE_AKCIPHER:
-		if (crypto_report_akcipher(skb, alg))
-			goto nla_put_failure;
-
-		break;
-	case CRYPTO_ALG_TYPE_KPP:
-		if (crypto_report_kpp(skb, alg))
-			goto nla_put_failure;
-		break;
 	}
 
 out:
-- 
2.19.1

