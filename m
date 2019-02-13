Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B83CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CB721934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MTQOFDUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392828AbfBMRAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:00:52 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:33308 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbfBMRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:00:51 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 690C210C080C;
        Wed, 13 Feb 2019 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550077251; bh=d8q5MR3izpl8VwXVtXGseZpfeWaHvQ+qPzz7A/lSimI=;
        h=From:To:Cc:Subject:Date:From;
        b=MTQOFDUhC23jRwqgVguy7CR/aWE5TuSFbOhwnaPgLh5lhiaQBPDyAN/dApL14dEU3
         RLRb+ZLb/LxKDPn5iPc/gHL4IcCXowlE6qW4P9vIhlqhvOhufmnC95jz33APcIQ2nw
         TLZ3p6Do5RuNdiK9xJmy9WUiguuRAkn20wHfn8CzKM/M2aeEZEgW+OGSwJb2E1OuoK
         xkSKZB0pU5EfIVIPa4w6a9ZbscTY+sMQKhnvnTh+YkPY6LZE50ikZ6vCTip4IDmesf
         pJePcXgT4gK0r1oFI5sbP6S0m1pw+riJx6CqNpFCSpRJd+m+vJGl8C7bnRO8ecKBBm
         /QNqlChVUbhnA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 8A18D5637;
        Wed, 13 Feb 2019 09:00:49 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net] net: stmmac: Fix NAPI poll in TX path when in multi-queue
Date:   Wed, 13 Feb 2019 18:00:43 +0100
Message-Id: <a264c48823687434e4d18aeb5830707e00c64250.1550077162.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8fce33317023 introduced the concept of NAPI per-channel and
independent cleaning of TX path.

This is currently breaking performance in some cases. The scenario
happens when all packets are being received in Queue 0 but the TX is
performed in Queue != 0.

I didn't look very deep but it seems that NAPI for Queue 0 will clean
the RX path but as TX is in different NAPI, this last one is called at a
slower rate which kills performance in TX. I suspect this is due to TX
cleaning takes much longer than RX and because NAPI will get canceled
once we return with 0 budget consumed (e.g. when TX is still not done it
will return 0 budget).

Fix this by looking at all TX channels in NAPI poll function.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 63e1064b27a2..8f6741a626d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -82,7 +82,6 @@ struct stmmac_channel {
 	struct stmmac_priv *priv_data;
 	u32 index;
 	int has_rx;
-	int has_tx;
 };
 
 struct stmmac_tc_entry {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 685d20472358..5bf5f8ebb4b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2031,13 +2031,13 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan)
 	struct stmmac_channel *ch = &priv->channel[chan];
 	bool needs_work = false;
 
-	if ((status & handle_rx) && ch->has_rx) {
+	if (status & handle_rx) {
 		needs_work = true;
 	} else {
 		status &= ~handle_rx;
 	}
 
-	if ((status & handle_tx) && ch->has_tx) {
+	if (status & handle_tx) {
 		needs_work = true;
 	} else {
 		status &= ~handle_tx;
@@ -3528,11 +3528,12 @@ static int stmmac_napi_poll(struct napi_struct *napi, int budget)
 	struct stmmac_priv *priv = ch->priv_data;
 	int work_done, rx_done = 0, tx_done = 0;
 	u32 chan = ch->index;
+	int i;
 
 	priv->xstats.napi_poll++;
 
-	if (ch->has_tx)
-		tx_done = stmmac_tx_clean(priv, budget, chan);
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
+		tx_done += stmmac_tx_clean(priv, budget, i);
 	if (ch->has_rx)
 		rx_done = stmmac_rx(priv, budget, chan);
 
@@ -4325,8 +4326,6 @@ int stmmac_dvr_probe(struct device *device,
 
 		if (queue < priv->plat->rx_queues_to_use)
 			ch->has_rx = true;
-		if (queue < priv->plat->tx_queues_to_use)
-			ch->has_tx = true;
 
 		netif_napi_add(ndev, &ch->napi, stmmac_napi_poll,
 			       NAPI_POLL_WEIGHT);
-- 
2.7.4

