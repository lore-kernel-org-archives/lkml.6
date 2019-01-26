Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C40FC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C4C214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfAZQuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbfAZQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E98BBF81EDF801352B80;
        Sun, 27 Jan 2019 00:49:58 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:51 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: call hns3_nic_set_real_num_queue with netdev down
Date:   Sun, 27 Jan 2019 00:49:18 +0800
Message-ID: <20190126164921.3872-10-tanhuazhong@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

hns3_client_setup_tc in enet is for updating TC configuration to
stack, and hclge_setup_tc in hclge_dcb is mainly for setting the
configuration to hardware.

This patch removes the hns3_nic_set_real_num_queue from
hns3_setup_tc in enet, and call hclge_client_setup_tc to update
TC configuration to stack with netdev down, because the netdev
down operation is done in hclge_dcb now.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c    |  7 +------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0ecaeab2dad4..93e3e38ba852 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1482,7 +1482,6 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	u8 tc = mqprio_qopt->qopt.num_tc;
 	u16 mode = mqprio_qopt->mode;
 	u8 hw = mqprio_qopt->qopt.hw;
-	int ret;
 
 	if (!((hw == TC_MQPRIO_HW_OFFLOAD_TCS &&
 	       mode == TC_MQPRIO_MODE_CHANNEL) || (!hw && tc == 0)))
@@ -1494,12 +1493,8 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	if (!netdev)
 		return -EINVAL;
 
-	ret = (kinfo->dcb_ops && kinfo->dcb_ops->setup_tc) ?
+	return (kinfo->dcb_ops && kinfo->dcb_ops->setup_tc) ?
 		kinfo->dcb_ops->setup_tc(h, tc, prio_tc) : -EOPNOTSUPP;
-	if (ret)
-		return ret;
-
-	return hns3_nic_set_real_num_queue(netdev);
 }
 
 static int hns3_nic_setup_tc(struct net_device *dev, enum tc_setup_type type,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index de8e38cca507..961aedb0e20f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -384,13 +384,12 @@ static int hclge_setup_tc(struct hnae3_handle *h, u8 tc, u8 *prio_tc)
 	hclge_tm_prio_tc_info_update(hdev, prio_tc);
 
 	ret = hclge_tm_init_hw(hdev, false);
-	if (ret) {
-		if (hclge_notify_client(hdev, HNAE3_INIT_CLIENT))
-			return ret;
+	if (ret)
+		goto err_out;
 
-		hclge_notify_client(hdev, HNAE3_UP_CLIENT);
-		return ret;
-	}
+	ret = hclge_client_setup_tc(hdev);
+	if (ret)
+		goto err_out;
 
 	hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
 
@@ -404,6 +403,13 @@ static int hclge_setup_tc(struct hnae3_handle *h, u8 tc, u8 *prio_tc)
 		return ret;
 
 	return hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+
+err_out:
+	if (hclge_notify_client(hdev, HNAE3_INIT_CLIENT))
+		return ret;
+
+	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	return ret;
 }
 
 static const struct hnae3_dcb_ops hns3_dcb_ops = {
-- 
2.20.1


