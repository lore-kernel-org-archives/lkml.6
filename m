Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EC3C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCD62186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfBFNRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:17:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:26739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbfBFNRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="120384278"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2019 05:17:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A3D5A141; Wed,  6 Feb 2019 15:17:38 +0200 (EET)
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
Subject: [PATCH v2 03/28] thunderbolt: Enable TMU access when accessing port space on legacy devices
Date:   Wed,  6 Feb 2019 16:17:13 +0300
Message-Id: <20190206131738.43696-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Light Ridge and Eagle Ridge both need to have TMU access enabled before
port space can be fully accessed so make sure it happens on those. This
allows us to get rid of the offset quirk in tb_port_find_cap().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/cap.c | 74 ++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/thunderbolt/cap.c b/drivers/thunderbolt/cap.c
index 9553305c63ea..0de548bda663 100644
--- a/drivers/thunderbolt/cap.c
+++ b/drivers/thunderbolt/cap.c
@@ -13,6 +13,7 @@
 
 #define CAP_OFFSET_MAX		0xff
 #define VSE_CAP_OFFSET_MAX	0xffff
+#define TMU_ACCESS_EN		BIT(20)
 
 struct tb_cap_any {
 	union {
@@ -22,28 +23,43 @@ struct tb_cap_any {
 	};
 } __packed;
 
-/**
- * tb_port_find_cap() - Find port capability
- * @port: Port to find the capability for
- * @cap: Capability to look
- *
- * Returns offset to start of capability or %-ENOENT if no such
- * capability was found. Negative errno is returned if there was an
- * error.
- */
-int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
+static int tb_port_enable_tmu(struct tb_port *port, bool enable)
 {
-	u32 offset;
+	struct tb_switch *sw = port->sw;
+	u32 value, offset;
+	int ret;
 
 	/*
-	 * DP out adapters claim to implement TMU capability but in
-	 * reality they do not so we hard code the adapter specific
-	 * capability offset here.
+	 * Legacy devices need to have TMU access enabled before port
+	 * space can be fully accessed.
 	 */
-	if (port->config.type == TB_TYPE_DP_HDMI_OUT)
-		offset = 0x39;
+	switch (sw->config.device_id) {
+	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
+		offset = 0x26;
+		break;
+	case PCI_DEVICE_ID_INTEL_EAGLE_RIDGE:
+		offset = 0x2a;
+		break;
+
+	default:
+		return 0;
+	}
+
+	ret = tb_sw_read(sw, &value, TB_CFG_SWITCH, offset, 1);
+	if (ret)
+		return ret;
+
+	if (enable)
+		value |= TMU_ACCESS_EN;
 	else
-		offset = 0x1;
+		value &= ~TMU_ACCESS_EN;
+
+	return tb_sw_write(sw, &value, TB_CFG_SWITCH, offset, 1);
+}
+
+static int __tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
+{
+	u32 offset = 1;
 
 	do {
 		struct tb_cap_any header;
@@ -62,6 +78,30 @@ int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
 	return -ENOENT;
 }
 
+/**
+ * tb_port_find_cap() - Find port capability
+ * @port: Port to find the capability for
+ * @cap: Capability to look
+ *
+ * Returns offset to start of capability or %-ENOENT if no such
+ * capability was found. Negative errno is returned if there was an
+ * error.
+ */
+int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
+{
+	int ret;
+
+	ret = tb_port_enable_tmu(port, true);
+	if (ret)
+		return ret;
+
+	ret = __tb_port_find_cap(port, cap);
+
+	tb_port_enable_tmu(port, false);
+
+	return ret;
+}
+
 static int tb_switch_find_cap(struct tb_switch *sw, enum tb_switch_cap cap)
 {
 	int offset = sw->config.first_cap_offset;
-- 
2.20.1

