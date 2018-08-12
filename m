Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2287AC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB7321919
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB7321919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeHLM0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36887 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbeHLM0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:25 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFC9CA68CA49D;
        Sun, 12 Aug 2018 17:48:54 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:46 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 8/9] net: hns3: Set tx ring' tc info when netdev is up
Date:   Sun, 12 Aug 2018 10:47:37 +0100
Message-ID: <20180812094738.14852-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180812094738.14852-1-salil.mehta@huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.119]
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
index b7b9ee3f4d20..b28c7e142308 100644
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
index 0f071a0f4ff9..a02a96aee2a2 100644
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
2.11.0


