Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BEBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6ED214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864531;
	bh=9wJcwZOgGWHIzjkkOYJ6ggxYG5xTFbP67WOtfd9/fUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nea52LcSWkHLJ6afmGhrKtMch34elpS4U0masKLTOBFI49xWhjhHYZi1GK7NjNDg4
	 qTmf7c7/wFN/IPaa8MuIXZDq5IsU0SRL7hE+p9aqX4cSoPuw/5/5F5d1sXs/Lt4893
	 iInQeBlaHPMPRZKUW3WJ0HJtgOUdt1wDiYnu1i7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeLZWsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbeLZWiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002752054F;
        Wed, 26 Dec 2018 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863882;
        bh=9wJcwZOgGWHIzjkkOYJ6ggxYG5xTFbP67WOtfd9/fUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eh9sErOoKNZDsk3JefpjRw0r5gvlS1jTqMpTcYaLt0PWhvizFavnY9ZvrYL/3I9RK
         FA/3yoosUXpumxh2ST8yVN+zmi9/fG/0HNLA+SyiWXotH5/8Usr1umGqnr5tconPVK
         6pAgrKtRf+dJe6XQyUkvbZ0Dldacg8XKYAQ0MLBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 72/97] net: macb: restart tx after tx used bit read
Date:   Wed, 26 Dec 2018 17:35:32 -0500
Message-Id: <20181226223557.149329-72-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 4298388574dae6168fa8940b3edc7ba965e8a7ab ]

On some platforms (currently detected only on SAMA5D4) TX might stuck
even the pachets are still present in DMA memories and TX start was
issued for them. This happens due to race condition between MACB driver
updating next TX buffer descriptor to be used and IP reading the same
descriptor. In such a case, the "TX USED BIT READ" interrupt is asserted.
GEM/MACB user guide specifies that if a "TX USED BIT READ" interrupt
is asserted TX must be restarted. Restart TX if used bit is read and
packets are present in software TX queue. Packets are removed from software
TX queue if TX was successful for them (see macb_tx_interrupt()).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 58b9744c4058..240fd36b5074 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -61,7 +61,8 @@
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
 					| MACB_BIT(ISR_RLE)		\
 					| MACB_BIT(TXERR))
-#define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP))
+#define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP)	\
+					| MACB_BIT(TXUBR))
 
 /* Max length of transmit frame must be a multiple of 8 bytes */
 #define MACB_TX_LEN_ALIGN	8
@@ -1313,6 +1314,21 @@ static void macb_hresp_error_task(unsigned long data)
 	netif_tx_start_all_queues(dev);
 }
 
+static void macb_tx_restart(struct macb_queue *queue)
+{
+	unsigned int head = queue->tx_head;
+	unsigned int tail = queue->tx_tail;
+	struct macb *bp = queue->bp;
+
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+		queue_writel(queue, ISR, MACB_BIT(TXUBR));
+
+	if (head == tail)
+		return;
+
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+}
+
 static irqreturn_t macb_interrupt(int irq, void *dev_id)
 {
 	struct macb_queue *queue = dev_id;
@@ -1370,6 +1386,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		if (status & MACB_BIT(TCOMP))
 			macb_tx_interrupt(queue);
 
+		if (status & MACB_BIT(TXUBR))
+			macb_tx_restart(queue);
+
 		/* Link change detection isn't possible with RMII, so we'll
 		 * add that if/when we get our hands on a full-blown MII PHY.
 		 */
-- 
2.19.1

