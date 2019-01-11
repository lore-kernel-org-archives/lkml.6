Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70D2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749552177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216991;
	bh=OfoB1p4qiCIyPuc2Ty456x1e7sE0vdDjz+9ewDCj9SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oAXStkdKrrzzLpHAKJuJGpDluUR1zKjUd0cTXTFvnqu382IZ8h4lwj1ud89Q/Wjnn
	 RrTQgN302CjtYKftu49l5CREBOgM+tLmqroBXZ6R7MGZihHNFgfkQOgTKjueixiv0A
	 H50ery3ODM6NE5++QhzqvNaxKHRX7b54NQWk6pMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbfAKO3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388800AbfAKO3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75FD2063F;
        Fri, 11 Jan 2019 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216985;
        bh=OfoB1p4qiCIyPuc2Ty456x1e7sE0vdDjz+9ewDCj9SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwzSdhQa5vaB164RVAoBzCnO50svPmu60ljGrWK7dB+3eb/aDUYANvq9+CHMvydkz
         rN2xdrGDIVcVO6YgIFbC+gVH1fwICFEYZ88HIxG8p6z/7cGb9dYN3LqPElBEj1iSbn
         jg0gkgfMHoGz+wxh8V9joSD/hZXs3UTozWBEbHEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 24/63] net: hns: Free irq when exit from abnormal branch
Date:   Fri, 11 Jan 2019 15:14:27 +0100
Message-Id: <20190111131049.561214939@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



