Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeBZVr0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:47:26 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:54801 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBZVrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:47:23 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, pavel@ucw.cz,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] net: stmmac: ensure that the MSS desc is the last desc to set the own bit
Date: Mon, 26 Feb 2018 22:47:06 +0100
Message-Id: <20180226214709.4359-2-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180226214709.4359-1-niklas.cassel@axis.com>
References: <20180226214709.4359-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dma_wmb() is used to guarantee the ordering, with respect to
other writes, to cache coherent DMA memory.

There is a dma_wmb() in prepare_tx_desc()/prepare_tso_tx_desc() which
ensures that TDES0/1/2 is written before TDES3 (which contains the own
bit), for First Desc.

However, in the rare case that MSS changes, there will be a MSS
context descriptor in front of the regular DMA descriptors:

<MSS desc> <- DMA Next Descriptor
<First Desc>
<desc n>
<Last Desc>

Thus, for this special case, we need a dma_wmb()
after prepare_tso_tx_desc()/before writing the own bit to the MSS desc,
so that we flush the write to TDES3 for First Desc,
in order to ensure that the MSS descriptor is the last descriptor to
set the own bit.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c8d86d77e03d..3b5e7b06e796 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2983,8 +2983,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			tcp_hdrlen(skb) / 4, (skb->len - proto_hdr_len));
 
 	/* If context desc is used to change MSS */
-	if (mss_desc)
+	if (mss_desc) {
+		/* Make sure that first descriptor has been completely
+		 * written, including its own bit. This is because MSS is
+		 * actually before first descriptor, so we need to make
+		 * sure that MSS's own bit is the last thing written.
+		 */
+		dma_wmb();
 		priv->hw->desc->set_tx_owner(mss_desc);
+	}
 
 	/* The own bit must be the latest setting done when prepare the
 	 * descriptor and then barrier is needed to make sure that
-- 
2.14.2
