Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeCWWZT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:25:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeCWWXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:23:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E19B607E5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] bnx2x: Replace doorbell barrier() with wmb()
Date: Fri, 23 Mar 2018 18:23:08 -0400
Message-Id: <1521843791-21201-4-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
References: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

barrier() doesn't guarantee memory writes to be observed by the hardware on
all architectures. barrier() only tells compiler not to move this code
with respect to other read/writes.

If memory write needs to be observed by the HW, wmb() is the right choice.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c     | 3 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index d7c98e8..b97820f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4153,7 +4153,8 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	wmb();
 
 	txdata->tx_db.data.prod += nbd;
-	barrier();
+	/* make sur edescriptor update is observed by HW */
+	wmb();
 
 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 1e33abd..39af4f8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2591,7 +2591,8 @@ static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
 	wmb();
 
 	txdata->tx_db.data.prod += 2;
-	barrier();
+	/* make sure descriptor update is observed by the HW */
+	wmb();
 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
 
 	mmiowb();
-- 
2.7.4
