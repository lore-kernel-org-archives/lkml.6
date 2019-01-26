Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B684C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DBC214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfAZQup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbfAZQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:05 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1D4CE4556EB623CF008A;
        Sun, 27 Jan 2019 00:49:59 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:48 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: fix return value handle issue for hclge_set_loopback()
Date:   Sun, 27 Jan 2019 00:49:13 +0800
Message-ID: <20190126164921.3872-5-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190126164921.3872-1-tanhuazhong@huawei.com>
References: <20190126164921.3872-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In current code, it always return 0, even loopback mode setting failed.
It's incorrect. This patch fixes return value handle for loopback test.

Fixes: 0f29fc23b21d ("net: hns3: Fix for loopback selftest failed problem")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c      | 8 ++++----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index abb78696d7ce..ed73f7fc9171 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -117,7 +117,7 @@ static int hns3_lp_up(struct net_device *ndev, enum hnae3_loop loop_mode)
 	ret = hns3_lp_setup(ndev, loop_mode, true);
 	usleep_range(10000, 20000);
 
-	return 0;
+	return ret;
 }
 
 static int hns3_lp_down(struct net_device *ndev, enum hnae3_loop loop_mode)
@@ -334,10 +334,10 @@ static void hns3_self_test(struct net_device *ndev,
 			continue;
 
 		data[test_index] = hns3_lp_up(ndev, loop_type);
-		if (!data[test_index]) {
+		if (!data[test_index])
 			data[test_index] = hns3_lp_run_test(ndev, loop_type);
-			hns3_lp_down(ndev, loop_type);
-		}
+
+		hns3_lp_down(ndev, loop_type);
 
 		if (data[test_index])
 			eth_test->flags |= ETH_TEST_FL_FAILED;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 64b1589e549f..d5482f9c422c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5332,6 +5332,9 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 		break;
 	}
 
+	if (ret)
+		return ret;
+
 	kinfo = &vport->nic.kinfo;
 	for (i = 0; i < kinfo->num_tqps; i++) {
 		ret = hclge_tqp_enable(hdev, i, 0, en);
-- 
2.20.1


