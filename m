Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE03FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAB820651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863863;
	bh=MmiBwVwSm7pvKHoVDSJNZI2cbh8FY3Aeunc89WRQvY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xLy509Q454Fd06kQqkWkRyyJ3YUMwg0Q9VKGVWQgwyEWEHhCYW0Yr85nzXLyCcpJH
	 i2ITaJDssZYn4FqcuqECluZMw5wId4JimyBVnXyrNKo3uNkujxXxK/1xFAgtSdOBUN
	 2IgJJQsAdH8Pg+gTFZSS3+jxmjR1oUAzHUac2fkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeLZWhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbeLZWhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 512A92054F;
        Wed, 26 Dec 2018 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863857;
        bh=MmiBwVwSm7pvKHoVDSJNZI2cbh8FY3Aeunc89WRQvY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ+ppXpa2335VvnFVlaMsPM43330p3zcLuC10AqrreTXvivCx1gb/1V/Vlq33144A
         iFt1hFlsE/MDxWYfOpYVNfw0hJ+3wdC5KESnXuGRtMES980N2kXBme0oqwk2supfHb
         mrFJXe2OxtVFIc4hM5MN+2w+grKQR+O9SRZz1dGk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 59/97] net: hns: Free irq when exit from abnormal branch
Date:   Wed, 26 Dec 2018 17:35:19 -0500
Message-Id: <20181226223557.149329-59-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index c9454c4784cb..03d959c7a39f 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1284,6 +1284,22 @@ static int hns_nic_init_affinity_mask(int q_num, int ring_idx,
 	return cpu;
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
@@ -1309,7 +1325,7 @@ static int hns_nic_init_irq(struct hns_nic_priv *priv)
 		if (ret) {
 			netdev_err(priv->netdev, "request irq(%d) fail\n",
 				   rd->ring->irq);
-			return ret;
+			goto out_free_irq;
 		}
 		disable_irq(rd->ring->irq);
 
@@ -1324,6 +1340,10 @@ static int hns_nic_init_irq(struct hns_nic_priv *priv)
 	}
 
 	return 0;
+
+out_free_irq:
+	hns_nic_free_irq(h->q_num, priv);
+	return ret;
 }
 
 static int hns_nic_net_up(struct net_device *ndev)
@@ -1371,6 +1391,7 @@ static int hns_nic_net_up(struct net_device *ndev)
 	for (j = i - 1; j >= 0; j--)
 		hns_nic_ring_close(ndev, j);
 
+	hns_nic_free_irq(h->q_num, priv);
 	set_bit(NIC_STATE_DOWN, &priv->state);
 
 	return ret;
-- 
2.19.1

