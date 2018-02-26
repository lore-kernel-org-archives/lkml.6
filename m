Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeBZLSK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:18:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52114 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeBZLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:17:59 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Applied "regmap: Tidy up regmap_raw_write chunking code" to the regmap tree
In-Reply-To: <20180222125914.17016-4-ckeepax@opensource.cirrus.com>
Message-Id: <E1eqGn6-0005b6-1c@debutante>
Date: Mon, 26 Feb 2018 11:17:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Tidy up regmap_raw_write chunking code

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

>From 364e378b8d1679f91a29a9537a881bba17931cfb Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 22 Feb 2018 12:59:13 +0000
Subject: [PATCH] regmap: Tidy up regmap_raw_write chunking code

Raw writes may need to be split into small chunks if max_raw_write is
set. Tidy up the code implementing this, the new code is slightly
clearer, slightly shorter and slightly more efficient.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e82ea77849fb..bfdd66dd3766 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1812,40 +1812,35 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 {
 	size_t val_bytes = map->format.val_bytes;
 	size_t val_count = val_len / val_bytes;
-	int chunk_stride = map->reg_stride;
-	size_t chunk_size = val_bytes;
-	size_t chunk_count = val_count;
+	size_t chunk_count, chunk_bytes;
+	size_t chunk_regs = val_count;
 	int ret, i;
 
 	if (!val_count)
 		return -EINVAL;
 
-	if (!map->use_single_write) {
-		if (map->max_raw_write)
-			chunk_size = map->max_raw_write;
-		else
-			chunk_size = val_len;
-		if (chunk_size % val_bytes)
-			chunk_size -= chunk_size % val_bytes;
-		chunk_count = val_len / chunk_size;
-		chunk_stride *= chunk_size / val_bytes;
-	}
+	if (map->use_single_write)
+		chunk_regs = 1;
+	else if (map->max_raw_write && val_len > map->max_raw_write)
+		chunk_regs = map->max_raw_write / val_bytes;
+
+	chunk_count = val_count / chunk_regs;
+	chunk_bytes = chunk_regs * val_bytes;
 
 	/* Write as many bytes as possible with chunk_size */
 	for (i = 0; i < chunk_count; i++) {
-		ret = _regmap_raw_write_impl(map,
-					     reg + (i * chunk_stride),
-					     val + (i * chunk_size),
-					     chunk_size);
+		ret = _regmap_raw_write_impl(map, reg, val, chunk_bytes);
 		if (ret)
 			return ret;
+
+		reg += regmap_get_offset(map, chunk_regs);
+		val += chunk_bytes;
+		val_len -= chunk_bytes;
 	}
 
 	/* Write remaining bytes */
-	if (!ret && chunk_size * i < val_len)
-		ret = _regmap_raw_write_impl(map, reg + (i * chunk_stride),
-					     val + (i * chunk_size),
-					     val_len - i * chunk_size);
+	if (val_len)
+		ret = _regmap_raw_write_impl(map, reg, val, val_len);
 
 	return ret;
 }
-- 
2.16.1
