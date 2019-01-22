Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB6DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D759521726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfAVXkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:40:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbfAVXkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:40:09 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10DF12151F1F8C6923F5;
        Wed, 23 Jan 2019 07:40:08 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.16) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 07:39:57 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>, <eric.dumazet@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Wei Hu <xavier.huwei@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 01/12] net: hns3: add calling roce callback function when link status change
Date:   Wed, 23 Jan 2019 07:39:27 +0800
Message-ID: <20190122233938.7188-2-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122233938.7188-1-tanhuazhong@huawei.com>
References: <20190122233938.7188-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

This patch adds calling roce callback function when link status
change.

Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 00d7acb4d45a..35fb0c54b986 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2105,7 +2105,9 @@ static int hclge_get_mac_phy_link(struct hclge_dev *hdev)
 
 static void hclge_update_link_status(struct hclge_dev *hdev)
 {
+	struct hnae3_client *rclient = hdev->roce_client;
 	struct hnae3_client *client = hdev->nic_client;
+	struct hnae3_handle *rhandle;
 	struct hnae3_handle *handle;
 	int state;
 	int i;
@@ -2117,6 +2119,10 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 		for (i = 0; i < hdev->num_vmdq_vport + 1; i++) {
 			handle = &hdev->vport[i].nic;
 			client->ops->link_status_change(handle, state);
+			rhandle = &hdev->vport[i].roce;
+			if (rclient && rclient->ops->link_status_change)
+				rclient->ops->link_status_change(rhandle,
+								 state);
 		}
 		hdev->hw.mac.link = state;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index bb9f45200ef5..989f08377d58 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -349,16 +349,21 @@ static void hclgevf_request_link_info(struct hclgevf_dev *hdev)
 
 void hclgevf_update_link_status(struct hclgevf_dev *hdev, int link_state)
 {
+	struct hnae3_handle *rhandle = &hdev->roce;
 	struct hnae3_handle *handle = &hdev->nic;
+	struct hnae3_client *rclient;
 	struct hnae3_client *client;
 
 	client = handle->client;
+	rclient = hdev->roce_client;
 
 	link_state =
 		test_bit(HCLGEVF_STATE_DOWN, &hdev->state) ? 0 : link_state;
 
 	if (link_state != hdev->hw.mac.link) {
 		client->ops->link_status_change(handle, !!link_state);
+		if (rclient && rclient->ops->link_status_change)
+			rclient->ops->link_status_change(rhandle, !!link_state);
 		hdev->hw.mac.link = link_state;
 	}
 }
-- 
2.20.1


