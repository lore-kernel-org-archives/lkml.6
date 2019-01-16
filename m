Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A502C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D5920859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfAPCvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:51:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730079AbfAPCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:51:32 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5808051869300664AB37;
        Wed, 16 Jan 2019 10:51:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 10:51:10 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <broonie@kernel.org>,
        <ard.biesheuvel@linaro.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH 3/5] crypto: gcm - use template array registering API to simplify the code
Date:   Wed, 16 Jan 2019 10:50:32 +0800
Message-ID: <1547607034-40948-4-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use crypto template array registering API to simplify the code.

Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
---
 crypto/gcm.c | 76 +++++++++++++++++++++---------------------------------------
 1 file changed, 26 insertions(+), 50 deletions(-)

diff --git a/crypto/gcm.c b/crypto/gcm.c
index e438492..c8d5fe3 100644
--- a/crypto/gcm.c
+++ b/crypto/gcm.c
@@ -727,12 +727,6 @@ static int crypto_gcm_create(struct crypto_template *tmpl, struct rtattr **tb)
 					ctr_name, "ghash");
 }
 
-static struct crypto_template crypto_gcm_tmpl = {
-	.name = "gcm",
-	.create = crypto_gcm_create,
-	.module = THIS_MODULE,
-};
-
 static int crypto_gcm_base_create(struct crypto_template *tmpl,
 				  struct rtattr **tb)
 {
@@ -756,12 +750,6 @@ static int crypto_gcm_base_create(struct crypto_template *tmpl,
 					ctr_name, ghash_name);
 }
 
-static struct crypto_template crypto_gcm_base_tmpl = {
-	.name = "gcm_base",
-	.create = crypto_gcm_base_create,
-	.module = THIS_MODULE,
-};
-
 static int crypto_rfc4106_setkey(struct crypto_aead *parent, const u8 *key,
 				 unsigned int keylen)
 {
@@ -989,12 +977,6 @@ static int crypto_rfc4106_create(struct crypto_template *tmpl,
 	goto out;
 }
 
-static struct crypto_template crypto_rfc4106_tmpl = {
-	.name = "rfc4106",
-	.create = crypto_rfc4106_create,
-	.module = THIS_MODULE,
-};
-
 static int crypto_rfc4543_setkey(struct crypto_aead *parent, const u8 *key,
 				 unsigned int keylen)
 {
@@ -1231,10 +1213,27 @@ static int crypto_rfc4543_create(struct crypto_template *tmpl,
 	goto out;
 }
 
-static struct crypto_template crypto_rfc4543_tmpl = {
-	.name = "rfc4543",
-	.create = crypto_rfc4543_create,
-	.module = THIS_MODULE,
+static struct crypto_template crypto_gcm_tmpl[] = {
+	{
+		.name = "gcm_base",
+		.create = crypto_gcm_base_create,
+		.module = THIS_MODULE,
+	},
+	{
+		.name = "gcm",
+		.create = crypto_gcm_create,
+		.module = THIS_MODULE,
+	},
+	{
+		.name = "rfc4106",
+		.create = crypto_rfc4106_create,
+		.module = THIS_MODULE,
+	},
+	{
+		.name = "rfc4543",
+		.create = crypto_rfc4543_create,
+		.module = THIS_MODULE,
+	},
 };
 
 static int __init crypto_gcm_module_init(void)
@@ -1247,42 +1246,19 @@ static int __init crypto_gcm_module_init(void)
 
 	sg_init_one(&gcm_zeroes->sg, gcm_zeroes->buf, sizeof(gcm_zeroes->buf));
 
-	err = crypto_register_template(&crypto_gcm_base_tmpl);
-	if (err)
-		goto out;
-
-	err = crypto_register_template(&crypto_gcm_tmpl);
+	err = crypto_register_templates(crypto_gcm_tmpl,
+			ARRAY_SIZE(crypto_gcm_tmpl));
 	if (err)
-		goto out_undo_base;
+		kfree(gcm_zeroes);
 
-	err = crypto_register_template(&crypto_rfc4106_tmpl);
-	if (err)
-		goto out_undo_gcm;
-
-	err = crypto_register_template(&crypto_rfc4543_tmpl);
-	if (err)
-		goto out_undo_rfc4106;
-
-	return 0;
-
-out_undo_rfc4106:
-	crypto_unregister_template(&crypto_rfc4106_tmpl);
-out_undo_gcm:
-	crypto_unregister_template(&crypto_gcm_tmpl);
-out_undo_base:
-	crypto_unregister_template(&crypto_gcm_base_tmpl);
-out:
-	kfree(gcm_zeroes);
 	return err;
 }
 
 static void __exit crypto_gcm_module_exit(void)
 {
 	kfree(gcm_zeroes);
-	crypto_unregister_template(&crypto_rfc4543_tmpl);
-	crypto_unregister_template(&crypto_rfc4106_tmpl);
-	crypto_unregister_template(&crypto_gcm_tmpl);
-	crypto_unregister_template(&crypto_gcm_base_tmpl);
+	crypto_unregister_templates(crypto_gcm_tmpl,
+			ARRAY_SIZE(crypto_gcm_tmpl));
 }
 
 module_init(crypto_gcm_module_init);
-- 
1.7.12.4

