Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A2ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305232087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pvBre4Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305232087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJSUf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:35:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43766 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=stTohkAM0VrQtox+epeCOVa0bu2RyOIYJ5g1Kg1Ugvw=; b=pvBre4Tjmkfn
        bFLk9QEJPoB0pUICll8lnOsAi4uj+5SEF5LLKJmNz08aq7uRF5/NbaMyC7vgHwkwzCOqBWM9gE9gL
        cBsbJc/3pZ83lpRo9rSZwefDh5NxUaru6I8YBf3mnsn7iJgFii7+4vJaOvcMOG6FMvMO0vH/ojdZ7
        bwCbU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTuE-0008WJ-3J; Fri, 19 Oct 2018 12:29:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D2E071122548; Fri, 19 Oct 2018 13:29:29 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Add regmap_noinc_write API" to the regmap tree
In-Reply-To: 
Message-Id: <20181019122929.D2E071122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:29:29 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Add regmap_noinc_write API

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

From cdf6b11daa77d4b55ddf0530842a551cc5562a93 Mon Sep 17 00:00:00 2001
From: Ben Whitten <ben.whitten@gmail.com>
Date: Fri, 19 Oct 2018 10:33:50 +0100
Subject: [PATCH] regmap: Add regmap_noinc_write API

The regmap API had a noinc_read function added for instances where devices
supported returning data from an internal FIFO in a single read.

This commit adds the noinc_write variant to allow writing to a non
incrementing register, this is used in devices such as the sx1301 for
loading firmware.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 77 ++++++++++++++++++++++++++++++++++
 include/linux/regmap.h         | 19 +++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a6bf34d6394e..404f123cbe55 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -94,11 +94,13 @@ struct regmap {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
 	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *wr_noinc_table;
 	const struct regmap_access_table *rd_noinc_table;
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
@@ -183,6 +185,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
 bool regmap_precious(struct regmap *map, unsigned int reg);
+bool regmap_writeable_noinc(struct regmap *map, unsigned int reg);
 bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
 
 int _regmap_write(struct regmap *map, unsigned int reg,
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0360a90ad6b6..d4f1fc642600 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -168,6 +168,17 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
 	return false;
 }
 
+bool regmap_writeable_noinc(struct regmap *map, unsigned int reg)
+{
+	if (map->writeable_noinc_reg)
+		return map->writeable_noinc_reg(map->dev, reg);
+
+	if (map->wr_noinc_table)
+		return regmap_check_range_table(map, reg, map->wr_noinc_table);
+
+	return true;
+}
+
 bool regmap_readable_noinc(struct regmap *map, unsigned int reg)
 {
 	if (map->readable_noinc_reg)
@@ -777,11 +788,13 @@ struct regmap *__regmap_init(struct device *dev,
 	map->rd_table = config->rd_table;
 	map->volatile_table = config->volatile_table;
 	map->precious_table = config->precious_table;
+	map->wr_noinc_table = config->wr_noinc_table;
 	map->rd_noinc_table = config->rd_noinc_table;
 	map->writeable_reg = config->writeable_reg;
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->writeable_noinc_reg = config->writeable_noinc_reg;
 	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
@@ -1298,6 +1311,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->writeable_noinc_reg = config->writeable_noinc_reg;
 	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
@@ -1897,6 +1911,69 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(regmap_raw_write);
 
+/**
+ * regmap_noinc_write(): Write data from a register without incrementing the
+ *			register number
+ *
+ * @map: Register map to write to
+ * @reg: Register to write to
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus write operations will write a
+ * range of registers. Some devices have certain registers for which a write
+ * operation can write to an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple writes as required to write val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_noinc_write(struct regmap *map, unsigned int reg,
+		      const void *val, size_t val_len)
+{
+	size_t write_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->write)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg) || !regmap_writeable_noinc(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_write && map->max_raw_write < val_len)
+			write_len = map->max_raw_write;
+		else
+			write_len = val_len;
+		ret = _regmap_raw_write(map, reg, val, write_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + write_len;
+		val_len -= write_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_noinc_write);
+
 /**
  * regmap_field_update_bits_base() - Perform a read/modify/write cycle a
  *                                   register field.
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 379505a53722..de04dc46c7a9 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -268,6 +268,13 @@ typedef void (*regmap_unlock)(void *);
  *                field is NULL but precious_table (see below) is not, the
  *                check is performed on such table (a register is precious if
  *                it belongs to one of the ranges specified by precious_table).
+ * @writeable_noinc_reg: Optional callback returning true if the register
+ *			supports multiple write operations without incrementing
+ *			the register number. If this field is NULL but
+ *			wr_noinc_table (see below) is not, the check is
+ *			performed on such table (a register is no increment
+ *			writeable if it belongs to one of the ranges specified
+ *			by wr_noinc_table).
  * @readable_noinc_reg: Optional callback returning true if the register
  *			supports multiple read operations without incrementing
  *			the register number. If this field is NULL but
@@ -302,6 +309,7 @@ typedef void (*regmap_unlock)(void *);
  * @rd_table:     As above, for read access.
  * @volatile_table: As above, for volatile registers.
  * @precious_table: As above, for precious registers.
+ * @wr_noinc_table: As above, for no increment writeable registers.
  * @rd_noinc_table: As above, for no increment readable registers.
  * @reg_defaults: Power on reset values for registers (for use with
  *                register cache support).
@@ -352,6 +360,7 @@ struct regmap_config {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
 	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 
 	bool disable_locking;
@@ -369,6 +378,7 @@ struct regmap_config {
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *wr_noinc_table;
 	const struct regmap_access_table *rd_noinc_table;
 	const struct reg_default *reg_defaults;
 	unsigned int num_reg_defaults;
@@ -979,6 +989,8 @@ int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
 int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val);
 int regmap_raw_write(struct regmap *map, unsigned int reg,
 		     const void *val, size_t val_len);
+int regmap_noinc_write(struct regmap *map, unsigned int reg,
+		     const void *val, size_t val_len);
 int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			size_t val_count);
 int regmap_multi_reg_write(struct regmap *map, const struct reg_sequence *regs,
@@ -1222,6 +1234,13 @@ static inline int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_noinc_write(struct regmap *map, unsigned int reg,
+				    const void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_write(struct regmap *map, unsigned int reg,
 				    const void *val, size_t val_count)
 {
-- 
2.19.0.rc2

