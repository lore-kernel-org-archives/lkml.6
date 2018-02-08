Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeBHUKD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:10:03 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45673 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeBHUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:10:01 -0500
X-Google-Smtp-Source: AH8x225SWYAQAwjSZChDcQKMoKlBghjL40RgUbjoG6ZJdZ5rmAorUvy78pR0rVn5H9bdAikWNlD1NQ==
From: Carlo Caione <carlo@caione.org>
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
Date: Thu,  8 Feb 2018 20:09:52 +0000
Message-Id: <20180208200952.13111-1-carlo@caione.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

On at least one notebook (ECS EF20EA) the 'hp-detect' GPIO is defined in
the DSDT table by the ACPI GpioIo resources in _CRS. Add this mapping to
the rt5645 driver to enable the jack detection also on non-DT platforms.

Method (_CRS, 0, NotSerialized)
{
  Name (SBUF, ResourceTemplate ()
  {
    I2cSerialBusV2 (0x001A, ControllerInitiated, 0x00061A80,
        AddressingMode7Bit, "\\_SB.PCI0.I2C2",
        0x00, ResourceConsumer, , Exclusive,
        )
    GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x0000,
        "\\_SB.GPO3", 0x00, ResourceConsumer, ,
        )
        {   // Pin list
            0x004F
        }
    GpioIo (Shared, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
        "\\_SB.GPO3", 0x00, ResourceConsumer, ,
        )
        {   // Pin list
            0x004F
        }
  })
  Return (SBUF) /* \_SB_.PCI0.I2C2.RTK2._CRS.SBUF */
}

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/codecs/rt5645.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 8f140c8b93ac..7f2d83884556 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3764,6 +3764,13 @@ static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 	return 0;
 }
 
+static const struct acpi_gpio_params hp_detect_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping cht_rt5645_gpios[] = {
+	{ "hp-detect-gpios", &hp_detect_gpios, 1 },
+	{},
+};
+
 static int rt5645_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -3779,6 +3786,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	if (rt5645 == NULL)
 		return -ENOMEM;
 
+	if (ACPI_HANDLE(&i2c->dev))
+		if (devm_acpi_dev_add_driver_gpios(&i2c->dev, cht_rt5645_gpios))
+			dev_dbg(&i2c->dev, "Failed to add driver gpios\n");
+
 	rt5645->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5645);
 
-- 
2.14.1
