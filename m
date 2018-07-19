Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6945D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6945D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbeGSPb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731850AbeGSPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3CE62A7767955;
        Thu, 19 Jul 2018 22:47:59 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:47:49 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 2/9] net: hns3: Standardize the handle of return value
Date:   Thu, 19 Jul 2018 15:46:59 +0100
Message-ID: <20180719144706.644-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719144706.644-1-salil.mehta@huawei.com>
References: <20180719144706.644-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Apply the standard minor cleanup by returning ret outside
the brackets.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 133 +++++++--------------
 1 file changed, 46 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b271880..cca5b2f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1108,12 +1108,12 @@ static int hclge_get_cfg(struct hclge_dev *hdev, struct hclge_cfg *hcfg)
 
 	ret = hclge_cmd_send(&hdev->hw, desc, HCLGE_PF_CFG_DESC_NUM);
 	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"get config failed %d.\n", ret);
+		dev_err(&hdev->pdev->dev, "get config failed %d.\n", ret);
 		return ret;
 	}
 
 	hclge_parse_cfg(hcfg, desc);
+
 	return 0;
 }
 
@@ -1130,13 +1130,10 @@ static int hclge_get_cap(struct hclge_dev *hdev)
 
 	/* get pf resource */
 	ret = hclge_query_pf_resource(hdev);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"query pf resource error %d.\n", ret);
-		return ret;
-	}
+	if (ret)
+		dev_err(&hdev->pdev->dev, "query pf resource error %d.\n", ret);
 
-	return 0;
+	return ret;
 }
 
 static int hclge_configure(struct hclge_dev *hdev)
@@ -1265,13 +1262,10 @@ static int hclge_map_tqps_to_func(struct hclge_dev *hdev, u16 func_id,
 	req->tqp_vid = cpu_to_le16(tqp_vid);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
-		dev_err(&hdev->pdev->dev, "TQP map failed %d.\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		dev_err(&hdev->pdev->dev, "TQP map failed %d.\n", ret);
 
-	return 0;
+	return ret;
 }
 
 static int  hclge_assign_tqp(struct hclge_vport *vport,
@@ -1330,12 +1324,10 @@ static int hclge_knic_setup(struct hclge_vport *vport, u16 num_tqps)
 		return -ENOMEM;
 
 	ret = hclge_assign_tqp(vport, kinfo->tqp, kinfo->num_tqps);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev, "fail to assign TQPs %d.\n", ret);
-		return -EINVAL;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int hclge_map_tqp_to_vport(struct hclge_dev *hdev,
@@ -1487,13 +1479,11 @@ static int  hclge_cmd_alloc_tx_buff(struct hclge_dev *hdev,
 	}
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev, "tx buffer alloc cmd failed %d.\n",
 			ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int hclge_tx_buffer_alloc(struct hclge_dev *hdev,
@@ -1501,13 +1491,10 @@ static int hclge_tx_buffer_alloc(struct hclge_dev *hdev,
 {
 	int ret = hclge_cmd_alloc_tx_buff(hdev, buf_alloc);
 
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"tx buffer alloc failed %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		dev_err(&hdev->pdev->dev, "tx buffer alloc failed %d\n", ret);
 
-	return 0;
+	return ret;
 }
 
 static int hclge_get_tc_num(struct hclge_dev *hdev)
@@ -1825,13 +1812,11 @@ static int hclge_rx_priv_buf_alloc(struct hclge_dev *hdev,
 			    (1 << HCLGE_TC0_PRI_BUF_EN_B));
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"rx private buffer alloc cmd failed %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int hclge_rx_priv_wl_config(struct hclge_dev *hdev,
@@ -1871,13 +1856,11 @@ static int hclge_rx_priv_wl_config(struct hclge_dev *hdev,
 
 	/* Send 2 descriptor at one time */
 	ret = hclge_cmd_send(&hdev->hw, desc, 2);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"rx private waterline config cmd failed %d\n",
 			ret);
-		return ret;
-	}
-	return 0;
+	return ret;
 }
 
 static int hclge_common_thrd_config(struct hclge_dev *hdev,
@@ -1917,12 +1900,10 @@ static int hclge_common_thrd_config(struct hclge_dev *hdev,
 
 	/* Send 2 descriptors at one time */
 	ret = hclge_cmd_send(&hdev->hw, desc, 2);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"common threshold config cmd failed %d\n", ret);
-		return ret;
-	}
-	return 0;
+	return ret;
 }
 
 static int hclge_common_wl_config(struct hclge_dev *hdev,
@@ -1943,13 +1924,11 @@ static int hclge_common_wl_config(struct hclge_dev *hdev,
 	req->com_wl.low |=  cpu_to_le16(BIT(HCLGE_RX_PRIV_EN_B));
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"common waterline config cmd failed %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 int hclge_buffer_alloc(struct hclge_dev *hdev)
@@ -2196,13 +2175,11 @@ static int hclge_query_mac_an_speed_dup(struct hclge_dev *hdev, int *speed,
 				    HCLGE_QUERY_SPEED_S);
 
 	ret = hclge_parse_speed(speed_tmp, speed);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"could not parse speed(=%d), %d\n", speed_tmp, ret);
-		return -EIO;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int hclge_set_autoneg_en(struct hclge_dev *hdev, bool enable)
@@ -2219,13 +2196,11 @@ static int hclge_set_autoneg_en(struct hclge_dev *hdev, bool enable)
 	req->cfg_an_cmd_flag = cpu_to_le32(flag);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev, "auto neg set cmd failed %d.\n",
 			ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
@@ -2331,13 +2306,11 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 		mtu = ETH_DATA_LEN;
 
 	ret = hclge_set_mtu(handle, mtu);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"set mtu failed ret=%d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static void hclge_mbx_task_schedule(struct hclge_dev *hdev)
@@ -3121,13 +3094,11 @@ static int hclge_set_rss_tc_mode(struct hclge_dev *hdev, u16 *tc_valid,
 	}
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Configure rss tc mode fail, status = %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int hclge_set_rss_input_tuple(struct hclge_dev *hdev)
@@ -3150,13 +3121,10 @@ static int hclge_set_rss_input_tuple(struct hclge_dev *hdev)
 	req->ipv6_sctp_en = hdev->vport[0].rss_tuple_sets.ipv6_sctp_en;
 	req->ipv6_fragment_en = hdev->vport[0].rss_tuple_sets.ipv6_fragment_en;
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Configure rss input fail, status = %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static int hclge_get_rss(struct hnae3_handle *handle, u32 *indir,
@@ -3604,12 +3572,11 @@ int hclge_cmd_set_promisc_mode(struct hclge_dev *hdev,
 		HCLGE_PROMISC_TX_EN_B | HCLGE_PROMISC_RX_EN_B;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Set promisc mode fail, status is %d.\n", ret);
-		return ret;
-	}
-	return 0;
+
+	return ret;
 }
 
 void hclge_promisc_param_init(struct hclge_promisc_param *param, bool en_uc,
@@ -3960,14 +3927,12 @@ static int hclge_set_mta_filter_mode(struct hclge_dev *hdev,
 			HCLGE_CFG_MTA_MAC_SEL_S, mta_mac_sel);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Config mat filter mode failed for cmd_send, ret =%d.\n",
 			ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 int hclge_cfg_func_mta_filter(struct hclge_dev *hdev,
@@ -3986,14 +3951,12 @@ int hclge_cfg_func_mta_filter(struct hclge_dev *hdev,
 	req->function_id = func_id;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Config func_id enable failed for cmd_send, ret =%d.\n",
 			ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int hclge_set_mta_table_item(struct hclge_vport *vport,
@@ -4598,13 +4561,11 @@ static int hclge_set_vlan_filter_ctrl(struct hclge_dev *hdev, u8 vlan_type,
 	req->vlan_fe = filter_en;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev, "set vlan filter fail, ret =%d.\n",
 			ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 #define HCLGE_FILTER_TYPE_VF		0
@@ -4996,14 +4957,12 @@ static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mtu)
 	req->min_frm_size = HCLGE_MAC_MIN_FRAME;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev, "set mtu fail, ret =%d.\n", ret);
-		return ret;
-	}
-
-	hdev->mps = max_frm_size;
+	else
+		hdev->mps = max_frm_size;
 
-	return 0;
+	return ret;
 }
 
 static int hclge_set_mtu(struct hnae3_handle *handle, int new_mtu)
-- 
2.7.4


