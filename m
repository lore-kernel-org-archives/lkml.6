Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965424AbeBMRMS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:12:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:30085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965357AbeBMRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="29717764"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 17/18] thunderbolt: Introduce USB only (SL4) security level
Date: Tue, 13 Feb 2018 20:00:17 +0300
Message-Id: <20180213170018.9780-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new security level works so that it creates one PCIe tunnel to the
connected Thunderbolt dock, removing PCIe links downstream of the dock.
This leaves only the internal USB controller visible.

Display Port tunnels are created normally.

While there make sure security sysfs attribute returns "unknown" for any
future security level.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-thunderbolt | 3 +++
 drivers/thunderbolt/domain.c                    | 7 ++++++-
 include/linux/thunderbolt.h                     | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 4ed229789852..151584a1f950 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -35,6 +35,9 @@ Description:	This attribute holds current Thunderbolt security level
 			minimum. User needs to authorize each device.
 		dponly: Automatically tunnel Display port (and USB). No
 			PCIe tunnels are created.
+		usbonly: Automatically tunnel USB controller of the
+			 connected Thunderbolt dock (and Display Port). All
+			 PCIe links downstream of the dock are removed.
 
 What: /sys/bus/thunderbolt/devices/.../authorized
 Date:		Sep 2017
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index cc68faedf42a..526972227dd4 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -117,6 +117,7 @@ static const char * const tb_security_names[] = {
 	[TB_SECURITY_USER] = "user",
 	[TB_SECURITY_SECURE] = "secure",
 	[TB_SECURITY_DPONLY] = "dponly",
+	[TB_SECURITY_USBONLY] = "usbonly",
 };
 
 static ssize_t boot_acl_show(struct device *dev, struct device_attribute *attr,
@@ -226,8 +227,12 @@ static ssize_t security_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct tb *tb = container_of(dev, struct tb, dev);
+	const char *name = "unknown";
 
-	return sprintf(buf, "%s\n", tb_security_names[tb->security_level]);
+	if (tb->security_level < ARRAY_SIZE(tb_security_names))
+		name = tb_security_names[tb->security_level];
+
+	return sprintf(buf, "%s\n", name);
 }
 static DEVICE_ATTR_RO(security);
 
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 47251844d064..a3ed26082bc1 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -45,12 +45,16 @@ enum tb_cfg_pkg_type {
  * @TB_SECURITY_USER: User approval required at minimum
  * @TB_SECURITY_SECURE: One time saved key required at minimum
  * @TB_SECURITY_DPONLY: Only tunnel Display port (and USB)
+ * @TB_SECURITY_USBONLY: Only tunnel USB controller of the connected
+ *			 Thunderbolt dock (and Display Port). All PCIe
+ *			 links downstream of the dock are removed.
  */
 enum tb_security_level {
 	TB_SECURITY_NONE,
 	TB_SECURITY_USER,
 	TB_SECURITY_SECURE,
 	TB_SECURITY_DPONLY,
+	TB_SECURITY_USBONLY,
 };
 
 /**
-- 
2.15.1
