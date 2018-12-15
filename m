Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63127C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C71206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbeLOPdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:33:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54929 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730436AbeLOPdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:33:03 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A030781BC8DE;
        Sat, 15 Dec 2018 23:32:58 +0800 (CST)
Received: from S00293818-DELL1.home (10.47.95.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 23:32:49 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH V2 net-next 5/6] net: hns3: Add "queue map" information query function
Date:   Sat, 15 Dec 2018 15:31:57 +0000
Message-ID: <20181215153158.1239-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181215153158.1239-1-salil.mehta@huawei.com>
References: <20181215153158.1239-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.95.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch prints queue map information.

debugfs command:
echo dump queue map > cmd

Sample Command:
root@(none)# echo queue map > cmd
 local queue id | global queue id | vector id
          0              32             769
          1              33             770
          2              34             771
          3              35             772
          4              36             773
          5              37             774
          6              38             775
          7              39             776
          8              40             777
          9              41             778
         10              42             779
         11              43             780
         12              44             781
         13              45             782
         14              46             783
         15              47             784
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 33 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  4 +--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 20 +++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 18 ++++++++++++
 7 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 4d9cf39da48c..691d12174902 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -39,6 +39,7 @@ enum HCLGE_MBX_OPCODE {
 	HCLGE_MBX_KEEP_ALIVE,		/* (VF -> PF) send keep alive cmd */
 	HCLGE_MBX_SET_ALIVE,		/* (VF -> PF) set alive state */
 	HCLGE_MBX_SET_MTU,		/* (VF -> PF) set mtu */
+	HCLGE_MBX_GET_QID_IN_PF,	/* (VF -> PF) get queue id in pf */
 };
 
 /* below are per-VF mac-vlan subcodes */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 294e725c7c44..845d43d3a920 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -460,6 +460,7 @@ struct hnae3_ae_ops {
 	bool (*ae_dev_resetting)(struct hnae3_handle *handle);
 	unsigned long (*ae_dev_reset_cnt)(struct hnae3_handle *handle);
 	int (*set_gro_en)(struct hnae3_handle *handle, int enable);
+	u16 (*get_global_queue_id)(struct hnae3_handle *handle, u16 queue_id);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 005b7e77c3f3..76c74b4b9777 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -125,6 +125,36 @@ static int hns3_dbg_queue_info(struct hnae3_handle *h, char *cmd_buf)
 	return 0;
 }
 
+static int hns3_dbg_queue_map(struct hnae3_handle *h)
+{
+	struct hns3_nic_priv *priv = h->priv;
+	struct hns3_nic_ring_data *ring_data;
+	int i;
+
+	if (!h->ae_algo->ops->get_global_queue_id)
+		return -EOPNOTSUPP;
+
+	dev_info(&h->pdev->dev, "map info for queue id and vector id\n");
+	dev_info(&h->pdev->dev,
+		 "local queue id | global queue id | vector id\n");
+	for (i = 0; i < h->kinfo.num_tqps; i++) {
+		u16 global_qid;
+
+		global_qid = h->ae_algo->ops->get_global_queue_id(h, i);
+		ring_data = &priv->ring_data[i];
+		if (!ring_data || !ring_data->ring ||
+		    !ring_data->ring->tqp_vector)
+			continue;
+
+		dev_info(&h->pdev->dev,
+			 "      %4d            %4d            %4d\n",
+			 i, global_qid,
+			 ring_data->ring->tqp_vector->vector_irq);
+	}
+
+	return 0;
+}
+
 static int hns3_dbg_bd_info(struct hnae3_handle *h, char *cmd_buf)
 {
 	struct hns3_nic_priv *priv = h->priv;
@@ -207,6 +237,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 
 	dev_info(&h->pdev->dev, "available commands\n");
 	dev_info(&h->pdev->dev, "queue info [number]\n");
+	dev_info(&h->pdev->dev, "queue map\n");
 	dev_info(&h->pdev->dev, "bd info [q_num] <bd index>\n");
 	dev_info(&h->pdev->dev, "dump fd tcam\n");
 	dev_info(&h->pdev->dev, "dump tc\n");
@@ -303,6 +334,8 @@ static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
 		hns3_dbg_help(handle);
 	else if (strncmp(cmd_buf, "queue info", 10) == 0)
 		ret = hns3_dbg_queue_info(handle, cmd_buf);
+	else if (strncmp(cmd_buf, "queue map", 9) == 0)
+		ret = hns3_dbg_queue_map(handle);
 	else if (strncmp(cmd_buf, "bd info", 7) == 0)
 		ret = hns3_dbg_bd_info(handle, cmd_buf);
 	else if (handle->ae_algo->ops->dbg_run_cmd)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 22380202ba83..3fe08cf477f9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6602,8 +6602,7 @@ static int hclge_get_reset_status(struct hclge_dev *hdev, u16 queue_id)
 	return hnae3_get_bit(req->ready_to_reset, HCLGE_TQP_RESET_B);
 }
 
-static u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle,
-					  u16 queue_id)
+u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle, u16 queue_id)
 {
 	struct hnae3_queue *queue;
 	struct hclge_tqp *tqp;
@@ -7975,6 +7974,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.ae_dev_resetting = hclge_ae_dev_resetting,
 	.ae_dev_reset_cnt = hclge_ae_dev_reset_cnt,
 	.set_gro_en = hclge_gro_en,
+	.get_global_queue_id = hclge_covert_handle_qid_global,
 };
 
 static struct hnae3_ae_algo ae_algo = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 106fce172563..9571e228ab42 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -874,4 +874,5 @@ int hclge_vport_start(struct hclge_vport *vport);
 void hclge_vport_stop(struct hclge_vport *vport);
 int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu);
 int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf);
+u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle, u16 queue_id);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index e16a730a5f54..a1de451a85df 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -413,6 +413,19 @@ static int hclge_set_vf_mtu(struct hclge_vport *vport,
 	return hclge_gen_resp_to_vf(vport, mbx_req, ret, NULL, 0);
 }
 
+static int hclge_get_queue_id_in_pf(struct hclge_vport *vport,
+				    struct hclge_mbx_vf_to_pf_cmd *mbx_req)
+{
+	u16 queue_id, qid_in_pf;
+	u8 resp_data[2];
+
+	memcpy(&queue_id, &mbx_req->msg[2], sizeof(queue_id));
+	qid_in_pf = hclge_covert_handle_qid_global(&vport->nic, queue_id);
+	memcpy(resp_data, &qid_in_pf, sizeof(qid_in_pf));
+
+	return hclge_gen_resp_to_vf(vport, mbx_req, 0, resp_data, 2);
+}
+
 static bool hclge_cmd_crq_empty(struct hclge_hw *hw)
 {
 	u32 tail = hclge_read_dev(hw, HCLGE_NIC_CRQ_TAIL_REG);
@@ -533,6 +546,13 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 				dev_err(&hdev->pdev->dev,
 					"VF fail(%d) to set mtu\n", ret);
 			break;
+		case HCLGE_MBX_GET_QID_IN_PF:
+			ret = hclge_get_queue_id_in_pf(vport, req);
+			if (ret)
+				dev_err(&hdev->pdev->dev,
+					"PF failed(%d) to get qid for VF\n",
+					ret);
+			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"un-supported mailbox message, code = %d\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 417e078eac62..75327dcda3b0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -256,6 +256,23 @@ static int hclgevf_get_queue_info(struct hclgevf_dev *hdev)
 	return 0;
 }
 
+static u16 hclgevf_get_qid_global(struct hnae3_handle *handle, u16 queue_id)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	u8 msg_data[2], resp_data[2];
+	u16 qid_in_pf = 0;
+	int ret;
+
+	memcpy(&msg_data[0], &queue_id, sizeof(queue_id));
+
+	ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_GET_QID_IN_PF, 0, msg_data,
+				   2, true, resp_data, 2);
+	if (!ret)
+		qid_in_pf = *(u16 *)resp_data;
+
+	return qid_in_pf;
+}
+
 static int hclgevf_alloc_tqps(struct hclgevf_dev *hdev)
 {
 	struct hclgevf_tqp *tqp;
@@ -2642,6 +2659,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.ae_dev_reset_cnt = hclgevf_ae_dev_reset_cnt,
 	.set_gro_en = hclgevf_gro_en,
 	.set_mtu = hclgevf_set_mtu,
+	.get_global_queue_id = hclgevf_get_qid_global,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
-- 
2.11.0


