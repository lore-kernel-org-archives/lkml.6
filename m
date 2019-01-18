Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA57C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB612086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfARIN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:13:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727548AbfARINy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:54 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BCE2E4515032667C957B;
        Fri, 18 Jan 2019 16:13:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:43 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: fix user configuration loss for ethtool -L
Date:   Fri, 18 Jan 2019 16:13:10 +0800
Message-ID: <1547799194-38212-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
References: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethtool -L option with the combined parameter is for changing the number of
multi-purpose channels of the specified network device. Under the current
scheme, the user configuration information will be lost after the reset or
TC information changed.

This patch fixes this issue. By default, this configuration is set to the
minimum between the number of queues for each enabled TCs and the maximum
number support available in the hardware. When there is a user
configuration, regardless of the reset or TC information change, it should
keep the user's configuration while it is under the hardware limits,
otherwise set to the maximum number support available in the hardware.

Fixes: 09f2af6405b8 ("net: hns3: add support to modify tqps number")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 54 ++++------------------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 40 ++++++++++++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  1 +
 4 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 36eab37..81d1585 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -500,6 +500,7 @@ struct hnae3_tc_info {
 struct hnae3_knic_private_info {
 	struct net_device *netdev; /* Set by KNIC client when init instance */
 	u16 rss_size;		   /* Allocated RSS queues */
+	u16 req_rss_size;
 	u16 rx_buf_len;
 	u16 num_desc;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 17b1e33..55a456f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1068,14 +1068,14 @@ static int hclge_map_tqps_to_func(struct hclge_dev *hdev, u16 func_id,
 	return ret;
 }
 
-static int  hclge_assign_tqp(struct hclge_vport *vport)
+static int  hclge_assign_tqp(struct hclge_vport *vport, u16 num_tqps)
 {
 	struct hnae3_knic_private_info *kinfo = &vport->nic.kinfo;
 	struct hclge_dev *hdev = vport->back;
 	int i, alloced;
 
 	for (i = 0, alloced = 0; i < hdev->num_tqps &&
-	     alloced < kinfo->num_tqps; i++) {
+	     alloced < num_tqps; i++) {
 		if (!hdev->htqp[i].alloced) {
 			hdev->htqp[i].q.handle = &vport->nic;
 			hdev->htqp[i].q.tqp_index = alloced;
@@ -1085,7 +1085,9 @@ static int  hclge_assign_tqp(struct hclge_vport *vport)
 			alloced++;
 		}
 	}
-	vport->alloc_tqps = kinfo->num_tqps;
+	vport->alloc_tqps = alloced;
+	kinfo->rss_size = min_t(u16, hdev->rss_size_max,
+				vport->alloc_tqps / hdev->tm_info.num_tc);
 
 	return 0;
 }
@@ -1100,17 +1102,13 @@ static int hclge_knic_setup(struct hclge_vport *vport,
 
 	kinfo->num_desc = num_desc;
 	kinfo->rx_buf_len = hdev->rx_buf_len;
-	kinfo->num_tc = min_t(u16, num_tqps, hdev->tm_info.num_tc);
-	kinfo->rss_size
-		= min_t(u16, hdev->rss_size_max, num_tqps / kinfo->num_tc);
-	kinfo->num_tqps = kinfo->rss_size * kinfo->num_tc;
 
-	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, kinfo->num_tqps,
+	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, num_tqps,
 				  sizeof(struct hnae3_queue *), GFP_KERNEL);
 	if (!kinfo->tqp)
 		return -ENOMEM;
 
-	ret = hclge_assign_tqp(vport);
+	ret = hclge_assign_tqp(vport, num_tqps);
 	if (ret)
 		dev_err(&hdev->pdev->dev, "fail to assign TQPs %d.\n", ret);
 
@@ -7532,25 +7530,6 @@ static void hclge_get_tqps_and_rss_info(struct hnae3_handle *handle,
 	*max_rss_size = hdev->rss_size_max;
 }
 
-static void hclge_release_tqp(struct hclge_vport *vport)
-{
-	struct hnae3_knic_private_info *kinfo = &vport->nic.kinfo;
-	struct hclge_dev *hdev = vport->back;
-	int i;
-
-	for (i = 0; i < kinfo->num_tqps; i++) {
-		struct hclge_tqp *tqp =
-			container_of(kinfo->tqp[i], struct hclge_tqp, q);
-
-		tqp->q.handle = NULL;
-		tqp->q.tqp_index = 0;
-		tqp->alloced = false;
-	}
-
-	devm_kfree(&hdev->pdev->dev, kinfo->tqp);
-	kinfo->tqp = NULL;
-}
-
 static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -7565,24 +7544,11 @@ static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num)
 	u32 *rss_indir;
 	int ret, i;
 
-	/* Free old tqps, and reallocate with new tqp number when nic setup */
-	hclge_release_tqp(vport);
-
-	ret = hclge_knic_setup(vport, new_tqps_num, kinfo->num_desc);
-	if (ret) {
-		dev_err(&hdev->pdev->dev, "setup nic fail, ret =%d\n", ret);
-		return ret;
-	}
-
-	ret = hclge_map_tqp_to_vport(hdev, vport);
-	if (ret) {
-		dev_err(&hdev->pdev->dev, "map vport tqp fail, ret =%d\n", ret);
-		return ret;
-	}
+	kinfo->req_rss_size = new_tqps_num;
 
-	ret = hclge_tm_schd_init(hdev);
+	ret = hclge_tm_vport_map_update(hdev);
 	if (ret) {
-		dev_err(&hdev->pdev->dev, "tm schd init fail, ret =%d\n", ret);
+		dev_err(&hdev->pdev->dev, "tm vport map fail, ret =%d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 8c57950..fb8596a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -517,14 +517,27 @@ static void hclge_tm_vport_tc_info_update(struct hclge_vport *vport)
 {
 	struct hnae3_knic_private_info *kinfo = &vport->nic.kinfo;
 	struct hclge_dev *hdev = vport->back;
+	u16 max_rss_size;
 	u8 i;
 
 	vport->bw_limit = hdev->tm_info.pg_info[0].bw_limit;
-	kinfo->num_tc =
-		min_t(u16, kinfo->num_tqps, hdev->tm_info.num_tc);
-	kinfo->rss_size
-		= min_t(u16, hdev->rss_size_max,
-			kinfo->num_tqps / kinfo->num_tc);
+	kinfo->num_tc = min_t(u16, vport->alloc_tqps, hdev->tm_info.num_tc);
+	max_rss_size = min_t(u16, hdev->rss_size_max,
+			     vport->alloc_tqps / kinfo->num_tc);
+
+	if (kinfo->req_rss_size != kinfo->rss_size && kinfo->req_rss_size &&
+	    kinfo->req_rss_size <= max_rss_size) {
+		dev_info(&hdev->pdev->dev, "rss changes from %d to %d\n",
+			 kinfo->rss_size, kinfo->req_rss_size);
+		kinfo->rss_size = kinfo->req_rss_size;
+	} else if (kinfo->rss_size > max_rss_size ||
+		   (!kinfo->req_rss_size && kinfo->rss_size < max_rss_size)) {
+		dev_info(&hdev->pdev->dev, "rss changes from %d to %d\n",
+			 kinfo->rss_size, max_rss_size);
+		kinfo->rss_size = max_rss_size;
+	}
+
+	kinfo->num_tqps = kinfo->num_tc * kinfo->rss_size;
 	vport->qs_offset = hdev->tm_info.num_tc * vport->vport_id;
 	vport->dwrr = 100;  /* 100 percent as init */
 	vport->alloc_rss_size = kinfo->rss_size;
@@ -1334,3 +1347,20 @@ int hclge_tm_schd_init(struct hclge_dev *hdev)
 
 	return hclge_tm_init_hw(hdev);
 }
+
+int hclge_tm_vport_map_update(struct hclge_dev *hdev)
+{
+	struct hclge_vport *vport = hdev->vport;
+	int ret;
+
+	hclge_tm_vport_tc_info_update(vport);
+
+	ret = hclge_vport_q_to_qs_map(hdev, vport);
+	if (ret)
+		return ret;
+
+	if (!(hdev->flag & HCLGE_FLAG_DCB_ENABLE))
+		return 0;
+
+	return hclge_tm_bp_setup(hdev);
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index b6496a4..898163c4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -142,6 +142,7 @@ struct hclge_port_shapping_cmd {
 				       (HCLGE_TM_SHAP_##string##_LSH))
 
 int hclge_tm_schd_init(struct hclge_dev *hdev);
+int hclge_tm_vport_map_update(struct hclge_dev *hdev);
 int hclge_pause_setup_hw(struct hclge_dev *hdev);
 int hclge_tm_schd_mode_hw(struct hclge_dev *hdev);
 void hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc);
-- 
2.7.4

