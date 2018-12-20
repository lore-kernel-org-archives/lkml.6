Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09866C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D364821741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeLTDQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:16:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729230AbeLTDQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:23 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D894ABCDBAE99;
        Thu, 20 Dec 2018 11:16:19 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 11:16:15 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: reset tqp while doing DOWN operation
Date:   Thu, 20 Dec 2018 11:52:02 +0800
Message-ID: <1545277926-66432-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
References: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

While doing DOWN operation, the driver will reclaim the memory which has
already used for TX. If the hardware is processing this memory, it will
cause a RCB error to the hardware. According the hardware's description,
the driver should reset the tqp before reclaim the memory during DOWN.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 0b04d04..98ae282 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5331,6 +5331,7 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	int i;
 
 	set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
@@ -5343,6 +5344,9 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 		return;
 	}
 
+	for (i = 0; i < handle->kinfo.num_tqps; i++)
+		hclge_reset_tqp(handle, i);
+
 	/* Mac disable */
 	hclge_cfg_mac_mode(hdev, false);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 919c3aa..156242f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1870,9 +1870,13 @@ static int hclgevf_ae_start(struct hnae3_handle *handle)
 static void hclgevf_ae_stop(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int i;
 
 	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
+	for (i = 0; i < handle->kinfo.num_tqps; i++)
+		hclgevf_reset_tqp(handle, i);
+
 	/* reset tqp stats */
 	hclgevf_reset_tqp_stats(handle);
 	hclgevf_update_link_status(hdev, 0);
-- 
1.9.1

