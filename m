Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA27C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2394F206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfBWJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfBWJXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 94CFA45ED7A7008AD0B6;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:23:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [Patch net-next 09/12] net: hns3: enable VF VLAN filter for each VF when initializing
Date:   Sat, 23 Feb 2019 17:22:16 +0800
Message-ID: <1550913739-13232-10-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
References: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

For revision 0x21, the switch of VF VLAN filter is per function.
It's necessary to enable VF VLAN filter for each VF when initializing.
Otherwise, VF will be able to receive broadcast packets with unknown
VLAN when PF enters promisc mode.

Fixes: 64d114f0a750 ("net: hns3: Add egress/ingress vlan filter for revision 0x21")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  4 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 30 ++++++++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index bad21c89..3714733 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -693,7 +693,9 @@ struct hclge_mac_vlan_remove_cmd {
 struct hclge_vlan_filter_ctrl_cmd {
 	u8 vlan_type;
 	u8 vlan_fe;
-	u8 rsv[22];
+	u8 rsv1[2];
+	u8 vf_id;
+	u8 rsv2[19];
 };
 
 struct hclge_vlan_filter_pf_cfg_cmd {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f113439..deda606 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6337,7 +6337,7 @@ static int hclge_do_ioctl(struct hnae3_handle *handle, struct ifreq *ifr,
 }
 
 static int hclge_set_vlan_filter_ctrl(struct hclge_dev *hdev, u8 vlan_type,
-				      u8 fe_type, bool filter_en)
+				      u8 fe_type, bool filter_en, u8 vf_id)
 {
 	struct hclge_vlan_filter_ctrl_cmd *req;
 	struct hclge_desc desc;
@@ -6348,6 +6348,7 @@ static int hclge_set_vlan_filter_ctrl(struct hclge_dev *hdev, u8 vlan_type,
 	req = (struct hclge_vlan_filter_ctrl_cmd *)desc.data;
 	req->vlan_type = vlan_type;
 	req->vlan_fe = filter_en ? fe_type : 0;
+	req->vf_id = vf_id;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
@@ -6376,12 +6377,13 @@ static void hclge_enable_vlan_filter(struct hnae3_handle *handle, bool enable)
 
 	if (hdev->pdev->revision >= 0x21) {
 		hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
-					   HCLGE_FILTER_FE_EGRESS, enable);
+					   HCLGE_FILTER_FE_EGRESS, enable, 0);
 		hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
-					   HCLGE_FILTER_FE_INGRESS, enable);
+					   HCLGE_FILTER_FE_INGRESS, enable, 0);
 	} else {
 		hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
-					   HCLGE_FILTER_FE_EGRESS_V1_B, enable);
+					   HCLGE_FILTER_FE_EGRESS_V1_B, enable,
+					   0);
 	}
 	if (enable)
 		handle->netdev_flags |= HNAE3_VLAN_FLTR;
@@ -6689,19 +6691,27 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 	int i;
 
 	if (hdev->pdev->revision >= 0x21) {
-		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
-						 HCLGE_FILTER_FE_EGRESS, true);
-		if (ret)
-			return ret;
+		/* for revision 0x21, vf vlan filter is per function */
+		for (i = 0; i < hdev->num_alloc_vport; i++) {
+			vport = &hdev->vport[i];
+			ret = hclge_set_vlan_filter_ctrl(hdev,
+							 HCLGE_FILTER_TYPE_VF,
+							 HCLGE_FILTER_FE_EGRESS,
+							 true,
+							 vport->vport_id);
+			if (ret)
+				return ret;
+		}
 
 		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
-						 HCLGE_FILTER_FE_INGRESS, true);
+						 HCLGE_FILTER_FE_INGRESS, true,
+						 0);
 		if (ret)
 			return ret;
 	} else {
 		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
 						 HCLGE_FILTER_FE_EGRESS_V1_B,
-						 true);
+						 true, 0);
 		if (ret)
 			return ret;
 	}
-- 
2.7.4

