Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030986AbeEZBO4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 21:14:56 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44558 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030816AbeEZBOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 21:14:54 -0400
X-Google-Smtp-Source: AB8JxZoNzpGYcqeRDxbAHZW/yboitwn0ljml4FmWQbikIdww5XM0d5+qoeiZMu4WKq4+2Isy00sjsw==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: dmitry.torokhov@gmail.com, lee.jones@linaro.org,
        ravisadineni@chromium.org, ravisadineni@google.com, dtor@google.com,
        briannorris@chromium.org
Cc: tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, rajatja@google.com, bleung@google.com
Subject: [PATCH V2] cros_ec_keyb: Mark cros_ec_keyb driver as wake enabled device.
Date: Fri, 25 May 2018 18:14:40 -0700
Message-Id: <20180526011440.102417-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180524234213.GE177107@dtor-ws>
References: <20180524234213.GE177107@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark cros_ec_keyb has wake enabled by default. If we see a MKBP event
related to keyboard,  call pm_wakeup_event() to make sure wakeup
triggers are accounted to keyb during suspend resume path.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
V2: Marked the ckdev as wake enabled instead of input devices.

 drivers/input/keyboard/cros_ec_keyb.c | 21 +++++++++++++++++----
 drivers/mfd/cros_ec.c                 | 19 +++++++------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 79eb29550c348..a7c96f0317123 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -245,12 +245,17 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	switch (ckdev->ec->event_data.event_type) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		/*
-		 * If EC is not the wake source, discard key state changes
+		 * If Keyb is not wake enabled, discard key state changes
 		 * during suspend.
 		 */
-		if (queued_during_suspend)
+		if (queued_during_suspend
+		    && !device_may_wakeup(ckdev->dev))
 			return NOTIFY_OK;
 
+		if (device_may_wakeup(ckdev->dev))
+			pm_wakeup_event(ckdev->dev, 0);
+
+
 		if (ckdev->ec->event_size != ckdev->cols) {
 			dev_err(ckdev->dev,
 				"Discarded incomplete key matrix event.\n");
@@ -265,18 +270,25 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
 		dev_dbg(ckdev->dev, "sysrq code from EC: %#x\n", val);
 		handle_sysrq(val);
+
+		if (device_may_wakeup(ckdev->dev))
+			pm_wakeup_event(ckdev->dev, 0);
 		break;
 
 	case EC_MKBP_EVENT_BUTTON:
 	case EC_MKBP_EVENT_SWITCH:
 		/*
-		 * If EC is not the wake source, discard key state
+		 * If keyb is not wake enabled, discard key state
 		 * changes during suspend. Switches will be re-checked in
 		 * cros_ec_keyb_resume() to be sure nothing is lost.
 		 */
-		if (queued_during_suspend)
+		if (queued_during_suspend
+		    && !device_may_wakeup(ckdev->dev))
 			return NOTIFY_OK;
 
+		if (device_may_wakeup(ckdev->dev))
+			pm_wakeup_event(ckdev->dev, 0);
+
 		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
 			val = get_unaligned_le32(
 					&ckdev->ec->event_data.data.buttons);
@@ -639,6 +651,7 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	device_init_wakeup(ckdev->dev, true);
 	return 0;
 }
 
diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index d61024141e2b6..36156a41499c9 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -229,7 +229,7 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 }
 EXPORT_SYMBOL(cros_ec_suspend);
 
-static void cros_ec_drain_events(struct cros_ec_device *ec_dev)
+static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 {
 	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
@@ -253,21 +253,16 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
 			ret);
 
-	/*
-	 * In some cases, we need to distinguish between events that occur
-	 * during suspend if the EC is not a wake source. For example,
-	 * keypresses during suspend should be discarded if it does not wake
-	 * the system.
-	 *
-	 * If the EC is not a wake source, drain the event queue and mark them
-	 * as "queued during suspend".
-	 */
 	if (ec_dev->wake_enabled) {
 		disable_irq_wake(ec_dev->irq);
 		ec_dev->wake_enabled = 0;
-	} else {
-		cros_ec_drain_events(ec_dev);
 	}
+	/*
+	 * Let the mfd devices know about events that occur during
+	 * suspend. This way the clients know what to do with them.
+	 */
+	cros_ec_report_events_during_suspend(ec_dev);
+
 
 	return 0;
 }
-- 
2.17.0.921.gf22659ad46-goog
