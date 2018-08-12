Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE954C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96221943
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF96221943
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeHLM0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728084AbeHLM0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0EB28DF8384A;
        Sun, 12 Aug 2018 17:48:45 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:39 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 6/9] net: hns3: Fix desc num set to default when setting channel
Date:   Sun, 12 Aug 2018 10:47:35 +0100
Message-ID: <20180812094738.14852-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180812094738.14852-1-salil.mehta@huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.119]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When user set the channel num using "ethtool -L ethX", the desc num
of BD will set to default value, which will cause desc num set by
user lost problem.

This patch fixes it by restoring the desc num set by user when setting
channel num.

Fixes: 09f2af6405b8 ("net: hns3: add support to modify tqps number")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c88f5e6a9b77..8510245705cc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1267,35 +1267,37 @@ static int hclge_map_tqps_to_func(struct hclge_dev *hdev, u16 func_id,
 	return ret;
 }
 
-static int  hclge_assign_tqp(struct hclge_vport *vport,
-			     struct hnae3_queue **tqp, u16 num_tqps)
+static int  hclge_assign_tqp(struct hclge_vport *vport)
 {
+	struct hnae3_knic_private_info *kinfo = &vport->nic.kinfo;
 	struct hclge_dev *hdev = vport->back;
 	int i, alloced;
 
 	for (i = 0, alloced = 0; i < hdev->num_tqps &&
-	     alloced < num_tqps; i++) {
+	     alloced < kinfo->num_tqps; i++) {
 		if (!hdev->htqp[i].alloced) {
 			hdev->htqp[i].q.handle = &vport->nic;
 			hdev->htqp[i].q.tqp_index = alloced;
-			tqp[alloced] = &hdev->htqp[i].q;
+			hdev->htqp[i].q.desc_num = kinfo->num_desc;
+			kinfo->tqp[alloced] = &hdev->htqp[i].q;
 			hdev->htqp[i].alloced = true;
 			alloced++;
 		}
 	}
-	vport->alloc_tqps = num_tqps;
+	vport->alloc_tqps = kinfo->num_tqps;
 
 	return 0;
 }
 
-static int hclge_knic_setup(struct hclge_vport *vport, u16 num_tqps)
+static int hclge_knic_setup(struct hclge_vport *vport,
+			    u16 num_tqps, u16 num_desc)
 {
 	struct hnae3_handle *nic = &vport->nic;
 	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
 	struct hclge_dev *hdev = vport->back;
 	int i, ret;
 
-	kinfo->num_desc = hdev->num_desc;
+	kinfo->num_desc = num_desc;
 	kinfo->rx_buf_len = hdev->rx_buf_len;
 	kinfo->num_tc = min_t(u16, num_tqps, hdev->tm_info.num_tc);
 	kinfo->rss_size
@@ -1322,7 +1324,7 @@ static int hclge_knic_setup(struct hclge_vport *vport, u16 num_tqps)
 	if (!kinfo->tqp)
 		return -ENOMEM;
 
-	ret = hclge_assign_tqp(vport, kinfo->tqp, kinfo->num_tqps);
+	ret = hclge_assign_tqp(vport);
 	if (ret)
 		dev_err(&hdev->pdev->dev, "fail to assign TQPs %d.\n", ret);
 
@@ -1388,7 +1390,7 @@ static int hclge_vport_setup(struct hclge_vport *vport, u16 num_tqps)
 	nic->numa_node_mask = hdev->numa_node_mask;
 
 	if (hdev->ae_dev->dev_type == HNAE3_DEV_KNIC) {
-		ret = hclge_knic_setup(vport, num_tqps);
+		ret = hclge_knic_setup(vport, num_tqps, hdev->num_desc);
 		if (ret) {
 			dev_err(&hdev->pdev->dev, "knic setup failed %d\n",
 				ret);
@@ -5944,7 +5946,7 @@ static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num)
 	/* Free old tqps, and reallocate with new tqp number when nic setup */
 	hclge_release_tqp(vport);
 
-	ret = hclge_knic_setup(vport, new_tqps_num);
+	ret = hclge_knic_setup(vport, new_tqps_num, kinfo->num_desc);
 	if (ret) {
 		dev_err(&hdev->pdev->dev, "setup nic fail, ret =%d\n", ret);
 		return ret;
-- 
2.11.0


