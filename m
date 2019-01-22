Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFAAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689462085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfAVQkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:40:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729511AbfAVQkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:40:14 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49A9B7F7916F450FEF7D;
        Wed, 23 Jan 2019 00:40:10 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.54.154) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 00:40:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: add ETS TC weight setting in SSU module
Date:   Wed, 23 Jan 2019 00:39:38 +0800
Message-ID: <20190122163940.7876-11-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122163940.7876-1-tanhuazhong@huawei.com>
References: <20190122163940.7876-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.54.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch sets the TC weight in SSU module according to
info in tm_info.

Also, zero weight of TC weight in SSU ETS module means enabling
strict priority, so do not allow zero weight when in ETS mode.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 44316602c2fc..bad975ebe137 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -947,6 +947,36 @@ static int hclge_tm_pri_tc_base_dwrr_cfg(struct hclge_dev *hdev)
 	return 0;
 }
 
+static int hclge_tm_ets_tc_dwrr_cfg(struct hclge_dev *hdev)
+{
+#define DEFAULT_TC_WEIGHT	1
+#define DEFAULT_TC_OFFSET	14
+
+	struct hclge_ets_tc_weight_cmd *ets_weight;
+	struct hclge_desc desc;
+	int i;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_ETS_TC_WEIGHT, false);
+	ets_weight = (struct hclge_ets_tc_weight_cmd *)desc.data;
+
+	for (i = 0; i < HNAE3_MAX_TC; i++) {
+		struct hclge_pg_info *pg_info;
+
+		ets_weight->tc_weight[i] = DEFAULT_TC_WEIGHT;
+
+		if (!(hdev->hw_tc_map & BIT(i)))
+			continue;
+
+		pg_info =
+			&hdev->tm_info.pg_info[hdev->tm_info.tc_info[i].pgid];
+		ets_weight->tc_weight[i] = pg_info->tc_dwrr[i];
+	}
+
+	ets_weight->weight_offset = DEFAULT_TC_OFFSET;
+
+	return hclge_cmd_send(&hdev->hw, &desc, 1);
+}
+
 static int hclge_tm_pri_vnet_base_dwrr_pri_cfg(struct hclge_vport *vport)
 {
 	struct hnae3_knic_private_info *kinfo = &vport->nic.kinfo;
@@ -996,6 +1026,19 @@ static int hclge_tm_pri_dwrr_cfg(struct hclge_dev *hdev)
 		ret = hclge_tm_pri_tc_base_dwrr_cfg(hdev);
 		if (ret)
 			return ret;
+
+		if (!hnae3_dev_dcb_supported(hdev))
+			return 0;
+
+		ret = hclge_tm_ets_tc_dwrr_cfg(hdev);
+		if (ret == -EOPNOTSUPP) {
+			dev_warn(&hdev->pdev->dev,
+				 "fw %08x does't support ets tc weight cmd\n",
+				 hdev->fw_version);
+			ret = 0;
+		}
+
+		return ret;
 	} else {
 		ret = hclge_tm_pri_vnet_base_dwrr_cfg(hdev);
 		if (ret)
-- 
2.20.1


