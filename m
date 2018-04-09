Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeDIJLZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:11:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeDIJLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:11:21 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 8/9] Input: elantech - detect new ICs and setup Host Notify for them
Date: Mon,  9 Apr 2018 11:10:50 +0200
Message-Id: <20180409091051.2944-9-benjamin.tissoires@redhat.com>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
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
no changes in v2

 drivers/input/mouse/elantech.c | 11 +++++++----
 drivers/input/mouse/elantech.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 510e7c0622d3..07e40a58e66c 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1793,11 +1793,11 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 
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
@@ -1818,6 +1818,9 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
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
