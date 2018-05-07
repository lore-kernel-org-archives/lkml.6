Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeEGOI2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:08:28 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46916 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeEGOIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:08:23 -0400
X-Google-Smtp-Source: AB8JxZrg+93ndJTI6w3hw/apCVYENb8fNN0H1/JSkLorLhuem9lHGEoZ/hRVnJP9ScZUIqHtu3BnnQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, fthain@telegraphics.com.au, joe@perches.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: 8390: Fix possible data races in __ei_get_stats
Date: Mon,  7 May 2018 22:08:09 +0800
Message-Id: <20180507140809.28847-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write operations to "dev->stats" are protected by 
the spinlock on line 862-864, but the read operations to
this data on line 858 and 867 are not protected by the spinlock.
Thus, there may exist data races for "dev->stats".

To fix the data races, the read operations to "dev->stats" are 
protected by the spinlock, and a local variable is used for return.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/8390/lib8390.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/8390/lib8390.c b/drivers/net/ethernet/8390/lib8390.c
index c9c55c9eab9f..198952247d30 100644
--- a/drivers/net/ethernet/8390/lib8390.c
+++ b/drivers/net/ethernet/8390/lib8390.c
@@ -852,19 +852,25 @@ static struct net_device_stats *__ei_get_stats(struct net_device *dev)
 	unsigned long ioaddr = dev->base_addr;
 	struct ei_device *ei_local = netdev_priv(dev);
 	unsigned long flags;
+	struct net_device_stats *stats;
+
+	spin_lock_irqsave(&ei_local->page_lock, flags);
 
 	/* If the card is stopped, just return the present stats. */
-	if (!netif_running(dev))
-		return &dev->stats;
+	if (!netif_running(dev)) {
+		stats = &dev->stats;
+		spin_unlock_irqrestore(&ei_local->page_lock, flags);
+		return stats;
+	}
 
-	spin_lock_irqsave(&ei_local->page_lock, flags);
 	/* Read the counter registers, assuming we are in page 0. */
 	dev->stats.rx_frame_errors  += ei_inb_p(ioaddr + EN0_COUNTER0);
 	dev->stats.rx_crc_errors    += ei_inb_p(ioaddr + EN0_COUNTER1);
 	dev->stats.rx_missed_errors += ei_inb_p(ioaddr + EN0_COUNTER2);
+	stats = &dev->stats;
 	spin_unlock_irqrestore(&ei_local->page_lock, flags);
 
-	return &dev->stats;
+	return stats;
 }
 
 /*
-- 
2.17.0
