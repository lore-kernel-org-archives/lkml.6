Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621F2C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B73B20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfBBOlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:41:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39038 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728082AbfBBOlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:41:04 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 17F5646044379317F3C1;
        Sat,  2 Feb 2019 22:41:01 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.97.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 22:40:51 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: optimize the maximum TC macro
Date:   Sat, 2 Feb 2019 22:39:34 +0800
Message-ID: <20190202143937.8924-10-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190202143937.8924-1-tanhuazhong@huawei.com>
References: <20190202143937.8924-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.97.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

Multiple macros with the largest number of TCs in the system,
optimized to HCLGE_MAX_TC_NUM.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h     | 7 +++----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index e26a25128693..ac2cd219a9fb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -312,16 +312,16 @@ struct hclge_ctrl_vector_chain_cmd {
 	u8 rsv;
 };
 
-#define HCLGE_TC_NUM		8
+#define HCLGE_MAX_TC_NUM		8
 #define HCLGE_TC0_PRI_BUF_EN_B	15 /* Bit 15 indicate enable or not */
 #define HCLGE_BUF_UNIT_S	7  /* Buf size is united by 128 bytes */
 struct hclge_tx_buff_alloc_cmd {
-	__le16 tx_pkt_buff[HCLGE_TC_NUM];
+	__le16 tx_pkt_buff[HCLGE_MAX_TC_NUM];
 	u8 tx_buff_rsv[8];
 };
 
 struct hclge_rx_priv_buff_cmd {
-	__le16 buf_num[HCLGE_TC_NUM];
+	__le16 buf_num[HCLGE_MAX_TC_NUM];
 	__le16 shared_buf;
 	u8 rsv[6];
 };
@@ -367,7 +367,6 @@ struct hclge_priv_buf {
 	u32 enable;	/* Enable TC private buffer or not */
 };
 
-#define HCLGE_MAX_TC_NUM	8
 struct hclge_shared_buf {
 	struct hclge_waterline self;
 	struct hclge_tc_thrd tc_thrd[HCLGE_MAX_TC_NUM];
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 26d80504c730..1192cf6f2321 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -691,7 +691,7 @@ static void hclge_dbg_dump_qos_buf_cfg(struct hclge_dev *hdev)
 	dev_info(&hdev->pdev->dev, "dump qos buf cfg\n");
 
 	tx_buf_cmd = (struct hclge_tx_buff_alloc_cmd *)desc[0].data;
-	for (i = 0; i < HCLGE_TC_NUM; i++)
+	for (i = 0; i < HCLGE_MAX_TC_NUM; i++)
 		dev_info(&hdev->pdev->dev, "tx_packet_buf_tc_%d: 0x%x\n", i,
 			 tx_buf_cmd->tx_pkt_buff[i]);
 
@@ -703,7 +703,7 @@ static void hclge_dbg_dump_qos_buf_cfg(struct hclge_dev *hdev)
 
 	dev_info(&hdev->pdev->dev, "\n");
 	rx_buf_cmd = (struct hclge_rx_priv_buff_cmd *)desc[0].data;
-	for (i = 0; i < HCLGE_TC_NUM; i++)
+	for (i = 0; i < HCLGE_MAX_TC_NUM; i++)
 		dev_info(&hdev->pdev->dev, "rx_packet_buf_tc_%d: 0x%x\n", i,
 			 rx_buf_cmd->buf_num[i]);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5f6fc23fab5d..f55835dee5c7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1331,7 +1331,7 @@ static int  hclge_cmd_alloc_tx_buff(struct hclge_dev *hdev,
 	req = (struct hclge_tx_buff_alloc_cmd *)desc.data;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_TX_BUFF_ALLOC, 0);
-	for (i = 0; i < HCLGE_TC_NUM; i++) {
+	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
 		u32 buf_size = buf_alloc->priv_buf[i].tx_buf_size;
 
 		req->tx_pkt_buff[i] =
-- 
2.20.1


