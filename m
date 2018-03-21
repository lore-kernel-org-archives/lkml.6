Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCUHVg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:21:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbeCUHSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:15 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 10/11] net: hns3: add querying speed and duplex support to VF
Date: Wed, 21 Mar 2018 15:49:29 +0800
Message-ID: <1521618570-129694-11-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

This patch adds support for querying speed and duplex by ethtool ethX
to VF.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  8 ++++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 22 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  4 ++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  5 +++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index cef14e7..949da0c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -309,16 +309,20 @@ static int hclge_get_link_info(struct hclge_vport *vport,
 {
 	struct hclge_dev *hdev = vport->back;
 	u16 link_status;
-	u8 msg_data[2];
+	u8 msg_data[8];
 	u8 dest_vfid;
+	u16 duplex;
 
 	/* mac.link can only be 0 or 1 */
 	link_status = (u16)hdev->hw.mac.link;
+	duplex = hdev->hw.mac.duplex;
 	memcpy(&msg_data[0], &link_status, sizeof(u16));
+	memcpy(&msg_data[2], &hdev->hw.mac.speed, sizeof(u32));
+	memcpy(&msg_data[6], &duplex, sizeof(u16));
 	dest_vfid = mbx_req->mbx_src_vfid;
 
 	/* send this requested info to VF */
-	return hclge_send_mbx_msg(vport, msg_data, sizeof(u8),
+	return hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
 				  HCLGE_MBX_LINK_STAT_CHANGE, dest_vfid);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index f917a1e..906dfa3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1475,6 +1475,27 @@ static int hclgevf_get_status(struct hnae3_handle *handle)
 	return hdev->hw.mac.link;
 }
 
+static void hclgevf_get_ksettings_an_result(struct hnae3_handle *handle,
+					    u8 *auto_neg, u32 *speed,
+					    u8 *duplex)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	if (speed)
+		*speed = hdev->hw.mac.speed;
+	if (duplex)
+		*duplex = hdev->hw.mac.duplex;
+	if (auto_neg)
+		*auto_neg = AUTONEG_DISABLE;
+}
+
+void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
+				 u8 duplex)
+{
+	hdev->hw.mac.speed = speed;
+	hdev->hw.mac.duplex = duplex;
+}
+
 static const struct hnae3_ae_ops hclgevf_ops = {
 	.init_ae_dev = hclgevf_init_ae_dev,
 	.uninit_ae_dev = hclgevf_uninit_ae_dev,
@@ -1508,6 +1529,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_channels = hclgevf_get_channels,
 	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
 	.get_status = hclgevf_get_status,
+	.get_ksettings_an_result = hclgevf_get_ksettings_an_result,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index a63bee4..0eaea06 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -61,6 +61,8 @@ enum hclgevf_states {
 struct hclgevf_mac {
 	u8 mac_addr[ETH_ALEN];
 	int link;
+	u8 duplex;
+	u32 speed;
 };
 
 struct hclgevf_hw {
@@ -161,4 +163,6 @@ int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev, u16 code, u16 subcode,
 			 u8 *resp_data, u16 resp_len);
 void hclgevf_mbx_handler(struct hclgevf_dev *hdev);
 void hclgevf_update_link_status(struct hclgevf_dev *hdev, int link_state);
+void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
+				 u8 duplex);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 9768f71..a63ed3a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -133,6 +133,8 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 	struct hclgevf_cmq_ring *crq;
 	struct hclgevf_desc *desc;
 	u16 link_status, flag;
+	u32 speed;
+	u8 duplex;
 	u8 *temp;
 	int i;
 
@@ -164,9 +166,12 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 			break;
 		case HCLGE_MBX_LINK_STAT_CHANGE:
 			link_status = le16_to_cpu(req->msg[1]);
+			memcpy(&speed, &req->msg[2], sizeof(speed));
+			duplex = (u8)le16_to_cpu(req->msg[4]);
 
 			/* update upper layer with new link link status */
 			hclgevf_update_link_status(hdev, link_status);
+			hclgevf_update_speed_duplex(hdev, speed, duplex);
 
 			break;
 		default:
-- 
2.9.3
