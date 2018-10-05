Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D51C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B6D21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B6D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeJFAEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:04:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbeJFAEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:04:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40AE9F7A8140A;
        Sat,  6 Oct 2018 01:04:44 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Sat, 6 Oct 2018 01:04:37 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Zhongzhu Liu <liuzhongzhu@huawei.com>,
        Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 5/6] net: hns3: Add egress/ingress vlan filter for revision 0x21
Date:   Fri, 5 Oct 2018 18:03:28 +0100
Message-ID: <20181005170329.6512-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181005170329.6512-1-salil.mehta@huawei.com>
References: <20181005170329.6512-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongzhu Liu <liuzhongzhu@huawei.com>

In revision 0x21, hw supports both ingress and egress vlan filter.
This patch adds support for it.

Signed-off-by: Zhongzhu Liu <liuzhongzhu@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 45 +++++++++++++++++-----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d95ea9b..ca1a936 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5523,7 +5523,7 @@ static int hclge_do_ioctl(struct hnae3_handle *handle, struct ifreq *ifr,
 }
 
 static int hclge_set_vlan_filter_ctrl(struct hclge_dev *hdev, u8 vlan_type,
-				      bool filter_en)
+				      u8 fe_type, bool filter_en)
 {
 	struct hclge_vlan_filter_ctrl_cmd *req;
 	struct hclge_desc desc;
@@ -5533,7 +5533,7 @@ static int hclge_set_vlan_filter_ctrl(struct hclge_dev *hdev, u8 vlan_type,
 
 	req = (struct hclge_vlan_filter_ctrl_cmd *)desc.data;
 	req->vlan_type = vlan_type;
-	req->vlan_fe = filter_en;
+	req->vlan_fe = filter_en ? fe_type : 0;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
@@ -5545,13 +5545,30 @@ static int hclge_set_vlan_filter_ctrl(struct hclge_dev *hdev, u8 vlan_type,
 
 #define HCLGE_FILTER_TYPE_VF		0
 #define HCLGE_FILTER_TYPE_PORT		1
+#define HCLGE_FILTER_FE_EGRESS_V1_B	BIT(0)
+#define HCLGE_FILTER_FE_NIC_INGRESS_B	BIT(0)
+#define HCLGE_FILTER_FE_NIC_EGRESS_B	BIT(1)
+#define HCLGE_FILTER_FE_ROCE_INGRESS_B	BIT(2)
+#define HCLGE_FILTER_FE_ROCE_EGRESS_B	BIT(3)
+#define HCLGE_FILTER_FE_EGRESS		(HCLGE_FILTER_FE_NIC_EGRESS_B \
+					| HCLGE_FILTER_FE_ROCE_EGRESS_B)
+#define HCLGE_FILTER_FE_INGRESS		(HCLGE_FILTER_FE_NIC_INGRESS_B \
+					| HCLGE_FILTER_FE_ROCE_INGRESS_B)
 
 static void hclge_enable_vlan_filter(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF, enable);
+	if (hdev->pdev->revision >= 0x21) {
+		hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
+					   HCLGE_FILTER_FE_EGRESS, enable);
+		hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
+					   HCLGE_FILTER_FE_INGRESS, enable);
+	} else {
+		hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
+					   HCLGE_FILTER_FE_EGRESS_V1_B, enable);
+	}
 }
 
 static int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
@@ -5853,13 +5870,23 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 	int ret;
 	int i;
 
-	ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF, true);
-	if (ret)
-		return ret;
+	if (hdev->pdev->revision >= 0x21) {
+		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
+						 HCLGE_FILTER_FE_EGRESS, true);
+		if (ret)
+			return ret;
 
-	ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT, true);
-	if (ret)
-		return ret;
+		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
+						 HCLGE_FILTER_FE_INGRESS, true);
+		if (ret)
+			return ret;
+	} else {
+		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
+						 HCLGE_FILTER_FE_EGRESS_V1_B,
+						 true);
+		if (ret)
+			return ret;
+	}
 
 	hdev->vlan_type_cfg.rx_in_fst_vlan_type = HCLGE_DEF_VLAN_TYPE;
 	hdev->vlan_type_cfg.rx_in_sec_vlan_type = HCLGE_DEF_VLAN_TYPE;
-- 
2.7.4


