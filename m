Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40549C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC058218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfA3U41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:56:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728824AbfA3U4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:22 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 05C74E2A96A1AE3C1DD9;
        Thu, 31 Jan 2019 04:56:20 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:13 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: use the correct interface to stop|open port
Date:   Thu, 31 Jan 2019 04:55:43 +0800
Message-ID: <20190130205552.8512-4-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190130205552.8512-1-tanhuazhong@huawei.com>
References: <20190130205552.8512-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

dev_close() stop the netdev and the service base on the netdev
will stop. But ndev->netdev_ops->ndo_stop() may only stop HW
and stack queue, the service base on the netdev can still work.

Fixes: 5668abda0931 ("net: hns3: add support for set_ringparam")
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 76ef06a7c261..63f5f56bda94 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -805,7 +805,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
 		    old_desc_num, new_desc_num);
 
 	if (if_running)
-		dev_close(ndev);
+		ndev->netdev_ops->ndo_stop(ndev);
 
 	ret = hns3_uninit_all_ring(priv);
 	if (ret)
@@ -822,7 +822,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	}
 
 	if (if_running)
-		ret = dev_open(ndev, NULL);
+		ret = ndev->netdev_ops->ndo_open(ndev);
 
 	return ret;
 }
-- 
2.20.1


