Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BA9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF7C20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF7C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeK0Fiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:38:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54949 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeK0Fiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:38:50 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CCD5A8CA6B46;
        Tue, 27 Nov 2018 02:43:47 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Tue, 27 Nov 2018 02:43:38 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next] net: hns3: Config NIC port speed same as that of optical module
Date:   Mon, 26 Nov 2018 18:43:00 +0000
Message-ID: <20181126184300.24964-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

Port 0/1 of HiP08 supports 10G and 25G. This patch adds a
change to configure NIC port speed same as that of  optical
module(SFP/QFSP). Driver gets the optical module speed and
sets NIC port speed accordingly.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 23 +++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 84 ++++++++++------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  2 +
 3 files changed, 49 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 2b90410..e1805b9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -90,7 +90,6 @@ enum hclge_opcode_type {
 	/* MAC command */
 	HCLGE_OPC_CONFIG_MAC_MODE	= 0x0301,
 	HCLGE_OPC_CONFIG_AN_MODE	= 0x0304,
-	HCLGE_OPC_QUERY_AN_RESULT	= 0x0306,
 	HCLGE_OPC_QUERY_LINK_STATUS	= 0x0307,
 	HCLGE_OPC_CONFIG_MAX_FRM_SIZE	= 0x0308,
 	HCLGE_OPC_CONFIG_SPEED_DUP	= 0x0309,
@@ -212,6 +211,9 @@ enum hclge_opcode_type {
 	/* Led command */
 	HCLGE_OPC_LED_STATUS_CFG	= 0xB000,
 
+	/* SFP command */
+	HCLGE_OPC_SFP_GET_SPEED		= 0x7104,
+
 	/* Error INT commands */
 	HCLGE_TM_SCH_ECC_INT_EN		= 0x0829,
 	HCLGE_TM_SCH_ECC_ERR_RINT_CMD	= 0x082d,
@@ -544,20 +546,6 @@ struct hclge_config_mac_speed_dup_cmd {
 	u8 rsv[22];
 };
 
-#define HCLGE_QUERY_SPEED_S		3
-#define HCLGE_QUERY_AN_B		0
-#define HCLGE_QUERY_DUPLEX_B		2
-
-#define HCLGE_QUERY_SPEED_M		GENMASK(4, 0)
-#define HCLGE_QUERY_AN_M		BIT(HCLGE_QUERY_AN_B)
-#define HCLGE_QUERY_DUPLEX_M		BIT(HCLGE_QUERY_DUPLEX_B)
-
-struct hclge_query_an_speed_dup_cmd {
-	u8 an_syn_dup_speed;
-	u8 pause;
-	u8 rsv[23];
-};
-
 #define HCLGE_RING_ID_MASK		GENMASK(9, 0)
 #define HCLGE_TQP_ENABLE_B		0
 
@@ -574,6 +562,11 @@ struct hclge_config_auto_neg_cmd {
 	u8      rsv[20];
 };
 
+struct hclge_sfp_speed_cmd {
+	__le32	sfp_speed;
+	u32	rsv[5];
+};
+
 #define HCLGE_MAC_UPLINK_PORT		0x100
 
 struct hclge_config_max_frm_size_cmd {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 696cb53..1c8cf84 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1896,37 +1896,6 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 	return hclge_cfg_mac_speed_dup(hdev, speed, duplex);
 }
 
-static int hclge_query_mac_an_speed_dup(struct hclge_dev *hdev, int *speed,
-					u8 *duplex)
-{
-	struct hclge_query_an_speed_dup_cmd *req;
-	struct hclge_desc desc;
-	int speed_tmp;
-	int ret;
-
-	req = (struct hclge_query_an_speed_dup_cmd *)desc.data;
-
-	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_AN_RESULT, true);
-	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"mac speed/autoneg/duplex query cmd failed %d\n",
-			ret);
-		return ret;
-	}
-
-	*duplex = hnae3_get_bit(req->an_syn_dup_speed, HCLGE_QUERY_DUPLEX_B);
-	speed_tmp = hnae3_get_field(req->an_syn_dup_speed, HCLGE_QUERY_SPEED_M,
-				    HCLGE_QUERY_SPEED_S);
-
-	ret = hclge_parse_speed(speed_tmp, speed);
-	if (ret)
-		dev_err(&hdev->pdev->dev,
-			"could not parse speed(=%d), %d\n", speed_tmp, ret);
-
-	return ret;
-}
-
 static int hclge_set_autoneg_en(struct hclge_dev *hdev, bool enable)
 {
 	struct hclge_config_auto_neg_cmd *req;
@@ -1973,6 +1942,7 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	struct hclge_mac *mac = &hdev->hw.mac;
 	int ret;
 
+	hdev->support_sfp_query = true;
 	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
 	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
 					 hdev->hw.mac.duplex);
@@ -2082,34 +2052,58 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 	}
 }
 
+static int hclge_get_sfp_speed(struct hclge_dev *hdev, u32 *speed)
+{
+	struct hclge_sfp_speed_cmd *resp = NULL;
+	struct hclge_desc desc;
+	int ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_SFP_GET_SPEED, true);
+	resp = (struct hclge_sfp_speed_cmd *)desc.data;
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret == -EOPNOTSUPP) {
+		dev_warn(&hdev->pdev->dev,
+			 "IMP do not support get SFP speed %d\n", ret);
+		return ret;
+	} else if (ret) {
+		dev_err(&hdev->pdev->dev, "get sfp speed failed %d\n", ret);
+		return ret;
+	}
+
+	*speed = resp->sfp_speed;
+
+	return 0;
+}
+
 static int hclge_update_speed_duplex(struct hclge_dev *hdev)
 {
 	struct hclge_mac mac = hdev->hw.mac;
-	u8 duplex;
 	int speed;
 	int ret;
 
-	/* get the speed and duplex as autoneg'result from mac cmd when phy
+	/* get the speed from SFP cmd when phy
 	 * doesn't exit.
 	 */
-	if (mac.phydev || !mac.autoneg)
+	if (mac.phydev)
 		return 0;
 
-	ret = hclge_query_mac_an_speed_dup(hdev, &speed, &duplex);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"mac autoneg/speed/duplex query failed %d\n", ret);
-		return ret;
-	}
+	/* if IMP does not support get SFP/qSFP speed, return directly */
+	if (!hdev->support_sfp_query)
+		return 0;
 
-	ret = hclge_cfg_mac_speed_dup(hdev, speed, duplex);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"mac speed/duplex config failed %d\n", ret);
+	ret = hclge_get_sfp_speed(hdev, &speed);
+	if (ret == -EOPNOTSUPP) {
+		hdev->support_sfp_query = false;
+		return ret;
+	} else if (ret) {
 		return ret;
 	}
 
-	return 0;
+	if (speed == HCLGE_MAC_SPEED_UNKNOWN)
+		return 0; /* do nothing if no SFP */
+
+	/* must config full duplex for SFP */
+	return hclge_cfg_mac_speed_dup(hdev, speed, HCLGE_MAC_FULL);
 }
 
 static int hclge_update_speed_duplex_h(struct hnae3_handle *handle)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 4122ad1..0dd23a1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -155,6 +155,7 @@ enum hclge_evt_cause {
 #define HCLGE_MPF_ENBALE 1
 
 enum HCLGE_MAC_SPEED {
+	HCLGE_MAC_SPEED_UNKNOWN = 0,		/* unknown */
 	HCLGE_MAC_SPEED_10M	= 10,		/* 10 Mbps */
 	HCLGE_MAC_SPEED_100M	= 100,		/* 100 Mbps */
 	HCLGE_MAC_SPEED_1G	= 1000,		/* 1000 Mbps   = 1 Gbps */
@@ -624,6 +625,7 @@ struct hclge_dev {
 	u8 hw_tc_map;
 	u8 tc_num_last_time;
 	enum hclge_fc_mode fc_mode_last_time;
+	u8 support_sfp_query;
 
 #define HCLGE_FLAG_TC_BASE_SCH_MODE		1
 #define HCLGE_FLAG_VNET_BASE_SCH_MODE		2
-- 
2.7.4


