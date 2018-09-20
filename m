Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467EAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEABF20880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEABF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeITPw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:52:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730984AbeITPw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:52:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5958C6369CED;
        Thu, 20 Sep 2018 18:09:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 18:09:38 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <harsh@chelsio.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto : chtls: remove redundant null pointer check before kfree_skb
Date:   Thu, 20 Sep 2018 17:57:16 +0800
Message-ID: <1537437436-43088-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree_skb has taken the null pointer into account. hence it is safe
to remove the redundant null pointer check before kfree_skb.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/crypto/chelsio/chtls/chtls_cm.c   | 3 +--
 drivers/crypto/chelsio/chtls/chtls_main.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
index 0997e16..fd2ae1e 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -234,8 +234,7 @@ static void chtls_send_reset(struct sock *sk, int mode, struct sk_buff *skb)
 
 	return;
 out:
-	if (skb)
-		kfree_skb(skb);
+	kfree_skb(skb);
 }
 
 static void release_tcp_port(struct sock *sk)
diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/chelsio/chtls/chtls_main.c
index f59b044..f472c51 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -272,8 +272,7 @@ static void chtls_free_uld(struct chtls_dev *cdev)
 	for (i = 0; i < (1 << RSPQ_HASH_BITS); i++)
 		kfree_skb(cdev->rspq_skb_cache[i]);
 	kfree(cdev->lldi);
-	if (cdev->askb)
-		kfree_skb(cdev->askb);
+	kfree_skb(cdev->askb);
 	kfree(cdev);
 }
 
-- 
1.7.12.4

