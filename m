Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427681AbeCBMjI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:39:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:3940 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427644AbeCBMjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:39:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="38740370"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 07/18] thunderbolt: Handle rejected Thunderbolt devices
Date: Fri,  2 Mar 2018 15:38:41 +0300
Message-Id: <20180302123852.50463-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ICM firmware rejects devices if the maximum topology limit is
exceeded (more than 6 devices are connected). If that happens just log a
message to the kernel message buffer and bail out.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/icm.c     | 6 ++++++
 drivers/thunderbolt/tb_msgs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 611d28e8e5f2..6d7f8262f864 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -410,6 +410,12 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		ICM_LINK_INFO_DEPTH_SHIFT;
 	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
 
+	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
+		tb_info(tb, "switch at %u.%u was rejected by ICM firmware because topology limit exceeded\n",
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
2.16.1
