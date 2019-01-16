Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB99C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1609420859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfAPCvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:51:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17553 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729853AbfAPCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:51:32 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7BC2EBC3D61C7FD6D7C8;
        Wed, 16 Jan 2019 10:51:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 10:51:10 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <broonie@kernel.org>,
        <ard.biesheuvel@linaro.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH 2/5] crypto: ccm - use template array registering API to simplify the code
Date:   Wed, 16 Jan 2019 10:50:31 +0800
Message-ID: <1547607034-40948-3-git-send-email-wangxiongfeng2@huawei.com>
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
 crypto/ccm.c | 81 +++++++++++++++++++-----------------------------------------
 1 file changed, 26 insertions(+), 55 deletions(-)

diff --git a/crypto/ccm.c b/crypto/ccm.c
index b242fd0..8949aa2 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -589,12 +589,6 @@ static int crypto_ccm_create(struct crypto_template *tmpl, struct rtattr **tb)
 					mac_name);
 }
 
-static struct crypto_template crypto_ccm_tmpl = {
-	.name = "ccm",
-	.create = crypto_ccm_create,
-	.module = THIS_MODULE,
-};
-
 static int crypto_ccm_base_create(struct crypto_template *tmpl,
 				  struct rtattr **tb)
 {
@@ -618,12 +612,6 @@ static int crypto_ccm_base_create(struct crypto_template *tmpl,
 					cipher_name);
 }
 
-static struct crypto_template crypto_ccm_base_tmpl = {
-	.name = "ccm_base",
-	.create = crypto_ccm_base_create,
-	.module = THIS_MODULE,
-};
-
 static int crypto_rfc4309_setkey(struct crypto_aead *parent, const u8 *key,
 				 unsigned int keylen)
 {
@@ -854,12 +842,6 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 	goto out;
 }
 
-static struct crypto_template crypto_rfc4309_tmpl = {
-	.name = "rfc4309",
-	.create = crypto_rfc4309_create,
-	.module = THIS_MODULE,
-};
-
 static int crypto_cbcmac_digest_setkey(struct crypto_shash *parent,
 				     const u8 *inkey, unsigned int keylen)
 {
@@ -999,51 +981,40 @@ static int cbcmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 	return err;
 }
 
-static struct crypto_template crypto_cbcmac_tmpl = {
-	.name = "cbcmac",
-	.create = cbcmac_create,
-	.free = shash_free_instance,
-	.module = THIS_MODULE,
+static struct crypto_template crypto_ccm_tmpl[] = {
+	{
+		.name = "cbcmac",
+		.create = cbcmac_create,
+		.free = shash_free_instance,
+		.module = THIS_MODULE,
+	},
+	{
+		.name = "ccm_base",
+		.create = crypto_ccm_base_create,
+		.module = THIS_MODULE,
+	},
+	{
+		.name = "ccm",
+		.create = crypto_ccm_create,
+		.module = THIS_MODULE,
+	},
+	{
+		.name = "rfc4309",
+		.create = crypto_rfc4309_create,
+		.module = THIS_MODULE,
+	},
 };
 
 static int __init crypto_ccm_module_init(void)
 {
-	int err;
-
-	err = crypto_register_template(&crypto_cbcmac_tmpl);
-	if (err)
-		goto out;
-
-	err = crypto_register_template(&crypto_ccm_base_tmpl);
-	if (err)
-		goto out_undo_cbcmac;
-
-	err = crypto_register_template(&crypto_ccm_tmpl);
-	if (err)
-		goto out_undo_base;
-
-	err = crypto_register_template(&crypto_rfc4309_tmpl);
-	if (err)
-		goto out_undo_ccm;
-
-out:
-	return err;
-
-out_undo_ccm:
-	crypto_unregister_template(&crypto_ccm_tmpl);
-out_undo_base:
-	crypto_unregister_template(&crypto_ccm_base_tmpl);
-out_undo_cbcmac:
-	crypto_register_template(&crypto_cbcmac_tmpl);
-	goto out;
+	return crypto_register_templates(crypto_ccm_tmpl,
+			ARRAY_SIZE(crypto_ccm_tmpl));
 }
 
 static void __exit crypto_ccm_module_exit(void)
 {
-	crypto_unregister_template(&crypto_rfc4309_tmpl);
-	crypto_unregister_template(&crypto_ccm_tmpl);
-	crypto_unregister_template(&crypto_ccm_base_tmpl);
-	crypto_unregister_template(&crypto_cbcmac_tmpl);
+	crypto_unregister_templates(crypto_ccm_tmpl,
+			ARRAY_SIZE(crypto_ccm_tmpl));
 }
 
 module_init(crypto_ccm_module_init);
-- 
1.7.12.4

