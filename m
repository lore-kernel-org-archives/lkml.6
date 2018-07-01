Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB723C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8124C21
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC8124C21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeGAPld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 11:41:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeGAPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 11:41:31 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fZeTX-00071b-TI; Sun, 01 Jul 2018 17:41:20 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH REPOST] mfd: dln2: use irqsave() in USB's complete callback
Date:   Sun,  1 Jul 2018 17:41:08 +0200
Message-Id: <20180701154108.13233-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/dln2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 704e189ca162..1ef3c92f32e0 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -194,6 +194,7 @@ static bool dln2_transfer_complete(struct dln2_dev *dln=
2, struct urb *urb,
 	struct device *dev =3D &dln2->interface->dev;
 	struct dln2_mod_rx_slots *rxs =3D &dln2->mod_rx_slots[handle];
 	struct dln2_rx_context *rxc;
+	unsigned long flags;
 	bool valid_slot =3D false;
=20
 	if (rx_slot >=3D DLN2_MAX_RX_SLOTS)
@@ -206,13 +207,13 @@ static bool dln2_transfer_complete(struct dln2_dev *d=
ln2, struct urb *urb,
 	 * context elsewhere in this driver. This function (or its callers) are
 	 * also not exported to other modules.
 	 */
-	spin_lock(&rxs->lock);
+	spin_lock_irqsave(&rxs->lock, flags);
 	if (rxc->in_use && !rxc->urb) {
 		rxc->urb =3D urb;
 		complete(&rxc->done);
 		valid_slot =3D true;
 	}
-	spin_unlock(&rxs->lock);
+	spin_unlock_irqrestore(&rxs->lock, flags);
=20
 out:
 	if (!valid_slot)
--=20
2.18.0

