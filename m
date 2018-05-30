Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeE3Usg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:48:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36105 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeE3Usd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:48:33 -0400
X-Google-Smtp-Source: ADUXVKJDQw9l7A+MylU1hnmM9c5FjW9xwXHh5QI5+DfY9eRmnqYQ+fOU0ABj/rMkfZeXAgq8kA9bcw==
Date: Wed, 30 May 2018 13:48:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mdio-mux-gpio: Remove VLA usage
Message-ID: <20180530204830.GA24884@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
moves the allocation into struct mdio_mux_gpio_state during probe.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: allocate array as part of structure (Andrew Lunn)
---
 drivers/net/phy/mdio-mux-gpio.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index 082ffef0dec4..6b55e0ddef63 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -20,23 +20,23 @@
 struct mdio_mux_gpio_state {
 	struct gpio_descs *gpios;
 	void *mux_handle;
+	int values[];
 };
 
 static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 				   void *data)
 {
 	struct mdio_mux_gpio_state *s = data;
-	int values[s->gpios->ndescs];
 	unsigned int n;
 
 	if (current_child == desired_child)
 		return 0;
 
 	for (n = 0; n < s->gpios->ndescs; n++)
-		values[n] = (desired_child >> n) & 1;
+		s->values[n] = (desired_child >> n) & 1;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       values);
+				       s->values);
 
 	return 0;
 }
@@ -44,15 +44,21 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 static int mdio_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct mdio_mux_gpio_state *s;
+	struct gpio_descs *gpios;
 	int r;
 
-	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
-	if (!s)
+	gpios = gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(gpios))
+		return PTR_ERR(gpios);
+
+	s = devm_kzalloc(&pdev->dev, sizeof(*s->values) * gpios->ndescs +
+				     sizeof(*s), GFP_KERNEL);
+	if (!s) {
+		gpiod_put_array(gpios);
 		return -ENOMEM;
+	}
 
-	s->gpios = gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(s->gpios))
-		return PTR_ERR(s->gpios);
+	s->gpios = gpios;
 
 	r = mdio_mux_init(&pdev->dev, pdev->dev.of_node,
 			  mdio_mux_gpio_switch_fn, &s->mux_handle, s, NULL);
-- 
2.17.0


-- 
Kees Cook
Pixel Security
