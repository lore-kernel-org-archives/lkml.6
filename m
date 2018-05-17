Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeEQQlR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:41:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeEQQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:41:15 -0400
From: Mark Brown <broonie@kernel.org>
To: James Kelly <jamespeterkelly@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Skip clk_put for attached clocks when freeing context" to the regmap tree
In-Reply-To: <20180515005017.46851-1-jamespeterkelly@gmail.com>
Message-Id: <20180517164110.E6D5344007E@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 17:41:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Skip clk_put for attached clocks when freeing context

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eb4a219d19fde99616f120f5655a7121c918cd49 Mon Sep 17 00:00:00 2001
From: James Kelly <jamespeterkelly@gmail.com>
Date: Tue, 15 May 2018 10:59:58 +1000
Subject: [PATCH] regmap: Skip clk_put for attached clocks when freeing context

Capability to attach an existing clk to a MMIO regmap was
introduced in 4.17rc1.

However, when using attached clk, regmap does not do the clk_get.
Therefore it should not do the clk_put when freeing the MMIO
regmap context.

There does not appear to be any users of attached clocks yet
so this would be a good time to make this change before anything
depends on the existing behaviour.

Signed-off-by: James Kelly <jamespeterkelly@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.17.0
