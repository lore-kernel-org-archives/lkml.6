Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7847FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B20A21731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B20A21731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbeHNTCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:02:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733022AbeHNTCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:02:14 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 96B853A3FCE82;
        Wed, 15 Aug 2018 00:14:21 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 15 Aug 2018 00:14:16 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH V2 net-next 7/8] net: hns3: Set tx ring' tc info when netdev is up
Date:   Tue, 14 Aug 2018 17:13:18 +0100
Message-ID: <20180814161319.16392-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180814161319.16392-1-salil.mehta@huawei.com>
References: <20180814161319.16392-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The HNS3_RING_TX_RING_TC_REG register is used to map tx ring to
specific tc, the tx queue to tc mapping is needed by the hardware
to do the correct tx schedule.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 24 ++++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b7b9ee3..b28c7e1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2974,6 +2974,28 @@ static void hns3_init_ring_hw(struct hns3_enet_ring *ring)
 	}
 }
 
+static void hns3_init_tx_ring_tc(struct hns3_nic_priv *priv)
+{
+	struct hnae3_knic_private_info *kinfo = &priv->ae_handle->kinfo;
+	int i;
+
+	for (i = 0; i < HNAE3_MAX_TC; i++) {
+		struct hnae3_tc_info *tc_info = &kinfo->tc_info[i];
+		int j;
+
+		if (!tc_info->enable)
+			continue;
+
+		for (j = 0; j < tc_info->tqp_count; j++) {
+			struct hnae3_queue *q;
+
+			q = priv->ring_data[tc_info->tqp_offset + j].ring->tqp;
+			hns3_write_dev(q, HNS3_RING_TX_RING_TC_REG,
+				       tc_info->tc);
+		}
+	}
+}
+
 int hns3_init_all_ring(struct hns3_nic_priv *priv)
 {
 	struct hnae3_handle *h = priv->ae_handle;
@@ -3385,6 +3407,8 @@ int hns3_nic_reset_all_ring(struct hnae3_handle *h)
 		rx_ring->next_to_use = 0;
 	}
 
+	hns3_init_tx_ring_tc(priv);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 0f071a0..a02a96a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -37,6 +37,7 @@ enum hns3_nic_state {
 #define HNS3_RING_TX_RING_BASEADDR_L_REG	0x00040
 #define HNS3_RING_TX_RING_BASEADDR_H_REG	0x00044
 #define HNS3_RING_TX_RING_BD_NUM_REG		0x00048
+#define HNS3_RING_TX_RING_TC_REG		0x00050
 #define HNS3_RING_TX_RING_TAIL_REG		0x00058
 #define HNS3_RING_TX_RING_HEAD_REG		0x0005C
 #define HNS3_RING_TX_RING_FBDNUM_REG		0x00060
-- 
2.7.4


