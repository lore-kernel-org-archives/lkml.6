Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF529ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFE82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFE82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeGRITS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:19:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729010AbeGRITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:19:17 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8998ED424EC39;
        Wed, 18 Jul 2018 15:42:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 15:42:23 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>,
        <herbert@gondor.apana.org.au>
CC:     <dm-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <broonie@kernel.org>, <arnd@arndb.de>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH 3/5] crypto: gcm - use template array registering API to simplify the code
Date:   Wed, 18 Jul 2018 15:30:53 +0800
Message-ID: <1531899055-29362-4-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
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
index 0ad879e..b180536 100644
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
@@ -1231,10 +1213,29 @@ static int crypto_rfc4543_create(struct crypto_template *tmpl,
 	goto out;
 }
 
-static struct crypto_template crypto_rfc4543_tmpl = {
-	.name = "rfc4543",
-	.create = crypto_rfc4543_create,
-	.module = THIS_MODULE,
+#define GCM_TEMPLATE_NUM 4
+
+static struct crypto_template crypto_gcm_tmpl[GCM_TEMPLATE_NUM] = {
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
@@ -1247,42 +1248,17 @@ static int __init crypto_gcm_module_init(void)
 
 	sg_init_one(&gcm_zeroes->sg, gcm_zeroes->buf, sizeof(gcm_zeroes->buf));
 
-	err = crypto_register_template(&crypto_gcm_base_tmpl);
-	if (err)
-		goto out;
-
-	err = crypto_register_template(&crypto_gcm_tmpl);
+	err = crypto_register_template_array(crypto_gcm_tmpl, GCM_TEMPLATE_NUM);
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
+	crypto_unregister_template_array(crypto_gcm_tmpl, GCM_TEMPLATE_NUM);
 }
 
 module_init(crypto_gcm_module_init);
-- 
1.7.12.4

