Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E64C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07526222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025310;
	bh=TODPY5ZMFTP/fxSsWDDPdX60IJxYtgCDhedP/dUL6i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ax0IT4DtupjHJPkbt5Z8LJ4C0o1EgDdAiJ+m8NbygIqXhPl8cIwFKoo47kNg6K5eD
	 iJQcktF/SfOpOW7HVifVDbVpqMIhNDfGDkGkGlhtOMBr5adtEFzSTuFXvjPx+yJ4vF
	 XtEOO1PnyXOd4W+YpKd0IBYFvAY0orbi3mNzN090=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfBMCfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387900AbfBMCfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAE7222C2;
        Wed, 13 Feb 2019 02:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025304;
        bh=TODPY5ZMFTP/fxSsWDDPdX60IJxYtgCDhedP/dUL6i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGzqPohWxSQndSJS6RwS0Xa1F0dVAFwDvhynRFaZ4Je9M1KjUhhUQ8BAYczcPkJXA
         b9+NbEhL90QP4iEoVYdseVpou+Ci5/AQJq8DRhIu9HEQ2CuVA9ZiU5HqPXbXlekVGc
         4CatHFjZNA7akE9DTGKqv48ZoHMXL7rj9F9gGl4U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 057/105] net: stmmac: Prevent RX starvation in stmmac_napi_poll()
Date:   Tue, 12 Feb 2019 21:32:48 -0500
Message-Id: <20190213023336.19019-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>

[ Upstream commit fa0be0a43f101888ac677dba31b590963eafeaa1 ]

Currently, TX is given a budget which is consumed by stmmac_tx_clean()
and stmmac_rx() is given the remaining non-consumed budget.

This is wrong and in case we are sending a large number of packets this
can starve RX because remaining budget will be low.

Let's give always the same budget for RX and TX clean.

While at it, check if we missed any interrupts while we were in NAPI
callback by looking at DMA interrupt status.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe9240e15aea..5d83d6a7694b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3525,27 +3525,28 @@ static int stmmac_napi_poll(struct napi_struct *napi, int budget)
 	struct stmmac_channel *ch =
 		container_of(napi, struct stmmac_channel, napi);
 	struct stmmac_priv *priv = ch->priv_data;
-	int work_done = 0, work_rem = budget;
+	int work_done, rx_done = 0, tx_done = 0;
 	u32 chan = ch->index;
 
 	priv->xstats.napi_poll++;
 
-	if (ch->has_tx) {
-		int done = stmmac_tx_clean(priv, work_rem, chan);
+	if (ch->has_tx)
+		tx_done = stmmac_tx_clean(priv, budget, chan);
+	if (ch->has_rx)
+		rx_done = stmmac_rx(priv, budget, chan);
 
-		work_done += done;
-		work_rem -= done;
-	}
-
-	if (ch->has_rx) {
-		int done = stmmac_rx(priv, work_rem, chan);
+	work_done = max(rx_done, tx_done);
+	work_done = min(work_done, budget);
 
-		work_done += done;
-		work_rem -= done;
-	}
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		int stat;
 
-	if (work_done < budget && napi_complete_done(napi, work_done))
 		stmmac_enable_dma_irq(priv, priv->ioaddr, chan);
+		stat = stmmac_dma_interrupt_status(priv, priv->ioaddr,
+						   &priv->xstats, chan);
+		if (stat && napi_reschedule(napi))
+			stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
+	}
 
 	return work_done;
 }
-- 
2.19.1

