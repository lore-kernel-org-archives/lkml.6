Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410D227D65
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410D227D65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935298AbeF2Kyx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:54:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60002 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932718AbeF2Kyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:54:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B9CACB461FC8;
        Fri, 29 Jun 2018 18:54:46 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Fri, 29 Jun 2018 18:51:22 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 03/10] net: hns3: remove some redundant assignments
Date:   Fri, 29 Jun 2018 19:22:58 +0800
Message-ID: <1530271385-49668-4-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
References: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

Remove some redundant assignments.
desc->flag = cpu_to_le16(HCLGE_CMD_FLAG_NO_INTR | HCLGE_CMD_FLAG_IN)
has set bit HCLGE_CMD_FLAG_WR to zero, so does others.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c  | 2 --
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 969966c..054a913 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -110,8 +110,6 @@ void hclge_cmd_setup_basic_desc(struct hclge_desc *desc,
 
 	if (is_read)
 		desc->flag |= cpu_to_le16(HCLGE_CMD_FLAG_WR);
-	else
-		desc->flag &= cpu_to_le16(~HCLGE_CMD_FLAG_WR);
 }
 
 static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 14a6991..b7f6960 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2733,7 +2733,6 @@ int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id)
 	int ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_RST_TRIGGER, false);
-	hnae_set_bit(req->mac_func_reset, HCLGE_CFG_RESET_MAC_B, 0);
 	hnae_set_bit(req->mac_func_reset, HCLGE_CFG_RESET_FUNC_B, 1);
 	req->fun_reset_vfid = func_id;
 
@@ -4264,16 +4263,9 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 
 	memset(&req, 0, sizeof(req));
 	hnae_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
-	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
-	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 0);
-	hnae_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 
-	hnae_set_bit(egress_port, HCLGE_MAC_EPORT_SW_EN_B, 0);
-	hnae_set_bit(egress_port, HCLGE_MAC_EPORT_TYPE_B, 0);
 	hnae_set_field(egress_port, HCLGE_MAC_EPORT_VFID_M,
 		       HCLGE_MAC_EPORT_VFID_S, vport->vport_id);
-	hnae_set_field(egress_port, HCLGE_MAC_EPORT_PFID_M,
-		       HCLGE_MAC_EPORT_PFID_S, 0);
 
 	req.egress_port = cpu_to_le16(egress_port);
 
-- 
1.9.1

