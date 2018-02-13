Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964780AbeBMMdE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:33:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59362 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935130AbeBMM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:29:28 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        david.rhodes@cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Correct offset handling in regmap_volatile_range" to the regmap tree
In-Reply-To: <20180212181547.2415-2-ckeepax@opensource.cirrus.com>
Message-Id: <E1elZi9-0007PA-Gu@debutante>
Date: Tue, 13 Feb 2018 12:29:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Correct offset handling in regmap_volatile_range

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

>From b8f9a03b741ddfdde4aa8b607fa7d88eb63a6338 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 12 Feb 2018 18:15:45 +0000
Subject: [PATCH] regmap: Correct offset handling in regmap_volatile_range

The current implementation is broken for regmaps that have a reg_stride,
since it doesn't take the stride into account. Correct this by using the
helper function to calculate the register offset.

Fixes: f01ee60fffa4 ("regmap: implement register striding")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee302ccdfbc8..f89d01e7b257 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -174,7 +174,7 @@ static bool regmap_volatile_range(struct regmap *map, unsigned int reg,
 	unsigned int i;
 
 	for (i = 0; i < num; i++)
-		if (!regmap_volatile(map, reg + i))
+		if (!regmap_volatile(map, reg + regmap_get_offset(map, i)))
 			return false;
 
 	return true;
-- 
2.16.1
