Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeB1GsT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:48:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeB1GsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:48:18 -0500
From: Alex Hung <alex.hung@canonical.com>
To: jdelvare@suse.com, alex.hung@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH][V2] firmware: dmi_scan: add DMI_OEM_STRING support to dmi_matches
Date: Tue, 27 Feb 2018 22:48:14 -0800
Message-Id: <1519800494-32107-1-git-send-email-alex.hung@canonical.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OEM strings are defined by each OEM and they contain customized and
useful OEM information. Supporting it provides more flexible uses of
the dmi_matches function.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/firmware/dmi_scan.c     | 11 +++++++++--
 include/linux/mod_devicetable.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index e763e14..c712e66 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -775,7 +775,15 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
 		int s = dmi->matches[i].slot;
 		if (s == DMI_NONE)
 			break;
-		if (dmi_ident[s]) {
+		if (s == DMI_OEM_STRING) {
+			/* DMI_OEM_STRING must be exact match */
+			const struct dmi_device *valid;
+
+			valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
+						dmi->matches[i].substr, NULL);
+			if (valid)
+				continue;
+		} else if (dmi_ident[s]) {
 			if (dmi->matches[i].exact_match) {
 				if (!strcmp(dmi_ident[s],
 					    dmi->matches[i].substr))
@@ -786,7 +794,6 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
 					continue;
 			}
 		}
-
 		/* No match */
 		return false;
 	}
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 48fb2b4..7d361be 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -502,6 +502,7 @@ enum dmi_field {
 	DMI_CHASSIS_SERIAL,
 	DMI_CHASSIS_ASSET_TAG,
 	DMI_STRING_MAX,
+	DMI_OEM_STRING,	/* special case - will not be in dmi_ident */
 };
 
 struct dmi_strmatch {
-- 
2.7.4
