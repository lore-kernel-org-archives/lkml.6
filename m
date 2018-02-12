Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeBLOYx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:24:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50347 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbeBLOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:24:52 -0500
X-Google-Smtp-Source: AH8x227flDL6/mwmWODZmbTvNlTlIaKQEgqdfu4dlqVGfHU0JrHxGvxJv4CkKxpCO5qFgKeWUt5bIA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH] clk: don't call __of_clk_get_by_name() unnecessarily from clk_get()
Date: Mon, 12 Feb 2018 15:24:39 +0100
Message-Id: <20180212142439.15885-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The way this function is implemented caused some confusion when
converting the TI DaVinci platform to using the common clock framework.

Current kernel supports booting DaVinci boards both in device tree as
well as legacy, board-file mode. In the latter, we always end up
calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
returns -ENOENT.

It was not obvious at first glance how clk_get(dev, NULL) will work in
board-file mode since we always call __of_clk_get_by_name(). Let's make
it clearer by checking if of_node is NULL and skipping right to
clk_get_sys().

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/clkdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411140b6..f394e8964909 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -199,7 +199,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct clk *clk;
 
-	if (dev) {
+	if (dev && dev->of_node) {
 		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
-- 
2.16.1
