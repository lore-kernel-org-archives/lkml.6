Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDQJuH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:50:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34311 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeDQJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:50:05 -0400
X-Google-Smtp-Source: AIpwx4+XiJioxssomO9X2efGzXM7QLEFF3ZEeE1tFc2Sgmc/UXgBOkn1e+EBO68kxg6kBEmn7JmE9g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH] clkdev: don't call __of_clk_get_by_name() unnecessarily from clk_get()
Date: Tue, 17 Apr 2018 11:50:01 +0200
Message-Id: <20180417095001.8508-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
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
2.17.0
