Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeBFLTH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:19:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51581 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeBFLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:18:59 -0500
X-Google-Smtp-Source: AH8x225wS72f0ybdUJ/hBAi3bozg8yTihsroUk04tduqKZa83unXY6ih2lQNqjjsbY6P1UE1M6UfyA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] clk: call the clock init() callback before any other ops callback
Date: Tue,  6 Feb 2018 12:18:55 +0100
Message-Id: <20180206111855.18827-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks may need to initialize things, whatever it is, before
being able to properly operate. Move the .init() call before any
other callback, such recalc_rate() or get_phase(), so the clock
is properly setup before being used.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Hi Stephen, Mike,

This change is addressing a problem I have with clock driver I'm working
on. This driver needs the .init() callback to run first is order to answer
correctly .get_phase(). It does not address an existing issue, not one
that I'm aware of at least, which is why I did not put a Fixes tag.

In any case, it makes sense to run init before running anything else.

Since this changes the same region, this patch applies top of [0]

[0]: https://lkml.kernel.org/r/20180206105404.13086-1-jbrunet@baylibre.com

 drivers/clk/clk.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cca05ea2c058..9d56be6ead39 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2929,6 +2929,17 @@ static int __clk_core_init(struct clk_core *core)
 		core->orphan = true;
 	}
 
+	/*
+	 * optional platform-specific magic
+	 *
+	 * The .init callback is not used by any of the basic clock types, but
+	 * exists for weird hardware that must perform initialization magic.
+	 * Please consider other ways of solving initialization problems before
+	 * using this callback, as its use is discouraged.
+	 */
+	if (core->ops->init)
+		core->ops->init(core->hw);
+
 	/*
 	 * Set clk's accuracy.  The preferred method is to use
 	 * .recalc_accuracy. For simple clocks and lazy developers the default
@@ -3006,17 +3017,6 @@ static int __clk_core_init(struct clk_core *core)
 		}
 	}
 
-	/*
-	 * optional platform-specific magic
-	 *
-	 * The .init callback is not used by any of the basic clock types, but
-	 * exists for weird hardware that must perform initialization magic.
-	 * Please consider other ways of solving initialization problems before
-	 * using this callback, as its use is discouraged.
-	 */
-	if (core->ops->init)
-		core->ops->init(core->hw);
-
 	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
-- 
2.14.3
