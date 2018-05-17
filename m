Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeEQIfK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:35:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752106AbeEQIfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:35:02 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Yan Markman <ymarkman@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next 1/3] net: mvpp2: avoid checking for free aggregated descriptors twice
Date: Thu, 17 May 2018 10:34:25 +0200
Message-Id: <20180517083427.15793-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517083427.15793-1-antoine.tenart@bootlin.com>
References: <20180517083427.15793-1-antoine.tenart@bootlin.com>
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
index df59f0e0d33c..73b2f2d331c5 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -5488,11 +5488,10 @@ static int mvpp2_aggr_desc_num_check(struct mvpp2 *priv,
 					     MVPP2_AGGR_TXQ_STATUS_REG(cpu));
 
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
2.17.0
