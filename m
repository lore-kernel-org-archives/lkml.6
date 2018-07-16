Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4C7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BB8208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BB8208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeGPQFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731420AbeGPQFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:45 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 49F4C50490F97;
        Mon, 16 Jul 2018 23:37:29 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.382.0; Mon, 16 Jul 2018 23:37:23 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 8/9] net: hns3: Fix for using wrong mask and shift in hclge_get_ring_chain_from_mbx
Date:   Mon, 16 Jul 2018 16:36:26 +0100
Message-ID: <20180716153627.476-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716153627.476-1-salil.mehta@huawei.com>
References: <20180716153627.476-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

HCLGE_INT_GL_IDX_M and HCLGE_INT_GL_IDX_S are used to set fireware
cmd. When getting int_gl value from mailbox message, we should use
HNAE3_RING_GL_IDX_M and HNAE3_RING_GL_IDX_S.

Fixes: 79eee4108541 ("net: hns3: add int_gl_idx setup for VF")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 50ae2f8..9d36bcc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -131,8 +131,8 @@ static int hclge_get_ring_chain_from_mbx(
 	hnae3_set_bit(ring_chain->flag, HNAE3_RING_TYPE_B, req->msg[3]);
 	ring_chain->tqp_index =
 			hclge_get_queue_id(vport->nic.kinfo.tqp[req->msg[4]]);
-	hnae3_set_field(ring_chain->int_gl_idx, HCLGE_INT_GL_IDX_M,
-			HCLGE_INT_GL_IDX_S,
+	hnae3_set_field(ring_chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
+			HNAE3_RING_GL_IDX_S,
 			req->msg[5]);
 
 	cur_chain = ring_chain;
@@ -151,8 +151,8 @@ static int hclge_get_ring_chain_from_mbx(
 			[req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
 			HCLGE_MBX_RING_MAP_BASIC_MSG_NUM + 1]]);
 
-		hnae3_set_field(new_chain->int_gl_idx, HCLGE_INT_GL_IDX_M,
-				HCLGE_INT_GL_IDX_S,
+		hnae3_set_field(new_chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
+				HNAE3_RING_GL_IDX_S,
 				req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
 				HCLGE_MBX_RING_MAP_BASIC_MSG_NUM + 2]);
 
-- 
2.7.4


