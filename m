Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeDSOWB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:22:01 -0400
Received: from sauhun.de ([88.99.104.3]:45416 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeDSOG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:59 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 21/61] input: misc: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:51 +0200
Message-Id: <20180419140641.27926-22-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/input/misc/max77693-haptic.c  | 6 ++----
 drivers/input/misc/max8997_haptic.c   | 3 +--
 drivers/input/misc/palmas-pwrbutton.c | 6 ++----
 drivers/input/misc/regulator-haptic.c | 6 ++----
 drivers/input/misc/twl4030-vibra.c    | 3 +--
 drivers/input/misc/twl6040-vibra.c    | 3 +--
 6 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 46b0f48fbf49..8968fd48e95c 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -381,8 +381,7 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 
 static int __maybe_unused max77693_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max77693_haptic *haptic = platform_get_drvdata(pdev);
+	struct max77693_haptic *haptic = dev_get_drvdata(dev);
 
 	if (haptic->enabled) {
 		max77693_haptic_disable(haptic);
@@ -394,8 +393,7 @@ static int __maybe_unused max77693_haptic_suspend(struct device *dev)
 
 static int __maybe_unused max77693_haptic_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max77693_haptic *haptic = platform_get_drvdata(pdev);
+	struct max77693_haptic *haptic = dev_get_drvdata(dev);
 
 	if (haptic->suspend_state) {
 		max77693_haptic_enable(haptic);
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index 99bc762881d5..5ffb0ac68d50 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -388,8 +388,7 @@ static int max8997_haptic_remove(struct platform_device *pdev)
 
 static int __maybe_unused max8997_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max8997_haptic *chip = platform_get_drvdata(pdev);
+	struct max8997_haptic *chip = dev_get_drvdata(dev);
 
 	max8997_haptic_disable(chip);
 
diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 1e1baed63929..27617868b292 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -270,8 +270,7 @@ static int palmas_pwron_remove(struct platform_device *pdev)
  */
 static int __maybe_unused palmas_pwron_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
+	struct palmas_pwron *pwron = dev_get_drvdata(dev);
 
 	cancel_delayed_work_sync(&pwron->input_work);
 
@@ -291,8 +290,7 @@ static int __maybe_unused palmas_pwron_suspend(struct device *dev)
  */
 static int __maybe_unused palmas_pwron_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
+	struct palmas_pwron *pwron = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(pwron->irq);
diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index a1db1e5040dc..0b78a87f3192 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -206,8 +206,7 @@ static int regulator_haptic_probe(struct platform_device *pdev)
 
 static int __maybe_unused regulator_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct regulator_haptic *haptic = platform_get_drvdata(pdev);
+	struct regulator_haptic *haptic = dev_get_drvdata(dev);
 	int error;
 
 	error = mutex_lock_interruptible(&haptic->mutex);
@@ -225,8 +224,7 @@ static int __maybe_unused regulator_haptic_suspend(struct device *dev)
 
 static int __maybe_unused regulator_haptic_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct regulator_haptic *haptic = platform_get_drvdata(pdev);
+	struct regulator_haptic *haptic = dev_get_drvdata(dev);
 	unsigned int magnitude;
 
 	mutex_lock(&haptic->mutex);
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index c37aea9ac272..7b9104c058ca 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -159,8 +159,7 @@ static void twl4030_vibra_close(struct input_dev *input)
 /*** Module ***/
 static int __maybe_unused twl4030_vibra_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct vibra_info *info = platform_get_drvdata(pdev);
+	struct vibra_info *info = dev_get_drvdata(dev);
 
 	if (info->enabled)
 		vibra_disable(info);
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 15e0d352c4cc..c8539a4a98c6 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -226,8 +226,7 @@ static void twl6040_vibra_close(struct input_dev *input)
 
 static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct vibra_info *info = platform_get_drvdata(pdev);
+	struct vibra_info *info = dev_get_drvdata(dev);
 
 	cancel_work_sync(&info->play_work);
 
-- 
2.11.0
