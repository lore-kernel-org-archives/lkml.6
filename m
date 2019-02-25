Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0F52083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131413;
	bh=h4BWWu+CulK9A7x1hhncLze98ZpmSXQchpaoMbxVHzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TVt8GsDFuzcCAafPPQahYsXgqxW0ahOj7K0sQplDaVYx70mT7HEIbXAjA88w2hzXm
	 6Z9ou0Si0odYVlPPW3tgjO6GqpMl3LOKKzeyyokAtMnZuzoAEaxtwHfgYQBaR1HL+v
	 ORyi/u9q1uGWD5jLQ7jjin7+6Fq1IY4I6sD2gH7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfBYVuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbfBYVYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3E820C01;
        Mon, 25 Feb 2019 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129894;
        bh=h4BWWu+CulK9A7x1hhncLze98ZpmSXQchpaoMbxVHzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6HWRT8ZRqbsgga30pee7MuxxbzMAv8uPo+8cyRjpdYBEgE9pI0S8xo4fQodaD/Fb
         Iz6X3yXxVFQNpU/M6LS1qWIlPkev4VREHzN/hoZsbK4C1yOTxNfVDjHoupg0NY2wdh
         G6md5OgiuESAUdHkIgGdOKJNh4PoCCKXcGiZRzZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 064/152] net: stmmac: Prevent RX starvation in stmmac_napi_poll()
Date:   Mon, 25 Feb 2019 22:10:56 +0100
Message-Id: <20190225195047.810547535@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 24ae244c2ee33..123b74e25ed81 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3522,27 +3522,28 @@ static int stmmac_napi_poll(struct napi_struct *napi, int budget)
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



