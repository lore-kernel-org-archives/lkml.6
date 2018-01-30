Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeA3QTd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:19:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56724 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbeA3QTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:19:31 -0500
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fix suspend to idle" to the regulator tree
In-Reply-To: <20180130120340.GB10525@sirena.org.uk>
Message-Id: <E1egYd5-0000f8-9h@debutante>
Date: Tue, 30 Jan 2018 16:19:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix suspend to idle

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 57a0dd187956ea04870f4bbbf25a63c425ee7cad Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Jan 2018 12:16:31 +0000
Subject: [PATCH] regulator: Fix suspend to idle

When suspending to idle with the new suspend mode configuration support
we go through the suspend callbacks with a state of PM_SUSPEND_TO_IDLE
which we don't have regulator constraints for, causing an error.  Avoid
this and similar errors by treating missing constraints as a noop.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 42681c10cbe4..dd4708c58480 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -758,7 +758,7 @@ static int suspend_set_state(struct regulator_dev *rdev,
 
 	rstate = regulator_get_suspend_state(rdev, state);
 	if (rstate == NULL)
-		return -EINVAL;
+		return 0;
 
 	/* If we have no suspend mode configration don't set anything;
 	 * only warn if the driver implements set_suspend_voltage or
-- 
2.15.1
