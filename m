Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeFER1F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752501AbeFERDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 4.4 20/37] i2c: rcar: init new messages in irq
Date: Tue,  5 Jun 2018 19:01:25 +0200
Message-Id: <20180605170110.077770572@linuxfoundation.org>
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

commit cc21d0b4b62e41e5013d763adade5ea4462c33a4 upstream.

Setting up new messages was done in process context while handling a
message was in interrupt context. Because of the HW design, this IP core
is sensitive to timing, so the context switches were too expensive. Move
this setup to interrupt context as well.

In my test setup, this fixed the occasional 'data byte sent twice' issue
which a number of people have seen. It also fixes to send REP_START
after a read message which was wrongly send as a STOP + START sequence
before.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |   90 ++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -267,10 +267,17 @@ static void rcar_i2c_prepare_msg(struct
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
 }
 
+static void rcar_i2c_next_msg(struct rcar_i2c_priv *priv)
+{
+	priv->msg++;
+	priv->msgs_left--;
+	rcar_i2c_prepare_msg(priv);
+}
+
 /*
  *		interrupt functions
  */
-static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
+static void rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 {
 	struct i2c_msg *msg = priv->msg;
 
@@ -280,7 +287,7 @@ static int rcar_i2c_irq_send(struct rcar
 	 * Do nothing
 	 */
 	if (!(msr & MDE))
-		return 0;
+		return;
 
 	/*
 	 * If address transfer phase finished,
@@ -309,29 +316,23 @@ static int rcar_i2c_irq_send(struct rcar
 		 * [ICRXTX] -> [SHIFT] -> [I2C bus]
 		 */
 
-		if (priv->flags & ID_LAST_MSG)
+		if (priv->flags & ID_LAST_MSG) {
 			/*
 			 * If current msg is the _LAST_ msg,
 			 * prepare stop condition here.
 			 * ID_DONE will be set on STOP irq.
 			 */
 			rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-		else
-			/*
-			 * If current msg is _NOT_ last msg,
-			 * it doesn't call stop phase.
-			 * thus, there is no STOP irq.
-			 * return ID_DONE here.
-			 */
-			return ID_DONE;
+		} else {
+			rcar_i2c_next_msg(priv);
+			return;
+		}
 	}
 
 	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_SEND);
-
-	return 0;
 }
 
-static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
+static void rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 {
 	struct i2c_msg *msg = priv->msg;
 
@@ -341,7 +342,7 @@ static int rcar_i2c_irq_recv(struct rcar
 	 * Do nothing
 	 */
 	if (!(msr & MDR))
-		return 0;
+		return;
 
 	if (msr & MAT) {
 		/*
@@ -367,9 +368,10 @@ static int rcar_i2c_irq_recv(struct rcar
 	else
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
-	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
-
-	return 0;
+	if (priv->pos == msg->len && !(priv->flags & ID_LAST_MSG))
+		rcar_i2c_next_msg(priv);
+	else
+		rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
 }
 
 static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
@@ -462,14 +464,15 @@ static irqreturn_t rcar_i2c_irq(int irq,
 
 	/* Stop */
 	if (msr & MST) {
+		priv->msgs_left--; /* The last message also made it */
 		rcar_i2c_flags_set(priv, ID_DONE);
 		goto out;
 	}
 
 	if (rcar_i2c_is_recv(priv))
-		rcar_i2c_flags_set(priv, rcar_i2c_irq_recv(priv, msr));
+		rcar_i2c_irq_recv(priv, msr);
 	else
-		rcar_i2c_flags_set(priv, rcar_i2c_irq_send(priv, msr));
+		rcar_i2c_irq_send(priv, msr);
 
 out:
 	if (rcar_i2c_flags_has(priv, ID_DONE)) {
@@ -501,35 +504,28 @@ static int rcar_i2c_master_xfer(struct i
 		/* This HW can't send STOP after address phase */
 		if (msgs[i].len == 0) {
 			ret = -EOPNOTSUPP;
-			break;
-		}
-
-		/* init each data */
-		priv->msg = &msgs[i];
-		priv->msgs_left = num - i;
-
-		rcar_i2c_prepare_msg(priv);
-
-		time_left = wait_event_timeout(priv->wait,
-					     rcar_i2c_flags_has(priv, ID_DONE),
-					     adap->timeout);
-		if (!time_left) {
-			rcar_i2c_init(priv);
-			ret = -ETIMEDOUT;
-			break;
-		}
-
-		if (rcar_i2c_flags_has(priv, ID_NACK)) {
-			ret = -ENXIO;
-			break;
-		}
-
-		if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
-			ret = -EAGAIN;
-			break;
+			goto out;
 		}
+	}
 
-		ret = i + 1; /* The number of transfer */
+	/* init data */
+	priv->msg = msgs;
+	priv->msgs_left = num;
+
+	rcar_i2c_prepare_msg(priv);
+
+	time_left = wait_event_timeout(priv->wait,
+				     rcar_i2c_flags_has(priv, ID_DONE),
+				     num * adap->timeout);
+	if (!time_left) {
+		rcar_i2c_init(priv);
+		ret = -ETIMEDOUT;
+	} else if (rcar_i2c_flags_has(priv, ID_NACK)) {
+		ret = -ENXIO;
+	} else if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
+		ret = -EAGAIN;
+	} else {
+		ret = num - priv->msgs_left; /* The number of transfer */
 	}
 out:
 	pm_runtime_put(dev);
