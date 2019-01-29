Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC83C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485BF2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfA2PBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:01:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:7039 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbfA2PBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="142391801"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2019 07:01:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7A4E0404; Tue, 29 Jan 2019 17:01:44 +0200 (EET)
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
Subject: [PATCH 07/28] thunderbolt: Set sleep bit when suspending switch
Date:   Tue, 29 Jan 2019 18:01:22 +0300
Message-Id: <20190129150143.12681-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt 2 devices and beyond link controller needs to be notified
when a switch is going to be suspended by setting bit 31 in LC_SX_CTRL
register. Add this functionality to the software connection manager.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/lc.c      | 44 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c  |  6 ++---
 drivers/thunderbolt/tb.h      |  1 +
 drivers/thunderbolt/tb_regs.h |  2 ++
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index a5dddf176546..ae1e92611c3e 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -133,3 +133,47 @@ void tb_lc_unconfigure_link(struct tb_switch *sw)
 	tb_lc_configure_lane(up, false);
 	tb_lc_configure_lane(down, false);
 }
+
+/**
+ * tb_lc_set_sleep() - Inform LC that the switch is going to sleep
+ * @sw: Switch to set sleep
+ *
+ * Let the switch link controllers know that the switch is going to
+ * sleep.
+ */
+int tb_lc_set_sleep(struct tb_switch *sw)
+{
+	int start, size, nlc, ret, i;
+	u32 desc;
+
+	if (sw->generation < 2)
+		return 0;
+
+	ret = read_lc_desc(sw, &desc);
+	if (ret)
+		return ret;
+
+	/* Figure out number of link controllers */
+	nlc = desc & TB_LC_DESC_NLC_MASK;
+	start = (desc & TB_LC_DESC_SIZE_MASK) >> TB_LC_DESC_SIZE_SHIFT;
+	size = (desc & TB_LC_DESC_PORT_SIZE_MASK) >> TB_LC_DESC_PORT_SIZE_SHIFT;
+
+	/* For each link controller set sleep bit */
+	for (i = 0; i < nlc; i++) {
+		unsigned int offset = sw->cap_lc + start + i * size;
+		u32 ctrl;
+
+		ret = tb_sw_read(sw, &ctrl, TB_CFG_SWITCH,
+				 offset + TB_LC_SX_CTRL, 1);
+		if (ret)
+			return ret;
+
+		ctrl |= TB_LC_SX_CTRL_SLP;
+		ret = tb_sw_write(sw, &ctrl, TB_CFG_SWITCH,
+				  offset + TB_LC_SX_CTRL, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 760332f57b5c..1eee2502b5ba 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1604,10 +1604,8 @@ void tb_switch_suspend(struct tb_switch *sw)
 		if (!tb_is_upstream_port(&sw->ports[i]) && sw->ports[i].remote)
 			tb_switch_suspend(sw->ports[i].remote->sw);
 	}
-	/*
-	 * TODO: invoke tb_cfg_prepare_to_sleep here? does not seem to have any
-	 * effect?
-	 */
+
+	tb_lc_set_sleep(sw);
 }
 
 struct tb_sw_lookup {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e61c2409021d..3160169389cc 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -453,6 +453,7 @@ int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
 int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
 int tb_lc_configure_link(struct tb_switch *sw);
 void tb_lc_unconfigure_link(struct tb_switch *sw);
+int tb_lc_set_sleep(struct tb_switch *sw);
 
 static inline int tb_route_length(u64 route)
 {
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index e0f867dad5cf..1ab6e0fb31c0 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -239,6 +239,7 @@ struct tb_regs_hop {
 
 /* Common link controller registers */
 #define TB_LC_DESC			0x02
+#define TB_LC_DESC_NLC_MASK		GENMASK(3, 0)
 #define TB_LC_DESC_SIZE_SHIFT		8
 #define TB_LC_DESC_SIZE_MASK		GENMASK(15, 8)
 #define TB_LC_DESC_PORT_SIZE_SHIFT	16
@@ -250,5 +251,6 @@ struct tb_regs_hop {
 #define TB_LC_SX_CTRL_L1C		BIT(16)
 #define TB_LC_SX_CTRL_L2C		BIT(20)
 #define TB_LC_SX_CTRL_UPSTREAM		BIT(30)
+#define TB_LC_SX_CTRL_SLP		BIT(31)
 
 #endif
-- 
2.20.1

