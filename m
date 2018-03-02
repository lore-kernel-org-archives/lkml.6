Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427667AbeCBMjG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:39:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:53055 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427645AbeCBMjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:39:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="22322591"
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
Subject: [PATCH v3 14/18] thunderbolt: Move driver ready handling to struct icm
Date: Fri,  2 Mar 2018 15:38:48 +0300
Message-Id: <20180302123852.50463-15-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Titan Ridge uses slightly different format for ICM driver ready
response, so add a new ->driver_ready() callback to struct icm and move
the existing handling to a separate function which we then use in Falcon
Ridge and Alpine Ridge.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/icm.c     | 42 +++++++++++++++++++++++++++++++-----------
 drivers/thunderbolt/tb_msgs.h |  6 ++++--
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 1c10aa8d224d..5d3cd740b71f 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -59,6 +59,7 @@
  * @is_supported: Checks if we can support ICM on this controller
  * @get_mode: Read and return the ICM firmware mode (optional)
  * @get_route: Find a route string for given switch
+ * @driver_ready: Send driver ready message to ICM
  * @device_connected: Handle device connected ICM message
  * @device_disconnected: Handle device disconnected ICM message
  * @xdomain_connected - Handle XDomain connected ICM message
@@ -73,6 +74,8 @@ struct icm {
 	bool (*is_supported)(struct tb *tb);
 	int (*get_mode)(struct tb *tb);
 	int (*get_route)(struct tb *tb, u8 link, u8 depth, u64 *route);
+	int (*driver_ready)(struct tb *tb,
+			    enum tb_security_level *security_level);
 	void (*device_connected)(struct tb *tb,
 				 const struct icm_pkg_header *hdr);
 	void (*device_disconnected)(struct tb *tb,
@@ -246,6 +249,27 @@ static int icm_fr_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 	return ret;
 }
 
+static int
+icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level)
+{
+	struct icm_fr_pkg_driver_ready_response reply;
+	struct icm_pkg_driver_ready request = {
+		.hdr.code = ICM_DRIVER_READY,
+	};
+	int ret;
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, ICM_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (security_level)
+		*security_level = reply.security_level & ICM_FR_SLEVEL_MASK;
+
+	return 0;
+}
+
 static int icm_fr_approve_switch(struct tb *tb, struct tb_switch *sw)
 {
 	struct icm_fr_pkg_approve_device request;
@@ -869,21 +893,15 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 static int
 __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level)
 {
-	struct icm_pkg_driver_ready_response reply;
-	struct icm_pkg_driver_ready request = {
-		.hdr.code = ICM_DRIVER_READY,
-	};
+	struct icm *icm = tb_priv(tb);
 	unsigned int retries = 50;
 	int ret;
 
-	memset(&reply, 0, sizeof(reply));
-	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
-	if (ret)
+	ret = icm->driver_ready(tb, security_level);
+	if (ret) {
+		tb_err(tb, "failed to send driver ready to ICM\n");
 		return ret;
-
-	if (security_level)
-		*security_level = reply.security_level & 0xf;
+	}
 
 	/*
 	 * Hold on here until the switch config space is accessible so
@@ -1329,6 +1347,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
 		icm->is_supported = icm_fr_is_supported;
 		icm->get_route = icm_fr_get_route;
+		icm->driver_ready = icm_fr_driver_ready;
 		icm->device_connected = icm_fr_device_connected;
 		icm->device_disconnected = icm_fr_device_disconnected;
 		icm->xdomain_connected = icm_fr_xdomain_connected;
@@ -1344,6 +1363,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 		icm->is_supported = icm_ar_is_supported;
 		icm->get_mode = icm_ar_get_mode;
 		icm->get_route = icm_ar_get_route;
+		icm->driver_ready = icm_fr_driver_ready;
 		icm->device_connected = icm_fr_device_connected;
 		icm->device_disconnected = icm_fr_device_disconnected;
 		icm->xdomain_connected = icm_fr_xdomain_connected;
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index 476bc04cac6c..931db2a7c7b3 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -127,14 +127,16 @@ struct icm_pkg_driver_ready {
 	struct icm_pkg_header hdr;
 };
 
-struct icm_pkg_driver_ready_response {
+/* Falcon Ridge & Alpine Ridge common messages */
+
+struct icm_fr_pkg_driver_ready_response {
 	struct icm_pkg_header hdr;
 	u8 romver;
 	u8 ramver;
 	u16 security_level;
 };
 
-/* Falcon Ridge & Alpine Ridge common messages */
+#define ICM_FR_SLEVEL_MASK		0xf
 
 struct icm_fr_pkg_get_topology {
 	struct icm_pkg_header hdr;
-- 
2.16.1
