Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E68AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F6220875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F6220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966451AbeFSNzY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:55:24 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:58250 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965681AbeFSNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:55:22 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 0dvL1y00V3XaVaC01dvL9n; Tue, 19 Jun 2018 15:55:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVH6O-0000Yu-CW; Tue, 19 Jun 2018 15:55:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVH6O-0002Lp-BR; Tue, 19 Jun 2018 15:55:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] regulator: bd9571mwv: Add support for toggle power switches
Date:   Tue, 19 Jun 2018 15:55:18 +0200
Message-Id: <20180619135518.8990-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619135518.8990-1-geert+renesas@glider.be>
References: <20180619135518.8990-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing support for backup mode to toggle power switches.
With a toggle power switch (or level signal), the following steps must
be followed exactly:
   1. Configure PMIC for backup mode,
   2. Switch accessory power switch off, to prepare for system suspend,
      which is a manual step not controlled by software,
   3. Suspend system,
   4. Switch accessory power switch on to wake up system.

Hence the PMIC is configured for backup mode when "enabled" is written
to the PMIC's "wakeup" virtual file in sysfs, using the newly introduced
callback for wake-up change notification.  Conversely, writing
"disabled" reverts the role of the accessory switch to a power switch.

Unlike with momentary switches, backup mode is not enabled by default,
as enabling it prevents the board from being powered off using the power
switch, which may confuse the user.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Improve patch description,
  - Drop "return;" at end of function.
---
 drivers/regulator/bd9571mwv-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index be574eb444ebda97..403bc3fa1f2513de 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -171,6 +171,24 @@ static int bd9571mwv_bkup_mode_write(struct bd9571mwv *bd, unsigned int mode)
 	return 0;
 }
 
+static void bd9571mwv_wakeup_change_notify(struct device *dev, bool enable)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+
+	unsigned int mode;
+	int ret;
+
+	ret = bd9571mwv_bkup_mode_read(bdreg->bd, &mode);
+	if (ret)
+		return;
+
+	mode &= ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+	if (enable)
+		mode |= bdreg->bkup_mode_cnt_keepon;
+
+	bd9571mwv_bkup_mode_write(bdreg->bd, mode);
+}
+
 static int bd9571mwv_suspend(struct device *dev)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
@@ -277,6 +295,11 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		 * explicit user setup in level mode.
 		 */
 		device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
+#ifdef CONFIG_PM_SLEEP
+		if (bdreg->rstbmode_level)
+			pdev->dev.power.wakeup_change_notify =
+				bd9571mwv_wakeup_change_notify;
+#endif /* CONFIG_PM_SLEEP */
 	}
 
 	return 0;
-- 
2.17.1

