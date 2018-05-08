Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeEHWGX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:06:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52483 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755741AbeEHWGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:06:21 -0400
X-Google-Smtp-Source: AB8JxZqlqbqlmNJOASqdb6YHDVML3n+UvQT4JDgcTYmH4OKbkdmKv5jr1er2xcYYE5A4V7pIC2AyUQ==
From: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
To: jramirez@baylibre.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] regmap: allow volatile register writes with cached only read maps
Date: Wed,  9 May 2018 00:06:09 +0200
Message-Id: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regmap only allows volatile access to registers when the client
supports both reads and writes.

This commit bypasses that limitation and enables volatile writes to
selected registers while maintaining cached accesses on all reads. For
this, the client does not need to configure the reg_read callback.

Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
---
 drivers/base/regmap/internal.h       |  1 +
 drivers/base/regmap/regcache.c       | 10 +++++++++-
 drivers/base/regmap/regmap-debugfs.c | 17 +++++++++++++++--
 drivers/base/regmap/regmap.c         | 11 +++++++++++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 53785e0..496c825 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -180,6 +180,7 @@ bool regmap_cached(struct regmap *map, unsigned int reg);
 bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
+bool regmap_volatile_writes(struct regmap *map, unsigned int reg);
 bool regmap_precious(struct regmap *map, unsigned int reg);
 
 int _regmap_write(struct regmap *map, unsigned int reg,
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7735603..51cceaa 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -273,8 +273,16 @@ int regcache_write(struct regmap *map,
 
 	BUG_ON(!map->cache_ops);
 
-	if (!regmap_volatile(map, reg))
+	if (!regmap_volatile(map, reg)) {
+
+		if (!regmap_readable(map, reg)) {
+			/* check if the client configured volatile writes */
+			if (regmap_volatile_writes(map, reg))
+				return 0;
+		}
+
 		return map->cache_ops->write(map, reg, value);
+	}
 
 	return 0;
 }
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 87b562e..89fb771 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -415,20 +415,33 @@ static const struct file_operations regmap_reg_ranges_fops = {
 static int regmap_access_show(struct seq_file *s, void *ignored)
 {
 	struct regmap *map = s->private;
+	char reg_volatile;
 	int i, reg_len;
 
 	reg_len = regmap_calc_reg_len(map->max_register);
 
 	for (i = 0; i <= map->max_register; i += map->reg_stride) {
-		/* Ignore registers which are neither readable nor writable */
+		 reg_volatile = 'n';
+
+		 /* Ignore registers which are neither readable nor writable */
 		if (!regmap_readable(map, i) && !regmap_writeable(map, i))
 			continue;
 
+		if (regmap_volatile(map, i)) {
+			reg_volatile = 'y';
+			goto done;
+		}
+
+		if (!regmap_readable(map, i)) {
+			if (regmap_volatile_writes(map, i))
+				reg_volatile = 'y';
+		}
+done:
 		/* Format the register */
 		seq_printf(s, "%.*x: %c %c %c %c\n", reg_len, i,
 			   regmap_readable(map, i) ? 'y' : 'n',
 			   regmap_writeable(map, i) ? 'y' : 'n',
-			   regmap_volatile(map, i) ? 'y' : 'n',
+			   reg_volatile,
 			   regmap_precious(map, i) ? 'y' : 'n');
 	}
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..7d4b671 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -154,6 +154,17 @@ bool regmap_volatile(struct regmap *map, unsigned int reg)
 		return true;
 }
 
+bool regmap_volatile_writes(struct regmap *map, unsigned int reg)
+{
+	if (map->volatile_reg)
+		return map->volatile_reg(map->dev, reg);
+
+	if (map->volatile_table)
+		return regmap_check_range_table(map, reg, map->volatile_table);
+
+	return false;
+}
+
 bool regmap_precious(struct regmap *map, unsigned int reg)
 {
 	if (!regmap_readable(map, reg))
-- 
2.7.4
