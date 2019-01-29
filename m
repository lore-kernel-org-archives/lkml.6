Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9810CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4CE2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfA2PFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:05:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:7039 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbfA2PBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="134112124"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2019 07:01:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 62DD537B; Tue, 29 Jan 2019 17:01:44 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH 05/28] thunderbolt: Move LC specific functionality into a separate file
Date:   Tue, 29 Jan 2019 18:01:20 +0300
Message-Id: <20190129150143.12681-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be adding more link controller functionality in subsequent
patches and it does not make sense to keep all that in switch.c, so
separate LC functionality into its own file.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/Makefile  |  2 +-
 drivers/thunderbolt/lc.c      | 21 +++++++++++++++++++++
 drivers/thunderbolt/switch.c  | 12 +++++++-----
 drivers/thunderbolt/tb.h      |  3 +++
 drivers/thunderbolt/tb_regs.h |  2 ++
 5 files changed, 34 insertions(+), 6 deletions(-)
 create mode 100644 drivers/thunderbolt/lc.c

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index f2f0de27252b..8531f15d3b3c 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,3 +1,3 @@
 obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
 thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o eeprom.o
-thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o
+thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o
diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
new file mode 100644
index 000000000000..2134a55ed837
--- /dev/null
+++ b/drivers/thunderbolt/lc.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Thunderbolt link controller support
+ *
+ * Copyright (C) 2019, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#include "tb.h"
+
+/**
+ * tb_lc_read_uuid() - Read switch UUID from link controller common register
+ * @sw: Switch whose UUID is read
+ * @uuid: UUID is placed here
+ */
+int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid)
+{
+	if (!sw->cap_lc)
+		return -EINVAL;
+	return tb_sw_read(sw, uuid, TB_CFG_SWITCH, sw->cap_lc + TB_LC_FUSE, 4);
+}
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a90d21abed88..bd96eebd8248 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1207,6 +1207,10 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 	}
 	sw->cap_plug_events = cap;
 
+	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
+	if (cap > 0)
+		sw->cap_lc = cap;
+
 	/* Root switch is always authorized */
 	if (!route)
 		sw->authorized = true;
@@ -1303,7 +1307,7 @@ int tb_switch_configure(struct tb_switch *sw)
 static void tb_switch_set_uuid(struct tb_switch *sw)
 {
 	u32 uuid[4];
-	int cap;
+	int ret;
 
 	if (sw->uuid)
 		return;
@@ -1312,10 +1316,8 @@ static void tb_switch_set_uuid(struct tb_switch *sw)
 	 * The newer controllers include fused UUID as part of link
 	 * controller specific registers
 	 */
-	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
-	if (cap > 0) {
-		tb_sw_read(sw, uuid, TB_CFG_SWITCH, cap + 3, 4);
-	} else {
+	ret = tb_lc_read_uuid(sw, uuid);
+	if (ret) {
 		/*
 		 * ICM generates UUID based on UID and fills the upper
 		 * two words with ones. This is not strictly following
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5faec5a8eb98..530464b25dcb 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -63,6 +63,7 @@ struct tb_switch_nvm {
  * @device_name: Name of the device (or %NULL if not known)
  * @generation: Switch Thunderbolt generation
  * @cap_plug_events: Offset to the plug events capability (%0 if not found)
+ * @cap_lc: Offset to the link controller capability (%0 if not found)
  * @is_unplugged: The switch is going away
  * @drom: DROM of the switch (%NULL if not found)
  * @nvm: Pointer to the NVM if the switch has one (%NULL otherwise)
@@ -98,6 +99,7 @@ struct tb_switch {
 	const char *device_name;
 	unsigned int generation;
 	int cap_plug_events;
+	int cap_lc;
 	bool is_unplugged;
 	u8 *drom;
 	struct tb_switch_nvm *nvm;
@@ -448,6 +450,7 @@ bool tb_path_is_invalid(struct tb_path *path);
 int tb_drom_read(struct tb_switch *sw);
 int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
 
+int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
 
 static inline int tb_route_length(u64 route)
 {
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 6f1ff04ee195..4895ae9f0b40 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -237,5 +237,7 @@ struct tb_regs_hop {
 	u32 unknown3:4; /* set to zero */
 } __packed;
 
+/* Common link controller registers */
+#define TB_LC_FUSE			0x03
 
 #endif
-- 
2.20.1

