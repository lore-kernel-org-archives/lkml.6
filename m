Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A20C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424D721480
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vXD1rMhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424D721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeJPMDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbeJPMDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C5B2148D;
        Tue, 16 Oct 2018 04:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663291;
        bh=7RcuDesSr22xID4BWMQ8xm6WSaX3q2viJM2KKuFU+Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vXD1rMhk/cTNnewPwRavJHwy8wVKjG2yp6H7DOcrs37B9KjXNQRE4F71BhFPEshxV
         21+QZaEywNMfgsRfsQGn/6WW4MZ00ZKxWNtRsAAs4w2dCEdD5Xq1IeZUpfE/27wKk4
         JrVjl39HAuRkI91746jxF0B9pbB6fa2pqfAtaoLQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rickard x Andersson <rickaran@axis.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 50/61] net: fec: fix rare tx timeout
Date:   Tue, 16 Oct 2018 00:13:52 -0400
Message-Id: <20181016041403.135678-50-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rickard x Andersson <rickaran@axis.com>

[ Upstream commit 657ade07df72847f591ccdb36bd9b91ed0edbac3 ]

During certain heavy network loads TX could time out
with TX ring dump.
TX is sometimes never restarted after reaching
"tx_stop_threshold" because function "fec_enet_tx_queue"
only tests the first queue.

In addition the TX timeout callback function failed to
recover because it also operated only on the first queue.

Signed-off-by: Rickard x Andersson <rickaran@axis.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index eb2ea231c7ca..8bfa6ef826a9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1155,7 +1155,7 @@ static void fec_enet_timeout_work(struct work_struct *work)
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(ndev);
 		fec_restart(ndev);
-		netif_wake_queue(ndev);
+		netif_tx_wake_all_queues(ndev);
 		netif_tx_unlock_bh(ndev);
 		napi_enable(&fep->napi);
 	}
@@ -1270,7 +1270,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 
 		/* Since we have freed up a buffer, the ring is no longer full
 		 */
-		if (netif_queue_stopped(ndev)) {
+		if (netif_tx_queue_stopped(nq)) {
 			entries_free = fec_enet_get_free_txdesc_num(txq);
 			if (entries_free >= txq->tx_wake_threshold)
 				netif_tx_wake_queue(nq);
@@ -1747,7 +1747,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
-			netif_wake_queue(ndev);
+			netif_tx_wake_all_queues(ndev);
 			netif_tx_unlock_bh(ndev);
 			napi_enable(&fep->napi);
 		}
@@ -2249,7 +2249,7 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(ndev);
 		fec_restart(ndev);
-		netif_wake_queue(ndev);
+		netif_tx_wake_all_queues(ndev);
 		netif_tx_unlock_bh(ndev);
 		napi_enable(&fep->napi);
 	}
-- 
2.17.1

