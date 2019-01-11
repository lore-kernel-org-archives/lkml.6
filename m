Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF47C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B972063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217086;
	bh=P4LZg10fwEg4f84c4sk+zejqZSUhJWuhu2XhiPkOfqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKvTceZCBYPrgnEiAwmxVse0W0ezRcHx4XXBFHFZoxTBE2d3BmqoivTzgrmuFdMpl
	 hredsXI5SQOceFGOfEv44QtgqV951DfLx03FZ7cglxMWrUgXjGF871I4ibNXJlPK+F
	 0p82rvXK3bmQiBA5KSQnvT5wytdsbrClcO1eoZnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfAKObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389156AbfAKObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B6921848;
        Fri, 11 Jan 2019 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217082;
        bh=P4LZg10fwEg4f84c4sk+zejqZSUhJWuhu2XhiPkOfqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+p/LoSRxc+4IdNw/kG8UL1pF/VD6vWT6ts90L4Z8ytqzUJs4DV2zWULJ8bahT6Au
         iPIpIgbTUUDzVPp5QcMfffGtfsB7rnuMxwkUEfgGbGDdRmrZV1WVeXYIQCq/9iyFhu
         crlVAfTVAFuMmAJJ4zmRVXL7BFdGNbOzqF/V/8IQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 036/105] net: hns: Free irq when exit from abnormal branch
Date:   Fri, 11 Jan 2019 15:14:07 +0100
Message-Id: <20190111131106.240713262@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 801fbcebfbaa..bcd9aaba09b3 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1384,6 +1384,22 @@ static int hns_nic_init_affinity_mask(int q_num, int ring_idx,
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
@@ -1409,7 +1425,7 @@ static int hns_nic_init_irq(struct hns_nic_priv *priv)
 		if (ret) {
 			netdev_err(priv->netdev, "request irq(%d) fail\n",
 				   rd->ring->irq);
-			return ret;
+			goto out_free_irq;
 		}
 		disable_irq(rd->ring->irq);
 
@@ -1424,6 +1440,10 @@ static int hns_nic_init_irq(struct hns_nic_priv *priv)
 	}
 
 	return 0;
+
+out_free_irq:
+	hns_nic_free_irq(h->q_num, priv);
+	return ret;
 }
 
 static int hns_nic_net_up(struct net_device *ndev)
@@ -1471,6 +1491,7 @@ static int hns_nic_net_up(struct net_device *ndev)
 	for (j = i - 1; j >= 0; j--)
 		hns_nic_ring_close(ndev, j);
 
+	hns_nic_free_irq(h->q_num, priv);
 	set_bit(NIC_STATE_DOWN, &priv->state);
 
 	return ret;
-- 
2.19.1



