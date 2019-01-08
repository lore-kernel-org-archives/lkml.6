Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0222E206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfAHSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:02:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:12960 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbfAHSCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:02:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 10:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,455,1539673200"; 
   d="scan'208";a="136455515"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jan 2019 10:02:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DBB45E3; Tue,  8 Jan 2019 20:02:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFT][PATCH v1] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date:   Tue,  8 Jan 2019 20:02:05 +0200
Message-Id: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New quirk enforces search for GPIO based on its type.
Note, supplied index in the mapping table must be 0.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

- it was sent few weeks ago to Hans for testing, but better to re-test
- it's supposed to go via ASoC subsystem due to recent changes made for sound driver

 drivers/gpio/gpiolib-acpi.c           | 15 ++++--
 include/linux/acpi.h                  |  2 +
 sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------
 3 files changed, 22 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 259cf6ab969b..4d291b75cb9f 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -530,17 +530,24 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
 		return 1;
 
-	if (lookup->n++ == lookup->index && !lookup->desc) {
+	if (!lookup->desc) {
 		const struct acpi_resource_gpio *agpio = &ares->data.gpio;
-		int pin_index = lookup->pin_index;
+		bool gpioint = agpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT;
+		int pin_index;
 
+		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
+			lookup->index++;
+
+		if (lookup->n++ != lookup->index)
+			return 1;
+
+		pin_index = lookup->pin_index;
 		if (pin_index >= agpio->pin_table_length)
 			return 1;
 
 		lookup->desc = acpi_get_gpiod(agpio->resource_source.string_ptr,
 					      agpio->pin_table[pin_index]);
-		lookup->info.gpioint =
-			agpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT;
+		lookup->info.gpioint = gpioint;
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1e89c688139f..7af06794e6fd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1020,6 +1020,8 @@ struct acpi_gpio_mapping {
 
 /* Ignore IoRestriction field */
 #define ACPI_GPIO_QUIRK_NO_IO_RESTRICTION	BIT(0)
+/* Choose one of GpioIo() type */
+#define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
 
 	unsigned int quirks;
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b618d984e2d5..5bfbbdc2a62a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -844,74 +844,18 @@ static const struct x86_cpu_id cherrytrail_cpu_ids[] = {
 	{}
 };
 
-static const struct acpi_gpio_params first_gpio = { 0, 0, false };
-static const struct acpi_gpio_params second_gpio = { 1, 0, false };
+static const struct acpi_gpio_params ext_amp_enable_gpios = { 0, 0, false };
 
-static const struct acpi_gpio_mapping byt_rt5651_amp_en_first[] = {
-	{ "ext-amp-enable-gpios", &first_gpio, 1 },
-	{ },
-};
-
-static const struct acpi_gpio_mapping byt_rt5651_amp_en_second[] = {
-	{ "ext-amp-enable-gpios", &second_gpio, 1 },
+static const struct acpi_gpio_mapping cht_rt5651_gpios[] = {
+	/*
+	 * Some boards have I2cSerialBusV2, GpioIo, GpioInt as ACPI resources, other
+	 * boards may  have I2cSerialBusV2, GpioInt, GpioIo instead. We want the
+	 * GpioIo one for the ext-amp-enable-gpio. That's why quirk is enabled.
+	 */
+	{ "ext-amp-enable-gpios", &ext_amp_enable_gpios, 1, ACPI_GPIO_QUIRK_ONLY_GPIOIO },
 	{ },
 };
 
-/*
- * Some boards have I2cSerialBusV2, GpioIo, GpioInt as ACPI resources, other
- * boards may  have I2cSerialBusV2, GpioInt, GpioIo instead. We want the
- * GpioIo one for the ext-amp-enable-gpio and both count for the index in
- * acpi_gpio_params index.  So we have 2 different mappings and the code
- * below figures out which one to use.
- */
-struct byt_rt5651_acpi_resource_data {
-	int gpio_count;
-	int gpio_int_idx;
-};
-
-static int snd_byt_rt5651_acpi_resource(struct acpi_resource *ares, void *arg)
-{
-	struct byt_rt5651_acpi_resource_data *data = arg;
-
-	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
-		return 0;
-
-	if (ares->data.gpio.connection_type == ACPI_RESOURCE_GPIO_TYPE_INT)
-		data->gpio_int_idx = data->gpio_count;
-
-	data->gpio_count++;
-	return 0;
-}
-
-static void snd_byt_rt5651_mc_pick_amp_en_gpio_mapping(struct device *codec)
-{
-	struct byt_rt5651_acpi_resource_data data = { 0, -1 };
-	LIST_HEAD(resources);
-	int ret;
-
-	ret = acpi_dev_get_resources(ACPI_COMPANION(codec), &resources,
-				     snd_byt_rt5651_acpi_resource, &data);
-	if (ret < 0) {
-		dev_warn(codec, "Failed to get ACPI resources, not adding external amplifier GPIO mapping\n");
-		return;
-	}
-
-	/* All info we need is gathered during the walk */
-	acpi_dev_free_resource_list(&resources);
-
-	switch (data.gpio_int_idx) {
-	case 0:
-		byt_rt5651_gpios = byt_rt5651_amp_en_second;
-		break;
-	case 1:
-		byt_rt5651_gpios = byt_rt5651_amp_en_first;
-		break;
-	default:
-		dev_warn(codec, "Unknown GpioInt index %d, not adding external amplifier GPIO mapping\n",
-			 data.gpio_int_idx);
-	}
-}
-
 struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 	u64 aif_value;       /* 1: AIF1, 2: AIF2 */
 	u64 mclock_value;    /* usually 25MHz (0x17d7940), ignored */
@@ -1037,7 +981,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* Cherry Trail devices use an external amplifier enable gpio */
 	if (x86_match_cpu(cherrytrail_cpu_ids) && !byt_rt5651_gpios)
-		snd_byt_rt5651_mc_pick_amp_en_gpio_mapping(codec_dev);
+		byt_rt5651_gpios = cht_rt5651_gpios;
 
 	if (byt_rt5651_gpios) {
 		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
-- 
2.19.2

