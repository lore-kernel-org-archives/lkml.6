Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90310C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF13214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864975;
	bh=wDf4zjb9rEvdGiwp9Kgq9zafUn+YBESe08rWbKX+nBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wiLufudjSbeBbUMaGS8TTM2wsJRZCTY8wyOYNCszR4KBdfVEL+HOp64zhLueKwmOA
	 Ip933RQLWw5JVOTvki+2gxL7OvOSOFZgLxpRzX5hzmFPGPNeAdYLI6rNPBWbl9Dbnj
	 m6wkDRwh2Ug3a7NQbBLGrflpNwNGahMHRDsRNx38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeLZW4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbeLZWyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EAEF21741;
        Wed, 26 Dec 2018 22:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864879;
        bh=wDf4zjb9rEvdGiwp9Kgq9zafUn+YBESe08rWbKX+nBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HI8VbBy6OP2VrBkWFGZREyK0xSs4jZ0f7FWPVcKC69lpjNhx4XEkZ8mjrWac81OIZ
         N1uMCJV7SFxjz4YFl1ebuE9K6tmMM3qfEQ6zKoxqpq4haSCR6VEgj3vnBISVW42/ZE
         Z+S/r+u19RHmqxCwKXtTBEGJWlwBXh00DTcf05d0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 25/35] net: hns: Free irq when exit from abnormal branch
Date:   Wed, 26 Dec 2018 17:41:32 -0500
Message-Id: <20181226224142.150866-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit c82bd077e1ba3dd586569c733dc6d3dd4b0e43cd ]

1.In "hns_nic_init_irq", if request irq fail at index i,
  the function return directly without releasing irq resources
  that already requested.

2.In "hns_nic_net_up" after "hns_nic_init_irq",
  if exceptional branch occurs, irqs that already requested
  are not release.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index d96a64bc1db8..63a14edd6a19 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1195,6 +1195,22 @@ static void hns_set_irq_affinity(struct hns_nic_priv *priv)
 	}
 }
 
+static void hns_nic_free_irq(int q_num, struct hns_nic_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < q_num * 2; i++) {
+		if (priv->ring_data[i].ring->irq_init_flag == RCB_IRQ_INITED) {
+			irq_set_affinity_hint(priv->ring_data[i].ring->irq,
+					      NULL);
+			free_irq(priv->ring_data[i].ring->irq,
+				 &priv->ring_data[i]);
+			priv->ring_data[i].ring->irq_init_flag =
+				RCB_IRQ_NOT_INITED;
+		}
+	}
+}
+
 static int hns_nic_init_irq(struct hns_nic_priv *priv)
 {
 	struct hnae_handle *h = priv->ae_handle;
@@ -1219,7 +1235,7 @@ static int hns_nic_init_irq(struct hns_nic_priv *priv)
 		if (ret) {
 			netdev_err(priv->netdev, "request irq(%d) fail\n",
 				   rd->ring->irq);
-			return ret;
+			goto out_free_irq;
 		}
 		disable_irq(rd->ring->irq);
 		rd->ring->irq_init_flag = RCB_IRQ_INITED;
@@ -1229,6 +1245,10 @@ static int hns_nic_init_irq(struct hns_nic_priv *priv)
 	hns_set_irq_affinity(priv);
 
 	return 0;
+
+out_free_irq:
+	hns_nic_free_irq(h->q_num, priv);
+	return ret;
 }
 
 static int hns_nic_net_up(struct net_device *ndev)
@@ -1276,6 +1296,7 @@ static int hns_nic_net_up(struct net_device *ndev)
 	for (j = i - 1; j >= 0; j--)
 		hns_nic_ring_close(ndev, j);
 
+	hns_nic_free_irq(h->q_num, priv);
 	set_bit(NIC_STATE_DOWN, &priv->state);
 
 	return ret;
-- 
2.19.1

