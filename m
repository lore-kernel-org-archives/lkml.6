Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeCaCIe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 22:08:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43736 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeCaCIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 22:08:32 -0400
X-Google-Smtp-Source: AIpwx49eq/awcOd4t3m5Rojwh9Os1Aeg9tKeDlb2rxorgf4YXljF3DdlXl4pj8/ViGEsA/m4uJi6pQ==
From: Chris Chiu <chiu@endlessm.com>
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] ACPI / PM: Fix wake up by PS2 keyboard fail on ASUS UX331UA
Date: Sat, 31 Mar 2018 10:08:23 +0800
Message-Id: <1522462103-84130-1-git-send-email-chiu@endlessm.com>
X-Mailer: git-send-email 2.5.4 (Apple Git-61)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue happens on new ASUS laptop UX331UA which has modern
standby mode (suspend-to-idle). Pressing keys on the PS2 keyboard
can't wake up the system from suspend-to-idle which is not expected.
However, pressing power button can wake up without problem.

Per the engineers of ASUS, the keypress event is routed to Embedded
Controller (EC) in standby mode. EC then signals the SCI event to
BIOS so BIOS would Notify() power button to wake up the system. It's
from BIOS perspective. What we observe here is that kernel receives
the SCI event from SCI interrupt handler which informs that the GPE
status bit belongs to EC needs to be handled and then queries the EC
to find out what event is pending. Then execute the following ACPI
_QDF method which defined in ACPI DSDT for EC to notify power button.

 Method (_QDF, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (PWRB, 0x80) // Status Change
        }

With more debug messages added to analyze this problem, we find that
the keypress does wake up the system from suspend-to-idle but it's back
to suspend again almost immediately. As we see in the following messages,
the acpi_button_notify() is invoked but acpi_pm_wakeup_event() can not
really wake up the system here because acpi_s2idle_wakeup() is false.
The acpi_s2idle_wakeup() returnd false because the acpi_s2idle_sync() has
alrealdy exited.

[   52.987048] s2idle_loop going s2idle
[   59.713392] acpi_s2idle_wake enter
[   59.713394] acpi_s2idle_wake exit
[   59.760888] acpi_ev_gpe_detect enter
[   59.760893] acpi_s2idle_sync enter
[   59.760893] acpi_ec_query_flushed ec pending queries 0
[   59.760953] Read registers for GPE 50-57: Status=01, Enable=01, RunEnable=01, WakeEnable=00
[   59.760955] ACPI: EC: ===== IRQ (1) =====
[   59.760972] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   59.760979] ACPI: EC: +++++ Polling enabled +++++
[   59.760979] ACPI: EC: ##### Command(QR_EC) submitted/blocked #####
[   59.761003] acpi_s2idle_sync exit
[   59.769587] ACPI: EC: ##### Query(0xdf) started #####
[   59.769611] ACPI: EC: ##### Query(0xdf) stopped #####
[   59.774154] acpi_button_notify button type 1
[   59.813175] s2idle_loop going s2idle

acpi_s2idle_sync() already makes an effort to flush the EC event
queue, but in this case, the EC event has yet to be generated when
the call to acpi_ec_flush_work() is made. The event is generated
shortly after, through the ongoing handling of the SCI interrupt
which is happening on another CPU, and we must synchronize that
to make sure that it has run and completed. Adding another call to
acpi_os_wait_events_complete() solves this issue, since that
function synchronizes with SCI interrupt completion.

Signed-off-by: Chris Chiu <chiu@endlessm.com>

https://phabricator.endlessm.com/T21599
---
 drivers/acpi/sleep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8082871..c6e1b4b 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -982,8 +982,9 @@ static void acpi_s2idle_sync(void)
 	 * The EC driver uses the system workqueue and an additional special
 	 * one, so those need to be flushed too.
 	 */
+	acpi_os_wait_events_complete();	/* synchronize SCI IRQ handling */
 	acpi_ec_flush_work();
-	acpi_os_wait_events_complete();
+	acpi_os_wait_events_complete();	/* synchronize Notify handling */
 	s2idle_wakeup = false;
 }
 
-- 
2.7.4
