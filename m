Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0172DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09FC2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfAPCve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:51:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730077AbfAPCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:51:32 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 76A67A81942323EFEBDA;
        Wed, 16 Jan 2019 10:51:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 10:51:11 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <broonie@kernel.org>,
        <ard.biesheuvel@linaro.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH 4/5] crypto: ctr - use template array registering API to simplify the code
Date:   Wed, 16 Jan 2019 10:50:33 +0800
Message-ID: <1547607034-40948-5-git-send-email-wangxiongfeng2@huawei.com>
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
 crypto/ctr.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/crypto/ctr.c b/crypto/ctr.c
index 30f3946..ef51099 100644
--- a/crypto/ctr.c
+++ b/crypto/ctr.c
@@ -248,13 +248,6 @@ static void crypto_ctr_free(struct crypto_instance *inst)
 	kfree(inst);
 }
 
-static struct crypto_template crypto_ctr_tmpl = {
-	.name = "ctr",
-	.alloc = crypto_ctr_alloc,
-	.free = crypto_ctr_free,
-	.module = THIS_MODULE,
-};
-
 static int crypto_rfc3686_setkey(struct crypto_skcipher *parent,
 				 const u8 *key, unsigned int keylen)
 {
@@ -444,36 +437,31 @@ static int crypto_rfc3686_create(struct crypto_template *tmpl,
 	goto out;
 }
 
-static struct crypto_template crypto_rfc3686_tmpl = {
-	.name = "rfc3686",
-	.create = crypto_rfc3686_create,
-	.module = THIS_MODULE,
+static struct crypto_template crypto_ctr_tmpl[] = {
+	{
+		.name = "ctr",
+		.alloc = crypto_ctr_alloc,
+		.free = crypto_ctr_free,
+		.module = THIS_MODULE,
+	},
+	{
+		.name = "rfc3686",
+		.create = crypto_rfc3686_create,
+		.module = THIS_MODULE,
+	},
 };
 
+
 static int __init crypto_ctr_module_init(void)
 {
-	int err;
-
-	err = crypto_register_template(&crypto_ctr_tmpl);
-	if (err)
-		goto out;
-
-	err = crypto_register_template(&crypto_rfc3686_tmpl);
-	if (err)
-		goto out_drop_ctr;
-
-out:
-	return err;
-
-out_drop_ctr:
-	crypto_unregister_template(&crypto_ctr_tmpl);
-	goto out;
+	return crypto_register_templates(crypto_ctr_tmpl,
+			ARRAY_SIZE(crypto_ctr_tmpl));
 }
 
 static void __exit crypto_ctr_module_exit(void)
 {
-	crypto_unregister_template(&crypto_rfc3686_tmpl);
-	crypto_unregister_template(&crypto_ctr_tmpl);
+	crypto_unregister_templates(crypto_ctr_tmpl,
+			ARRAY_SIZE(crypto_ctr_tmpl));
 }
 
 module_init(crypto_ctr_module_init);
-- 
1.7.12.4

