Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D4C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1A0218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfA3PO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:14:57 -0500
Received: from proxy01.fsdata.se ([89.221.252.211]:31031 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726332AbfA3PO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:14:56 -0500
Received: from localhost (94.234.42.28) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 30 Jan 2019 16:14:51
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <dvhart@infradead.org>, <andy@infradead.org>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] platform/x86: wmi: move struct wmi_device_id to mod_devicetable.h
Date:   Wed, 30 Jan 2019 16:14:38 +0100
Message-ID: <de9fb65f88eea485814d19d5708d70845e24032f.1548860212.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1548860212.git.2pi@mok.nu>
References: <cover.1548860212.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.42.28]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding WMI support to MODULE_DEVICE_TABLE() move the
definition of struct wmi_device_id to mod_devicetable.h and inline
guid_string in the struct.

Changing guid_string to an inline char array changes the loop conditions
when looping over an array of struct wmi_device_id. Therefore update
wmi_dev_match()'s loop to check for an empty guid_string instead of a
NULL pointer.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 drivers/platform/x86/wmi.c      |  2 +-
 include/linux/mod_devicetable.h | 12 ++++++++++++
 include/linux/wmi.h             |  5 +----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index b0f3d8ecd898..7b26b6ccf1a0 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -771,7 +771,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 	if (id == NULL)
 		return 0;
 
-	while (id->guid_string) {
+	while (*id->guid_string) {
 		uuid_le driver_guid;
 
 		if (WARN_ON(uuid_le_to_bin(id->guid_string, &driver_guid)))
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index f9bd2f34b99f..e44b90fa0aef 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -779,4 +779,16 @@ struct typec_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/* WMI */
+
+#define WMI_MODULE_PREFIX	"wmi:"
+
+/**
+ * struct wmi_device_id - WMI device identifier
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ */
+struct wmi_device_id {
+	const char guid_string[UUID_STRING_LEN+1];
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 4757cb5077e5..592f81afecbb 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -18,6 +18,7 @@
 
 #include <linux/device.h>
 #include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <uapi/linux/wmi.h>
 
 struct wmi_device {
@@ -39,10 +40,6 @@ extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
 
 extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
 
-struct wmi_device_id {
-	const char *guid_string;
-};
-
 struct wmi_driver {
 	struct device_driver driver;
 	const struct wmi_device_id *id_table;
-- 
2.20.1

