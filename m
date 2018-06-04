Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeFDS0W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:26:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46274 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeFDS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:26:20 -0400
X-Google-Smtp-Source: ADUXVKKA1SQUrV60G+/vv3BIV3205dlLnJ/YH/xAXfsMGXYyk6n00WVYgXdwJYNA67QaUsZmOSsZJA==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: rjw@rjwysocki.net, lenb@kernel.org, ravisadineni@chromium.org,
        ravisadineni@google.com
Cc: dmitry.torokhov@gmail.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rajatja@google.com, bleung@google.com, furquan@chromium.org
Subject: [PATCH] ACPI LID: increment wakeup count only when notified.
Date: Mon,  4 Jun 2018 11:26:12 -0700
Message-Id: <20180604182612.72699-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ACPI LID increments wakeup count irrespective of the wake source.
This is because we call acpi_lid_initialize_state on every resume.
Userland deamons using wakeup_count to identify the potential wake
source for the last wake will be thrown off by this. Instead increment
the wakeup count only when there is a FIXED_HARDWARE/NOTFIY_STATUS event.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/acpi/button.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index f1cc4f9d31cd9..d40fef7241f08 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 		button->last_time = ktime_get();
 	}
 
-	if (state)
-		acpi_pm_wakeup_event(&device->dev);
-
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
 		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
@@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 		/* fall through */
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
+		acpi_pm_wakeup_event(&device->dev);
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
 			mutex_lock(&button->input->mutex);
 			users = button->input->users;
@@ -426,7 +424,6 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 		} else {
 			int keycode;
 
-			acpi_pm_wakeup_event(&device->dev);
 			if (button->suspended)
 				break;
 
-- 
2.17.1.1185.g55be947832-goog
