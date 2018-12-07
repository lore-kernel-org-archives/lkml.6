Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE4C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338DE2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338DE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLGVJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:09:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbeLGVJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:53 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D1E52CD319A5;
        Sat,  8 Dec 2018 05:09:49 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:42 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 11/14] net: hns3: handle hw errors of PPP PF
Date:   Fri, 7 Dec 2018 21:08:08 +0000
Message-ID: <20181207210811.23844-12-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181207210811.23844-1-salil.mehta@huawei.com>
References: <20181207210811.23844-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch handles PF hw errors of PPP(Programmable Packet Processor).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 20f8bb5..e82ef4f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -112,8 +112,8 @@ static const struct hclge_hw_error hclge_ppp_mpf_abnormal_int_st1[] = {
 	{ /* sentinel */ }
 };
 
-static const struct hclge_hw_error hclge_ppp_pf_int[] = {
-	{ .int_msk = BIT(0), .msg = "Tx_vlan_tag_err" },
+static const struct hclge_hw_error hclge_ppp_pf_abnormal_int[] = {
+	{ .int_msk = BIT(0), .msg = "tx_vlan_tag_err" },
 	{ .int_msk = BIT(1), .msg = "rss_list_tc_unassigned_queue_err" },
 	{ /* sentinel */ }
 };
@@ -385,12 +385,16 @@ static int hclge_config_ppp_error_interrupt(struct hclge_dev *hdev, u32 cmd,
 				cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT0_EN);
 			desc[0].data[1] =
 				cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT1_EN);
+			desc[0].data[4] = cpu_to_le32(HCLGE_PPP_PF_ERR_INT_EN);
 		}
 
 		desc[1].data[0] =
 			cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT0_EN_MASK);
 		desc[1].data[1] =
 			cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT1_EN_MASK);
+		if (hdev->pdev->revision >= 0x21)
+			desc[1].data[2] =
+				cpu_to_le32(HCLGE_PPP_PF_ERR_INT_EN_MASK);
 	} else if (cmd == HCLGE_PPP_CMD1_INT_CMD) {
 		if (en) {
 			desc[0].data[0] =
@@ -850,6 +854,13 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		goto msi_error;
 	}
 
+	/* read and log PPP PF errors */
+	desc_data = (__le32 *)&desc[2];
+	status = le32_to_cpu(*desc_data);
+	if (status)
+		hclge_log_error(dev, "PPP_PF_ABNORMAL_INT_ST0",
+				&hclge_ppp_pf_abnormal_int[0], status);
+
 	/* clear all PF MSIx errors */
 	hclge_cmd_reuse_desc(&desc[0], false);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
-- 
2.7.4


