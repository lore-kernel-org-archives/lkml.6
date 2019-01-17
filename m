Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C00520657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfAQGtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:49:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfAQGsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:48:53 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7129674A3DCE02FC3AF6;
        Thu, 17 Jan 2019 14:48:50 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Thu, 17 Jan 2019 14:48:42 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <ebiggers@kernel.org>
CC:     <wangxiongfeng2@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
        <ard.biesheuvel@linaro.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH V2 1/5] crypto: api - add a helper to (un)register a array of templates
Date:   Thu, 17 Jan 2019 14:47:59 +0800
Message-ID: <1547707683-45878-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1547707683-45878-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1547707683-45878-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a helper to (un)register a array of templates. The
following patches will use this helper to simplify the code.

Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
---
 crypto/algapi.c         | 27 +++++++++++++++++++++++++++
 include/crypto/algapi.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 713baab..4c9c86b 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -494,6 +494,24 @@ int crypto_register_template(struct crypto_template *tmpl)
 }
 EXPORT_SYMBOL_GPL(crypto_register_template);
 
+int crypto_register_templates(struct crypto_template *tmpls, int count)
+{
+	int i, err;
+
+	for (i = 0; i < count; i++) {
+		err = crypto_register_template(&tmpls[i]);
+		if (err)
+			goto out;
+	}
+	return 0;
+
+out:
+	for (--i; i >= 0; --i)
+		crypto_unregister_template(&tmpls[i]);
+	return err;
+}
+EXPORT_SYMBOL_GPL(crypto_register_templates);
+
 void crypto_unregister_template(struct crypto_template *tmpl)
 {
 	struct crypto_instance *inst;
@@ -523,6 +541,15 @@ void crypto_unregister_template(struct crypto_template *tmpl)
 }
 EXPORT_SYMBOL_GPL(crypto_unregister_template);
 
+void crypto_unregister_templates(struct crypto_template *tmpls, int count)
+{
+	int i;
+
+	for (i = count - 1; i >= 0; --i)
+		crypto_unregister_template(&tmpls[i]);
+}
+EXPORT_SYMBOL_GPL(crypto_unregister_templates);
+
 static struct crypto_template *__crypto_lookup_template(const char *name)
 {
 	struct crypto_template *q, *tmpl = NULL;
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 093869f..4be38cd 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -143,7 +143,9 @@ struct ablkcipher_walk {
 void crypto_mod_put(struct crypto_alg *alg);
 
 int crypto_register_template(struct crypto_template *tmpl);
+int crypto_register_templates(struct crypto_template *tmpls, int count);
 void crypto_unregister_template(struct crypto_template *tmpl);
+void crypto_unregister_templates(struct crypto_template *tmpls, int count);
 struct crypto_template *crypto_lookup_template(const char *name);
 
 int crypto_register_instance(struct crypto_template *tmpl,
-- 
1.7.12.4

