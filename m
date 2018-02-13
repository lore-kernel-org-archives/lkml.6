Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965513AbeBMRNe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:13:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:59638 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965349AbeBMRAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="17603998"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 07/18] thunderbolt: Handle rejected Thunderbolt devices
Date: Tue, 13 Feb 2018 20:00:07 +0300
Message-Id: <20180213170018.9780-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ICM firmware may reject devices for different reasons, even if we
have asked it to accept anything. If we notice a device is rejected, we
just log the event and bail out.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c     | 6 ++++++
 drivers/thunderbolt/tb_msgs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 611d28e8e5f2..34d7740d1cbd 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -410,6 +410,12 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		ICM_LINK_INFO_DEPTH_SHIFT;
 	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
 
+	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
+		tb_info(tb, "switch at %u.%u was rejected by ICM firmware\n",
+			link, depth);
+		return;
+	}
+
 	ret = icm->get_route(tb, link, depth, &route);
 	if (ret) {
 		tb_err(tb, "failed to find route string for switch at %u.%u\n",
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index b0a092baa605..476bc04cac6c 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -176,6 +176,7 @@ struct icm_fr_event_device_connected {
 #define ICM_LINK_INFO_DEPTH_SHIFT	4
 #define ICM_LINK_INFO_DEPTH_MASK	GENMASK(7, 4)
 #define ICM_LINK_INFO_APPROVED		BIT(8)
+#define ICM_LINK_INFO_REJECTED		BIT(9)
 
 struct icm_fr_pkg_approve_device {
 	struct icm_pkg_header hdr;
-- 
2.15.1
