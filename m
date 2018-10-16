Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DBC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A734214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmY5R77u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A734214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbeJPMEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbeJPMET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2A7214AB;
        Tue, 16 Oct 2018 04:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663356;
        bh=DyF6kO+K1rG2hPDtEni2CRE+qIuQehQuTjmvTqb+zlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmY5R77u0aMd5ab6ipv9ZJhdeRiEgED80tBbFB3wukp4Vrlp3r/hVm402MUPxncRH
         aVcPHNPsKWEV1NRw9VYHmpl0yCl1NqCa4Hyyb2bYqCdgRwOtm2lC8XO1hDRNTNn57W
         dOnGdaXh4a+reThthrz0mk2Hhp1qODzCzkZCpyFo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rickard x Andersson <rickaran@axis.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 34/38] net: fec: fix rare tx timeout
Date:   Tue, 16 Oct 2018 00:15:18 -0400
Message-Id: <20181016041522.135789-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041522.135789-1-sashal@kernel.org>
References: <20181016041522.135789-1-sashal@kernel.org>
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
index fe00f71bc6b4..051ecc76a7ef 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1152,7 +1152,7 @@ static void fec_enet_timeout_work(struct work_struct *work)
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(ndev);
 		fec_restart(ndev);
-		netif_wake_queue(ndev);
+		netif_tx_wake_all_queues(ndev);
 		netif_tx_unlock_bh(ndev);
 		napi_enable(&fep->napi);
 	}
@@ -1267,7 +1267,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 
 		/* Since we have freed up a buffer, the ring is no longer full
 		 */
-		if (netif_queue_stopped(ndev)) {
+		if (netif_tx_queue_stopped(nq)) {
 			entries_free = fec_enet_get_free_txdesc_num(txq);
 			if (entries_free >= txq->tx_wake_threshold)
 				netif_tx_wake_queue(nq);
@@ -1744,7 +1744,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
-			netif_wake_queue(ndev);
+			netif_tx_wake_all_queues(ndev);
 			netif_tx_unlock_bh(ndev);
 			napi_enable(&fep->napi);
 		}
@@ -2247,7 +2247,7 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
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

