Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeFEMNl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:13:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45088 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeFEMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:13:39 -0400
X-Google-Smtp-Source: ADUXVKJ8VPaCJLw085rF24yxs63p7x6we7l8vjoRa8yhChRN+z33fZ0UIovq9aJA4EeOTiIXbjACfQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: tegra: emc: Avoid out-of-bounds bug
Date: Tue,  5 Jun 2018 15:12:32 +0300
Message-Id: <20180605121232.7121-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently there was an attempt to avoid out-of-bounds accesses when there
is only one memory timing available, but there is a typo in the code that
neglects that attempt.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 5234acd30e89..0621a3a82ea6 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -132,7 +132,7 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 		timing = tegra->timings + i;
 
 		if (timing->rate > req->max_rate) {
-			i = min(i, 1);
+			i = max(i, 1);
 			req->rate = tegra->timings[i - 1].rate;
 			return 0;
 		}
-- 
2.17.0
