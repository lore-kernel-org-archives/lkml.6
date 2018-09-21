Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718CBC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357C22159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357C22159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390524AbeIUVcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeIUVcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D74B3FD6494F1;
        Fri, 21 Sep 2018 23:42:52 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:42:44 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: Unify the type convert for desc.data
Date:   Fri, 21 Sep 2018 16:41:38 +0100
Message-ID: <20180921154148.26756-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180921154148.26756-1-salil.mehta@huawei.com>
References: <20180921154148.26756-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

For desc.data is already point to the address of struct member "data[6]",
it's unnecessary to use '&' to get its address. This patch unifies all
the type convert for dest.data, using "req = (struct name *)dest.data".

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index cf365d4..e9625ce 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3387,7 +3387,7 @@ static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en)
 	struct hclge_desc desc;
 	int ret, i = 0;
 
-	req = (struct hclge_serdes_lb_cmd *)&desc.data[0];
+	req = (struct hclge_serdes_lb_cmd *)desc.data;
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_SERDES_LOOPBACK, false);
 
 	if (en) {
@@ -4634,7 +4634,7 @@ static int hclge_set_vlan_protocol_type(struct hclge_dev *hdev)
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MAC_VLAN_INSERT, false);
 
-	tx_req = (struct hclge_tx_vlan_type_cfg_cmd *)&desc.data;
+	tx_req = (struct hclge_tx_vlan_type_cfg_cmd *)desc.data;
 	tx_req->ot_vlan_type = cpu_to_le16(hdev->vlan_type_cfg.tx_ot_vlan_type);
 	tx_req->in_vlan_type = cpu_to_le16(hdev->vlan_type_cfg.tx_in_vlan_type);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 0282067..00bb394 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -172,7 +172,7 @@ static int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
 				  u8 pfc_bitmap)
 {
 	struct hclge_desc desc;
-	struct hclge_pfc_en_cmd *pfc = (struct hclge_pfc_en_cmd *)&desc.data;
+	struct hclge_pfc_en_cmd *pfc = (struct hclge_pfc_en_cmd *)desc.data;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_PFC_PAUSE_EN, false);
 
@@ -188,7 +188,7 @@ static int hclge_pause_param_cfg(struct hclge_dev *hdev, const u8 *addr,
 	struct hclge_cfg_pause_param_cmd *pause_param;
 	struct hclge_desc desc;
 
-	pause_param = (struct hclge_cfg_pause_param_cmd *)&desc.data;
+	pause_param = (struct hclge_cfg_pause_param_cmd *)desc.data;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_MAC_PARA, false);
 
@@ -207,7 +207,7 @@ int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr)
 	u8 trans_gap;
 	int ret;
 
-	pause_param = (struct hclge_cfg_pause_param_cmd *)&desc.data;
+	pause_param = (struct hclge_cfg_pause_param_cmd *)desc.data;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_MAC_PARA, true);
 
-- 
2.7.4


