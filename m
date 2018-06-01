Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeFAQ5J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:57:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753187AbeFAQx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:53:56 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 02/11] net: hns3: Add support for IFF_ALLMULTI flag
Date: Fri, 1 Jun 2018 17:52:02 +0100
Message-ID: <20180601165211.46372-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180601165211.46372-1-salil.mehta@huawei.com>
References: <20180601165211.46372-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

This patch adds support for IFF_ALLMULTI flag to HNS3 PF and VF
driver.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               |  3 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           |  6 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c        |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |  6 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c    |  5 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 11 +++++++----
 6 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index f250c59..e8244a5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -316,7 +316,8 @@ struct hnae3_ae_ops {
 	int (*set_loopback)(struct hnae3_handle *handle,
 			    enum hnae3_loop loop_mode, bool en);
 
-	void (*set_promisc_mode)(struct hnae3_handle *handle, u32 en);
+	void (*set_promisc_mode)(struct hnae3_handle *handle, bool en_uc_pmc,
+				 bool en_mc_pmc);
 	int (*set_mtu)(struct hnae3_handle *handle, int new_mtu);
 
 	void (*get_pauseparam)(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0529012..0a6876a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -415,9 +415,11 @@ static void hns3_nic_set_rx_mode(struct net_device *netdev)
 
 	if (h->ae_algo->ops->set_promisc_mode) {
 		if (netdev->flags & IFF_PROMISC)
-			h->ae_algo->ops->set_promisc_mode(h, 1);
+			h->ae_algo->ops->set_promisc_mode(h, true, true);
+		else if (netdev->flags & IFF_ALLMULTI)
+			h->ae_algo->ops->set_promisc_mode(h, false, true);
 		else
-			h->ae_algo->ops->set_promisc_mode(h, 0);
+			h->ae_algo->ops->set_promisc_mode(h, false, false);
 	}
 	if (__dev_uc_sync(netdev, hns3_nic_uc_sync, hns3_nic_uc_unsync))
 		netdev_err(netdev, "sync uc address fail\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 8f8cc24..40c0425 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -95,7 +95,7 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 	if (ret)
 		return ret;
 
-	h->ae_algo->ops->set_promisc_mode(h, en);
+	h->ae_algo->ops->set_promisc_mode(h, en, en);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 4ca5318..18027bc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3580,13 +3580,15 @@ void hclge_promisc_param_init(struct hclge_promisc_param *param, bool en_uc,
 	param->vf_id = vport_id;
 }
 
-static void hclge_set_promisc_mode(struct hnae3_handle *handle, u32 en)
+static void hclge_set_promisc_mode(struct hnae3_handle *handle, bool en_uc_pmc,
+				   bool en_mc_pmc)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_promisc_param param;
 
-	hclge_promisc_param_init(&param, en, en, true, vport->vport_id);
+	hclge_promisc_param_init(&param, en_uc_pmc, en_mc_pmc, true,
+				 vport->vport_id);
 	hclge_cmd_set_promisc_mode(hdev, &param);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 31f3d9a..d299805 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -190,11 +190,12 @@ static int hclge_map_unmap_ring_to_vf_vector(struct hclge_vport *vport, bool en,
 static int hclge_set_vf_promisc_mode(struct hclge_vport *vport,
 				     struct hclge_mbx_vf_to_pf_cmd *req)
 {
-	bool en = req->msg[1] ? true : false;
+	bool en_uc = req->msg[1] ? true : false;
+	bool en_mc = req->msg[2] ? true : false;
 	struct hclge_promisc_param param;
 
 	/* always enable broadcast promisc bit */
-	hclge_promisc_param_init(&param, en, en, true, vport->vport_id);
+	hclge_promisc_param_init(&param, en_uc, en_mc, true, vport->vport_id);
 	return hclge_cmd_set_promisc_mode(vport->back, &param);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 266cdcb..e28e0db 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -654,7 +654,8 @@ static int hclgevf_put_vector(struct hnae3_handle *handle, int vector)
 	return 0;
 }
 
-static int hclgevf_cmd_set_promisc_mode(struct hclgevf_dev *hdev, u32 en)
+static int hclgevf_cmd_set_promisc_mode(struct hclgevf_dev *hdev,
+					bool en_uc_pmc, bool en_mc_pmc)
 {
 	struct hclge_mbx_vf_to_pf_cmd *req;
 	struct hclgevf_desc desc;
@@ -664,7 +665,8 @@ static int hclgevf_cmd_set_promisc_mode(struct hclgevf_dev *hdev, u32 en)
 
 	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_MBX_VF_TO_PF, false);
 	req->msg[0] = HCLGE_MBX_SET_PROMISC_MODE;
-	req->msg[1] = en;
+	req->msg[1] = en_uc_pmc ? 1 : 0;
+	req->msg[2] = en_mc_pmc ? 1 : 0;
 
 	status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
 	if (status)
@@ -674,11 +676,12 @@ static int hclgevf_cmd_set_promisc_mode(struct hclgevf_dev *hdev, u32 en)
 	return status;
 }
 
-static void hclgevf_set_promisc_mode(struct hnae3_handle *handle, u32 en)
+static void hclgevf_set_promisc_mode(struct hnae3_handle *handle,
+				     bool en_uc_pmc, bool en_mc_pmc)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 
-	hclgevf_cmd_set_promisc_mode(hdev, en);
+	hclgevf_cmd_set_promisc_mode(hdev, en_uc_pmc, en_mc_pmc);
 }
 
 static int hclgevf_tqp_enable(struct hclgevf_dev *hdev, int tqp_id,
-- 
2.7.4
