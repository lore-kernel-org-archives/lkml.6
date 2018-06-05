Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeFER0g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeFERDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 4.4 23/37] i2c: rcar: revoke START request early
Date: Tue,  5 Jun 2018 19:01:28 +0200
Message-Id: <20180605170110.258340836@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 52df445f29b79006d8b2dcd129152987c0d3bd64 upstream.

If we don't clear START generation as soon as possible, it may cause
another message to be generated, e.g. when receiving NACK in address
phase. To keep the race window as small as possible, we clear it right
at the beginning of the interrupt. We don't need any checks since we
always want to stop START and STOP generation on the next occasion after
we started it.

This patch improves the situation but sadly does not completely fix it.
It is still to be researched if we can do better given this HW design.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -83,6 +83,7 @@
 
 #define RCAR_BUS_PHASE_START	(MDBS | MIE | ESG)
 #define RCAR_BUS_PHASE_DATA	(MDBS | MIE)
+#define RCAR_BUS_MASK_DATA	(~(ESG | FSB) & 0xFF)
 #define RCAR_BUS_PHASE_STOP	(MDBS | MIE | FSB)
 
 #define RCAR_IRQ_SEND	(MNR | MAL | MST | MAT | MDE)
@@ -289,13 +290,6 @@ static void rcar_i2c_irq_send(struct rca
 	if (!(msr & MDE))
 		return;
 
-	/*
-	 * If address transfer phase finished,
-	 * goto data phase.
-	 */
-	if (msr & MAT)
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
-
 	if (priv->pos < msg->len) {
 		/*
 		 * Prepare next data to ICRXTX register.
@@ -345,11 +339,7 @@ static void rcar_i2c_irq_recv(struct rca
 		return;
 
 	if (msr & MAT) {
-		/*
-		 * Address transfer phase finished,
-		 * but, there is no data at this point.
-		 * Do nothing.
-		 */
+		/* Address transfer phase finished, but no data at this point. */
 	} else if (priv->pos < msg->len) {
 		/*
 		 * get received data
@@ -365,8 +355,6 @@ static void rcar_i2c_irq_recv(struct rca
 	 */
 	if (priv->pos + 1 >= msg->len)
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-	else
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
 	if (priv->pos == msg->len && !(priv->flags & ID_LAST_MSG))
 		rcar_i2c_next_msg(priv);
@@ -432,7 +420,11 @@ static bool rcar_i2c_slave_irq(struct rc
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
-	u32 msr;
+	u32 msr, val;
+
+	/* Clear START or STOP as soon as we can */
+	val = rcar_i2c_read(priv, ICMCR);
+	rcar_i2c_write(priv, ICMCR, val & RCAR_BUS_MASK_DATA);
 
 	msr = rcar_i2c_read(priv, ICMSR);
 
@@ -454,7 +446,6 @@ static irqreturn_t rcar_i2c_irq(int irq,
 	/* Nack */
 	if (msr & MNR) {
 		/* HW automatically sends STOP after received NACK */
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
