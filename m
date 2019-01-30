Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3241C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfA3PPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:15:23 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:33440 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3PPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:15:23 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 30 Jan
 2019 16:15:00 +0100
Received: from localhost (94.234.42.28) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 30 Jan 2019 16:15:05
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <mario.limonciello@dell.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <mjg59@srcf.ucam.org>, <pali.rohar@gmail.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
Date:   Wed, 30 Jan 2019 16:14:40 +0100
Message-ID: <830f6043839606c6ed04dfeaceeb0ce4d9cd1b54.1548860212.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1548860212.git.2pi@mok.nu>
References: <cover.1548860212.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.42.28]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WMI drivers can if they have specified an array of struct wmi_device_id
use the MODULE_DEVICE_TABLE() macro to automatically generate the
appropriate MODULE_ALIAS() output. Thus avoiding to keep both the array
of struct wmi_device_id and the MODULE_ALIAS() declaration(s) in sync.

Change all drivers that have specified an array of struct wmi_device_id
to use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS().

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell-smbios-wmi.c       | 2 +-
 drivers/platform/x86/dell-wmi-descriptor.c   | 2 +-
 drivers/platform/x86/dell-wmi.c              | 4 ++--
 drivers/platform/x86/huawei-wmi.c            | 3 +--
 drivers/platform/x86/intel-wmi-thunderbolt.c | 2 +-
 drivers/platform/x86/wmi-bmof.c              | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
index cf2229ece9ff..c3ed3c8c17b9 100644
--- a/drivers/platform/x86/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell-smbios-wmi.c
@@ -277,4 +277,4 @@ void exit_dell_smbios_wmi(void)
 	wmi_driver_unregister(&dell_smbios_wmi_driver);
 }
 
-MODULE_ALIAS("wmi:" DELL_WMI_SMBIOS_GUID);
+MODULE_DEVICE_TABLE(wmi, dell_smbios_wmi_id_table);
diff --git a/drivers/platform/x86/dell-wmi-descriptor.c b/drivers/platform/x86/dell-wmi-descriptor.c
index 072821aa47fc..14ab250b7d5a 100644
--- a/drivers/platform/x86/dell-wmi-descriptor.c
+++ b/drivers/platform/x86/dell-wmi-descriptor.c
@@ -207,7 +207,7 @@ static struct wmi_driver dell_wmi_descriptor_driver = {
 
 module_wmi_driver(dell_wmi_descriptor_driver);
 
-MODULE_ALIAS("wmi:" DELL_WMI_DESCRIPTOR_GUID);
+MODULE_DEVICE_TABLE(wmi, dell_wmi_descriptor_id_table);
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
 MODULE_DESCRIPTION("Dell WMI descriptor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 16c7f3d9a335..0602aba62b3f 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -50,8 +50,6 @@ MODULE_LICENSE("GPL");
 
 static bool wmi_requires_smbios_request;
 
-MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
-
 struct dell_wmi_priv {
 	struct input_dev *input_dev;
 	u32 interface_version;
@@ -738,3 +736,5 @@ static void __exit dell_wmi_exit(void)
 	wmi_driver_unregister(&dell_wmi_driver);
 }
 module_exit(dell_wmi_exit);
+
+MODULE_DEVICE_TABLE(wmi, dell_wmi_id_table);
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 59872f87b741..52fcac5b393a 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -201,8 +201,7 @@ static struct wmi_driver huawei_wmi_driver = {
 
 module_wmi_driver(huawei_wmi_driver);
 
-MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
-MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
+MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI hotkeys");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel-wmi-thunderbolt.c
index 9ded8e2af312..4dfa61434a76 100644
--- a/drivers/platform/x86/intel-wmi-thunderbolt.c
+++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
@@ -88,7 +88,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driver = {
 
 module_wmi_driver(intel_wmi_thunderbolt_driver);
 
-MODULE_ALIAS("wmi:" INTEL_WMI_THUNDERBOLT_GUID);
+MODULE_DEVICE_TABLE(wmi, intel_wmi_thunderbolt_id_table);
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
 MODULE_DESCRIPTION("Intel WMI Thunderbolt force power driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
index c4530ba715e8..8751a13134be 100644
--- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -119,7 +119,7 @@ static struct wmi_driver wmi_bmof_driver = {
 
 module_wmi_driver(wmi_bmof_driver);
 
-MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
+MODULE_DEVICE_TABLE(wmi, wmi_bmof_id_table);
 MODULE_AUTHOR("Andrew Lutomirski <luto@kernel.org>");
 MODULE_DESCRIPTION("WMI embedded Binary MOF driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

