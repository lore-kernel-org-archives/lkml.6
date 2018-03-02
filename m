Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423630AbeCBMnc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:43:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:43764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427620AbeCBMi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:38:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="35407830"
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
Subject: [PATCH v3 03/18] thunderbolt: Handle connecting device in place of host properly
Date: Fri,  2 Mar 2018 15:38:37 +0300
Message-Id: <20180302123852.50463-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
2.16.1
