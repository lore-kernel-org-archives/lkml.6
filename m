Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0C0C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93C020862
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wWfp0Z6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93C020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeKCDuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeKCDuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:09 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B80820854;
        Fri,  2 Nov 2018 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184117;
        bh=cdjFVVe5DIPX0L6K0yQHSLlPzVUKBsc0T+ty0Fl9uXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWfp0Z6m9fkioZahlWXkOt7KHKGLp9Iy/8TdWmF8HGbKBn1ZgEWTEF2qpi8wUwNWw
         y1HpuFqkmMffR5VvEtzrVOMgwnKEdH0DjUOFwXMWTkn3Gq0dfKsn4wqbH1O9zF2vcg
         ogE969q7Apmkvp9Uz/FtafV/eUsd5noMoLh3PTXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rickard x Andersson <rickaran@axis.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 060/150] net: fec: fix rare tx timeout
Date:   Fri,  2 Nov 2018 19:33:42 +0100
Message-Id: <20181102182907.741282330@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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
index c729665107f5..e10471ee0a8b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1157,7 +1157,7 @@ static void fec_enet_timeout_work(struct work_struct *work)
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(ndev);
 		fec_restart(ndev);
-		netif_wake_queue(ndev);
+		netif_tx_wake_all_queues(ndev);
 		netif_tx_unlock_bh(ndev);
 		napi_enable(&fep->napi);
 	}
@@ -1272,7 +1272,7 @@ skb_done:
 
 		/* Since we have freed up a buffer, the ring is no longer full
 		 */
-		if (netif_queue_stopped(ndev)) {
+		if (netif_tx_queue_stopped(nq)) {
 			entries_free = fec_enet_get_free_txdesc_num(txq);
 			if (entries_free >= txq->tx_wake_threshold)
 				netif_tx_wake_queue(nq);
@@ -1745,7 +1745,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
-			netif_wake_queue(ndev);
+			netif_tx_wake_all_queues(ndev);
 			netif_tx_unlock_bh(ndev);
 			napi_enable(&fep->napi);
 		}
@@ -2246,7 +2246,7 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
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



