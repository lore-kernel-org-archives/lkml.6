Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424406AbeE1LOX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424393AbeE1LOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:14:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 226/272] net: stmmac: ensure that the MSS desc is the last desc to set the own bit
Date: Mon, 28 May 2018 12:04:19 +0200
Message-Id: <20180528100259.430446112@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>

[ Upstream commit 15d2ee42a3087089e73ad52fd8c1b37ab496b87c ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2985,8 +2985,15 @@ static netdev_tx_t stmmac_tso_xmit(struc
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
