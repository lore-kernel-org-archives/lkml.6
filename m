Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeA3ReN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:34:13 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59424 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeA3Rcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:32:51 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w0UHWm4h001883, This message is accepted by code: ctloc85258
From: Chunhao Lin <hau@realtek.com>
To: <netdev@vger.kernel.org>
CC: <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        Chunhao Lin <hau@realtek.com>
Subject: [PATCH net] r8169: fix RTL8168EP take too long to complete driver initialization.
Date: Wed, 31 Jan 2018 01:32:36 +0800
Message-ID: <1517333556-4378-1-git-send-email-hau@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.177.216]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver check the wrong register bit in rtl_ocp_tx_cond() that keep driver
waiting until timeout.

Fix this by waiting for the right register bit.

Signed-off-by: Chunhao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 734286e..dd713df 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -1395,7 +1395,7 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
 {
 	void __iomem *ioaddr = tp->mmio_addr;
 
-	return RTL_R8(IBISR0) & 0x02;
+	return RTL_R8(IBISR0) & 0x20;
 }
 
 static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
@@ -1403,7 +1403,7 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
 	void __iomem *ioaddr = tp->mmio_addr;
 
 	RTL_W8(IBCR2, RTL_R8(IBCR2) & ~0x01);
-	rtl_msleep_loop_wait_low(tp, &rtl_ocp_tx_cond, 50, 2000);
+	rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
 	RTL_W8(IBISR0, RTL_R8(IBISR0) | 0x20);
 	RTL_W8(IBCR0, RTL_R8(IBCR0) & ~0x01);
 }
-- 
2.7.4
