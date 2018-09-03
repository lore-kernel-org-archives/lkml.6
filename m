Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD84C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0522077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0522077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeICOmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:42:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbeICOmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:42:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6EA42BC01338E;
        Mon,  3 Sep 2018 18:23:19 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 3 Sep 2018 18:23:12 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 08/11] net: hns3: Only update mac configuation when necessary
Date:   Mon, 3 Sep 2018 11:21:53 +0100
Message-ID: <20180903102156.18676-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180903102156.18676-1-salil.mehta@huawei.com>
References: <20180903102156.18676-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently only fiber port checks if it is necessay to set the
mac through firmware when link is changed, this patch unify the
checking to allow the copper port do the checking too.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 48 ++++++++++++++--------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 004bfc1..25d4fd9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2066,19 +2066,17 @@ static int hclge_init_msi(struct hclge_dev *hdev)
 	return 0;
 }
 
-static void hclge_check_speed_dup(struct hclge_dev *hdev, int duplex, int speed)
+static u8 hclge_check_speed_dup(u8 duplex, int speed)
 {
-	struct hclge_mac *mac = &hdev->hw.mac;
 
-	if ((speed == HCLGE_MAC_SPEED_10M) || (speed == HCLGE_MAC_SPEED_100M))
-		mac->duplex = (u8)duplex;
-	else
-		mac->duplex = HCLGE_MAC_FULL;
+	if (!(speed == HCLGE_MAC_SPEED_10M || speed == HCLGE_MAC_SPEED_100M))
+		duplex = HCLGE_MAC_FULL;
 
-	mac->speed = speed;
+	return duplex;
 }
 
-int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex)
+static int hclge_cfg_mac_speed_dup_hw(struct hclge_dev *hdev, int speed,
+				      u8 duplex)
 {
 	struct hclge_config_mac_speed_dup_cmd *req;
 	struct hclge_desc desc;
@@ -2138,7 +2136,23 @@ int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex)
 		return ret;
 	}
 
-	hclge_check_speed_dup(hdev, duplex, speed);
+	return 0;
+}
+
+int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex)
+{
+	int ret;
+
+	duplex = hclge_check_speed_dup(duplex, speed);
+	if (hdev->hw.mac.speed == speed && hdev->hw.mac.duplex == duplex)
+		return 0;
+
+	ret = hclge_cfg_mac_speed_dup_hw(hdev, speed, duplex);
+	if (ret)
+		return ret;
+
+	hdev->hw.mac.speed = speed;
+	hdev->hw.mac.duplex = duplex;
 
 	return 0;
 }
@@ -2259,7 +2273,9 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	int ret;
 	int i;
 
-	ret = hclge_cfg_mac_speed_dup(hdev, hdev->hw.mac.speed, HCLGE_MAC_FULL);
+	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
+					 hdev->hw.mac.duplex);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Config mac speed dup fail ret=%d\n", ret);
@@ -2415,13 +2431,11 @@ static int hclge_update_speed_duplex(struct hclge_dev *hdev)
 		return ret;
 	}
 
-	if ((mac.speed != speed) || (mac.duplex != duplex)) {
-		ret = hclge_cfg_mac_speed_dup(hdev, speed, duplex);
-		if (ret) {
-			dev_err(&hdev->pdev->dev,
-				"mac speed/duplex config failed %d\n", ret);
-			return ret;
-		}
+	ret = hclge_cfg_mac_speed_dup(hdev, speed, duplex);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"mac speed/duplex config failed %d\n", ret);
+		return ret;
 	}
 
 	return 0;
-- 
2.7.4


