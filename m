Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B7120818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B7120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeKLGPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:15:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50916 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730641AbeKLFs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:28 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsn-0000oN-MN; Sun, 11 Nov 2018 19:58:57 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001lY-SP; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Anssi Hannula" <anssi.hannula@bitwise.fi>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.361740465@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 282/366] can: xilinx_can: fix RX loop if RXNEMP is
 asserted without RXOK
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anssi Hannula <anssi.hannula@bitwise.fi>

commit 32852c561bffd613d4ed7ec464b1e03e1b7b6c5c upstream.

If the device gets into a state where RXNEMP (RX FIFO not empty)
interrupt is asserted without RXOK (new frame received successfully)
interrupt being asserted, xcan_rx_poll() will continue to try to clear
RXNEMP without actually reading frames from RX FIFO. If the RX FIFO is
not empty, the interrupt will not be cleared and napi_schedule() will
just be called again.

This situation can occur when:

(a) xcan_rx() returns without reading RX FIFO due to an error condition.
The code tries to clear both RXOK and RXNEMP but RXNEMP will not clear
due to a frame still being in the FIFO. The frame will never be read
from the FIFO as RXOK is no longer set.

(b) A frame is received between xcan_rx_poll() reading interrupt status
and clearing RXOK. RXOK will be cleared, but RXNEMP will again remain
set as the new message is still in the FIFO.

I'm able to trigger case (b) by flooding the bus with frames under load.

There does not seem to be any benefit in using both RXNEMP and RXOK in
the way the driver does, and the polling example in the reference manual
(UG585 v1.10 18.3.7 Read Messages from RxFIFO) also says that either
RXOK or RXNEMP can be used for detecting incoming messages.

Fix the issue and simplify the RX processing by only using RXNEMP
without RXOK.

Tested with the integrated CAN on Zynq-7000 SoC.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/xilinx_can.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -100,7 +100,7 @@ enum xcan_reg {
 #define XCAN_INTR_ALL		(XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |\
 				 XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK | \
 				 XCAN_IXR_RXNEMP_MASK | XCAN_IXR_ERROR_MASK | \
-				 XCAN_IXR_ARBLST_MASK | XCAN_IXR_RXOK_MASK)
+				 XCAN_IXR_ARBLST_MASK)
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BTR_SJW_SHIFT		7  /* Synchronous jump width */
@@ -709,15 +709,7 @@ static int xcan_rx_poll(struct napi_stru
 
 	isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 	while ((isr & XCAN_IXR_RXNEMP_MASK) && (work_done < quota)) {
-		if (isr & XCAN_IXR_RXOK_MASK) {
-			priv->write_reg(priv, XCAN_ICR_OFFSET,
-				XCAN_IXR_RXOK_MASK);
-			work_done += xcan_rx(ndev);
-		} else {
-			priv->write_reg(priv, XCAN_ICR_OFFSET,
-				XCAN_IXR_RXNEMP_MASK);
-			break;
-		}
+		work_done += xcan_rx(ndev);
 		priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_RXNEMP_MASK);
 		isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 	}
@@ -728,7 +720,7 @@ static int xcan_rx_poll(struct napi_stru
 	if (work_done < quota) {
 		napi_complete(napi);
 		ier = priv->read_reg(priv, XCAN_IER_OFFSET);
-		ier |= (XCAN_IXR_RXOK_MASK | XCAN_IXR_RXNEMP_MASK);
+		ier |= XCAN_IXR_RXNEMP_MASK;
 		priv->write_reg(priv, XCAN_IER_OFFSET, ier);
 	}
 	return work_done;
@@ -800,9 +792,9 @@ static irqreturn_t xcan_interrupt(int ir
 	}
 
 	/* Check for the type of receive interrupt and Processing it */
-	if (isr & (XCAN_IXR_RXNEMP_MASK | XCAN_IXR_RXOK_MASK)) {
+	if (isr & XCAN_IXR_RXNEMP_MASK) {
 		ier = priv->read_reg(priv, XCAN_IER_OFFSET);
-		ier &= ~(XCAN_IXR_RXNEMP_MASK | XCAN_IXR_RXOK_MASK);
+		ier &= ~XCAN_IXR_RXNEMP_MASK;
 		priv->write_reg(priv, XCAN_IER_OFFSET, ier);
 		napi_schedule(&priv->napi);
 	}

