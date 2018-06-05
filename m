Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeFERDT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752271AbeFERDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 4.4 18/37] i2c: rcar: remove spinlock
Date: Tue,  5 Jun 2018 19:01:23 +0200
Message-Id: <20180605170109.978602376@linuxfoundation.org>
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

commit ff2316b87a336bff940939cd9fc56287ed48e578 upstream.

After making sure to reinit the HW and clear interrupts in the timeout
case, we know that interrupts are always disabled in the sections
protected by the spinlock. Thus, we can simply remove it which is a
preparation for further refactoring. While here, rename the timeout
variable to time_left which is way more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -33,7 +33,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 
 /* register offsets */
 #define ICSCR	0x00	/* slave ctrl */
@@ -110,7 +109,6 @@ struct rcar_i2c_priv {
 	struct i2c_msg	*msg;
 	struct clk *clk;
 
-	spinlock_t lock;
 	wait_queue_head_t wait;
 
 	int pos;
@@ -429,9 +427,6 @@ static irqreturn_t rcar_i2c_irq(int irq,
 	irqreturn_t result = IRQ_HANDLED;
 	u32 msr;
 
-	/*-------------- spin lock -----------------*/
-	spin_lock(&priv->lock);
-
 	if (rcar_i2c_slave_irq(priv))
 		goto exit;
 
@@ -478,9 +473,6 @@ out:
 	}
 
 exit:
-	spin_unlock(&priv->lock);
-	/*-------------- spin unlock -----------------*/
-
 	return result;
 }
 
@@ -490,9 +482,8 @@ static int rcar_i2c_master_xfer(struct i
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
-	unsigned long flags;
 	int i, ret;
-	long timeout;
+	long time_left;
 
 	pm_runtime_get_sync(dev);
 
@@ -507,9 +498,6 @@ static int rcar_i2c_master_xfer(struct i
 			break;
 		}
 
-		/*-------------- spin lock -----------------*/
-		spin_lock_irqsave(&priv->lock, flags);
-
 		/* init each data */
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
@@ -519,13 +507,11 @@ static int rcar_i2c_master_xfer(struct i
 
 		rcar_i2c_prepare_msg(priv);
 
-		spin_unlock_irqrestore(&priv->lock, flags);
-		/*-------------- spin unlock -----------------*/
-
-		timeout = wait_event_timeout(priv->wait,
+		time_left = wait_event_timeout(priv->wait,
 					     rcar_i2c_flags_has(priv, ID_DONE),
 					     adap->timeout);
-		if (!timeout) {
+		if (!time_left) {
+			rcar_i2c_init(priv);
 			ret = -ETIMEDOUT;
 			break;
 		}
@@ -656,7 +642,6 @@ static int rcar_i2c_probe(struct platfor
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
-	spin_lock_init(&priv->lock);
 
 	adap = &priv->adap;
 	adap->nr = pdev->id;
