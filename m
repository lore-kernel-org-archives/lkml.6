Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC28C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FC8217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130298;
	bh=mgBnLn3jrMSWAVtvsK65wsfv+6fcevTCegZhiwrluLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=awQXikTE/Y911tLCSysfrfwyem1f6RSU+BGx4XAA8b5q/10LPG854n9pd+KrlBSgo
	 RvSAcd9TMy/og5vvFqd0wAGXrW4iJlQd06ylqjwViF6Dz3uSXS4Hbswp5Dpt1Dq0Qt
	 Z6FVdc4MHTDdfyMxU1a7i2Fwtq/OBHopNzSVrp/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbfBYVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbfBYVbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FFA21841;
        Mon, 25 Feb 2019 21:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130290;
        bh=mgBnLn3jrMSWAVtvsK65wsfv+6fcevTCegZhiwrluLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=weVb81Kewu7nTV94kqc/n9m0EbDTDB2Si0/TZliuUha/hAzDu/SzI3YAgG/vilpRa
         bhJEzXz+emeXb+a2Mb45IBGgMToLbijvryIcPBp+wNFQuN4MWrqqGlxvs8qhfJcwYD
         zxCrH2wHe4pXpSigeEvfCRmb0gTeGdfwvPiR8ckc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 075/183] net: stmmac: Prevent RX starvation in stmmac_napi_poll()
Date:   Mon, 25 Feb 2019 22:10:48 +0100
Message-Id: <20190225195107.102335094@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index fe9240e15aeac..5d83d6a7694b0 100644
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



