Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA9C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B71A20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfBBOlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:41:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728082AbfBBOk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:57 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9DD39132CD34C0869A07;
        Sat,  2 Feb 2019 22:40:55 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.97.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 22:40:48 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: move some set_bit statement into hclge_prepare_mac_addr
Date:   Sat, 2 Feb 2019 22:39:31 +0800
Message-ID: <20190202143937.8924-7-tanhuazhong@huawei.com>
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

From: Weihang Li <liweihang@hisilicon.com>

This patch does not change the code logic. There are some same
set_bit statements called by add/rm_uc/mc_addr_common, and move
this statements into hclge_prepare_mac_addr to reduce duplicate
code.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index be7d82502f5f..a037dc5e36b7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5586,13 +5586,19 @@ static bool hclge_is_all_function_id_zero(struct hclge_desc *desc)
 }
 
 static void hclge_prepare_mac_addr(struct hclge_mac_vlan_tbl_entry_cmd *new_req,
-				   const u8 *addr)
+				   const u8 *addr, bool is_mc)
 {
 	const unsigned char *mac_addr = addr;
 	u32 high_val = mac_addr[2] << 16 | (mac_addr[3] << 24) |
 		       (mac_addr[0]) | (mac_addr[1] << 8);
 	u32 low_val  = mac_addr[4] | (mac_addr[5] << 8);
 
+	hnae3_set_bit(new_req->flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
+	if (is_mc) {
+		hnae3_set_bit(new_req->entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
+		hnae3_set_bit(new_req->mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
+	}
+
 	new_req->mac_addr_hi32 = cpu_to_le32(high_val);
 	new_req->mac_addr_lo16 = cpu_to_le16(low_val & 0xffff);
 }
@@ -5863,14 +5869,13 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 	}
 
 	memset(&req, 0, sizeof(req));
-	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 
 	hnae3_set_field(egress_port, HCLGE_MAC_EPORT_VFID_M,
 			HCLGE_MAC_EPORT_VFID_S, vport->vport_id);
 
 	req.egress_port = cpu_to_le16(egress_port);
 
-	hclge_prepare_mac_addr(&req, addr);
+	hclge_prepare_mac_addr(&req, addr, false);
 
 	/* Lookup the mac address in the mac_vlan table, and add
 	 * it if the entry is inexistent. Repeated unicast entry
@@ -5928,9 +5933,8 @@ int hclge_rm_uc_addr_common(struct hclge_vport *vport,
 	}
 
 	memset(&req, 0, sizeof(req));
-	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
-	hclge_prepare_mac_addr(&req, addr);
+	hclge_prepare_mac_addr(&req, addr, false);
 	ret = hclge_remove_mac_vlan_tbl(vport, &req);
 	if (!ret)
 		hclge_update_umv_space(vport, true);
@@ -5962,11 +5966,8 @@ int hclge_add_mc_addr_common(struct hclge_vport *vport,
 		return -EINVAL;
 	}
 	memset(&req, 0, sizeof(req));
-	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
-	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
-	hclge_prepare_mac_addr(&req, addr);
+	hclge_prepare_mac_addr(&req, addr, true);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
 		/* This mac addr exist, update VFID for it */
@@ -6012,11 +6013,8 @@ int hclge_rm_mc_addr_common(struct hclge_vport *vport,
 	}
 
 	memset(&req, 0, sizeof(req));
-	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
-	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
-	hclge_prepare_mac_addr(&req, addr);
+	hclge_prepare_mac_addr(&req, addr, true);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
 		/* This mac addr exist, remove this handle's VFID for it */
-- 
2.20.1


