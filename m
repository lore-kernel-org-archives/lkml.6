Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeDKNzG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:55:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53312 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeDKNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:55:04 -0400
X-Google-Smtp-Source: AIpwx49SzHmEjxJTlc692yXu49xt3CUzk4DxmB96k/W2XCTU28dJbFRS/jPpxuVflsn1wEOt4w6D8Q==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        linux-gpio@vger.kernel.org, Rob Herring <robherring2@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
Date: Wed, 11 Apr 2018 15:55:01 +0200
Message-Id: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In past Xilinx gpio-zynq driver was setting up gpio chip->base as 0
which was chagned to autodetection when driver was upstreamed. Older
systems, which were using this old version, setup SW stack which expects
zynq gpio base as 0 and right now there is no way how to set this up.

The patch is adding an option to setup chip->base based on aliases which
is something what some other drivers are doing too.
It means when gpio0 alias is setup then chip->base is 0. When gpio alias
is not setup gpiochip_find_base() set it up properly which is current
behavior.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 23bb10576def..412cb5f31a9b 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -831,7 +831,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	chip->free = zynq_gpio_free;
 	chip->direction_input = zynq_gpio_dir_in;
 	chip->direction_output = zynq_gpio_dir_out;
-	chip->base = -1;
+	chip->base = of_alias_get_id(pdev->dev.of_node, "gpio");
 	chip->ngpio = gpio->p_data->ngpio;
 
 	/* Retrieve GPIO clock */
-- 
2.17.0
