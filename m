Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFDA13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B6920873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B6920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeG3Kxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:53:35 -0400
Received: from ms.tdt.de ([195.243.126.94]:37798 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbeG3Kxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:53:35 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 06:53:34 EDT
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id A10DE200C6;
        Mon, 30 Jul 2018 09:11:14 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH] leds: add APU3 dmi information to leds-apu
Date:   Mon, 30 Jul 2018 11:11:08 +0200
Message-Id: <20180730091108.30098-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver should also get loaded if this is a APU3 from PC Engines.
It has the same pin layout for leds.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/leds/leds-apu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/leds/leds-apu.c b/drivers/leds/leds-apu.c
index 8c93d68964c7..1ed1c5a5dc77 100644
--- a/drivers/leds/leds-apu.c
+++ b/drivers/leds/leds-apu.c
@@ -134,6 +134,14 @@ static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
 		}
 	},
+	/* PC Engines APU3 with "Legancy" bios >= 4.0.7 */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU3")
+		}
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(dmi, apu_led_dmi_table);
@@ -229,6 +237,7 @@ static int __init apu_led_probe(struct platform_device *pdev)
 		apu_led->num_led_instances = ARRAY_SIZE(apu1_led_profile);
 		apu_led->iosize = APU1_IOSIZE;
 	} else if (dmi_match(DMI_BOARD_NAME, "APU2") ||
+		   dmi_match(DMI_BOARD_NAME, "APU3") ||
 		   dmi_match(DMI_BOARD_NAME, "apu2") ||
 		   dmi_match(DMI_BOARD_NAME, "PC Engines apu2")) {
 		apu_led->profile = apu2_led_profile;
@@ -258,6 +267,7 @@ static int __init apu_led_init(void)
 	}
 	if (!(dmi_match(DMI_PRODUCT_NAME, "APU") ||
 	      dmi_match(DMI_PRODUCT_NAME, "APU2") ||
+	      dmi_match(DMI_PRODUCT_NAME, "APU3") ||
 	      dmi_match(DMI_PRODUCT_NAME, "apu2") ||
 	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2"))) {
 		pr_err("Unknown PC Engines board: %s\n",
-- 
2.11.0

