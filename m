Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449A5C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FE220823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfAUHZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:25:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55309 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfAUHZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:25:08 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1glTbp-0003RR-Vc; Mon, 21 Jan 2019 07:03:02 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     dmitry.torokhov@gmail.com
Cc:     benjamin.tissoires@redhat.com, kt.liao@emc.com.tw,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] Input: elantech: Enable SMBus on new (2018+) systems
Date:   Mon, 21 Jan 2019 15:02:58 +0800
Message-Id: <20190121070258.1844-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some new HP laptops with Elantech touchpad don't support
multitouch.

Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is
supported, but in addition to firmware version, the bus type also
informs us if the IC can support SMBus, so also check that.

In case of breaking old ICs, only enables SMBus on systems manufactured
after 2018, alongsides aforementioned checks.

Lastly, consolidats all check into elantech_use_host_notify() and use it
to determine whether to use PS/2 or SMBus.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Wording.
- Further restrain on older systems (< 2018).

 drivers/input/mouse/elantech.c | 63 ++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 9fe075c137dc..2594130b0079 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1799,6 +1799,39 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				  leave_breadcrumbs);
 }
 
+static bool elantech_use_host_notify(struct psmouse *psmouse,
+				     struct elantech_device_info *info)
+{
+	bool host_notify = false;
+
+	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		host_notify = true;
+	else {
+		switch (info->bus) {
+		case ETP_BUS_PS2_ONLY:
+			/* expected case */
+			break;
+		case ETP_BUS_SMB_ALERT_ONLY:
+			/* fall-through  */
+		case ETP_BUS_PS2_SMB_ALERT:
+			psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
+			break;
+		case ETP_BUS_SMB_HST_NTFY_ONLY:
+			/* fall-through  */
+		case ETP_BUS_PS2_SMB_HST_NTFY:
+			host_notify = true;
+			break;
+		default:
+			psmouse_dbg(psmouse,
+				    "Ignoring SMBus bus provider %d.\n",
+				    info->bus);
+		}
+	}
+
+	/* SMbus implementation is stable after 2018 */
+	return host_notify && (dmi_get_bios_year() >= 2018);
+}
+
 /**
  * elantech_setup_smbus - called once the PS/2 devices are enumerated
  * and decides to instantiate a SMBus InterTouch device.
@@ -1818,7 +1851,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 		 * i2c_blacklist_pnp_ids.
 		 * Old ICs are up to the user to decide.
 		 */
-		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
+		if (!elantech_use_host_notify(psmouse, info) ||
 		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
 			return -ENXIO;
 	}
@@ -1838,34 +1871,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 	return 0;
 }
 
-static bool elantech_use_host_notify(struct psmouse *psmouse,
-				     struct elantech_device_info *info)
-{
-	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
-		return true;
-
-	switch (info->bus) {
-	case ETP_BUS_PS2_ONLY:
-		/* expected case */
-		break;
-	case ETP_BUS_SMB_ALERT_ONLY:
-		/* fall-through  */
-	case ETP_BUS_PS2_SMB_ALERT:
-		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
-		break;
-	case ETP_BUS_SMB_HST_NTFY_ONLY:
-		/* fall-through  */
-	case ETP_BUS_PS2_SMB_HST_NTFY:
-		return true;
-	default:
-		psmouse_dbg(psmouse,
-			    "Ignoring SMBus bus provider %d.\n",
-			    info->bus);
-	}
-
-	return false;
-}
-
 int elantech_init_smbus(struct psmouse *psmouse)
 {
 	struct elantech_device_info info;
-- 
2.17.1

