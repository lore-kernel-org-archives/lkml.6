Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932989AbeCJDBJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:01:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751373AbeCJC5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:35 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: add existence check when remove old uc mac address
Date: Sat, 10 Mar 2018 11:29:22 +0800
Message-ID: <1520652573-75644-2-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
References: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
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
index a072048..70441d2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -338,7 +338,8 @@ struct hnae3_ae_ops {
 				   u32 *tx_usecs_high, u32 *rx_usecs_high);
 
 	void (*get_mac_addr)(struct hnae3_handle *handle, u8 *p);
-	int (*set_mac_addr)(struct hnae3_handle *handle, void *p);
+	int (*set_mac_addr)(struct hnae3_handle *handle, void *p,
+			    bool is_first);
 	int (*add_uc_addr)(struct hnae3_handle *handle,
 			   const unsigned char *addr);
 	int (*rm_uc_addr)(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0a8c427..8113d22 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1120,7 +1120,7 @@ static int hns3_nic_net_set_mac_address(struct net_device *netdev, void *p)
 	if (!mac_addr || !is_valid_ether_addr((const u8 *)mac_addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	ret = h->ae_algo->ops->set_mac_addr(h, mac_addr->sa_data);
+	ret = h->ae_algo->ops->set_mac_addr(h, mac_addr->sa_data, false);
 	if (ret) {
 		netdev_err(netdev, "set_mac_address fail, ret=%d!\n", ret);
 		return ret;
@@ -3048,7 +3048,7 @@ static void hns3_init_mac_addr(struct net_device *netdev)
 	}
 
 	if (h->ae_algo->ops->set_mac_addr)
-		h->ae_algo->ops->set_mac_addr(h, netdev->dev_addr);
+		h->ae_algo->ops->set_mac_addr(h, netdev->dev_addr, true);
 
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a318773..632672c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4378,7 +4378,8 @@ static void hclge_get_mac_addr(struct hnae3_handle *handle, u8 *p)
 	ether_addr_copy(p, hdev->hw.mac.mac_addr);
 }
 
-static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p)
+static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p,
+			      bool is_first)
 {
 	const unsigned char *new_addr = (const unsigned char *)p;
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -4395,11 +4396,9 @@ static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p)
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
@@ -4407,12 +4406,10 @@ static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p)
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
index f332de6..ed34ca3 100644
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
index 09a2a66..ba3fed1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -734,20 +734,24 @@ static void hclgevf_get_mac_addr(struct hnae3_handle *handle, u8 *p)
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
