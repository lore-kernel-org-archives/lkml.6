Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BEEC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021E521872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfAZQuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfAZQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:05 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE24EB607EA7D258BDA8;
        Sun, 27 Jan 2019 00:49:58 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: After setting the loopback, add the status of getting MAC
Date:   Sun, 27 Jan 2019 00:49:15 +0800
Message-ID: <20190126164921.3872-7-tanhuazhong@huawei.com>
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

From: liuzhongzhu <liuzhongzhu@huawei.com>

After setting the serdes loopback, you need to determine
the status of the MAC negotiation. If a status exception
is obtained after 200ms, a timeout error is returned.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 558389a18353..ae8336c18264 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5237,8 +5237,15 @@ static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en,
 {
 #define HCLGE_SERDES_RETRY_MS	10
 #define HCLGE_SERDES_RETRY_NUM	100
+
+#define HCLGE_MAC_LINK_STATUS_MS   20
+#define HCLGE_MAC_LINK_STATUS_NUM  10
+#define HCLGE_MAC_LINK_STATUS_DOWN 0
+#define HCLGE_MAC_LINK_STATUS_UP   1
+
 	struct hclge_serdes_lb_cmd *req;
 	struct hclge_desc desc;
+	int mac_link_ret = 0;
 	int ret, i = 0;
 	u8 loop_mode_b;
 
@@ -5261,8 +5268,10 @@ static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en,
 	if (en) {
 		req->enable = loop_mode_b;
 		req->mask = loop_mode_b;
+		mac_link_ret = HCLGE_MAC_LINK_STATUS_UP;
 	} else {
 		req->mask = loop_mode_b;
+		mac_link_ret = HCLGE_MAC_LINK_STATUS_DOWN;
 	}
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -5294,7 +5303,19 @@ static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en,
 	}
 
 	hclge_cfg_mac_mode(hdev, en);
-	return 0;
+
+	i = 0;
+	do {
+		/* serdes Internal loopback, independent of the network cable.*/
+		msleep(HCLGE_MAC_LINK_STATUS_MS);
+		ret = hclge_get_mac_link_status(hdev);
+		if (ret == mac_link_ret)
+			return 0;
+	} while (++i < HCLGE_MAC_LINK_STATUS_NUM);
+
+	dev_err(&hdev->pdev->dev, "config mac mode timeout\n");
+
+	return -EBUSY;
 }
 
 static int hclge_tqp_enable(struct hclge_dev *hdev, int tqp_id,
-- 
2.20.1


