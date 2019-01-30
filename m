Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597C4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F92E218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbfA3U4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:56:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729767AbfA3U41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1A2481D0B2F24F77D580;
        Thu, 31 Jan 2019 04:56:25 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:14 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: Fix NULL deref when unloading driver
Date:   Thu, 31 Jan 2019 04:55:46 +0800
Message-ID: <20190130205552.8512-7-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190130205552.8512-1-tanhuazhong@huawei.com>
References: <20190130205552.8512-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is unloading, if there is a calling of ndo_open occurs
between phy_disconnect() and unregister_netdev(), it will end up
causing the kernel to eventually hit a NULL deref:

[14942.417828] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
[14942.529878] Mem abort info:
[14942.551166]   ESR = 0x96000006
[14942.567070]   Exception class = DABT (current EL), IL = 32 bits
[14942.623081]   SET = 0, FnV = 0
[14942.639112]   EA = 0, S1PTW = 0
[14942.643628] Data abort info:
[14942.659227]   ISV = 0, ISS = 0x00000006
[14942.674870]   CM = 0, WnR = 0
[14942.679449] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000224ad6ad
[14942.695595] [0000000000000048] pgd=00000021e6673003, pud=00000021dbf01003, pmd=0000000000000000
[14942.723163] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[14942.729358] Modules linked in: hns3(O) hclge(O) pv680_mii(O) hnae3(O) [last unloaded: hclge]
[14942.738907] CPU: 1 PID: 26629 Comm: kworker/u4:13 Tainted: G           O      4.18.0-rc1-12928-ga960791-dirty #145
[14942.749491] Hardware name: Huawei Technologies Co., Ltd. D05/D05, BIOS Hi1620 FPGA TB BOOT BIOS B763 08/17/2018
[14942.760392] Workqueue: events_power_efficient phy_state_machine
[14942.766644] pstate: 80c00009 (Nzcv daif +PAN +UAO)
[14942.771918] pc : test_and_set_bit+0x18/0x38
[14942.776589] lr : netif_carrier_off+0x24/0x70
[14942.781033] sp : ffff0000121abd20
[14942.784518] x29: ffff0000121abd20 x28: 0000000000000000
[14942.790208] x27: ffff0000164d3cd8 x26: ffff8021da68b7b8
[14942.795832] x25: 0000000000000000 x24: ffff8021eb407800
[14942.801445] x23: 0000000000000000 x22: 0000000000000000
[14942.807046] x21: 0000000000000001 x20: 0000000000000000
[14942.812672] x19: 0000000000000000 x18: ffff000009781708
[14942.818284] x17: 00000000004970e8 x16: ffff00000816ad48
[14942.823900] x15: 0000000000000000 x14: 0000000000000008
[14942.829528] x13: 0000000000000000 x12: 0000000000000f65
[14942.835149] x11: 0000000000000001 x10: 00000000000009d0
[14942.840753] x9 : ffff0000121abaa0 x8 : 0000000000000000
[14942.846360] x7 : ffff000009781708 x6 : 0000000000000003
[14942.851970] x5 : 0000000000000020 x4 : 0000000000000004
[14942.857575] x3 : 0000000000000002 x2 : 0000000000000001
[14942.863180] x1 : 0000000000000048 x0 : 0000000000000000
[14942.868875] Process kworker/u4:13 (pid: 26629, stack limit = 0x00000000c909dbf3)
[14942.876464] Call trace:
[14942.879200]  test_and_set_bit+0x18/0x38
[14942.883376]  phy_link_change+0x38/0x78
[14942.887378]  phy_state_machine+0x3dc/0x4f8
[14942.891968]  process_one_work+0x158/0x470
[14942.896223]  worker_thread+0x50/0x470
[14942.900219]  kthread+0x104/0x130
[14942.903905]  ret_from_fork+0x10/0x1c
[14942.907755] Code: d2800022 8b400c21 f9800031 9ac32044 (c85f7c22)
[14942.914185] ---[ end trace 968c9e12eb740b23 ]---

So this patch fixes it by modifying the timing to do phy_connect_direct()
and phy_disconnect().

Fixes: 256727da7395 ("net: hns3: Add MDIO support to HNS3 Ethernet driver for hip08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 ++
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 28 +++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 20 ++-----------
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  8 ++++--
 .../hisilicon/hns3/hns3pf/hclge_mdio.h        |  4 +--
 5 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index c29f82aa5ba1..e05b4926feb2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -464,6 +464,8 @@ struct hnae3_ae_ops {
 	int (*set_gro_en)(struct hnae3_handle *handle, int enable);
 	u16 (*get_global_queue_id)(struct hnae3_handle *handle, u16 queue_id);
 	void (*set_timer_task)(struct hnae3_handle *handle, bool enable);
+	int (*mac_connect_phy)(struct hnae3_handle *handle);
+	void (*mac_disconnect_phy)(struct hnae3_handle *handle);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 6520e1c1a837..ac9b0aa258ec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3531,6 +3531,25 @@ static int hns3_init_mac_addr(struct net_device *netdev, bool init)
 	return ret;
 }
 
+static int hns3_init_phy(struct net_device *netdev)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+	int ret = 0;
+
+	if (h->ae_algo->ops->mac_connect_phy)
+		ret = h->ae_algo->ops->mac_connect_phy(h);
+
+	return ret;
+}
+
+static void hns3_uninit_phy(struct net_device *netdev)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	if (h->ae_algo->ops->mac_disconnect_phy)
+		h->ae_algo->ops->mac_disconnect_phy(h);
+}
+
 static int hns3_restore_fd_rules(struct net_device *netdev)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
@@ -3640,6 +3659,10 @@ static int hns3_client_init(struct hnae3_handle *handle)
 		goto out_init_ring_data;
 	}
 
+	ret = hns3_init_phy(netdev);
+	if (ret)
+		goto out_init_phy;
+
 	ret = register_netdev(netdev);
 	if (ret) {
 		dev_err(priv->dev, "probe register netdev fail!\n");
@@ -3664,6 +3687,9 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	return ret;
 
 out_reg_netdev_fail:
+	hns3_uninit_phy(netdev);
+out_init_phy:
+	hns3_uninit_all_ring(priv);
 out_init_ring_data:
 	(void)hns3_nic_uninit_vector_data(priv);
 out_init_vector_data:
@@ -3698,6 +3724,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_force_clear_all_rx_ring(handle);
 
+	hns3_uninit_phy(netdev);
+
 	ret = hns3_nic_uninit_vector_data(priv);
 	if (ret)
 		netdev_err(netdev, "uninit vector error\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ae8336c18264..795ebedde284 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7050,16 +7050,6 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 		*tp_mdix = ETH_TP_MDI;
 }
 
-static int hclge_init_instance_hw(struct hclge_dev *hdev)
-{
-	return hclge_mac_connect_phy(hdev);
-}
-
-static void hclge_uninit_instance_hw(struct hclge_dev *hdev)
-{
-	hclge_mac_disconnect_phy(hdev);
-}
-
 static int hclge_init_client_instance(struct hnae3_client *client,
 				      struct hnae3_ae_dev *ae_dev)
 {
@@ -7079,13 +7069,6 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			if (ret)
 				goto clear_nic;
 
-			ret = hclge_init_instance_hw(hdev);
-			if (ret) {
-			        client->ops->uninit_instance(&vport->nic,
-			                                     0);
-				goto clear_nic;
-			}
-
 			hnae3_set_client_init_flag(client, ae_dev, 1);
 
 			if (hdev->roce_client &&
@@ -7170,7 +7153,6 @@ static void hclge_uninit_client_instance(struct hnae3_client *client,
 		if (client->type == HNAE3_CLIENT_ROCE)
 			return;
 		if (hdev->nic_client && client->ops->uninit_instance) {
-			hclge_uninit_instance_hw(hdev);
 			client->ops->uninit_instance(&vport->nic, 0);
 			hdev->nic_client = NULL;
 			vport->nic.client = NULL;
@@ -8076,6 +8058,8 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.set_gro_en = hclge_gro_en,
 	.get_global_queue_id = hclge_covert_handle_qid_global,
 	.set_timer_task = hclge_set_timer_task,
+	.mac_connect_phy = hclge_mac_connect_phy,
+	.mac_disconnect_phy = hclge_mac_disconnect_phy,
 };
 
 static struct hnae3_ae_algo ae_algo = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index dabb8437f8dc..84f28785ba28 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -195,8 +195,10 @@ static void hclge_mac_adjust_link(struct net_device *netdev)
 		netdev_err(netdev, "failed to configure flow control.\n");
 }
 
-int hclge_mac_connect_phy(struct hclge_dev *hdev)
+int hclge_mac_connect_phy(struct hnae3_handle *handle)
 {
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
 	struct net_device *netdev = hdev->vport[0].nic.netdev;
 	struct phy_device *phydev = hdev->hw.mac.phydev;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
@@ -229,8 +231,10 @@ int hclge_mac_connect_phy(struct hclge_dev *hdev)
 	return 0;
 }
 
-void hclge_mac_disconnect_phy(struct hclge_dev *hdev)
+void hclge_mac_disconnect_phy(struct hnae3_handle *handle)
 {
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
 	struct phy_device *phydev = hdev->hw.mac.phydev;
 
 	if (!phydev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
index 5fbf7dddb5d9..ef095d9c566f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
@@ -5,8 +5,8 @@
 #define __HCLGE_MDIO_H
 
 int hclge_mac_mdio_config(struct hclge_dev *hdev);
-int hclge_mac_connect_phy(struct hclge_dev *hdev);
-void hclge_mac_disconnect_phy(struct hclge_dev *hdev);
+int hclge_mac_connect_phy(struct hnae3_handle *handle);
+void hclge_mac_disconnect_phy(struct hnae3_handle *handle);
 void hclge_mac_start_phy(struct hclge_dev *hdev);
 void hclge_mac_stop_phy(struct hclge_dev *hdev);
 
-- 
2.20.1


