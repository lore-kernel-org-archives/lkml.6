Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755426AbeBOK2i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:28:38 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43594 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755304AbeBOK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:28:35 -0500
X-Google-Smtp-Source: AH8x224bWNDWHhlMDkNqzW/C0kHqR9jiJ74APwJDjCrYnagKH3CIBcPToy0/bI+RkNo2adnc91iHFA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: use get_phase() if available
Date: Thu, 15 Feb 2018 11:28:22 +0100
Message-Id: <20180215102822.7721-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the get_phase() callback is available, we should use it
instead of just relying the values cached, and assumed un-rounded,
by the framework

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Hi Mike, Stephen,

This changes applies on top of the phase fix I've sent [0]

[0]: https://lkml.kernel.org/r/20180215101958.22676-1-jbrunet@baylibre.com

 drivers/clk/clk.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b33d362239e7..bcd6ec980903 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2297,6 +2297,21 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 }
 EXPORT_SYMBOL_GPL(clk_set_parent);
 
+static int clk_core_get_phase_nolock(struct clk_core *core)
+{
+	int ret;
+
+	if (!core->ops->get_phase)
+		return core->phase;
+
+	/* Update the phase if the callback is available */
+	ret = core->ops->get_phase(core->hw);
+	if (ret >= 0)
+		core->phase = ret;
+
+	return ret;
+}
+
 static int clk_core_set_phase_nolock(struct clk_core *core, int degrees)
 {
 	int ret = -EINVAL;
@@ -2314,12 +2329,16 @@ static int clk_core_set_phase_nolock(struct clk_core *core, int degrees)
 	if (core->ops->set_phase)
 		ret = core->ops->set_phase(core->hw, degrees);
 
-	if (!ret)
+	if (!ret) {
 		core->phase = degrees;
 
+		/* Read back the phase in case it got rounded */
+		ret = clk_core_get_phase_nolock(core);
+	}
+
 	trace_clk_set_phase_complete(core, degrees);
 
-	return ret;
+	return ret > 0 ? 0 : ret;
 }
 
 /**
@@ -2375,7 +2394,7 @@ static int clk_core_get_phase(struct clk_core *core)
 	int ret;
 
 	clk_prepare_lock();
-	ret = core->phase;
+	ret = clk_core_get_phase_nolock(core);
 	clk_prepare_unlock();
 
 	return ret;
-- 
2.14.3
