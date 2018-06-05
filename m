Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeFERDf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeFERDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 4.4 22/37] i2c: rcar: check master irqs before slave irqs
Date: Tue,  5 Jun 2018 19:01:27 +0200
Message-Id: <20180605170110.185722636@linuxfoundation.org>
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

commit c3be0af15959e11fa535d5332ab3d7cf34abd09b upstream.

Due to the HW design, master IRQs are timing critical, so give them
precedence over slave IRQ.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -432,19 +432,17 @@ static bool rcar_i2c_slave_irq(struct rc
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
-	irqreturn_t result = IRQ_HANDLED;
 	u32 msr;
 
-	if (rcar_i2c_slave_irq(priv))
-		goto exit;
-
 	msr = rcar_i2c_read(priv, ICMSR);
 
 	/* Only handle interrupts that are currently enabled */
 	msr &= rcar_i2c_read(priv, ICMIER);
 	if (!msr) {
-		result = IRQ_NONE;
-		goto exit;
+		if (rcar_i2c_slave_irq(priv))
+			return IRQ_HANDLED;
+
+		return IRQ_NONE;
 	}
 
 	/* Arbitration lost */
@@ -481,8 +479,7 @@ out:
 		wake_up(&priv->wait);
 	}
 
-exit:
-	return result;
+	return IRQ_HANDLED;
 }
 
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
