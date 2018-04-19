Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDSPBf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:01:35 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:14061 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753583AbeDSPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:01:31 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Thu, 19 Apr 2018 16:01:19 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        <patches@opensource.cirrus.com>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] ARM: s3c64xx: Tidy up handling of regulator GPIO lookups
Message-ID: <20180419150119.5yhf3uupdolg3cnv@localhost.localdomain>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
 <20180212131717.27193-17-linus.walleij@linaro.org>
 <20180213111147.kr4kecqbhmcoq6w2@localhost.localdomain>
 <CACRpkdZVoYsdWy6GwnnSfaSc2_wycEse3JswqufqDoz=GFb5FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdZVoYsdWy6GwnnSfaSc2_wycEse3JswqufqDoz=GFb5FQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=731 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804190132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

Rather than unconditionally registering the GPIO lookup table only do so
for devices that require it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Do you have any objections to the following?

If we are lucky I might be able to find time to test these early
next week. Well at least there is reasonable chance I can test
the 5102 stuff when you resend, not sure I have a device to
test the wm1277 but will have a look. Also I haven't run up
Cragganmore in a little while so might depend a little on how
much people have broken it since last I did :-)

Thanks,
Charles

 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index a4db97f156d78..883907fb38e28 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -316,6 +316,8 @@ static const struct {
 	int num_i2c_devs;
 	const struct spi_board_info *spi_devs;
 	int num_spi_devs;
+
+	struct gpiod_lookup_table *gpiod_table;
 } gf_mods[] = {
 	{ .id = 0x01, .rev = 0xff, .name = "1250-EV1 Springbank" },
 	{ .id = 0x02, .rev = 0xff, .name = "1251-EV1 Jura" },
@@ -350,7 +352,8 @@ static const struct {
 	  .i2c_devs = wm1255_devs, .num_i2c_devs = ARRAY_SIZE(wm1255_devs) },
 	{ .id = 0x3c, .rev = 0xff, .name = "1273-EV1 Longmorn" },
 	{ .id = 0x3d, .rev = 0xff, .name = "1277-EV1 Littlemill",
-	  .i2c_devs = wm1277_devs, .num_i2c_devs = ARRAY_SIZE(wm1277_devs) },
+	  .i2c_devs = wm1277_devs, .num_i2c_devs = ARRAY_SIZE(wm1277_devs),
+	  .gpiod_table = &wm8994_gpiod_table },
 	{ .id = 0x3e, .rev = 0, .name = "WM5102-6271-EV1-CS127 Amrut",
 	  .spi_devs = wm5102_reva_spi_devs,
 	  .num_spi_devs = ARRAY_SIZE(wm5102_reva_spi_devs) },
@@ -379,7 +382,6 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 					    rev == gf_mods[i].rev))
 			break;
 
-	gpiod_add_lookup_table(&wm8994_gpiod_table);
 	if (i < ARRAY_SIZE(gf_mods)) {
 		dev_info(&i2c->dev, "%s revision %d\n",
 			 gf_mods[i].name, rev + 1);
@@ -393,6 +395,9 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 
 		spi_register_board_info(gf_mods[i].spi_devs,
 					gf_mods[i].num_spi_devs);
+
+		if (gf_mods[i].gpiod_table)
+			gpiod_add_lookup_table(gf_mods[i].gpiod_table);
 	} else {
 		dev_warn(&i2c->dev, "Unknown module ID 0x%x revision %d\n",
 			 id, rev + 1);
-- 
2.11.0
