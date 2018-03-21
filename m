Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCULan (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:30:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40382 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeCULaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:30:35 -0400
X-Google-Smtp-Source: AG47ELu+u3PWsabbCF0McfCWZGeElJlVi2dox5o+3lFvIm4rMMRhLjBi/pPZ5z+nfhTjFgU1WP7uJg==
From: Baolin Wang <baolin.wang@linaro.org>
To: rjw@rjwysocki.net, lenb@kernel.org, pavel@ucw.cz
Cc: andrew.smirnov@gmail.com, akpm@linux-foundation.org,
        broonie@kernel.org, arnd@arndb.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 1/2] ACPI / PM: Use register_reboot_notifier() instead of pm_power_off_prepare
Date: Wed, 21 Mar 2018 19:30:16 +0800
Message-Id: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can register one notifier through register_reboot_notifier() function to
prepare to power off the system, then we can remove the 'pm_power_off_prepare'
hook in following patch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Note: Please help to review carefully, since I have no platform to test
this conversion.

I saw there is another reboot notifier in this driver, I am not sure the
orders between them. I can change the priority of notifier to keep their
orders if it is necessary.
---
 drivers/acpi/sleep.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 46cde091..b3de894 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1229,14 +1229,24 @@ static void acpi_sleep_hibernate_setup(void)
 static inline void acpi_sleep_hibernate_setup(void) {}
 #endif /* !CONFIG_HIBERNATION */
 
-static void acpi_power_off_prepare(void)
+static int acpi_reboot_notify(struct notifier_block *this, unsigned long code,
+			      void *x)
 {
-	/* Prepare to power off the system */
-	acpi_sleep_prepare(ACPI_STATE_S5);
-	acpi_disable_all_gpes();
-	acpi_os_wait_events_complete();
+	if (code == SYSTEM_POWER_OFF) {
+		/* Prepare to power off the system */
+		acpi_sleep_prepare(ACPI_STATE_S5);
+		acpi_disable_all_gpes();
+		acpi_os_wait_events_complete();
+	}
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block acpi_reboot_notifier = {
+	.notifier_call	= acpi_reboot_notify,
+	.priority	= 0,
+};
+
 static void acpi_power_off(void)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
@@ -1261,7 +1271,7 @@ int __init acpi_sleep_init(void)
 
 	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
 		sleep_states[ACPI_STATE_S5] = 1;
-		pm_power_off_prepare = acpi_power_off_prepare;
+		register_reboot_notifier(&acpi_reboot_notifier);
 		pm_power_off = acpi_power_off;
 	} else {
 		acpi_no_s5 = true;
-- 
1.7.9.5
