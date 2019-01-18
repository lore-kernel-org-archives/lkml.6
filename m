Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E17C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A572086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfARIOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:14:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbfARIN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:56 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0A61DEC02C96B8F9AEA;
        Fri, 18 Jan 2019 16:13:54 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:44 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: adjust the use of alloc_tqps and num_tqps
Date:   Fri, 18 Jan 2019 16:13:11 +0800
Message-ID: <1547799194-38212-10-git-send-email-tanhuazhong@huawei.com>
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

The alloc_tqps field of struct hclge_vport represents the total number
of tqps allocated to the vport. The num_tqps of struct
hnae3_knic_private_info indicates the total number of all enabled tqps,
which needs to be distinguished during use.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 55a456f..9506c52 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1123,7 +1123,7 @@ static int hclge_map_tqp_to_vport(struct hclge_dev *hdev,
 	u16 i;
 
 	kinfo = &nic->kinfo;
-	for (i = 0; i < kinfo->num_tqps; i++) {
+	for (i = 0; i < vport->alloc_tqps; i++) {
 		struct hclge_tqp *q =
 			container_of(kinfo->tqp[i], struct hclge_tqp, q);
 		bool is_pf;
@@ -5241,6 +5241,7 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 			      enum hnae3_loop loop_mode, bool en)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hnae3_knic_private_info *kinfo;
 	struct hclge_dev *hdev = vport->back;
 	int i, ret;
 
@@ -5259,7 +5260,8 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 		break;
 	}
 
-	for (i = 0; i < vport->alloc_tqps; i++) {
+	kinfo = &vport->nic.kinfo;
+	for (i = 0; i < kinfo->num_tqps; i++) {
 		ret = hclge_tqp_enable(hdev, i, 0, en);
 		if (ret)
 			return ret;
@@ -5271,11 +5273,13 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 static void hclge_reset_tqp_stats(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hnae3_knic_private_info *kinfo;
 	struct hnae3_queue *queue;
 	struct hclge_tqp *tqp;
 	int i;
 
-	for (i = 0; i < vport->alloc_tqps; i++) {
+	kinfo = &vport->nic.kinfo;
+	for (i = 0; i < kinfo->num_tqps; i++) {
 		queue = handle->kinfo.tqp[i];
 		tqp = container_of(queue, struct hclge_tqp, q);
 		memset(&tqp->tqp_stats, 0, sizeof(tqp->tqp_stats));
-- 
2.7.4

