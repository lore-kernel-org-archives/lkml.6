Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58265C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33486214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfAZQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfAZQuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:10 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E4253146808EAAEA6D7;
        Sun, 27 Jan 2019 00:50:05 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:53 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: don't allow vf to enable promisc mode
Date:   Sun, 27 Jan 2019 00:49:21 +0800
Message-ID: <20190126164921.3872-13-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190126164921.3872-1-tanhuazhong@huawei.com>
References: <20190126164921.3872-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

VF can receive packets of other functions when in promisc
mode. It's not safe, so don't allow VF to enable promisc
mode.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 ++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 32 +++++++++++--------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index a1de451a85df..3603034aa45c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -203,12 +203,11 @@ static int hclge_map_unmap_ring_to_vf_vector(struct hclge_vport *vport, bool en,
 static int hclge_set_vf_promisc_mode(struct hclge_vport *vport,
 				     struct hclge_mbx_vf_to_pf_cmd *req)
 {
-	bool en_uc = req->msg[1] ? true : false;
-	bool en_mc = req->msg[2] ? true : false;
+	bool en_bc = req->msg[1] ? true : false;
 	struct hclge_promisc_param param;
 
-	/* always enable broadcast promisc bit */
-	hclge_promisc_param_init(&param, en_uc, en_mc, true, vport->vport_id);
+	/* vf is not allowed to enable unicast/multicast broadcast */
+	hclge_promisc_param_init(&param, false, false, en_bc, vport->vport_id);
 	return hclge_cmd_set_promisc_mode(vport->back, &param);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 24b54083b5f9..fc99a0c70164 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -969,33 +969,29 @@ static int hclgevf_put_vector(struct hnae3_handle *handle, int vector)
 }
 
 static int hclgevf_cmd_set_promisc_mode(struct hclgevf_dev *hdev,
-					bool en_uc_pmc, bool en_mc_pmc)
+					bool en_bc_pmc)
 {
 	struct hclge_mbx_vf_to_pf_cmd *req;
 	struct hclgevf_desc desc;
-	int status;
+	int ret;
 
 	req = (struct hclge_mbx_vf_to_pf_cmd *)desc.data;
 
 	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_MBX_VF_TO_PF, false);
 	req->msg[0] = HCLGE_MBX_SET_PROMISC_MODE;
-	req->msg[1] = en_uc_pmc ? 1 : 0;
-	req->msg[2] = en_mc_pmc ? 1 : 0;
+	req->msg[1] = en_bc_pmc ? 1 : 0;
 
-	status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
-	if (status)
+	ret = hclgevf_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
 		dev_err(&hdev->pdev->dev,
-			"Set promisc mode fail, status is %d.\n", status);
+			"Set promisc mode fail, status is %d.\n", ret);
 
-	return status;
+	return ret;
 }
 
-static int hclgevf_set_promisc_mode(struct hnae3_handle *handle,
-				    bool en_uc_pmc, bool en_mc_pmc)
+static int hclgevf_set_promisc_mode(struct hclgevf_dev *hdev, bool en_bc_pmc)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-
-	return hclgevf_cmd_set_promisc_mode(hdev, en_uc_pmc, en_mc_pmc);
+	return hclgevf_cmd_set_promisc_mode(hdev, en_bc_pmc);
 }
 
 static int hclgevf_tqp_enable(struct hclgevf_dev *hdev, int tqp_id,
@@ -2382,6 +2378,15 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		goto err_config;
 
+	/* vf is not allowed to enable unicast/multicast promisc mode.
+	 * For revision 0x20, default to disable broadcast promisc mode,
+	 * firmware makes sure broadcast packets can be accepted.
+	 * For revision 0x21, default to enable broadcast promisc mode.
+	 */
+	ret = hclgevf_set_promisc_mode(hdev, true);
+	if (ret)
+		goto err_config;
+
 	/* Initialize RSS for this VF */
 	ret = hclgevf_rss_init_hw(hdev);
 	if (ret) {
@@ -2646,7 +2651,6 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_vector = hclgevf_get_vector,
 	.put_vector = hclgevf_put_vector,
 	.reset_queue = hclgevf_reset_tqp,
-	.set_promisc_mode = hclgevf_set_promisc_mode,
 	.get_mac_addr = hclgevf_get_mac_addr,
 	.set_mac_addr = hclgevf_set_mac_addr,
 	.add_uc_addr = hclgevf_add_uc_addr,
-- 
2.20.1


