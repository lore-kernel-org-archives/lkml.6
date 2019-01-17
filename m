Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E11420856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfAQJ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:29:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35395 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfAQJ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:29:59 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gk3zk-0002Vd-UG; Thu, 17 Jan 2019 09:29:53 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     dmitry.torokhov@gmail.com
Cc:     benjamin.tissoires@redhat.com, kt.liao@emc.com.tw,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/1] Input: elantech: Use SMBus based on bus info
Date:   Thu, 17 Jan 2019 17:29:48 +0800
Message-Id: <20190117092948.32079-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some new HP laptops with Elantech touchpad don't support
multitouch.

Both ETP_BUS_SMB_HST_NTFY_ONLY and ETP_BUS_PS2_SMB_HST_NTFY devices can
use SMBus to support 5 fingers touch, so we need to chech them too.

So use elantech_use_host_notify() to do a more thouroughly check.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/mouse/elantech.c | 58 +++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 9fe075c137dc..5bcf1c147eb1 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1799,6 +1799,34 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				  leave_breadcrumbs);
 }
 
+static bool elantech_use_host_notify(struct psmouse *psmouse,
+				     struct elantech_device_info *info)
+{
+	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		return true;
+
+	switch (info->bus) {
+	case ETP_BUS_PS2_ONLY:
+		/* expected case */
+		break;
+	case ETP_BUS_SMB_ALERT_ONLY:
+		/* fall-through  */
+	case ETP_BUS_PS2_SMB_ALERT:
+		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
+		break;
+	case ETP_BUS_SMB_HST_NTFY_ONLY:
+		/* fall-through  */
+	case ETP_BUS_PS2_SMB_HST_NTFY:
+		return true;
+	default:
+		psmouse_dbg(psmouse,
+			    "Ignoring SMBus bus provider %d.\n",
+			    info->bus);
+	}
+
+	return false;
+}
+
 /**
  * elantech_setup_smbus - called once the PS/2 devices are enumerated
  * and decides to instantiate a SMBus InterTouch device.
@@ -1818,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 		 * i2c_blacklist_pnp_ids.
 		 * Old ICs are up to the user to decide.
 		 */
-		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
+		if (!elantech_use_host_notify(psmouse, info) ||
 		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
 			return -ENXIO;
 	}
@@ -1838,34 +1866,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
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

