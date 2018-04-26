Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbeDZJyH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:54:07 -0400
Received: from mail.sysgo.com ([176.9.12.79]:55510 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754959AbeDZJyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:54:00 -0400
From: David Engraf <david.engraf@sysgo.com>
To: ludovic.desroches@microchip.com
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Engraf <david.engraf@sysgo.com>
Subject: [PATCH v2] i2c: at91: Read all available bytes at once
Date: Thu, 26 Apr 2018 11:53:14 +0200
Message-Id: <20180426095314.12758-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
References: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With FIFO enabled it is possible to read multiple bytes
at once in the interrupt handler as long as RXRDY is
set. This may also reduce the number of interrupts.

This patch polls RXRDY and reads all available bytes at
once.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/i2c/busses/i2c-at91.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index bfd1fdff64a9..9caee5b79eac 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -518,8 +518,16 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 	 * the RXRDY interrupt first in order to not keep garbage data in the
 	 * Receive Holding Register for the next transfer.
 	 */
-	if (irqstatus & AT91_TWI_RXRDY)
-		at91_twi_read_next_byte(dev);
+	if (irqstatus & AT91_TWI_RXRDY) {
+		/*
+		 * Read all available bytes at once by polling RXRDY usable w/ and w/o
+		 * FIFO. With FIFO enabled we could also read RXFL and avoid polling
+		 * RXRDY.
+		 */
+		do {
+			at91_twi_read_next_byte(dev);
+		} while (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY);
+	}
 
 	/*
 	 * When a NACK condition is detected, the I2C controller sets the NACK,
-- 
2.14.1
