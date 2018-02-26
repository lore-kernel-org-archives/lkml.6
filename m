Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBZVrw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:47:52 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:54832 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeBZVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:47:37 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, pavel@ucw.cz,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: stmmac: make dwmac4_release_tx_desc() clear all descriptor fields
Date: Mon, 26 Feb 2018 22:47:09 +0100
Message-Id: <20180226214709.4359-5-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180226214709.4359-1-niklas.cassel@axis.com>
References: <20180226214709.4359-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make dwmac4_release_tx_desc() clear all descriptor fields, not just
TDES2 and TDES3.

I'm suspecting that TDES0 and TDES1 wasn't cleared because the DMA
engine uses them to store the tx hardware timestamp (if PTP is enabled).

However, stmmac_tx_clean() calls stmmac_get_tx_hwtstamp(), which reads
and saves the timestamp, before it calls release_tx_desc(), so this
is not an issue.

stmmac_xmit() and stmmac_tso_xmit() both always overwrite TDES0,
however, stmmac_tso_xmit() sometimes sets TDES1, and since neither
stmmac_xmit() nor stmmac_tso_xmit() explicitly clears TDES1, both
functions might reuse a DMA descriptor with old TDES1 data.

I haven't observed any misbehavior even though TDES1 sometimes
point to an old skb, however, explicitly clearing both TDES0 and TDES1
in dwmac4_release_tx_desc() minimizes the chances of undefined behavior.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index c728ffa095de..2a6521d33e43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -389,6 +389,8 @@ static void dwmac4_rd_prepare_tso_tx_desc(struct dma_desc *p, int is_fs,
 
 static void dwmac4_release_tx_desc(struct dma_desc *p, int mode)
 {
+	p->des0 = 0;
+	p->des1 = 0;
 	p->des2 = 0;
 	p->des3 = 0;
 }
-- 
2.14.2
