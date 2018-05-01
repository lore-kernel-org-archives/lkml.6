Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeEALmX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:42:23 -0400
Received: from atl4mhob18.registeredsite.com ([209.17.115.111]:50804 "EHLO
        atl4mhob18.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754283AbeEALmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:42:21 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-i2c@vger.kernel.org
Cc: peda@axentia.se, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] i2c-mux-pca954x: Force reset on probe if available
Date: Tue,  1 May 2018 13:42:12 +0200
Message-Id: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of just hogging the reset GPIO into deactivated state, activate and
then de-activate the reset. This allows for better recovery if the CPU was
reset halfway through an I2C transaction for example.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 09bafd3..13e10d0 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -36,6 +36,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
@@ -389,10 +390,17 @@ static int pca954x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, muxc);
 	data->client = client;
 
-	/* Get the mux out of reset if a reset GPIO is specified. */
-	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
+	/* Reset the mux if a reset GPIO is specified. */
+	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
+	if (gpio) {
+		/* Datasheet specifies a 4 ns reset-low time */
+		udelay(1);
+		gpiod_set_value_cansleep(gpio, 0);
+		/* Datasheet specifies a 500 ns reset recovery time */
+		udelay(1);
+	}
 
 	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
 	if (match)
-- 
1.9.1
