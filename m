Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCMIyK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:54:10 -0400
Received: from atl4mhob05.registeredsite.com ([209.17.115.43]:46502 "EHLO
        atl4mhob05.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752202AbeCMIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:54:09 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk: clk-gpio: Allow GPIO to sleep in set/get_parent
Date: Tue, 13 Mar 2018 09:54:03 +0100
Message-Id: <1520931243-29091-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing or retrieving clock parents, the caller is in a sleepable
state (like prepare) so the GPIO operation need not be atomic. Replace
gpiod_{g|s}et_value with gpiod_{g|s}et_value_cansleep in the {g|s}et_parent
calls for the GPIO based clock mux.

This fixes a "slowpath" warning when the GPIO controller is an I2C expander
or something similar.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 151513c..40af4fb 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -73,14 +73,14 @@ static u8 clk_gpio_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_gpio *clk = to_clk_gpio(hw);
 
-	return gpiod_get_value(clk->gpiod);
+	return gpiod_get_value_cansleep(clk->gpiod);
 }
 
 static int clk_gpio_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_gpio *clk = to_clk_gpio(hw);
 
-	gpiod_set_value(clk->gpiod, index);
+	gpiod_set_value_cansleep(clk->gpiod, index);
 
 	return 0;
 }
-- 
1.9.1
