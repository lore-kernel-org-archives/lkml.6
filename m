Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968043AbeE2W7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:59:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33436 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967991AbeE2W7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:59:04 -0400
X-Google-Smtp-Source: ADUXVKK4xRc3G/gNg0UMtXwCZcMrTOZIOLEgzZFAeSQIDV1xrN4e6/WyZ3oA1jtBHs0pxZfhhRkP5Q==
Date: Tue, 29 May 2018 15:59:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Pramod Kumar <pramod.kumar@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mdio-mux-gpio: Remove VLA usage
Message-ID: <20180529225901.GA30464@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
allocates the values buffer during the callback instead of putting it
on the stack.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/phy/mdio-mux-gpio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index 082ffef0dec4..e99994f4ed50 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -26,18 +26,23 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 				   void *data)
 {
 	struct mdio_mux_gpio_state *s = data;
-	int values[s->gpios->ndescs];
+	int *values;
 	unsigned int n;
 
 	if (current_child == desired_child)
 		return 0;
 
+	values = kmalloc_array(s->gpios->ndescs, sizeof(*values), GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
+
 	for (n = 0; n < s->gpios->ndescs; n++)
 		values[n] = (desired_child >> n) & 1;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
 				       values);
 
+	kfree(values);
 	return 0;
 }
 
-- 
2.17.0


-- 
Kees Cook
Pixel Security
