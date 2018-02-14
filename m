Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030493AbeBNNsD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:48:03 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37143 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030301AbeBNNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:43:49 -0500
X-Google-Smtp-Source: AH8x225YdeTXcfobMSy4Y3WROwJy5m0fM0n1wNOXHUM0OOp3dt7Wvy6P0L/79o7TvJpP1QJbfQ94rg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] clk: fix determine rate error with pass-through clock
Date: Wed, 14 Feb 2018 14:43:35 +0100
Message-Id: <20180214134340.17242-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we try to determine the rate of a pass-through clock (a clock which
does not implement .round_rate() nor .determine_rate()),
clk_core_round_rate_nolock() will directly forward the call to the
parent clock. In the particular case where the pass-through actually
does not have a parent, clk_core_round_rate_nolock() will directly
return 0 with the requested rate still set to the initial request
structure. This is interpreted as if the rate could be exactly achieved
while it actually cannot be adjusted.

This become a real problem when this particular pass-through clock is
the parent of a mux with the flag CLK_SET_RATE_PARENT set. The
pass-through clock will always report an exact match, get picked and
finally error when the rate is actually getting set.

This is fixed by setting the rate inside the req to 0 when core is NULL
in clk_core_round_rate_nolock() (same as in __clk_determine_rate() when
hw is NULL)

Fixes: 0f6cc2b8e94d ("clk: rework calls to round and determine rate callbacks")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0f686a9dac3e..a4b4e4d6df5e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1125,8 +1125,10 @@ static int clk_core_round_rate_nolock(struct clk_core *core,
 {
 	lockdep_assert_held(&prepare_lock);
 
-	if (!core)
+	if (!core) {
+		req->rate = 0;
 		return 0;
+	}
 
 	clk_core_init_rate_req(core, req);
 
-- 
2.14.3
