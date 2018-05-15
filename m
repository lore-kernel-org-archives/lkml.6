Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeEOBAM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:00:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34728 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEOBAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:00:10 -0400
X-Google-Smtp-Source: AB8JxZr6pq5LvSeI5j7E8/eM7g+sLP36ux39wsB1UEwvwPliL0MvV0avIl49S34ytIOY0HP0hj7B+Q==
From: James Kelly <jamespeterkelly@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: James Kelly <jamespeterkelly@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: regmap: Skip clk_put for attached clocks when freeing context
Date: Tue, 15 May 2018 10:59:58 +1000
Message-Id: <20180515005958.46971-1-jamespeterkelly@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capability to attach an existing clk to a MMIO regmap was
introduced in 4.17rc1.

However, when using attached clk, regmap does not do the clk_get.
Therefore it should not do the clk_put when freeing the MMIO
regmap context.

There does not appear to be any users of attached clocks yet
so this would be a good time to make this change before anything
depends on the existing behaviour.

Signed-off-by: James Kelly <jamespeterkelly@gmail.com>
---
 drivers/base/regmap/regmap-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 5cadfd3394d8..8741fb5f8f54 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -206,7 +206,8 @@ static void regmap_mmio_free_context(void *context)
 
 	if (!IS_ERR(ctx->clk)) {
 		clk_unprepare(ctx->clk);
-		clk_put(ctx->clk);
+		if (!ctx->attached_clk)
+			clk_put(ctx->clk);
 	}
 	kfree(context);
 }
-- 
2.15.1 (Apple Git-101)
