Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeDEN0d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:26:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751519AbeDENZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:57 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 7/8] Input: elantech - detect new ICs and setup Host Notify for them
Date: Thu,  5 Apr 2018 15:25:36 +0200
Message-Id: <20180405132537.3218-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New ICs are using a different scheme for the alternate bus parameter.
Given that they are new and are only using either PS2 only or PS2 + SMBus
Host Notify, we force those new ICs to use the SMBus solution for enhanced
reporting.

This allows the touchpad found on the Lenovo T480s to report 5 fingers
every 8 ms, instead of having a limit of 2 every 8 ms.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 11 +++++++----
 drivers/input/mouse/elantech.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index a61fbddd6b92..29f55e8e07e9 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1789,11 +1789,11 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 
 	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
 		/*
-		 * FIXME:
-		 * constraint the I2C capable devices by using FW version,
-		 * board version, or by using DMI matching
+		 * New ICs are enabled by default.
+		 * Old ICs are up to the user to decide.
 		 */
-		return -ENXIO;
+		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+			return -ENXIO;
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
@@ -1814,6 +1814,9 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 static bool elantech_use_host_notify(struct psmouse *psmouse,
 				     struct elantech_device_info *info)
 {
+	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		return true;
+
 	switch (info->bus) {
 	case ETP_BUS_PS2_ONLY:
 		/* expected case */
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index f9b1c485e8d9..119727085a60 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -115,6 +115,21 @@
 #define ETP_BUS_PS2_SMB_ALERT		3
 #define ETP_BUS_PS2_SMB_HST_NTFY	4
 
+/*
+ * New ICs are either using SMBus Host Notify or just plain PS2.
+ *
+ * ETP_FW_VERSION_QUERY is:
+ * Byte 1:
+ *  - bit 0..3: IC BODY
+ * Byte 2:
+ *  - bit 4: HiddenButton
+ *  - bit 5: PS2_SMBUS_NOTIFY
+ *  - bit 6: PS2CRCCheck
+ */
+#define ETP_NEW_IC_SMBUS_HOST_NOTIFY(fw_version)	\
+		((((fw_version) & 0x0f2000) == 0x0f2000) && \
+		 ((fw_version) & 0x0000ff) > 0)
+
 /*
  * The base position for one finger, v4 hardware
  */
-- 
2.14.3
