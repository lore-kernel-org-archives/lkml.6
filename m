Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37461C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7872089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfBTCed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:34:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730340AbfBTCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1216DC6123CCF9320C85;
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
Subject: [Patch net-next 09/12] net: hns3: Record VF unicast and multicast tables
Date:   Wed, 20 Feb 2019 10:32:48 +0800
Message-ID: <1550629971-23999-10-git-send-email-tanhuazhong@huawei.com>
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

Record the unicast and multicast tables that the VF sends to the chip.
After the VF exception, the PF actively clears the VF to chip config.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 102 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  25 +++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  28 +++++-
 4 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 53089cd..9b6b7b4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -42,6 +42,8 @@ enum HCLGE_MBX_OPCODE {
 	HCLGE_MBX_GET_QID_IN_PF,	/* (VF -> PF) get queue id in pf */
 	HCLGE_MBX_LINK_STAT_MODE,	/* (PF -> VF) link mode has changed */
 	HCLGE_MBX_GET_LINK_MODE,	/* (VF -> PF) get the link mode of pf */
+
+	HCLGE_MBX_GET_VF_FLR_STATUS = 200, /* (M7 -> PF) get vf reset status */
 };
 
 /* below are per-VF mac-vlan subcodes */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 87edac4..b1f5c6f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1329,6 +1329,8 @@ static int hclge_alloc_vport(struct hclge_dev *hdev)
 		vport->back = hdev;
 		vport->vport_id = i;
 		vport->mps = HCLGE_MAC_DEFAULT_FRAME;
+		INIT_LIST_HEAD(&vport->uc_mac_list);
+		INIT_LIST_HEAD(&vport->mc_mac_list);
 
 		if (i == 0)
 			ret = hclge_vport_setup(vport, tqp_main_vport);
@@ -6074,6 +6076,103 @@ int hclge_rm_mc_addr_common(struct hclge_vport *vport,
 	return status;
 }
 
+void hclge_add_vport_mac_table(struct hclge_vport *vport, const u8 *mac_addr,
+			       enum HCLGE_MAC_ADDR_TYPE mac_type)
+{
+	struct hclge_vport_mac_addr_cfg *mac_cfg;
+	struct list_head *list;
+
+	if (!vport->vport_id)
+		return;
+
+	mac_cfg = kzalloc(sizeof(*mac_cfg), GFP_KERNEL);
+	if (!mac_cfg)
+		return;
+
+	mac_cfg->hd_tbl_status = true;
+	memcpy(mac_cfg->mac_addr, mac_addr, ETH_ALEN);
+
+	list = (mac_type == HCLGE_MAC_ADDR_UC) ?
+	       &vport->uc_mac_list : &vport->mc_mac_list;
+
+	list_add_tail(&mac_cfg->node, list);
+}
+
+void hclge_rm_vport_mac_table(struct hclge_vport *vport, const u8 *mac_addr,
+			      bool is_write_tbl,
+			      enum HCLGE_MAC_ADDR_TYPE mac_type)
+{
+	struct hclge_vport_mac_addr_cfg *mac_cfg, *tmp;
+	struct list_head *list;
+	bool uc_flag, mc_flag;
+
+	list = (mac_type == HCLGE_MAC_ADDR_UC) ?
+	       &vport->uc_mac_list : &vport->mc_mac_list;
+
+	uc_flag = is_write_tbl && mac_type == HCLGE_MAC_ADDR_UC;
+	mc_flag = is_write_tbl && mac_type == HCLGE_MAC_ADDR_MC;
+
+	list_for_each_entry_safe(mac_cfg, tmp, list, node) {
+		if (strncmp(mac_cfg->mac_addr, mac_addr, ETH_ALEN) == 0) {
+			if (uc_flag && mac_cfg->hd_tbl_status)
+				hclge_rm_uc_addr_common(vport, mac_addr);
+
+			if (mc_flag && mac_cfg->hd_tbl_status)
+				hclge_rm_mc_addr_common(vport, mac_addr);
+
+			list_del(&mac_cfg->node);
+			kfree(mac_cfg);
+			break;
+		}
+	}
+}
+
+void hclge_rm_vport_all_mac_table(struct hclge_vport *vport, bool is_del_list,
+				  enum HCLGE_MAC_ADDR_TYPE mac_type)
+{
+	struct hclge_vport_mac_addr_cfg *mac_cfg, *tmp;
+	struct list_head *list;
+
+	list = (mac_type == HCLGE_MAC_ADDR_UC) ?
+	       &vport->uc_mac_list : &vport->mc_mac_list;
+
+	list_for_each_entry_safe(mac_cfg, tmp, list, node) {
+		if (mac_type == HCLGE_MAC_ADDR_UC && mac_cfg->hd_tbl_status)
+			hclge_rm_uc_addr_common(vport, mac_cfg->mac_addr);
+
+		if (mac_type == HCLGE_MAC_ADDR_MC && mac_cfg->hd_tbl_status)
+			hclge_rm_mc_addr_common(vport, mac_cfg->mac_addr);
+
+		mac_cfg->hd_tbl_status = false;
+		if (is_del_list) {
+			list_del(&mac_cfg->node);
+			kfree(mac_cfg);
+		}
+	}
+}
+
+void hclge_uninit_vport_mac_table(struct hclge_dev *hdev)
+{
+	struct hclge_vport_mac_addr_cfg *mac, *tmp;
+	struct hclge_vport *vport;
+	int i;
+
+	mutex_lock(&hdev->vport_cfg_mutex);
+	for (i = 0; i < hdev->num_alloc_vport; i++) {
+		vport = &hdev->vport[i];
+		list_for_each_entry_safe(mac, tmp, &vport->uc_mac_list, node) {
+			list_del(&mac->node);
+			kfree(mac);
+		}
+
+		list_for_each_entry_safe(mac, tmp, &vport->mc_mac_list, node) {
+			list_del(&mac->node);
+			kfree(mac);
+		}
+	}
+	mutex_unlock(&hdev->vport_cfg_mutex);
+}
+
 static int hclge_get_mac_ethertype_cmd_status(struct hclge_dev *hdev,
 					      u16 cmdq_resp, u8 resp_code)
 {
@@ -7329,6 +7428,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hdev->mps = ETH_FRAME_LEN + ETH_FCS_LEN + 2 * VLAN_HLEN;
 
 	mutex_init(&hdev->vport_lock);
+	mutex_init(&hdev->vport_cfg_mutex);
 
 	ret = hclge_pci_init(hdev);
 	if (ret) {
@@ -7621,6 +7721,8 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_misc_irq_uninit(hdev);
 	hclge_pci_uninit(hdev);
 	mutex_destroy(&hdev->vport_lock);
+	hclge_uninit_vport_mac_table(hdev);
+	mutex_destroy(&hdev->vport_cfg_mutex);
 	ae_dev->priv = NULL;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 3303919..781bd11 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -632,6 +632,17 @@ struct hclge_fd_ad_data {
 	u16 rule_id;
 };
 
+struct hclge_vport_mac_addr_cfg {
+	struct list_head node;
+	int hd_tbl_status;
+	u8 mac_addr[ETH_ALEN];
+};
+
+enum HCLGE_MAC_ADDR_TYPE {
+	HCLGE_MAC_ADDR_UC,
+	HCLGE_MAC_ADDR_MC
+};
+
 /* For each bit of TCAM entry, it uses a pair of 'x' and
  * 'y' to indicate which value to match, like below:
  * ----------------------------------
@@ -771,6 +782,8 @@ struct hclge_dev {
 	/* unicast mac vlan space shared by PF and its VFs */
 	u16 share_umv_size;
 	struct mutex umv_mutex; /* protect share_umv_size */
+
+	struct mutex vport_cfg_mutex;   /* Protect stored vf table */
 };
 
 /* VPort level vlan tag configuration for TX direction */
@@ -838,6 +851,9 @@ struct hclge_vport {
 	unsigned long state;
 	unsigned long last_active_jiffies;
 	u32 mps; /* Max packet size */
+
+	struct list_head uc_mac_list;   /* Store VF unicast table */
+	struct list_head mc_mac_list;   /* Store VF multicast table */
 };
 
 void hclge_promisc_param_init(struct hclge_promisc_param *param, bool en_uc,
@@ -892,4 +908,13 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf);
 u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle, u16 queue_id);
 int hclge_notify_client(struct hclge_dev *hdev,
 			enum hnae3_reset_notify_type type);
+void hclge_add_vport_mac_table(struct hclge_vport *vport, const u8 *mac_addr,
+			       enum HCLGE_MAC_ADDR_TYPE mac_type);
+void hclge_rm_vport_mac_table(struct hclge_vport *vport, const u8 *mac_addr,
+			      bool is_write_tbl,
+			      enum HCLGE_MAC_ADDR_TYPE mac_type);
+void hclge_rm_vport_all_mac_table(struct hclge_vport *vport, bool is_del_list,
+				  enum HCLGE_MAC_ADDR_TYPE mac_type);
+void hclge_uninit_vport_mac_table(struct hclge_dev *hdev);
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 7e4a104..476ca83 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -224,12 +224,24 @@ static int hclge_set_vf_uc_mac_addr(struct hclge_vport *vport,
 
 		hclge_rm_uc_addr_common(vport, old_addr);
 		status = hclge_add_uc_addr_common(vport, mac_addr);
-		if (status)
+		if (status) {
 			hclge_add_uc_addr_common(vport, old_addr);
+		} else {
+			hclge_rm_vport_mac_table(vport, mac_addr,
+						 false, HCLGE_MAC_ADDR_UC);
+			hclge_add_vport_mac_table(vport, mac_addr,
+						  HCLGE_MAC_ADDR_UC);
+		}
 	} else if (mbx_req->msg[1] == HCLGE_MBX_MAC_VLAN_UC_ADD) {
 		status = hclge_add_uc_addr_common(vport, mac_addr);
+		if (!status)
+			hclge_add_vport_mac_table(vport, mac_addr,
+						  HCLGE_MAC_ADDR_UC);
 	} else if (mbx_req->msg[1] == HCLGE_MBX_MAC_VLAN_UC_REMOVE) {
 		status = hclge_rm_uc_addr_common(vport, mac_addr);
+		if (!status)
+			hclge_rm_vport_mac_table(vport, mac_addr,
+						 false, HCLGE_MAC_ADDR_UC);
 	} else {
 		dev_err(&hdev->pdev->dev,
 			"failed to set unicast mac addr, unknown subcode %d\n",
@@ -255,8 +267,14 @@ static int hclge_set_vf_mc_mac_addr(struct hclge_vport *vport,
 
 	if (mbx_req->msg[1] == HCLGE_MBX_MAC_VLAN_MC_ADD) {
 		status = hclge_add_mc_addr_common(vport, mac_addr);
+		if (!status)
+			hclge_add_vport_mac_table(vport, mac_addr,
+						  HCLGE_MAC_ADDR_MC);
 	} else if (mbx_req->msg[1] == HCLGE_MBX_MAC_VLAN_MC_REMOVE) {
 		status = hclge_rm_mc_addr_common(vport, mac_addr);
+		if (!status)
+			hclge_rm_vport_mac_table(vport, mac_addr,
+						 false, HCLGE_MAC_ADDR_MC);
 	} else {
 		dev_err(&hdev->pdev->dev,
 			"failed to set mcast mac addr, unknown subcode %d\n",
@@ -585,6 +603,14 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		case HCLGE_MBX_GET_LINK_MODE:
 			hclge_get_link_mode(vport, req);
 			break;
+		case HCLGE_MBX_GET_VF_FLR_STATUS:
+			mutex_lock(&hdev->vport_cfg_mutex);
+			hclge_rm_vport_all_mac_table(vport, true,
+						     HCLGE_MAC_ADDR_UC);
+			hclge_rm_vport_all_mac_table(vport, true,
+						     HCLGE_MAC_ADDR_MC);
+			mutex_unlock(&hdev->vport_cfg_mutex);
+			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"un-supported mailbox message, code = %d\n",
-- 
2.7.4

