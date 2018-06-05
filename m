Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeFER2J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeFERDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 4.4 16/37] i2c: rcar: rework hw init
Date: Tue,  5 Jun 2018 19:01:21 +0200
Message-Id: <20180605170109.859976584@linuxfoundation.org>
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

commit 2c78cdc1c06308a59d6ed4145cdba73fdeff8c0d upstream.

We don't need to init HW before every transfer since we know the HW
state then. HW init at probe time is enough. While here, add setting the
clock register which belongs to init HW. Also, set MDBS bit since not
setting it is prohibited according to the manual.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -144,9 +144,10 @@ static void rcar_i2c_init(struct rcar_i2
 {
 	/* reset master mode */
 	rcar_i2c_write(priv, ICMIER, 0);
-	rcar_i2c_write(priv, ICMCR, 0);
+	rcar_i2c_write(priv, ICMCR, MDBS);
 	rcar_i2c_write(priv, ICMSR, 0);
-	rcar_i2c_write(priv, ICMAR, 0);
+	/* start clock */
+	rcar_i2c_write(priv, ICCCR, priv->icccr);
 }
 
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
@@ -496,16 +497,6 @@ static int rcar_i2c_master_xfer(struct i
 
 	pm_runtime_get_sync(dev);
 
-	/*-------------- spin lock -----------------*/
-	spin_lock_irqsave(&priv->lock, flags);
-
-	rcar_i2c_init(priv);
-	/* start clock */
-	rcar_i2c_write(priv, ICCCR, priv->icccr);
-
-	spin_unlock_irqrestore(&priv->lock, flags);
-	/*-------------- spin unlock -----------------*/
-
 	ret = rcar_i2c_bus_barrier(priv);
 	if (ret < 0)
 		goto out;
@@ -666,6 +657,7 @@ static int rcar_i2c_probe(struct platfor
 	if (ret < 0)
 		goto out_pm_put;
 
+	rcar_i2c_init(priv);
 	pm_runtime_put(dev);
 
 	irq = platform_get_irq(pdev, 0);
