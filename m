Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F78DECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0305C2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0305C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGSDIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:08:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730811AbeGSDIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:08:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CB6F4C392A08E;
        Thu, 19 Jul 2018 10:27:45 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 10:27:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: caif: Add a missing rcu_read_unlock() in caif_flow_cb
Date:   Thu, 19 Jul 2018 10:27:13 +0800
Message-ID: <20180719022713.17324-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing rcu_read_unlock in the error path

Fixes: c95567c80352 ("caif: added check for potential null return")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/caif/caif_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/caif/caif_dev.c b/net/caif/caif_dev.c
index e0adcd1..711d715 100644
--- a/net/caif/caif_dev.c
+++ b/net/caif/caif_dev.c
@@ -131,8 +131,10 @@ static void caif_flow_cb(struct sk_buff *skb)
 	caifd = caif_get(skb->dev);
 
 	WARN_ON(caifd == NULL);
-	if (caifd == NULL)
+	if (!caifd) {
+		rcu_read_unlock();
 		return;
+	}
 
 	caifd_hold(caifd);
 	rcu_read_unlock();
-- 
2.7.0


