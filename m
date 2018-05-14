Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeENIIN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:08:13 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36108 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeENIHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:33 -0400
X-Google-Smtp-Source: AB8JxZpSrf99RtoaFi480CqAMgGGVuFd9UWIU87HGK93DpWNEjMo3C6Mm/LR00fhnCTpuMDUHEXauA==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 19/19 v3] ARM: s3c64xx: Tidy up handling of regulator GPIO lookups
Date: Mon, 14 May 2018 10:06:40 +0200
Message-Id: <20180514080640.12515-20-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

Rather than unconditionally registering the GPIO lookup table only do so
for devices that require it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
[Fixed up to also handle wm5102 and wm5102 reva]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Including this in my patch series.
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 76c4855a03bc..56ec212442ad 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -328,6 +328,8 @@ static const struct {
 	int num_i2c_devs;
 	const struct spi_board_info *spi_devs;
 	int num_spi_devs;
+
+	struct gpiod_lookup_table *gpiod_table;
 } gf_mods[] = {
 	{ .id = 0x01, .rev = 0xff, .name = "1250-EV1 Springbank" },
 	{ .id = 0x02, .rev = 0xff, .name = "1251-EV1 Jura" },
@@ -362,13 +364,16 @@ static const struct {
 	  .i2c_devs = wm1255_devs, .num_i2c_devs = ARRAY_SIZE(wm1255_devs) },
 	{ .id = 0x3c, .rev = 0xff, .name = "1273-EV1 Longmorn" },
 	{ .id = 0x3d, .rev = 0xff, .name = "1277-EV1 Littlemill",
-	  .i2c_devs = wm1277_devs, .num_i2c_devs = ARRAY_SIZE(wm1277_devs) },
+	  .i2c_devs = wm1277_devs, .num_i2c_devs = ARRAY_SIZE(wm1277_devs),
+	  .gpiod_table = &wm8994_gpiod_table },
 	{ .id = 0x3e, .rev = 0, .name = "WM5102-6271-EV1-CS127 Amrut",
 	  .spi_devs = wm5102_reva_spi_devs,
-	  .num_spi_devs = ARRAY_SIZE(wm5102_reva_spi_devs) },
+	  .num_spi_devs = ARRAY_SIZE(wm5102_reva_spi_devs),
+	  .gpiod_table = &wm5102_reva_gpiod_table },
 	{ .id = 0x3e, .rev = -1, .name = "WM5102-6271-EV1-CS127 Amrut",
 	  .spi_devs = wm5102_spi_devs,
-	  .num_spi_devs = ARRAY_SIZE(wm5102_spi_devs) },
+	  .num_spi_devs = ARRAY_SIZE(wm5102_spi_devs),
+	  .gpiod_table = &wm5102_gpiod_table },
 	{ .id = 0x3f, .rev = -1, .name = "WM2200-6271-CS90-M-REV1",
 	  .i2c_devs = wm2200_i2c, .num_i2c_devs = ARRAY_SIZE(wm2200_i2c) },
 };
@@ -391,10 +396,6 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 					    rev == gf_mods[i].rev))
 			break;
 
-	gpiod_add_lookup_table(&wm5102_reva_gpiod_table);
-	gpiod_add_lookup_table(&wm5102_gpiod_table);
-	gpiod_add_lookup_table(&wm8994_gpiod_table);
-
 	if (i < ARRAY_SIZE(gf_mods)) {
 		dev_info(&i2c->dev, "%s revision %d\n",
 			 gf_mods[i].name, rev + 1);
@@ -408,6 +409,9 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 
 		spi_register_board_info(gf_mods[i].spi_devs,
 					gf_mods[i].num_spi_devs);
+
+		if (gf_mods[i].gpiod_table)
+			gpiod_add_lookup_table(gf_mods[i].gpiod_table);
 	} else {
 		dev_warn(&i2c->dev, "Unknown module ID 0x%x revision %d\n",
 			 id, rev + 1);
-- 
2.17.0
