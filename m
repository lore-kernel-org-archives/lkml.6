Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeCGOPZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:15:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:15:17 -0500
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Applied "regmap: debugfs: Don't leak dummy names" to the regmap tree
In-Reply-To: 
Message-Id: <E1etZqd-0001Zu-SP@debutante>
Date: Wed, 07 Mar 2018 14:15:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: debugfs: Don't leak dummy names

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

>From 46589e9c753b7c905e8671a89cbb9728f3b99855 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 5 Mar 2018 20:26:51 +0000
Subject: [PATCH] regmap: debugfs: Don't leak dummy names

When allocating dummy names we need to store a pointer to the string we
allocate so that we don't leak it on free.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index e3e7b91cc421..dd3a16894e3c 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -575,7 +575,9 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 	}
 
 	if (!strcmp(name, "dummy")) {
-		name = kasprintf(GFP_KERNEL, "dummy%d", dummy_index);
+		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
+						dummy_index);
+		name = map->debugfs_name;
 		dummy_index++;
 	}
 
-- 
2.16.2
