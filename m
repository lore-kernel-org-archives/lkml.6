Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C23C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA59C23F13
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA59C23F13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeGFKbl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:31:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932318AbeGFK3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:29:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8B0196BC1C80;
        Fri,  6 Jul 2018 18:29:00 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:28:55 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 03/10] net: hns3: Fix for waterline not setting correctly
Date:   Fri, 6 Jul 2018 11:27:57 +0100
Message-ID: <20180706102804.196-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706102804.196-1-salil.mehta@huawei.com>
References: <20180706102804.196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The HCLGE_RX_PRIV_EN_B is used to tell the firmware whether
to update the specific waterline value, if the is not set,
the firmware will ignore the value.

This patch fixes by setting the HCLGE_RX_PRIV_EN_B even if
the updated value is zero.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6fffc69..dae1aa5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1834,8 +1834,6 @@ static int hclge_rx_priv_buf_alloc(struct hclge_dev *hdev,
 	return 0;
 }
 
-#define HCLGE_PRIV_ENABLE(a) ((a) > 0 ? 1 : 0)
-
 static int hclge_rx_priv_wl_config(struct hclge_dev *hdev,
 				   struct hclge_pkt_buf_alloc *buf_alloc)
 {
@@ -1863,13 +1861,11 @@ static int hclge_rx_priv_wl_config(struct hclge_dev *hdev,
 			req->tc_wl[j].high =
 				cpu_to_le16(priv->wl.high >> HCLGE_BUF_UNIT_S);
 			req->tc_wl[j].high |=
-				cpu_to_le16(HCLGE_PRIV_ENABLE(priv->wl.high) <<
-					    HCLGE_RX_PRIV_EN_B);
+				cpu_to_le16(BIT(HCLGE_RX_PRIV_EN_B));
 			req->tc_wl[j].low =
 				cpu_to_le16(priv->wl.low >> HCLGE_BUF_UNIT_S);
 			req->tc_wl[j].low |=
-				cpu_to_le16(HCLGE_PRIV_ENABLE(priv->wl.low) <<
-					    HCLGE_RX_PRIV_EN_B);
+				 cpu_to_le16(BIT(HCLGE_RX_PRIV_EN_B));
 		}
 	}
 
@@ -1911,13 +1907,11 @@ static int hclge_common_thrd_config(struct hclge_dev *hdev,
 			req->com_thrd[j].high =
 				cpu_to_le16(tc->high >> HCLGE_BUF_UNIT_S);
 			req->com_thrd[j].high |=
-				cpu_to_le16(HCLGE_PRIV_ENABLE(tc->high) <<
-					    HCLGE_RX_PRIV_EN_B);
+				 cpu_to_le16(BIT(HCLGE_RX_PRIV_EN_B));
 			req->com_thrd[j].low =
 				cpu_to_le16(tc->low >> HCLGE_BUF_UNIT_S);
 			req->com_thrd[j].low |=
-				cpu_to_le16(HCLGE_PRIV_ENABLE(tc->low) <<
-					    HCLGE_RX_PRIV_EN_B);
+				 cpu_to_le16(BIT(HCLGE_RX_PRIV_EN_B));
 		}
 	}
 
@@ -1943,14 +1937,10 @@ static int hclge_common_wl_config(struct hclge_dev *hdev,
 
 	req = (struct hclge_rx_com_wl *)desc.data;
 	req->com_wl.high = cpu_to_le16(buf->self.high >> HCLGE_BUF_UNIT_S);
-	req->com_wl.high |=
-		cpu_to_le16(HCLGE_PRIV_ENABLE(buf->self.high) <<
-			    HCLGE_RX_PRIV_EN_B);
+	req->com_wl.high |=  cpu_to_le16(BIT(HCLGE_RX_PRIV_EN_B));
 
 	req->com_wl.low = cpu_to_le16(buf->self.low >> HCLGE_BUF_UNIT_S);
-	req->com_wl.low |=
-		cpu_to_le16(HCLGE_PRIV_ENABLE(buf->self.low) <<
-			    HCLGE_RX_PRIV_EN_B);
+	req->com_wl.low |=  cpu_to_le16(BIT(HCLGE_RX_PRIV_EN_B));
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
-- 
2.7.4


