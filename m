Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BFFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F0A20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUAAO4uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F0A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbeKLIUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388232AbeKLIT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0D4223D1;
        Sun, 11 Nov 2018 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975403;
        bh=PHJH00DfyhMSD5SFlRpBbgoheV3pocSu6LCdWVyhSOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUAAO4uW/B7CHvv9iSSWbPg+R0bzegVgD/gJN1IttrsG/2GvBip8x0t1JI2sq5tBv
         Mqy9HKpaHjsCh0JopoP3bfb2CIxMpFws6MQMiEyellQh1Bf1eoj/DZLjsyBUJz/5hU
         kAalnQB5LOUDRc/qeLTQBFN8kqfy9vBX7rFeTPe8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 103/350] net: hns3: Add nic state check before calling netif_tx_wake_queue
Date:   Sun, 11 Nov 2018 14:19:27 -0800
Message-Id: <20181111221711.405000420@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1907,6 +1907,7 @@ static int is_valid_clean_head(struct hn
 bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
 {
 	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct netdev_queue *dev_queue;
 	int bytes, pkts;
 	int head;
@@ -1953,7 +1954,8 @@ bool hns3_clean_tx_ring(struct hns3_enet
 		 * sees the new next_to_clean.
 		 */
 		smp_mb();
-		if (netif_tx_queue_stopped(dev_queue)) {
+		if (netif_tx_queue_stopped(dev_queue) &&
+		    !test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
 			netif_tx_wake_queue(dev_queue);
 			ring->stats.restart_queue++;
 		}


