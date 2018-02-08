Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHTVG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:21:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27533 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBHTVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:21:05 -0500
From: Dean Nelson <dnelson@redhat.com>
To: Robert Richter <rric@kernel.org>, Sunil Goutham <sgoutham@cavium.com>,
        David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-Id: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
Subject: net: thunder: change q_len's type to handle max ring size
Date: Thu, 8 Feb 2018 14:21:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cavium thunder nicvf driver supports rx/tx rings of up to 65536 entries per.
The number of entires are stored in the q_len member of struct q_desc_mem. The
problem is that q_len being a u16, results in 65536 becoming 0.

In getting pointers to descriptors in the rings, the driver uses q_len minus 1
as a mask after incrementing the pointer, in order to go back to the beginning
and not go past the end of the ring.

With the q_len set to 0 the mask is no longer correct and the driver does go
beyond the end of the ring, causing various ills. Usually the first thing that
shows up is a "NETDEV WATCHDOG: enP2p1s0f1 (nicvf): transmit queue 7 timed out"
warning.

This patch remedies the problem by changing q_len to a u32.

Signed-off-by: Dean Nelson <dnelson@redhat.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
index 7d1e4e2aaad0..ce1eed7a6d63 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
@@ -213,7 +213,7 @@ struct rx_tx_queue_stats {
 struct q_desc_mem {
 	dma_addr_t	dma;
 	u64		size;
-	u16		q_len;
+	u32		q_len;
 	dma_addr_t	phys_base;
 	void		*base;
 	void		*unalign_base;
