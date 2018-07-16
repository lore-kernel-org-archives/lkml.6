Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE20BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74664208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74664208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeGPP6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:58:54 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:56042 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730890AbeGPP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:58:54 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id BTWu1y00C3XaVaC06TWulE; Mon, 16 Jul 2018 17:30:56 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1ff5Sg-0007Mq-2b; Mon, 16 Jul 2018 17:30:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ff5Sg-0000UK-1d; Mon, 16 Jul 2018 17:30:54 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 1/3] regulator: bd9571mwv: Use "backup_mode" sysfs file instead of "wake_up"
Date:   Mon, 16 Jul 2018 17:30:50 +0200
Message-Id: <20180716153052.1830-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716153052.1830-1-geert+renesas@glider.be>
References: <20180716153052.1830-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the BD9571MWV PMIC driver uses the standard "wake_up" sysfs
file to control enablement of DDR Backup Mode.

However, configuring DDR Backup Mode is not really equivalent to
configuring the PMIC as a wake-up source.  To avoid confusion, use a
custom "backup_mode" attribute file in sysfs instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Fix build error and warning if !CONFIG_PM_SLEEP,

v3:
  - New.
---
 drivers/regulator/bd9571mwv-regulator.c | 52 ++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index be574eb444ebda97..1da36a6590c84ba4 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -30,6 +30,7 @@ struct bd9571mwv_reg {
 	/* DDR Backup Power */
 	u8 bkup_mode_cnt_keepon;	/* from "rohm,ddr-backup-power" */
 	u8 bkup_mode_cnt_saved;
+	bool bkup_mode_enabled;
 
 	/* Power switch type */
 	bool rstbmode_level;
@@ -171,13 +172,40 @@ static int bd9571mwv_bkup_mode_write(struct bd9571mwv *bd, unsigned int mode)
 	return 0;
 }
 
+static ssize_t backup_mode_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", bdreg->bkup_mode_enabled ? "on" : "off");
+}
+
+static ssize_t backup_mode_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+	int ret;
+
+	if (!count)
+		return 0;
+
+	ret = kstrtobool(buf, &bdreg->bkup_mode_enabled);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+DEVICE_ATTR_RW(backup_mode);
+
 static int bd9571mwv_suspend(struct device *dev)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
 	unsigned int mode;
 	int ret;
 
-	if (!device_may_wakeup(dev))
+	if (!bdreg->bkup_mode_enabled)
 		return 0;
 
 	/* Save DDR Backup Mode */
@@ -204,7 +232,7 @@ static int bd9571mwv_resume(struct device *dev)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
 
-	if (!device_may_wakeup(dev))
+	if (!bdreg->bkup_mode_enabled)
 		return 0;
 
 	/* Restore DDR Backup Mode */
@@ -215,9 +243,15 @@ static const struct dev_pm_ops bd9571mwv_pm  = {
 	SET_SYSTEM_SLEEP_PM_OPS(bd9571mwv_suspend, bd9571mwv_resume)
 };
 
+static int bd9571mwv_regulator_remove(struct platform_device *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_backup_mode);
+	return 0;
+}
 #define DEV_PM_OPS	&bd9571mwv_pm
 #else
 #define DEV_PM_OPS	NULL
+#define bd9571mwv_regulator_remove	NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static int bd9571mwv_regulator_probe(struct platform_device *pdev)
@@ -270,14 +304,21 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_PM_SLEEP
 	if (bdreg->bkup_mode_cnt_keepon) {
-		device_set_wakeup_capable(&pdev->dev, true);
+		int ret;
+
 		/*
-		 * Wakeup is enabled by default in pulse mode, but needs
+		 * Backup mode is enabled by default in pulse mode, but needs
 		 * explicit user setup in level mode.
 		 */
-		device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
+		bdreg->bkup_mode_enabled = bdreg->rstbmode_pulse;
+
+		ret = device_create_file(&pdev->dev, &dev_attr_backup_mode);
+		if (ret)
+			return ret;
 	}
+#endif /* CONFIG_PM_SLEEP */
 
 	return 0;
 }
@@ -294,6 +335,7 @@ static struct platform_driver bd9571mwv_regulator_driver = {
 		.pm = DEV_PM_OPS,
 	},
 	.probe = bd9571mwv_regulator_probe,
+	.remove = bd9571mwv_regulator_remove,
 	.id_table = bd9571mwv_regulator_id_table,
 };
 module_platform_driver(bd9571mwv_regulator_driver);
-- 
2.17.1

