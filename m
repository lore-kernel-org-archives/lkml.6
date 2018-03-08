Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965039AbeCHCir (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:38:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934823AbeCHCfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:00 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 02/23] {topost} net: hns3: add existence check when remove old uc mac address
Date: Thu, 8 Mar 2018 11:06:27 +0800
Message-ID: <1520478408-116992-3-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

When driver is in initial state, the mac_vlan table table is empty.
So the delete operation for mac address must fail. Existence check
is needed here. Otherwise, the error message will make user confused.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             |  3 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         |  4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 17 +++++++----------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c  |  2 ++
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   | 10 +++++++---
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index fd06bc7..3c653eb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -336,7 +336,8 @@ struct hnae3_ae_ops {
 				   u32 *tx_usecs_high, u32 *rx_usecs_high);
 
 	void (*get_mac_addr)(struct hnae3_handle *handle, u8 *p);
-	int (*set_mac_addr)(struct hnae3_handle *handle, void *p);
+	int (*set_mac_addr)(struct hnae3_handle *handle, void *p,
+			    bool is_first);
 	int (*add_uc_addr)(struct hnae3_handle *handle,
 			   const unsigned char *addr);
 	int (*rm_uc_addr)(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 601b629..1bebfd9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1104,7 +1104,7 @@ static int hns3_nic_net_set_mac_address(struct net_device *netdev, void *p)
 	if (!mac_addr || !is_valid_ether_addr((const u8 *)mac_addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	ret = h->ae_algo->ops->set_mac_addr(h, mac_addr->sa_data);
+	ret = h->ae_algo->ops->set_mac_addr(h, mac_addr->sa_data, false);
 	if (ret) {
 		netdev_err(netdev, "set_mac_address fail, ret=%d!\n", ret);
 		return ret;
@@ -2987,7 +2987,7 @@ static void hns3_init_mac_addr(struct net_device *netdev)
 	}
 
 	if (h->ae_algo->ops->set_mac_addr)
-		h->ae_algo->ops->set_mac_addr(h, netdev->dev_addr);
+		h->ae_algo->ops->set_mac_addr(h, netdev->dev_addr, true);
 
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 32bc6f6..0b74461 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4392,7 +4392,8 @@ static void hclge_get_mac_addr(struct hnae3_handle *handle, u8 *p)
 	ether_addr_copy(p, hdev->hw.mac.mac_addr);
 }
 
-static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p)
+static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p,
+			      bool is_first)
 {
 	const unsigned char *new_addr = (const unsigned char *)p;
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -4409,11 +4410,9 @@ static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p)
 		return -EINVAL;
 	}
 
-	ret = hclge_rm_uc_addr(handle, hdev->hw.mac.mac_addr);
-	if (ret)
+	if (!is_first && hclge_rm_uc_addr(handle, hdev->hw.mac.mac_addr))
 		dev_warn(&hdev->pdev->dev,
-			 "remove old uc mac address fail, ret =%d.\n",
-			 ret);
+			 "remove old uc mac address fail.\n");
 
 	ret = hclge_add_uc_addr(handle, new_addr);
 	if (ret) {
@@ -4421,12 +4420,10 @@ static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p)
 			"add uc mac address fail, ret =%d.\n",
 			ret);
 
-		ret = hclge_add_uc_addr(handle, hdev->hw.mac.mac_addr);
-		if (ret) {
+		if (!is_first &&
+		    hclge_add_uc_addr(handle, hdev->hw.mac.mac_addr))
 			dev_err(&hdev->pdev->dev,
-				"restore uc mac address fail, ret =%d.\n",
-				ret);
-		}
+				"restore uc mac address fail.\n");
 
 		return -EIO;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 31383a6..ea78a99 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -196,6 +196,8 @@ static int hclge_set_vf_uc_mac_addr(struct hclge_vport *vport,
 
 		hclge_rm_uc_addr_common(vport, old_addr);
 		status = hclge_add_uc_addr_common(vport, mac_addr);
+		if (status)
+			hclge_add_uc_addr_common(vport, old_addr);
 	} else if (mbx_req->msg[1] == HCLGE_MBX_MAC_VLAN_UC_ADD) {
 		status = hclge_add_uc_addr_common(vport, mac_addr);
 	} else if (mbx_req->msg[1] == HCLGE_MBX_MAC_VLAN_UC_REMOVE) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 0d89965..ccb6756 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -729,20 +729,24 @@ static void hclgevf_get_mac_addr(struct hnae3_handle *handle, u8 *p)
 	ether_addr_copy(p, hdev->hw.mac.mac_addr);
 }
 
-static int hclgevf_set_mac_addr(struct hnae3_handle *handle, void *p)
+static int hclgevf_set_mac_addr(struct hnae3_handle *handle, void *p,
+				bool is_first)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	u8 *old_mac_addr = (u8 *)hdev->hw.mac.mac_addr;
 	u8 *new_mac_addr = (u8 *)p;
 	u8 msg_data[ETH_ALEN * 2];
+	u16 subcode;
 	int status;
 
 	ether_addr_copy(msg_data, new_mac_addr);
 	ether_addr_copy(&msg_data[ETH_ALEN], old_mac_addr);
 
+	subcode = is_first ? HCLGE_MBX_MAC_VLAN_UC_ADD :
+			HCLGE_MBX_MAC_VLAN_UC_MODIFY;
+
 	status = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_SET_UNICAST,
-				      HCLGE_MBX_MAC_VLAN_UC_MODIFY,
-				      msg_data, ETH_ALEN * 2,
+				      subcode, msg_data, ETH_ALEN * 2,
 				      false, NULL, 0);
 	if (!status)
 		ether_addr_copy(hdev->hw.mac.mac_addr, new_mac_addr);
-- 
2.9.3
