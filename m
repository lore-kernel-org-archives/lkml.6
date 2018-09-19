Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D64C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2062151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2062151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbeISXKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733104AbeISXKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0A155DE362B08;
        Thu, 20 Sep 2018 01:31:03 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:30:56 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: Add default irq affinity
Date:   Wed, 19 Sep 2018 18:29:47 +0100
Message-ID: <20180919172958.12992-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180919172958.12992-1-salil.mehta@huawei.com>
References: <20180919172958.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

All irq will float to cpu0 if do not set irq affinity.
This patch adds default irq affinity in hns3 driver, users can
also change the irq affinity in OS.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 49 +++++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  2 +
 2 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 75e8ee9..052b7fb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -66,6 +66,23 @@ static irqreturn_t hns3_irq_handle(int irq, void *vector)
 	return IRQ_HANDLED;
 }
 
+/* This callback function is used to set affinity changes to the irq affinity
+ * masks when the irq_set_affinity_notifier function is used.
+ */
+static void hns3_nic_irq_affinity_notify(struct irq_affinity_notify *notify,
+					 const cpumask_t *mask)
+{
+	struct hns3_enet_tqp_vector *tqp_vectors =
+		container_of(notify, struct hns3_enet_tqp_vector,
+			     affinity_notify);
+
+	tqp_vectors->affinity_mask = *mask;
+}
+
+static void hns3_nic_irq_affinity_release(struct kref *ref)
+{
+}
+
 static void hns3_nic_uninit_irq(struct hns3_nic_priv *priv)
 {
 	struct hns3_enet_tqp_vector *tqp_vectors;
@@ -77,6 +94,10 @@ static void hns3_nic_uninit_irq(struct hns3_nic_priv *priv)
 		if (tqp_vectors->irq_init_flag != HNS3_VECTOR_INITED)
 			continue;
 
+		/* clear the affinity notifier and affinity mask */
+		irq_set_affinity_notifier(tqp_vectors->vector_irq, NULL);
+		irq_set_affinity_hint(tqp_vectors->vector_irq, NULL);
+
 		/* release the irq resource */
 		free_irq(tqp_vectors->vector_irq, tqp_vectors);
 		tqp_vectors->irq_init_flag = HNS3_VECTOR_NOT_INITED;
@@ -127,6 +148,15 @@ static int hns3_nic_init_irq(struct hns3_nic_priv *priv)
 			return ret;
 		}
 
+		tqp_vectors->affinity_notify.notify =
+					hns3_nic_irq_affinity_notify;
+		tqp_vectors->affinity_notify.release =
+					hns3_nic_irq_affinity_release;
+		irq_set_affinity_notifier(tqp_vectors->vector_irq,
+					  &tqp_vectors->affinity_notify);
+		irq_set_affinity_hint(tqp_vectors->vector_irq,
+				      &tqp_vectors->affinity_mask);
+
 		tqp_vectors->irq_init_flag = HNS3_VECTOR_INITED;
 	}
 
@@ -2640,6 +2670,23 @@ static void hns3_add_ring_to_group(struct hns3_enet_ring_group *group,
 	group->count++;
 }
 
+static void hns3_nic_set_cpumask(struct hns3_nic_priv *priv)
+{
+	struct pci_dev *pdev = priv->ae_handle->pdev;
+	struct hns3_enet_tqp_vector *tqp_vector;
+	int num_vectors = priv->vector_num;
+	int numa_node;
+	int vector_i;
+
+	numa_node = dev_to_node(&pdev->dev);
+
+	for (vector_i = 0; vector_i < num_vectors; vector_i++) {
+		tqp_vector = &priv->tqp_vector[vector_i];
+		cpumask_set_cpu(cpumask_local_spread(vector_i, numa_node),
+				&tqp_vector->affinity_mask);
+	}
+}
+
 static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 {
 	struct hnae3_ring_chain_node vector_ring_chain;
@@ -2648,6 +2695,8 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 	int ret = 0;
 	u16 i;
 
+	hns3_nic_set_cpumask(priv);
+
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
 		hns3_vector_gl_rl_init_hw(tqp_vector, priv);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index cb450d7..31fa21f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -491,7 +491,9 @@ struct hns3_enet_tqp_vector {
 	struct hns3_enet_ring_group rx_group;
 	struct hns3_enet_ring_group tx_group;
 
+	cpumask_t affinity_mask;
 	u16 num_tqps;	/* total number of tqps in TQP vector */
+	struct irq_affinity_notify affinity_notify;
 
 	char name[HNAE3_INT_NAME_LEN];
 
-- 
2.7.4


