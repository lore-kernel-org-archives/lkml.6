Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbeFEWpF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:45:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44352 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeFEWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:45:03 -0400
X-Google-Smtp-Source: ADUXVKLqrvUM35meuLzPGZGFwRG+khHwT69037xDCgWPWmZgmDjUka6HK02scgtkaENOVfh1P/9qvQ==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: ravisadineni@google.com, dmitry.torokhov@gmail.com, dtor@google.com
Cc: tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH] Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
Date: Tue,  5 Jun 2018 15:44:57 -0700
Message-Id: <20180605224458.62692-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary check before calling pm_wakeup_event. If the
device is not wake enabled, this call is no-op anyway.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 30 ++++++++++-----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 489ddd37bd4ee..c5e32544130dc 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -242,19 +242,17 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	u32 val;
 	unsigned int ev_type;
 
+	/*
+	 * If not wake enabled, discard key state changes during
+	 * suspend. Switches will be re-checked in
+	 * cros_ec_keyb_resume() to be sure nothing is lost.
+	 */
+	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
+		return NOTIFY_OK;
+
 	switch (ckdev->ec->event_data.event_type) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
-		if (device_may_wakeup(ckdev->dev)) {
-			pm_wakeup_event(ckdev->dev, 0);
-		} else {
-			/*
-			 * If keyboard is not wake enabled, discard key state
-			 * changes during suspend. Switches will be re-checked
-			 * in cros_ec_keyb_resume() to be sure nothing is lost.
-			 */
-			if (queued_during_suspend)
-				return NOTIFY_OK;
-		}
+		pm_wakeup_event(ckdev->dev, 0);
 
 		if (ckdev->ec->event_size != ckdev->cols) {
 			dev_err(ckdev->dev,
@@ -268,10 +266,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 		break;
 
 	case EC_MKBP_EVENT_SYSRQ:
-		if (device_may_wakeup(ckdev->dev))
-			pm_wakeup_event(ckdev->dev, 0);
-		else if (queued_during_suspend)
-			return NOTIFY_OK;
+		pm_wakeup_event(ckdev->dev, 0);
 
 		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
 		dev_dbg(ckdev->dev, "sysrq code from EC: %#x\n", val);
@@ -280,10 +275,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 
 	case EC_MKBP_EVENT_BUTTON:
 	case EC_MKBP_EVENT_SWITCH:
-		if (device_may_wakeup(ckdev->dev))
-			pm_wakeup_event(ckdev->dev, 0);
-		else if (queued_during_suspend)
-			return NOTIFY_OK;
+		pm_wakeup_event(ckdev->dev, 0);
 
 		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
 			val = get_unaligned_le32(
-- 
2.18.0.rc1.242.g61856ae69a-goog
