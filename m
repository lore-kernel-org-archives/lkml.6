Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965324AbeBMRAc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:00:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:54580 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964869AbeBMRAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="18120013"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 03/18] thunderbolt: Handle connecting device in place of host properly
Date: Tue, 13 Feb 2018 20:00:03 +0300
Message-Id: <20180213170018.9780-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system is suspended and user disconnects cable to another host
and connects it to a Thunderbolt device instead we get a warning from
driver core about adding duplicate sysfs attribute and adding the new
device fails.

Handle this properly so that we first remove the existing XDomain
connection before adding new devices.

Fixes: d1ff70241a27 ("thunderbolt: Add support for XDomain discovery protocol")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/icm.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index ab02d13f40b7..182226023acb 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -383,6 +383,15 @@ static void remove_switch(struct tb_switch *sw)
 	tb_switch_remove(sw);
 }
 
+static void remove_xdomain(struct tb_xdomain *xd)
+{
+	struct tb_switch *sw;
+
+	sw = tb_to_switch(xd->dev.parent);
+	tb_port_at(xd->route, sw)->xdomain = NULL;
+	tb_xdomain_remove(xd);
+}
+
 static void
 icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
@@ -391,6 +400,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	struct tb_switch *sw, *parent_sw;
 	struct icm *icm = tb_priv(tb);
 	bool authorized = false;
+	struct tb_xdomain *xd;
 	u8 link, depth;
 	u64 route;
 	int ret;
@@ -467,6 +477,13 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		tb_switch_put(sw);
 	}
 
+	/* Remove existing XDomain connection if found */
+	xd = tb_xdomain_find_by_link_depth(tb, link, depth);
+	if (xd) {
+		remove_xdomain(xd);
+		tb_xdomain_put(xd);
+	}
+
 	parent_sw = tb_switch_find_by_link_depth(tb, link, depth - 1);
 	if (!parent_sw) {
 		tb_err(tb, "failed to find parent switch for %u.%u\n",
@@ -529,15 +546,6 @@ icm_fr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 	tb_switch_put(sw);
 }
 
-static void remove_xdomain(struct tb_xdomain *xd)
-{
-	struct tb_switch *sw;
-
-	sw = tb_to_switch(xd->dev.parent);
-	tb_port_at(xd->route, sw)->xdomain = NULL;
-	tb_xdomain_remove(xd);
-}
-
 static void
 icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
-- 
2.15.1
