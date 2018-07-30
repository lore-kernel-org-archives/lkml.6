Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D63AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA69320881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA69320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG3OnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:43:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbeG3OnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:43:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B85AF61C4F5B;
        Mon, 30 Jul 2018 21:07:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 30 Jul 2018
 21:07:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <roopa@cumulusnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <idosch@mellanox.com>, <dsahern@gmail.com>, <ktkhai@virtuozzo.com>,
        <sharpd@cumulusnetworks.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] fib_rules: NULL check before kfree is not needed
Date:   Mon, 30 Jul 2018 21:07:24 +0800
Message-ID: <20180730130724.20248-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(NULL) is safe,so this removes NULL check before freeing the mem

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/core/fib_rules.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index f64aa13..0ff3953 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -924,8 +924,7 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return 0;
 
 errout:
-	if (nlrule)
-		kfree(nlrule);
+	kfree(nlrule);
 	rules_ops_put(ops);
 	return err;
 }
-- 
2.7.0


