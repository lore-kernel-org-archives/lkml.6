Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB134C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B924FBF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5B924FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeGBHbk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:31:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeGBHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:31:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fZtJ7-00043x-HF; Mon, 02 Jul 2018 09:31:33 +0200
Date:   Mon, 2 Jul 2018 09:31:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Octavian Purdila <tavi@cs.pub.ro>,
        lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2] mfd: dln2: use irqsave() in USB's complete callback
Message-ID: <20180702073132.vrbvrdrht3ipwhq7@linutronix.de>
References: <20180701154108.13233-1-bigeasy@linutronix.de>
 <CAMoF9u0ZxNqKLV6FEjpHkGGuh8_V7zFQ_VpK-Y-fmbkSwL31Rg@mail.gmail.com>
 <20180702062442.GD9802@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180702062442.GD9802@localhost>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB completion callback does not disable interrupts while acquiring
the lock. We want to remove the local_irq_disable() invocation from
__usb_hcd_giveback_urb() and therefore it is required for the callback
handler to disable the interrupts while acquiring the lock.
The callback may be invoked either in IRQ or BH context depending on the
USB host controller.
Use the _irqsave() variant of the locking primitives.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Octavian Purdila <tavi@cs.pub.ro>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: Remove also the comment that says that there is no need to
       disable interrupts.

 drivers/mfd/dln2.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 704e189ca162..90e789943466 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -194,6 +194,7 @@ static bool dln2_transfer_complete(struct dln2_dev *dln2, struct urb *urb,
 	struct device *dev = &dln2->interface->dev;
 	struct dln2_mod_rx_slots *rxs = &dln2->mod_rx_slots[handle];
 	struct dln2_rx_context *rxc;
+	unsigned long flags;
 	bool valid_slot = false;
 
 	if (rx_slot >= DLN2_MAX_RX_SLOTS)
@@ -201,18 +202,13 @@ static bool dln2_transfer_complete(struct dln2_dev *dln2, struct urb *urb,
 
 	rxc = &rxs->slots[rx_slot];
 
-	/*
-	 * No need to disable interrupts as this lock is not taken in interrupt
-	 * context elsewhere in this driver. This function (or its callers) are
-	 * also not exported to other modules.
-	 */
-	spin_lock(&rxs->lock);
+	spin_lock_irqsave(&rxs->lock, flags);
 	if (rxc->in_use && !rxc->urb) {
 		rxc->urb = urb;
 		complete(&rxc->done);
 		valid_slot = true;
 	}
-	spin_unlock(&rxs->lock);
+	spin_unlock_irqrestore(&rxs->lock, flags);
 
 out:
 	if (!valid_slot)
-- 
2.18.0

