Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4869FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD602086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeUa2r9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD602086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbeKIHkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeKIHku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:50 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5992086C;
        Thu,  8 Nov 2018 22:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714601;
        bh=ZFCKKlRgz6t+uzrigy/a7x05DGwHukpLnnsnKQFWpQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeUa2r9FzuhjelyrZjj2AdtXgHjT/gJZc96rUMoZ8QRKERmcPJakq8VImnnhAVeU+
         +XsDjHMoI1MzP2raSyCdGVjM4/2QTKlBRO6sblAN7KNZknf+Iso3NMbwXJb2SolY4I
         Z+hlmpg8udbn1D4V4CvbgY/uyRlkX3RPLoloPFWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rickard x Andersson <rickaran@axis.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 029/171] net: fec: fix rare tx timeout
Date:   Thu,  8 Nov 2018 13:49:59 -0800
Message-Id: <20181108215129.434702688@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -1267,7 +1267,7 @@ skb_done:
 
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



