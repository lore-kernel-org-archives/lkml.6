Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2538C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFFF21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfBTCeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:34:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730332AbfBTCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 17B8653236796E69765B;
        Wed, 20 Feb 2019 10:33:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:30 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 10/12] net: hns3: Record VF vlan tables
Date:   Wed, 20 Feb 2019 10:32:49 +0800
Message-ID: <1550629971-23999-11-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

Record the vlan tables that the VF sends to the chip.
After the VF exception, the PF actively clears the VF to chip config.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 80 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    | 13 +++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  4 ++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b1f5c6f..4a59646 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1329,6 +1329,7 @@ static int hclge_alloc_vport(struct hclge_dev *hdev)
 		vport->back = hdev;
 		vport->vport_id = i;
 		vport->mps = HCLGE_MAC_DEFAULT_FRAME;
+		INIT_LIST_HEAD(&vport->vlan_list);
 		INIT_LIST_HEAD(&vport->uc_mac_list);
 		INIT_LIST_HEAD(&vport->mc_mac_list);
 
@@ -6746,6 +6747,84 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 	return hclge_set_vlan_filter(handle, htons(ETH_P_8021Q), 0, false);
 }
 
+void hclge_add_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id)
+{
+	struct hclge_vport_vlan_cfg *vlan;
+
+	/* vlan 0 is reserved */
+	if (!vlan_id)
+		return;
+
+	vlan = kzalloc(sizeof(*vlan), GFP_KERNEL);
+	if (!vlan)
+		return;
+
+	vlan->hd_tbl_status = true;
+	vlan->vlan_id = vlan_id;
+
+	list_add_tail(&vlan->node, &vport->vlan_list);
+}
+
+void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
+			       bool is_write_tbl)
+{
+	struct hclge_vport_vlan_cfg *vlan, *tmp;
+	struct hclge_dev *hdev = vport->back;
+
+	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
+		if (vlan->vlan_id == vlan_id) {
+			if (is_write_tbl && vlan->hd_tbl_status)
+				hclge_set_vlan_filter_hw(hdev,
+							 htons(ETH_P_8021Q),
+							 vport->vport_id,
+							 vlan_id, 0,
+							 true);
+
+			list_del(&vlan->node);
+			kfree(vlan);
+			break;
+		}
+	}
+}
+
+void hclge_rm_vport_all_vlan_table(struct hclge_vport *vport, bool is_del_list)
+{
+	struct hclge_vport_vlan_cfg *vlan, *tmp;
+	struct hclge_dev *hdev = vport->back;
+
+	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
+		if (vlan->hd_tbl_status)
+			hclge_set_vlan_filter_hw(hdev,
+						 htons(ETH_P_8021Q),
+						 vport->vport_id,
+						 vlan->vlan_id, 0,
+						 true);
+
+		vlan->hd_tbl_status = false;
+		if (is_del_list) {
+			list_del(&vlan->node);
+			kfree(vlan);
+		}
+	}
+}
+
+void hclge_uninit_vport_vlan_table(struct hclge_dev *hdev)
+{
+	struct hclge_vport_vlan_cfg *vlan, *tmp;
+	struct hclge_vport *vport;
+	int i;
+
+	mutex_lock(&hdev->vport_cfg_mutex);
+	for (i = 0; i < hdev->num_alloc_vport; i++) {
+		vport = &hdev->vport[i];
+		list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
+			list_del(&vlan->node);
+			kfree(vlan);
+		}
+	}
+	mutex_unlock(&hdev->vport_cfg_mutex);
+}
+
 int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -7722,6 +7801,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_pci_uninit(hdev);
 	mutex_destroy(&hdev->vport_lock);
 	hclge_uninit_vport_mac_table(hdev);
+	hclge_uninit_vport_vlan_table(hdev);
 	mutex_destroy(&hdev->vport_cfg_mutex);
 	ae_dev->priv = NULL;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 781bd11..abbc58e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -643,6 +643,12 @@ enum HCLGE_MAC_ADDR_TYPE {
 	HCLGE_MAC_ADDR_MC
 };
 
+struct hclge_vport_vlan_cfg {
+	struct list_head node;
+	int hd_tbl_status;
+	u16 vlan_id;
+};
+
 /* For each bit of TCAM entry, it uses a pair of 'x' and
  * 'y' to indicate which value to match, like below:
  * ----------------------------------
@@ -854,6 +860,7 @@ struct hclge_vport {
 
 	struct list_head uc_mac_list;   /* Store VF unicast table */
 	struct list_head mc_mac_list;   /* Store VF multicast table */
+	struct list_head vlan_list;     /* Store VF vlan table */
 };
 
 void hclge_promisc_param_init(struct hclge_promisc_param *param, bool en_uc,
@@ -916,5 +923,9 @@ void hclge_rm_vport_mac_table(struct hclge_vport *vport, const u8 *mac_addr,
 void hclge_rm_vport_all_mac_table(struct hclge_vport *vport, bool is_del_list,
 				  enum HCLGE_MAC_ADDR_TYPE mac_type);
 void hclge_uninit_vport_mac_table(struct hclge_dev *hdev);
-
+void hclge_add_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id);
+void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
+			       bool is_write_tbl);
+void hclge_rm_vport_all_vlan_table(struct hclge_vport *vport, bool is_del_list);
+void hclge_uninit_vport_vlan_table(struct hclge_dev *hdev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 476ca83..9e0952c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -305,6 +305,9 @@ static int hclge_set_vf_vlan_cfg(struct hclge_vport *vport,
 		memcpy(&proto, &mbx_req->msg[5], sizeof(proto));
 		status = hclge_set_vlan_filter(handle, cpu_to_be16(proto),
 					       vlan, is_kill);
+		if (!status)
+			is_kill ? hclge_rm_vport_vlan_table(vport, vlan, false)
+			: hclge_add_vport_vlan_table(vport, vlan);
 	} else if (mbx_req->msg[1] == HCLGE_MBX_VLAN_RX_OFF_CFG) {
 		struct hnae3_handle *handle = &vport->nic;
 		bool en = mbx_req->msg[2] ? true : false;
@@ -609,6 +612,7 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 						     HCLGE_MAC_ADDR_UC);
 			hclge_rm_vport_all_mac_table(vport, true,
 						     HCLGE_MAC_ADDR_MC);
+			hclge_rm_vport_all_vlan_table(vport, true);
 			mutex_unlock(&hdev->vport_cfg_mutex);
 			break;
 		default:
-- 
2.7.4

