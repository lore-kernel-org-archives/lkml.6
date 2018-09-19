Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF96C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BFA2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BFA2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeISSGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:06:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731070AbeISSGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:06:34 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5AC3FACF0D9F;
        Wed, 19 Sep 2018 20:28:47 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 20:28:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <parav@mellanox.com>, <danielj@mellanox.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/core: Properly return the error code of rdma_set_src_addr_rcu
Date:   Wed, 19 Sep 2018 20:28:38 +0800
Message-ID: <20180919122838.28184-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdma_set_src_addr_rcu should check copy_src_l2_addr fails,
rather than always return 0. Also copy_src_l2_addr should return
'ret' as its return value while rdma_translate_ip fails.

Fixes: c31d4b2ddf07 ("RDMA/core: Protect against changing dst->dev during destination resolve")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/core/addr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 7a0356c..8a31b11 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -468,7 +468,7 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 	return ret;
 }
 
-static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
+static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
 			     const struct sockaddr *dst_in,
 			     const struct dst_entry *dst,
 			     const struct net_device *ndev)
@@ -492,6 +492,8 @@ static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
 						RDMA_NETWORK_IPV6;
 	else
 		dev_addr->network = RDMA_NETWORK_IB;
+
+	return ret;
 }
 
 static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
@@ -499,6 +501,7 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
 				 const struct sockaddr *dst_in,
 				 const struct dst_entry *dst)
 {
+	int ret;
 	struct net_device *ndev = READ_ONCE(dst->dev);
 
 	*ndev_flags = ndev->flags;
@@ -515,8 +518,8 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
 			return -ENODEV;
 	}
 
-	copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
-	return 0;
+	ret = copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
+	return ret;
 }
 
 static int set_addr_netns_by_gid_rcu(struct rdma_dev_addr *addr)
-- 
2.7.0


