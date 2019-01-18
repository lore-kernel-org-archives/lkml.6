Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D051DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CA6214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfARF7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:59:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbfARF7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:59:02 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC9FB45E15388DB10ECF;
        Fri, 18 Jan 2019 13:58:59 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 13:58:51 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <ebiggers@kernel.org>
CC:     <wangxiongfeng2@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
        <ard.biesheuvel@linaro.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH V3 5/5] crypto: chacha20poly1305 - use template array registering API to simplify the code
Date:   Fri, 18 Jan 2019 13:58:15 +0800
Message-ID: <1547791095-48339-6-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1547791095-48339-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1547791095-48339-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongfeng Wang <xiongfeng.wang@linaro.org>

Use crypto template array registering API to simplify the code.

Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 crypto/chacha20poly1305.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/crypto/chacha20poly1305.c b/crypto/chacha20poly1305.c
index fef1144..ed2e12e 100644
--- a/crypto/chacha20poly1305.c
+++ b/crypto/chacha20poly1305.c
@@ -701,37 +701,28 @@ static int rfc7539esp_create(struct crypto_template *tmpl, struct rtattr **tb)
 	return chachapoly_create(tmpl, tb, "rfc7539esp", 8);
 }
 
-static struct crypto_template rfc7539_tmpl = {
-	.name = "rfc7539",
-	.create = rfc7539_create,
-	.module = THIS_MODULE,
-};
-
-static struct crypto_template rfc7539esp_tmpl = {
-	.name = "rfc7539esp",
-	.create = rfc7539esp_create,
-	.module = THIS_MODULE,
+static struct crypto_template rfc7539_tmpls[] = {
+	{
+		.name = "rfc7539",
+		.create = rfc7539_create,
+		.module = THIS_MODULE,
+	}, {
+		.name = "rfc7539esp",
+		.create = rfc7539esp_create,
+		.module = THIS_MODULE,
+	},
 };
 
 static int __init chacha20poly1305_module_init(void)
 {
-	int err;
-
-	err = crypto_register_template(&rfc7539_tmpl);
-	if (err)
-		return err;
-
-	err = crypto_register_template(&rfc7539esp_tmpl);
-	if (err)
-		crypto_unregister_template(&rfc7539_tmpl);
-
-	return err;
+	return crypto_register_templates(rfc7539_tmpls,
+					 ARRAY_SIZE(rfc7539_tmpls));
 }
 
 static void __exit chacha20poly1305_module_exit(void)
 {
-	crypto_unregister_template(&rfc7539esp_tmpl);
-	crypto_unregister_template(&rfc7539_tmpl);
+	crypto_unregister_templates(rfc7539_tmpls,
+				    ARRAY_SIZE(rfc7539_tmpls));
 }
 
 module_init(chacha20poly1305_module_init);
-- 
1.7.12.4

