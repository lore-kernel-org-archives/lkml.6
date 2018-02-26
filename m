Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeBZLSu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:18:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbeBZLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:18:08 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Applied "regmap: Format data for raw write in regmap_bulk_write" to the regmap tree
In-Reply-To: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
Message-Id: <E1eqGnF-0005dm-FZ@debutante>
Date: Mon, 26 Feb 2018 11:18:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Format data for raw write in regmap_bulk_write

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

>From 0812d8ffa9955251ba0077488d4408d8987ec091 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 22 Feb 2018 12:59:10 +0000
Subject: [PATCH] regmap: Format data for raw write in regmap_bulk_write

In the case were the bulk transaction is split up into smaller chunks
data is passed directly to regmap_raw_write. However regmap_bulk_write
uses data in host endian and regmap_raw_write expects data in device
endian. As such if the host and device differ in endian the wrong data
will be written to the device. Correct this issue using a similar
approach to the single raw write case below it, duplicate the data
into a new buffer and use parse_inplace to format the data correctly.

Fixes: adaac459759d ("regmap: Introduce max_raw_read/write for regmap_bulk_read/write")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f5d653663626..8fe6e08fa41e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2003,6 +2003,17 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		int chunk_stride = map->reg_stride;
 		size_t chunk_size = val_bytes;
 		size_t chunk_count = val_count;
+		void *wval;
+
+		if (!val_count)
+			return -EINVAL;
+
+		wval = kmemdup(val, val_count * val_bytes, map->alloc_flags);
+		if (!wval)
+			return -ENOMEM;
+
+		for (i = 0; i < val_count * val_bytes; i += val_bytes)
+			map->format.parse_inplace(wval + i);
 
 		if (!map->use_single_write) {
 			chunk_size = map->max_raw_write;
@@ -2017,7 +2028,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		for (i = 0; i < chunk_count; i++) {
 			ret = _regmap_raw_write(map,
 						reg + (i * chunk_stride),
-						val + (i * chunk_size),
+						wval + (i * chunk_size),
 						chunk_size);
 			if (ret)
 				break;
@@ -2026,10 +2037,12 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		/* Write remaining bytes */
 		if (!ret && chunk_size * i < total_size) {
 			ret = _regmap_raw_write(map, reg + (i * chunk_stride),
-						val + (i * chunk_size),
+						wval + (i * chunk_size),
 						total_size - i * chunk_size);
 		}
 		map->unlock(map->lock_arg);
+
+		kfree(wval);
 	} else {
 		void *wval;
 
-- 
2.16.1
