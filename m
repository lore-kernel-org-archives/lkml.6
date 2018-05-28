Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422934AbeE1LDm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164883AbeE1LDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:03:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 458/496] net: stmmac: ensure that the device has released ownership before reading data
Date: Mon, 28 May 2018 12:04:03 +0200
Message-Id: <20180528100339.215354471@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>

[ Upstream commit a6b25da5e7ba212af5826a662e6a035a79bffabd ]

According to Documentation/memory-barriers.txt, we need to use a
dma_rmb() after reading the status/own bit, to ensure that all
descriptor fields are read after reading the own bit.

This way, we ensure that the DMA engine is done with the DMA
descriptor before we read the other descriptor fields, e.g. reading
the tx hardware timestamp (if PTP is enabled).

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1829,6 +1829,11 @@ static void stmmac_tx_clean(struct stmma
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
