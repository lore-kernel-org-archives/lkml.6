Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeDQTqJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:46:09 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:5876 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751878AbeDQTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:46:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EqAgDGTdZah8mZ6ERdhFR6KJkCgwOSa?=
 =?us-ascii?q?IE9OwsbEIQ+glwhNRcBAgEBAQEBAQIBAQIQAQEBCgsJCCgjDII1JAEKBEspAy8?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBARUCDUNqME9vARKFDahViEKCJYgGgVQ/gQ+CX?=
 =?us-ascii?q?YM/Aoc0AoxmiwIIgWGMWgKMSgEYkAuBJR4BgghwgxMJghcOCSmDHIpwUY5oAQE?=
X-IPAS-Result: =?us-ascii?q?A2EqAgDGTdZah8mZ6ERdhFR6KJkCgwOSaIE9OwsbEIQ+glw?=
 =?us-ascii?q?hNRcBAgEBAQEBAQIBAQIQAQEBCgsJCCgjDII1JAEKBEspAy8BAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARUCDUNqME9vARKFDahViEKCJYgGgVQ/gQ+CXYM/Aoc0AoxmiwI?=
 =?us-ascii?q?IgWGMWgKMSgEYkAuBJR4BgghwgxMJghcOCSmDHIpwUY5oAQE?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.48,464,1517896800";
   d="scan'208";a="1134609170"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: dell-smbios: Match on www.dell.com in OEM strings too
Date: Tue, 17 Apr 2018 14:45:56 -0500
Message-Id: <1523994356-9598-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey reported that some much older Dell systems don't support
the OEM string "Dell System" but instead supported www.dell.com
in OEM strings.

Match both of these to indicate that this driver is running on
a Dell system.

Reported-by: Sergey Kubushyn <ksi@koi8.net>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Tested-by: Sergey Kubushyn <ksi@koi8.net>
---
 drivers/platform/x86/dell-smbios-base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 2485c80..fbd6557 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -555,11 +555,15 @@ static void free_group(struct platform_device *pdev)
 
 static int __init dell_smbios_init(void)
 {
-	const struct dmi_device *valid;
+	const struct dmi_device *valid_dell_system;
+	const struct dmi_device *valid_www;
 	int ret, wmi, smm;
 
-	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
-	if (!valid) {
+	valid_dell_system =
+		dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
+	valid_www =
+		dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL);
+	if (!valid_dell_system && !valid_www) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
 	}
-- 
2.7.4
