Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF7BC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65B1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLRLCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeLRLCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:08 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DDD4C97A19CCA;
        Tue, 18 Dec 2018 19:02:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:57 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: fix incomplete uninitialization of IRQ in the hns3_nic_uninit_vector_data()
Date:   Tue, 18 Dec 2018 19:37:53 +0800
Message-ID: <1545133079-79605-7-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
References: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

In the hns3_nic_uninit_vector_data(), the procedure of uninitializing
the tqp_vector's IRQ has not set affinity_notify to NULL and changes
its init flag. This patch fixes it. And for simplificaton, local
variable tqp_vector is used instead of priv->tqp_vector[i].

Fixes: 424eb834a9be ("net: hns3: Unified HNS3 {VF|PF} Ethernet Driver for hip08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e7cde08..354eca8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3181,12 +3181,12 @@ static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 
 		hns3_free_vector_ring_chain(tqp_vector, &vector_ring_chain);
 
-		if (priv->tqp_vector[i].irq_init_flag == HNS3_VECTOR_INITED) {
-			(void)irq_set_affinity_hint(
-				priv->tqp_vector[i].vector_irq,
-						    NULL);
-			free_irq(priv->tqp_vector[i].vector_irq,
-				 &priv->tqp_vector[i]);
+		if (tqp_vector->irq_init_flag == HNS3_VECTOR_INITED) {
+			irq_set_affinity_notifier(tqp_vector->vector_irq,
+						  NULL);
+			irq_set_affinity_hint(tqp_vector->vector_irq, NULL);
+			free_irq(tqp_vector->vector_irq, tqp_vector);
+			tqp_vector->irq_init_flag = HNS3_VECTOR_NOT_INITED;
 		}
 
 		priv->ring_data[i].ring->irq_init_flag = HNS3_VECTOR_NOT_INITED;
-- 
1.9.1

