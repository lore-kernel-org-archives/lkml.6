Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDTRmS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:42:18 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:52896 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752326AbeDTRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:42:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HHAAABJtpah2Ka6ERbhU4omGSDA5J4g?=
 =?us-ascii?q?XgLhGmCSCE0GAECAQEBAQEBAgEBAhABAQEIDQkIKC+CNSQBg0pPbwEShQ2pDYh?=
 =?us-ascii?q?BgimIBoFUP4hWhgsCjGmLCAiBYYxeAoxLAZApgSUcggtwgxOCLo4+UY0ggkYBA?=
 =?us-ascii?q?Q?=
X-IPAS-Result: =?us-ascii?q?A2HHAAABJtpah2Ka6ERbhU4omGSDA5J4gXgLhGmCSCE0GAE?=
 =?us-ascii?q?CAQEBAQEBAgEBAhABAQEIDQkIKC+CNSQBg0pPbwEShQ2pDYhBgimIBoFUP4hWh?=
 =?us-ascii?q?gsCjGmLCAiBYYxeAoxLAZApgSUcggtwgxOCLo4+UY0ggkYBAQ?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.49,302,1520917200";
   d="scan'208";a="1078926322"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: Kconfig: Fix dell-laptop dependency chain.
Date: Fri, 20 Apr 2018 12:42:11 -0500
Message-Id: <1524246131-17621-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Randy Dunlap:
>> WARNING: unmet direct dependencies detected for DELL_SMBIOS
>>   Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y]
>>	&& (DCDBAS [=m] ||
>> DCDBAS [=m]=n) && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
>>   Selected by [y]:
>>   - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]
>> && DMI [=y]
>> && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] ||
>>	ACPI_VIDEO [=n]=n)
>> && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y]
>>

Right now it's possible to set dell laptop to compile in but this
causes dell-smbios to compile in which breaks if dcdbas is a module.

Dell laptop shouldn't select dell-smbios anymore, but depend on it.

Fixes: 32d7b19 (platform/x86: dell-smbios: Resolve dependency error on DCDBAS)
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 39d06dd..bc309c5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -154,7 +154,7 @@ config DELL_LAPTOP
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL || RFKILL = n
 	depends on SERIO_I8042
-	select DELL_SMBIOS
+	depends on DELL_SMBIOS
 	select POWER_SUPPLY
 	select LEDS_CLASS
 	select NEW_LEDS
-- 
2.7.4
