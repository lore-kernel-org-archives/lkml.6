Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeBZOPV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:15:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50782 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753356AbeBZOPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:15:14 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Yan Markman <ymarkman@marvell.com>, mw@semihalf.com,
        stefanc@marvell.com, thomas.petazzoni@free-electrons.com,
        gregory.clement@free-electrons.com, miquel.raynal@free-electrons.com,
        nadavh@marvell.com, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next 1/3] net: mvpp2: avoid checking for free aggregated descriptors twice
Date: Mon, 26 Feb 2018 15:14:25 +0100
Message-Id: <20180226141427.31536-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Markman <ymarkman@marvell.com>

Avoid repeating the check for free aggregated descriptors when it
already failed at the beginning of the function.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Antoine: commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 5a1668cdb461..55300b1fe6c0 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -5224,11 +5224,10 @@ static int mvpp2_aggr_desc_num_check(struct mvpp2 *priv,
 		u32 val = mvpp2_read(priv, MVPP2_AGGR_TXQ_STATUS_REG(cpu));
 
 		aggr_txq->count = val & MVPP2_AGGR_TXQ_PENDING_MASK;
-	}
-
-	if ((aggr_txq->count + num) > MVPP2_AGGR_TXQ_SIZE)
-		return -ENOMEM;
 
+		if ((aggr_txq->count + num) > MVPP2_AGGR_TXQ_SIZE)
+			return -ENOMEM;
+	}
 	return 0;
 }
 
-- 
2.14.3
