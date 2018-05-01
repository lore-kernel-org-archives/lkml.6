Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756691AbeEAS6M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54953 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756247AbeEAS6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:06 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 8/9] net: hns3: Fix for packet loss due wrong filter config in VLAN tbls
Date: Tue, 1 May 2018 19:56:04 +0100
Message-ID: <20180501185605.9584-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180501185605.9584-1-salil.mehta@huawei.com>
References: <20180501185605.9584-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

There are two level of vlan tables in hardware, one is port vlan
which is shared by all functions, the other one is function
vlan table, each function has it's own function vlan table.
Currently, PF sets the port vlan table, and vf sets the function
vlan table, which will cause packet lost problem.

This patch fixes this problem by setting both vlan table, and
use hdev->vlan_table to manage thet port vlan table.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 79 +++++++++++++++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  8 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  7 +-
 3 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a4e9991..77d9e4c0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4543,8 +4543,9 @@ static void hclge_enable_vlan_filter(struct hnae3_handle *handle, bool enable)
 	hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF, enable);
 }
 
-int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
-			     bool is_kill, u16 vlan, u8 qos, __be16 proto)
+static int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
+				    bool is_kill, u16 vlan, u8 qos,
+				    __be16 proto)
 {
 #define HCLGE_MAX_VF_BYTES  16
 	struct hclge_vlan_filter_vf_cfg_cmd *req0;
@@ -4602,12 +4603,9 @@ int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
 	return -EIO;
 }
 
-static int hclge_set_port_vlan_filter(struct hnae3_handle *handle,
-				      __be16 proto, u16 vlan_id,
-				      bool is_kill)
+static int hclge_set_port_vlan_filter(struct hclge_dev *hdev, __be16 proto,
+				      u16 vlan_id, bool is_kill)
 {
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
 	struct hclge_vlan_filter_pf_cfg_cmd *req;
 	struct hclge_desc desc;
 	u8 vlan_offset_byte_val;
@@ -4627,22 +4625,66 @@ static int hclge_set_port_vlan_filter(struct hnae3_handle *handle,
 	req->vlan_offset_bitmap[vlan_offset_byte] = vlan_offset_byte_val;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(&hdev->pdev->dev,
+			"port vlan command, send fail, ret =%d.\n", ret);
+	return ret;
+}
+
+static int hclge_set_vlan_filter_hw(struct hclge_dev *hdev, __be16 proto,
+				    u16 vport_id, u16 vlan_id, u8 qos,
+				    bool is_kill)
+{
+	u16 vport_idx, vport_num = 0;
+	int ret;
+
+	ret = hclge_set_vf_vlan_common(hdev, vport_id, is_kill, vlan_id,
+				       0, proto);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
-			"port vlan command, send fail, ret =%d.\n",
-			ret);
+			"Set %d vport vlan filter config fail, ret =%d.\n",
+			vport_id, ret);
 		return ret;
 	}
 
-	ret = hclge_set_vf_vlan_common(hdev, 0, is_kill, vlan_id, 0, proto);
-	if (ret) {
+	/* vlan 0 may be added twice when 8021q module is enabled */
+	if (!is_kill && !vlan_id &&
+	    test_bit(vport_id, hdev->vlan_table[vlan_id]))
+		return 0;
+
+	if (!is_kill && test_and_set_bit(vport_id, hdev->vlan_table[vlan_id])) {
 		dev_err(&hdev->pdev->dev,
-			"Set pf vlan filter config fail, ret =%d.\n",
-			ret);
-		return -EIO;
+			"Add port vlan failed, vport %d is already in vlan %d\n",
+			vport_id, vlan_id);
+		return -EINVAL;
 	}
 
-	return 0;
+	if (is_kill &&
+	    !test_and_clear_bit(vport_id, hdev->vlan_table[vlan_id])) {
+		dev_err(&hdev->pdev->dev,
+			"Delete port vlan failed, vport %d is not in vlan %d\n",
+			vport_id, vlan_id);
+		return -EINVAL;
+	}
+
+	for_each_set_bit(vport_idx, hdev->vlan_table[vlan_id], VLAN_N_VID)
+		vport_num++;
+
+	if ((is_kill && vport_num == 0) || (!is_kill && vport_num == 1))
+		ret = hclge_set_port_vlan_filter(hdev, proto, vlan_id,
+						 is_kill);
+
+	return ret;
+}
+
+int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
+			  u16 vlan_id, bool is_kill)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	return hclge_set_vlan_filter_hw(hdev, proto, vport->vport_id, vlan_id,
+					0, is_kill);
 }
 
 static int hclge_set_vf_vlan_filter(struct hnae3_handle *handle, int vfid,
@@ -4656,7 +4698,7 @@ static int hclge_set_vf_vlan_filter(struct hnae3_handle *handle, int vfid,
 	if (proto != htons(ETH_P_8021Q))
 		return -EPROTONOSUPPORT;
 
-	return hclge_set_vf_vlan_common(hdev, vfid, false, vlan, qos, proto);
+	return hclge_set_vlan_filter_hw(hdev, proto, vfid, vlan, qos, false);
 }
 
 static int hclge_set_vlan_tx_offload_cfg(struct hclge_vport *vport)
@@ -4821,7 +4863,7 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 	}
 
 	handle = &hdev->vport[0].nic;
-	return hclge_set_port_vlan_filter(handle, htons(ETH_P_8021Q), 0, false);
+	return hclge_set_vlan_filter(handle, htons(ETH_P_8021Q), 0, false);
 }
 
 static int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
@@ -5604,6 +5646,7 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 	set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
 	hclge_stats_clear(hdev);
+	memset(hdev->vlan_table, 0, sizeof(hdev->vlan_table));
 
 	ret = hclge_cmd_init(hdev);
 	if (ret) {
@@ -6221,7 +6264,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_fw_version = hclge_get_fw_version,
 	.get_mdix_mode = hclge_get_mdix_mode,
 	.enable_vlan_filter = hclge_enable_vlan_filter,
-	.set_vlan_filter = hclge_set_port_vlan_filter,
+	.set_vlan_filter = hclge_set_vlan_filter,
 	.set_vf_vlan_filter = hclge_set_vf_vlan_filter,
 	.enable_hw_strip_rxvtag = hclge_en_hw_strip_rxvtag,
 	.reset_event = hclge_reset_event,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 0f4157e..6432f754 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -12,6 +12,8 @@
 #include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/phy.h>
+#include <linux/if_vlan.h>
+
 #include "hclge_cmd.h"
 #include "hnae3.h"
 
@@ -471,6 +473,7 @@ struct hclge_vlan_type_cfg {
 	u16 tx_in_vlan_type;
 };
 
+#define HCLGE_VPORT_NUM 256
 struct hclge_dev {
 	struct pci_dev *pdev;
 	struct hnae3_ae_dev *ae_dev;
@@ -562,6 +565,7 @@ struct hclge_dev {
 
 	u64 rx_pkts_for_led;
 	u64 tx_pkts_for_led;
+	unsigned long vlan_table[VLAN_N_VID][BITS_TO_LONGS(HCLGE_VPORT_NUM)];
 };
 
 /* VPort level vlan tag configuration for TX direction */
@@ -646,8 +650,8 @@ static inline int hclge_get_queue_id(struct hnae3_queue *queue)
 }
 
 int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex);
-int hclge_set_vf_vlan_common(struct hclge_dev *vport, int vfid,
-			     bool is_kill, u16 vlan, u8 qos, __be16 proto);
+int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
+			  u16 vlan_id, bool is_kill);
 
 int hclge_buffer_alloc(struct hclge_dev *hdev);
 int hclge_rss_init_hw(struct hclge_dev *hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index a6f7ffa..7563335 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -264,19 +264,18 @@ static int hclge_set_vf_vlan_cfg(struct hclge_vport *vport,
 				 struct hclge_mbx_vf_to_pf_cmd *mbx_req,
 				 bool gen_resp)
 {
-	struct hclge_dev *hdev = vport->back;
 	int status = 0;
 
 	if (mbx_req->msg[1] == HCLGE_MBX_VLAN_FILTER) {
+		struct hnae3_handle *handle = &vport->nic;
 		u16 vlan, proto;
 		bool is_kill;
 
 		is_kill = !!mbx_req->msg[2];
 		memcpy(&vlan, &mbx_req->msg[3], sizeof(vlan));
 		memcpy(&proto, &mbx_req->msg[5], sizeof(proto));
-		status = hclge_set_vf_vlan_common(hdev, vport->vport_id,
-						  is_kill, vlan, 0,
-						  cpu_to_be16(proto));
+		status = hclge_set_vlan_filter(handle, cpu_to_be16(proto),
+					       vlan, is_kill);
 	}
 
 	if (gen_resp)
-- 
2.7.4
