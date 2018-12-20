Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8BE2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeLTDQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:16:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729183AbeLTDQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:23 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD122845A3967;
        Thu, 20 Dec 2018 11:16:19 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 11:16:15 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 6/9] net: hns3: fix vf id check issue when add flow director rule
Date:   Thu, 20 Dec 2018 11:52:03 +0800
Message-ID: <1545277926-66432-7-git-send-email-lipeng321@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

When add flow director fule for vf, the vf id is used as array
subscript before valid checking, which may cause memory overflow.

Fixes: dd74f815dd41 ("net: hns3: Add support for rule add/delete for flow director")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 98ae282..9f89858 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4677,6 +4677,13 @@ static int hclge_add_fd_entry(struct hnae3_handle *handle,
 		u8 vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
 		u16 tqps;
 
+		if (vf > hdev->num_req_vfs) {
+			dev_err(&hdev->pdev->dev,
+				"Error: vf id (%d) > max vf num (%d)\n",
+				vf, hdev->num_req_vfs);
+			return -EINVAL;
+		}
+
 		dst_vport_id = vf ? hdev->vport[vf].vport_id : vport->vport_id;
 		tqps = vf ? hdev->vport[vf].alloc_tqps : vport->alloc_tqps;
 
@@ -4687,13 +4694,6 @@ static int hclge_add_fd_entry(struct hnae3_handle *handle,
 			return -EINVAL;
 		}
 
-		if (vf > hdev->num_req_vfs) {
-			dev_err(&hdev->pdev->dev,
-				"Error: vf id (%d) > max vf num (%d)\n",
-				vf, hdev->num_req_vfs);
-			return -EINVAL;
-		}
-
 		action = HCLGE_FD_ACTION_ACCEPT_PACKET;
 		q_index = ring;
 	}
-- 
1.9.1

