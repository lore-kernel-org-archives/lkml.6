Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755439AbeBOKUH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:20:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35207 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755404AbeBOKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:20:05 -0500
X-Google-Smtp-Source: AH8x225dfJ0w6C26vwD7H8R5ikuSHSRBL7RzJuL9AHqhxkdHxMDmlBZ25y7sQSj4XtmKVMrCxfqLvA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: fix phase reported being zero
Date: Thu, 15 Feb 2018 11:19:58 +0100
Message-Id: <20180215101958.22676-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While introducing clk_core_set_phase_nolock, assigning core->phase was
mistakenly removed. Fixing this now

Fixes: 9e4d04adeb1a ("clk: add clk_core_set_phase_nolock function")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9d56be6ead39..b33d362239e7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2314,6 +2314,9 @@ static int clk_core_set_phase_nolock(struct clk_core *core, int degrees)
 	if (core->ops->set_phase)
 		ret = core->ops->set_phase(core->hw, degrees);
 
+	if (!ret)
+		core->phase = degrees;
+
 	trace_clk_set_phase_complete(core, degrees);
 
 	return ret;
-- 
2.14.3
