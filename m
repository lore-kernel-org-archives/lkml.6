Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DD3C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EF620857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EF620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeIFRj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:39:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbeIFRj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:39:59 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 11369BB177D0F;
        Thu,  6 Sep 2018 21:04:30 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 6 Sep 2018
 21:04:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <alexander.h.duyck@intel.com>,
        <jeffrey.t.kirsher@intel.com>, <liran.alon@oracle.com>,
        <sridhar.samudrala@intel.com>, <stephen@networkplumber.org>,
        <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] failover: Fix error return code in net_failover_create
Date:   Thu, 6 Sep 2018 21:04:12 +0800
Message-ID: <20180906130412.21964-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if failover_register failed, 'err' code should be set correctly

Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/net_failover.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 192ae1c..cbcb9f2 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -761,8 +761,10 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	netif_carrier_off(failover_dev);
 
 	failover = failover_register(failover_dev, &net_failover_ops);
-	if (IS_ERR(failover))
+	if (IS_ERR(failover)) {
+		err = PTR_ERR(failover);
 		goto err_failover_register;
+	}
 
 	return failover;
 
-- 
2.7.0


