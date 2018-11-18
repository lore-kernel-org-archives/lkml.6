Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DDC20659
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DDC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeKRNjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 08:39:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbeKRNjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 08:39:44 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 949B7D5003BDF;
        Sun, 18 Nov 2018 11:20:48 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.178) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sun, 18 Nov 2018 11:20:41 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 4/5] net: hns3: Add mtu setting support for vf
Date:   Sun, 18 Nov 2018 03:19:13 +0000
Message-ID: <20181118031914.23892-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181118031914.23892-1-salil.mehta@huawei.com>
References: <20181118031914.23892-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.178]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The patch adds mtu setting support for vf, currently
vf and pf share the same hardware mtu setting. Mtu set
by vf must be less than or equal to pf' mtu, and mtu
set by pf must be greater than or equal to vf' mtu.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hclge_mbx.h   |  1 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 42 +++++++++++++++++--
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  4 ++
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         | 18 ++++++++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  9 ++++
 5 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index fd2338f0c34e..4d9cf39da48c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -38,6 +38,7 @@ enum HCLGE_MBX_OPCODE {
 	HCLGE_MBX_QUEUE_RESET,		/* (VF -> PF) reset queue */
 	HCLGE_MBX_KEEP_ALIVE,		/* (VF -> PF) send keep alive cmd */
 	HCLGE_MBX_SET_ALIVE,		/* (VF -> PF) set alive state */
+	HCLGE_MBX_SET_MTU,		/* (VF -> PF) set mtu */
 };
 
 /* below are per-VF mac-vlan subcodes */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9bb7a1c21e00..967cb83f32d6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1166,6 +1166,7 @@ static int hclge_alloc_vport(struct hclge_dev *hdev)
 	for (i = 0; i < num_vport; i++) {
 		vport->back = hdev;
 		vport->vport_id = i;
+		vport->mps = HCLGE_MAC_DEFAULT_FRAME;
 
 		if (i == 0)
 			ret = hclge_vport_setup(vport, tqp_main_vport);
@@ -2921,6 +2922,10 @@ static void hclge_update_vport_alive(struct hclge_dev *hdev)
 
 		if (time_after(jiffies, vport->last_active_jiffies + 8 * HZ))
 			clear_bit(HCLGE_VPORT_STATE_ALIVE, &vport->state);
+
+		/* If vf is not alive, set to default value */
+		if (!test_bit(HCLGE_VPORT_STATE_ALIVE, &vport->state))
+			vport->mps = HCLGE_MAC_DEFAULT_FRAME;
 	}
 }
 
@@ -6400,8 +6405,6 @@ static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mps)
 	struct hclge_config_max_frm_size_cmd *req;
 	struct hclge_desc desc;
 
-	new_mps = max(new_mps, HCLGE_MAC_DEFAULT_FRAME);
-
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CONFIG_MAX_FRM_SIZE, false);
 
 	req = (struct hclge_config_max_frm_size_cmd *)desc.data;
@@ -6414,28 +6417,56 @@ static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mps)
 static int hclge_set_mtu(struct hnae3_handle *handle, int new_mtu)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
+
+	return hclge_set_vport_mtu(vport, new_mtu);
+}
+
+int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu)
+{
 	struct hclge_dev *hdev = vport->back;
-	int max_frm_size, ret;
+	int i, max_frm_size, ret = 0;
 
 	max_frm_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN;
 	if (max_frm_size < HCLGE_MAC_MIN_FRAME ||
 	    max_frm_size > HCLGE_MAC_MAX_FRAME)
 		return -EINVAL;
 
+	max_frm_size = max(max_frm_size, HCLGE_MAC_DEFAULT_FRAME);
+	mutex_lock(&hdev->vport_lock);
+	/* VF's mps must fit within hdev->mps */
+	if (vport->vport_id && max_frm_size > hdev->mps) {
+		mutex_unlock(&hdev->vport_lock);
+		return -EINVAL;
+	} else if (vport->vport_id) {
+		vport->mps = max_frm_size;
+		mutex_unlock(&hdev->vport_lock);
+		return 0;
+	}
+
+	/* PF's mps must be greater then VF's mps */
+	for (i = 1; i < hdev->num_alloc_vport; i++)
+		if (max_frm_size < hdev->vport[i].mps) {
+			mutex_unlock(&hdev->vport_lock);
+			return -EINVAL;
+		}
+
 	ret = hclge_set_mac_mtu(hdev, max_frm_size);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Change mtu fail, ret =%d\n", ret);
-		return ret;
+		goto out;
 	}
 
 	hdev->mps = max_frm_size;
+	vport->mps = max_frm_size;
 
 	ret = hclge_buffer_alloc(hdev);
 	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Allocate buffer fail, ret =%d\n", ret);
 
+out:
+	mutex_unlock(&hdev->vport_lock);
 	return ret;
 }
 
@@ -7054,6 +7085,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	ae_dev->priv = hdev;
 	hdev->mps = ETH_FRAME_LEN + ETH_FCS_LEN + 2 * VLAN_HLEN;
 
+	mutex_init(&hdev->vport_lock);
+
 	ret = hclge_pci_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "PCI init failed\n");
@@ -7353,6 +7386,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_destroy_cmd_queue(&hdev->hw);
 	hclge_misc_irq_uninit(hdev);
 	hclge_pci_uninit(hdev);
+	mutex_destroy(&hdev->vport_lock);
 	ae_dev->priv = NULL;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 5617770c9eb8..5f24dd41d7eb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -678,6 +678,8 @@ struct hclge_dev {
 
 	u32 pkt_buf_size; /* Total pf buf size for tx/rx */
 	u32 mps; /* Max packet size */
+	/* vport_lock protect resource shared by vports */
+	struct mutex vport_lock;
 
 	struct hclge_vlan_type_cfg vlan_type_cfg;
 
@@ -761,6 +763,7 @@ struct hclge_vport {
 
 	unsigned long state;
 	unsigned long last_active_jiffies;
+	u32 mps; /* Max packet size */
 };
 
 void hclge_promisc_param_init(struct hclge_promisc_param *param, bool en_uc,
@@ -810,4 +813,5 @@ int hclge_cfg_flowctrl(struct hclge_dev *hdev);
 int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
 int hclge_vport_start(struct hclge_vport *vport);
 void hclge_vport_stop(struct hclge_vport *vport);
+int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index b64f4424837d..e16a730a5f54 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -401,6 +401,18 @@ static void hclge_vf_keep_alive(struct hclge_vport *vport,
 	vport->last_active_jiffies = jiffies;
 }
 
+static int hclge_set_vf_mtu(struct hclge_vport *vport,
+			    struct hclge_mbx_vf_to_pf_cmd *mbx_req)
+{
+	int ret;
+	u32 mtu;
+
+	memcpy(&mtu, &mbx_req->msg[2], sizeof(mtu));
+	ret = hclge_set_vport_mtu(vport, mtu);
+
+	return hclge_gen_resp_to_vf(vport, mbx_req, ret, NULL, 0);
+}
+
 static bool hclge_cmd_crq_empty(struct hclge_hw *hw)
 {
 	u32 tail = hclge_read_dev(hw, HCLGE_NIC_CRQ_TAIL_REG);
@@ -515,6 +527,12 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		case HCLGE_MBX_KEEP_ALIVE:
 			hclge_vf_keep_alive(vport, req);
 			break;
+		case HCLGE_MBX_SET_MTU:
+			ret = hclge_set_vf_mtu(vport, req);
+			if (ret)
+				dev_err(&hdev->pdev->dev,
+					"VF fail(%d) to set mtu\n", ret);
+			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"un-supported mailbox message, code = %d\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index cdaa7e4207ea..efec1b7a6a64 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1081,6 +1081,14 @@ static int hclgevf_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 				    2, true, NULL, 0);
 }
 
+static int hclgevf_set_mtu(struct hnae3_handle *handle, int new_mtu)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	return hclgevf_send_mbx_msg(hdev, HCLGE_MBX_SET_MTU, 0, (u8 *)&new_mtu,
+				    sizeof(new_mtu), true, NULL, 0);
+}
+
 static int hclgevf_notify_client(struct hclgevf_dev *hdev,
 				 enum hnae3_reset_notify_type type)
 {
@@ -2513,6 +2521,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.ae_dev_resetting = hclgevf_ae_dev_resetting,
 	.ae_dev_reset_cnt = hclgevf_ae_dev_reset_cnt,
 	.set_gro_en = hclgevf_gro_en,
+	.set_mtu = hclgevf_set_mtu,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
-- 
2.17.1


