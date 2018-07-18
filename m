Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C939ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291E22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291E22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeGRITQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:19:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728861AbeGRITP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:19:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45CBA3593EA92;
        Wed, 18 Jul 2018 15:42:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 15:42:21 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>,
        <herbert@gondor.apana.org.au>
CC:     <dm-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <broonie@kernel.org>, <arnd@arndb.de>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH 1/5] crypto: api - introduce API to (un)register a array of templates
Date:   Wed, 18 Jul 2018 15:30:51 +0800
Message-ID: <1531899055-29362-2-git-send-email-wangxiongfeng2@huawei.com>
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

The following patch introduce several crypto templates. To simplify the
code, this patch add two APIs to (un)register a array of templates.

Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
---
 crypto/algapi.c         | 27 +++++++++++++++++++++++++++
 include/crypto/algapi.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0755cf..08c29e6 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -485,6 +485,24 @@ int crypto_register_template(struct crypto_template *tmpl)
 }
 EXPORT_SYMBOL_GPL(crypto_register_template);
 
+int crypto_register_template_array(struct crypto_template *tmpl, int num)
+{
+	int i, err;
+
+	for (i = 0; i < num; i++) {
+		err = crypto_register_template(&tmpl[i]);
+		if (err)
+			goto out;
+	}
+	return 0;
+
+out:
+	for (i -= 1; i >= 0; i--)
+		crypto_unregister_template(&tmpl[i]);
+	return err;
+}
+EXPORT_SYMBOL_GPL(crypto_register_template_array);
+
 void crypto_unregister_template(struct crypto_template *tmpl)
 {
 	struct crypto_instance *inst;
@@ -514,6 +532,15 @@ void crypto_unregister_template(struct crypto_template *tmpl)
 }
 EXPORT_SYMBOL_GPL(crypto_unregister_template);
 
+void crypto_unregister_template_array(struct crypto_template *tmpl, int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		crypto_unregister_template(&tmpl[i]);
+}
+EXPORT_SYMBOL_GPL(crypto_unregister_template_array);
+
 static struct crypto_template *__crypto_lookup_template(const char *name)
 {
 	struct crypto_template *q, *tmpl = NULL;
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index bd5e8cc..14bfbe31 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -141,7 +141,9 @@ struct ablkcipher_walk {
 void crypto_mod_put(struct crypto_alg *alg);
 
 int crypto_register_template(struct crypto_template *tmpl);
+int crypto_register_template_array(struct crypto_template *tmpl, int num);
 void crypto_unregister_template(struct crypto_template *tmpl);
+void crypto_unregister_template_array(struct crypto_template *tmpl, int num);
 struct crypto_template *crypto_lookup_template(const char *name);
 
 int crypto_register_instance(struct crypto_template *tmpl,
-- 
1.7.12.4

