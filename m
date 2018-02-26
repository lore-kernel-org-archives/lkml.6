Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeBZVrh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:47:37 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:54826 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeBZVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:47:36 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, pavel@ucw.cz,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: stmmac: ensure that the device has released ownership before reading data
Date: Mon, 26 Feb 2018 22:47:08 +0100
Message-Id: <20180226214709.4359-4-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180226214709.4359-1-niklas.cassel@axis.com>
References: <20180226214709.4359-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/memory-barriers.txt, we need to use a
dma_rmb() after reading the status/own bit, to ensure that all
descriptor fields are read after reading the own bit.

This way, we ensure that the DMA engine is done with the DMA
descriptor before we read the other descriptor fields, e.g. reading
the tx hardware timestamp (if PTP is enabled).

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6dd04f237b2a..a9856a8bf8ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1844,6 +1844,11 @@ static void stmmac_tx_clean(struct stmmac_priv *priv, u32 queue)
 		if (unlikely(status & tx_dma_own))
 			break;
 
+		/* Make sure descriptor fields are read after reading
+		 * the own bit.
+		 */
+		dma_rmb();
+
 		/* Just consider the last segment and ...*/
 		if (likely(!(status & tx_not_ls))) {
 			/* ... verify the status error condition */
-- 
2.14.2
