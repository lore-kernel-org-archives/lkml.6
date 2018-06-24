Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AE0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9E620844
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9E620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dinapo.li
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeFXDWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 23:22:30 -0400
Received: from 45-63-23-208.nj.prd.rd2n.net ([45.63.23.208]:54884 "EHLO
        mail.rd2n.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeFXDW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 23:22:28 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jun 2018 23:22:28 EDT
Received: from [192.168.24.140] (c-76-124-26-104.hsd1.pa.comcast.net [76.124.26.104])
        by mail.rd2n.net (Postfix) with ESMTPSA id AE6F9200A9;
        Sat, 23 Jun 2018 23:17:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dinapo.li;
        s=selector1; t=1529810229;
        bh=7HHbRvq1yE7LoXrqmmxwYnmyOiA2pzb+Ft1gkg2IEoc=;
        h=From:Subject:Cc:Date:From;
        b=fvVo6Wil7hzilCh4lmY9AQkuhg8AtrY1nTHLvKcrxzRzfsBxF0PTz1+g0+N446QvZ
         ojjfLtZNPGPHFC40Cv7me/1+95yB7FLid2u7PRZBgZ4/Amtd5e+y38JDs/u3qSui4y
         leqFCOS4io5VF77tb7sNcJWVzoNrnYfqXQqDNBnFVdJ76YZUSJMOiK8S1okJQZpYq4
         tNPbsmhLGIkdrrVY4J0mIcs1P2tdGfgTwsaNApYWb+u1YDcdud646DX1snjywCneF4
         TmkA+fpTUb+3pebV1OXPGbAAyEbmUxpH1nRlN+Wekcu0nL7NMFXCoNabsTEU7FO2UX
         w7VHsBRRy2IqA==
From:   "Raffaello D. Di Napoli" <rafdev@dinapo.li>
Subject: [PATCH] leds: Modify PC Engines apu/apu2 driver to also support apu3
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Raffaello D. Di Napoli" <rafdev@dinapo.li>
Message-ID: <6f54ce4c-56e8-b683-cb1c-c186d3d298c4@dinapo.li>
Date:   Sat, 23 Jun 2018 23:17:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PC Engines apu3 is an improved version of the apu2, using the same SoC
and almost everything else.

This patch reuses as much as possible from the apu2 definitions, to
avoid redundancy.

Signed-off-by: Raffaello D. Di Napoli <rafdev@dinapo.li>
---
  drivers/leds/Kconfig    |  5 +++--
  drivers/leds/leds-apu.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
  2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6e3a998f..44097a3e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -57,12 +57,13 @@ config LEDS_AAT1290
  	depends on PINCTRL
  	help
  	 This option enables support for the LEDs on the AAT1290.
+
  config LEDS_APU
-	tristate "Front panel LED support for PC Engines APU/APU2 boards"
+	tristate "Front panel LED support for PC Engines APU/APU2/APU3 boards"
  	depends on LEDS_CLASS
  	depends on X86 && DMI
  	help
-	  This driver makes the PC Engines APU/APU2 front panel LEDs
+	  This driver makes the PC Engines APU/APU2/APU3 front panel LEDs
  	  accessible from userspace programs through the LED subsystem.
   	  To compile this driver as a module, choose M here: the
diff --git a/drivers/leds/leds-apu.c b/drivers/leds/leds-apu.c
index 8c93d689..8d42e46e 100644
--- a/drivers/leds/leds-apu.c
+++ b/drivers/leds/leds-apu.c
@@ -102,6 +102,13 @@ static const struct apu_led_profile 
apu2_led_profile[] = {
  	{ "apu2:green:3", LED_OFF, APU2_FCH_GPIO_BASE + 70 * APU2_IOSIZE },
  };
  +/* Same as apu2_led_profile, but with "3" in the LED names. */
+static const struct apu_led_profile apu3_led_profile[] = {
+	{ "apu3:green:1", LED_ON,  APU2_FCH_GPIO_BASE + 68 * APU2_IOSIZE },
+	{ "apu3:green:2", LED_OFF, APU2_FCH_GPIO_BASE + 69 * APU2_IOSIZE },
+	{ "apu3:green:3", LED_OFF, APU2_FCH_GPIO_BASE + 70 * APU2_IOSIZE },
+};
+
  static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
  	{
  		.ident = "apu",
@@ -134,6 +141,30 @@ static const struct dmi_system_id 
apu_led_dmi_table[] __initconst = {
  			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
  		}
  	},
+	/* PC Engines APU3 with "Legacy" bios < 4.0.8 */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU3")
+		}
+	},
+	/* PC Engines APU3 with "Legacy" bios >= 4.0.8 */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu3")
+		}
+	},
+	/* PC Engines APU2 with "Mainline" bios */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
+		}
+	},
  	{}
  };
  MODULE_DEVICE_TABLE(dmi, apu_led_dmi_table);
@@ -235,6 +266,14 @@ static int __init apu_led_probe(struct 
platform_device *pdev)
  		apu_led->platform = APU2_LED_PLATFORM;
  		apu_led->num_led_instances = ARRAY_SIZE(apu2_led_profile);
  		apu_led->iosize = APU2_IOSIZE;
+	} else if (dmi_match(DMI_BOARD_NAME, "APU3") ||
+		   dmi_match(DMI_BOARD_NAME, "apu3") ||
+		   dmi_match(DMI_BOARD_NAME, "PC Engines apu3")) {
+		apu_led->profile = apu3_led_profile;
+		/* Otherwise identical to APU2. */
+		apu_led->platform = APU2_LED_PLATFORM;
+		apu_led->num_led_instances = ARRAY_SIZE(apu3_led_profile);
+		apu_led->iosize = APU2_IOSIZE;
  	}
   	spin_lock_init(&apu_led->lock);
@@ -259,7 +298,10 @@ static int __init apu_led_init(void)
  	if (!(dmi_match(DMI_PRODUCT_NAME, "APU") ||
  	      dmi_match(DMI_PRODUCT_NAME, "APU2") ||
  	      dmi_match(DMI_PRODUCT_NAME, "apu2") ||
-	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2"))) {
+	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2") ||
+	      dmi_match(DMI_PRODUCT_NAME, "APU3") ||
+	      dmi_match(DMI_PRODUCT_NAME, "apu3") ||
+	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu3"))) {
  		pr_err("Unknown PC Engines board: %s\n",
  				dmi_get_system_info(DMI_PRODUCT_NAME));
  		return -ENODEV;
-- 
2.16.4

