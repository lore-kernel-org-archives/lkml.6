Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F9EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7642064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0MBlkp7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7642064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeKAIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbeKAIGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0630B20838;
        Wed, 31 Oct 2018 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027187;
        bh=bogQ2OPasVtxpZlxeHE3LLGq5X4oWhJUFJbQ2bmGGcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MBlkp7ll5l+sAq6vzp8C4EjR/xhuwGALvGEAOYkCoHqSqJMAeiZJYhFLLYB1qYRG
         CqFemfirooi4nvagLvVYIN9+ADqij6oVHj5ajqOygCrN/oZgraWQay6IVK8UGGR4OJ
         ieNV+8LRWuvPglmX4IAEaFmnn5KxMWqQeUxyUsW0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 050/146] net: hns3: Add nic state check before calling netif_tx_wake_queue
Date:   Wed, 31 Oct 2018 19:04:05 -0400
Message-Id: <20181031230541.28822-50-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 7a8101109dd37837f587cd56f3111d4fc17a07f5 ]

When nic down, it firstly calls netif_tx_stop_all_queues(), then calls
napi_disable(). But napi_disable() will wait current napi_poll finish,
it may call netif_tx_wake_queue(). This patch fixes it by add nic state
checking.

Fixes: 424eb834a9be ("net: hns3: Unified HNS3 {VF|PF} Ethernet Driver for hip08 SoC")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 955c4ab18b03..b7b2f8254ce1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1915,6 +1915,7 @@ static int is_valid_clean_head(struct hns3_enet_ring *ring, int h)
 bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
 {
 	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct netdev_queue *dev_queue;
 	int bytes, pkts;
 	int head;
@@ -1961,7 +1962,8 @@ bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
 		 * sees the new next_to_clean.
 		 */
 		smp_mb();
-		if (netif_tx_queue_stopped(dev_queue)) {
+		if (netif_tx_queue_stopped(dev_queue) &&
+		    !test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
 			netif_tx_wake_queue(dev_queue);
 			ring->stats.restart_queue++;
 		}
-- 
2.17.1

