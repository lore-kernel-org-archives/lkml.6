Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967764AbeEYSol (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:44:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34813 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S967453AbeEYSoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:39 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: Add support for tx_accept_tag2 and tx_accept_untag2 config
Date: Fri, 25 May 2018 19:42:57 +0100
Message-ID: <20180525184307.36288-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180525184307.36288-1-salil.mehta@huawei.com>
References: <20180525184307.36288-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

HNS3 Hardware can support up to two VLAN tags in transmit leg, the PPP
module can handle the packets based on the tag1 and tag2 config. This
patch adds support for tag2 config for vlan handling

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  7 ++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 26 +++++++++++++++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  6 +++--
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index ee3cbac..3fa08f7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -704,11 +704,14 @@ struct hclge_vlan_filter_vf_cfg_cmd {
 	u8  vf_bitmap[16];
 };
 
-#define HCLGE_ACCEPT_TAG_B		0
-#define HCLGE_ACCEPT_UNTAG_B		1
+#define HCLGE_ACCEPT_TAG1_B		0
+#define HCLGE_ACCEPT_UNTAG1_B		1
 #define HCLGE_PORT_INS_TAG1_EN_B	2
 #define HCLGE_PORT_INS_TAG2_EN_B	3
 #define HCLGE_CFG_NIC_ROCE_SEL_B	4
+#define HCLGE_ACCEPT_TAG2_B		5
+#define HCLGE_ACCEPT_UNTAG2_B		6
+
 struct hclge_vport_vtag_tx_cfg_cmd {
 	u8 vport_vlan_cfg;
 	u8 vf_offset;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2f0bbb6..c0b8d5a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4687,10 +4687,14 @@ static int hclge_set_vlan_tx_offload_cfg(struct hclge_vport *vport)
 	req = (struct hclge_vport_vtag_tx_cfg_cmd *)desc.data;
 	req->def_vlan_tag1 = cpu_to_le16(vcfg->default_tag1);
 	req->def_vlan_tag2 = cpu_to_le16(vcfg->default_tag2);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_TAG_B,
-		     vcfg->accept_tag ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_UNTAG_B,
-		     vcfg->accept_untag ? 1 : 0);
+	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_TAG1_B,
+			vcfg->accept_tag1 ? 1 : 0);
+	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_UNTAG1_B,
+			vcfg->accept_untag1 ? 1 : 0);
+	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_TAG2_B,
+			vcfg->accept_tag2 ? 1 : 0);
+	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_UNTAG2_B,
+			vcfg->accept_untag2 ? 1 : 0);
 	hnae_set_bit(req->vport_vlan_cfg, HCLGE_PORT_INS_TAG1_EN_B,
 		     vcfg->insert_tag1_en ? 1 : 0);
 	hnae_set_bit(req->vport_vlan_cfg, HCLGE_PORT_INS_TAG2_EN_B,
@@ -4814,8 +4818,18 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 
 	for (i = 0; i < hdev->num_alloc_vport; i++) {
 		vport = &hdev->vport[i];
-		vport->txvlan_cfg.accept_tag = true;
-		vport->txvlan_cfg.accept_untag = true;
+		vport->txvlan_cfg.accept_tag1 = true;
+		vport->txvlan_cfg.accept_untag1 = true;
+
+		/* accept_tag2 and accept_untag2 are not supported on
+		 * pdev revision(0x20), new revision support them. The
+		 * value of this two fields will not return error when driver
+		 * send command to fireware in revision(0x20).
+		 * This two fields can not configured by user.
+		 */
+		vport->txvlan_cfg.accept_tag2 = true;
+		vport->txvlan_cfg.accept_untag2 = true;
+
 		vport->txvlan_cfg.insert_tag1_en = false;
 		vport->txvlan_cfg.insert_tag2_en = false;
 		vport->txvlan_cfg.default_tag1 = 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 93177d9..677f1e4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -570,8 +570,10 @@ struct hclge_dev {
 
 /* VPort level vlan tag configuration for TX direction */
 struct hclge_tx_vtag_cfg {
-	bool accept_tag;	/* Whether accept tagged packet from host */
-	bool accept_untag;	/* Whether accept untagged packet from host */
+	bool accept_tag1;	/* Whether accept tag1 packet from host */
+	bool accept_untag1;	/* Whether accept untag1 packet from host */
+	bool accept_tag2;
+	bool accept_untag2;
 	bool insert_tag1_en;	/* Whether insert inner vlan tag */
 	bool insert_tag2_en;	/* Whether insert outer vlan tag */
 	u16  default_tag1;	/* The default inner vlan tag to insert */
-- 
2.7.4
