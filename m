Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A4C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617C420831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pPsv0b2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617C420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393651AbeKVUjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:39:53 -0500
Received: from m12-14.163.com ([220.181.12.14]:49933 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390330AbeKVUjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=AvYeQh1yeGK7rPhdeT
        ptzjlRCeoXDMojg/A8aa/hvys=; b=pPsv0b2k7CX8TIhSbUSi9pjsq5gl0Ypw1e
        rHbVEel5zzEgxeYI+Ueo29c/jDnNIeRoB3IMRIFY0u9p1/VCUcNp9wN7GAiOPnDE
        WlMbpoWzYXtNrDcX2lwrK3+qVElgaC/AAzIoliZBT2xth0FORrwmvSjRamiSDUII
        F9++VVZIM=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp10 (Coremail) with SMTP id DsCowAAnpdFWfvZbdqJJBQ--.64751S3;
        Thu, 22 Nov 2018 18:00:57 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] crypto: do not free algorithm before using
Date:   Thu, 22 Nov 2018 18:00:16 +0800
Message-Id: <1542880816-63838-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowAAnpdFWfvZbdqJJBQ--.64751S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyrCF4fXFW3Zw1kCrWUtwb_yoW5Zr1Dpr
        Z5KrWktFn5Jrs8urZ7GFs5XrykWrW09a43WrW8Kw4ayrs2qw18JrWIyry5AF4j9FWkJa43
        GFWvkr1F9a1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDa9-UUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZxoHcletsFUyfQAAsY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multiple functions, the algorithm fields are read after its reference
is dropped through crypto_mod_put. In this case, the algorithm memory
may be freed, resulting in use-after-free bugs. This patch delays the
put operation until the algorithm is never used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 crypto/cbc.c  | 6 ++++--
 crypto/cfb.c  | 6 ++++--
 crypto/pcbc.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/crypto/cbc.c b/crypto/cbc.c
index b761b1f..dd5f332 100644
--- a/crypto/cbc.c
+++ b/crypto/cbc.c
@@ -140,9 +140,8 @@ static int crypto_cbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 	spawn = skcipher_instance_ctx(inst);
 	err = crypto_init_spawn(spawn, alg, skcipher_crypto_instance(inst),
 				CRYPTO_ALG_TYPE_MASK);
-	crypto_mod_put(alg);
 	if (err)
-		goto err_free_inst;
+		goto err_put_alg;
 
 	err = crypto_inst_setname(skcipher_crypto_instance(inst), "cbc", alg);
 	if (err)
@@ -174,12 +173,15 @@ static int crypto_cbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
 		goto err_drop_spawn;
+	crypto_mod_put(alg);
 
 out:
 	return err;
 
 err_drop_spawn:
 	crypto_drop_spawn(spawn);
+err_put_alg:
+	crypto_mod_put(alg);
 err_free_inst:
 	kfree(inst);
 	goto out;
diff --git a/crypto/cfb.c b/crypto/cfb.c
index a0d68c0..20987d0 100644
--- a/crypto/cfb.c
+++ b/crypto/cfb.c
@@ -286,9 +286,8 @@ static int crypto_cfb_create(struct crypto_template *tmpl, struct rtattr **tb)
 	spawn = skcipher_instance_ctx(inst);
 	err = crypto_init_spawn(spawn, alg, skcipher_crypto_instance(inst),
 				CRYPTO_ALG_TYPE_MASK);
-	crypto_mod_put(alg);
 	if (err)
-		goto err_free_inst;
+		goto err_put_alg;
 
 	err = crypto_inst_setname(skcipher_crypto_instance(inst), "cfb", alg);
 	if (err)
@@ -317,12 +316,15 @@ static int crypto_cfb_create(struct crypto_template *tmpl, struct rtattr **tb)
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
 		goto err_drop_spawn;
+	crypto_mod_put(alg);
 
 out:
 	return err;
 
 err_drop_spawn:
 	crypto_drop_spawn(spawn);
+err_put_alg:
+	crypto_mod_put(alg);
 err_free_inst:
 	kfree(inst);
 	goto out;
diff --git a/crypto/pcbc.c b/crypto/pcbc.c
index ef802f6..8aa1014 100644
--- a/crypto/pcbc.c
+++ b/crypto/pcbc.c
@@ -244,9 +244,8 @@ static int crypto_pcbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 	spawn = skcipher_instance_ctx(inst);
 	err = crypto_init_spawn(spawn, alg, skcipher_crypto_instance(inst),
 				CRYPTO_ALG_TYPE_MASK);
-	crypto_mod_put(alg);
 	if (err)
-		goto err_free_inst;
+		goto err_put_alg;
 
 	err = crypto_inst_setname(skcipher_crypto_instance(inst), "pcbc", alg);
 	if (err)
@@ -275,12 +274,15 @@ static int crypto_pcbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
 		goto err_drop_spawn;
+	crypto_mod_put(alg);
 
 out:
 	return err;
 
 err_drop_spawn:
 	crypto_drop_spawn(spawn);
+err_put_alg:
+	crypto_mod_put(alg);
 err_free_inst:
 	kfree(inst);
 	goto out;
-- 
2.7.4


