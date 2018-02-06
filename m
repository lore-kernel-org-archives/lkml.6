Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbeBFMDS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:03:18 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:57520 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbeBFMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:02:54 -0500
X-Auth-Info: TIFRHxDn2Ezn0vCJgBxvvazZ2B+My+mpflQ1d5S5DMI=
From: Heiko Schocher <hs@denx.de>
To: linux-can@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, Markus Marb <markus@marb.org>,
        netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH 1/2] net, can, ifi: fix "write buffer full" error
Date: Tue,  6 Feb 2018 13:02:34 +0100
Message-Id: <20180206120235.15167-1-hs@denx.de>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the driver reads in the ISR first the IRQpending register,
and clears after that in a write *all* bits in it.

It could happen that the isr register raise bits between
this 2 register accesses, which leads in lost bits ...

In case it clears "TX message sent successfully", the driver
never sends any Tx data, and buffers to userspace run over.

Fixed this:
clear only the bits in the IRQpending register, the
driver had read.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 2772d05ff11c..05feb8177936 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -607,7 +607,7 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	/* Clear all pending interrupts but ErrWarn */
-	writel(clr_irq_mask, priv->base + IFI_CANFD_INTERRUPT);
+	writel(isr & clr_irq_mask, priv->base + IFI_CANFD_INTERRUPT);
 
 	/* RX IRQ or bus warning, start NAPI */
 	if (isr & rx_irq_mask) {
-- 
2.14.3
