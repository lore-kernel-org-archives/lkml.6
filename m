Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022C9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69052175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfA2PCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:02:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:45434 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbfA2PB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="113610581"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2019 07:01:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4A223B97; Tue, 29 Jan 2019 17:01:45 +0200 (EET)
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
Subject: [PATCH 23/28] thunderbolt: Add XDomain UUID exchange support
Date:   Tue, 29 Jan 2019 18:01:38 +0300
Message-Id: <20190129150143.12681-24-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ICM has been handling XDomain UUID exchange so there was no
need to have it in the driver yet. However, since now we are going to
add the same capabilities to the software connection manager it needs to
be handled properly.

For this reason modify the driver XDomain protocol handling so that if
the remote domain UUID is not filled in the core will query it first and
only then start the normal property exchange flow.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb_msgs.h |  11 +++
 drivers/thunderbolt/xdomain.c | 136 +++++++++++++++++++++++++++++++---
 include/linux/thunderbolt.h   |   8 ++
 3 files changed, 145 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index 02c84aa3d018..afbe1d29bb03 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -492,6 +492,17 @@ struct tb_xdp_header {
 	u32 type;
 };
 
+struct tb_xdp_uuid {
+	struct tb_xdp_header hdr;
+};
+
+struct tb_xdp_uuid_response {
+	struct tb_xdp_header hdr;
+	uuid_t src_uuid;
+	u32 src_route_hi;
+	u32 src_route_lo;
+};
+
 struct tb_xdp_properties {
 	struct tb_xdp_header hdr;
 	uuid_t src_uuid;
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 59789bdd93ac..7aa8b9da78c1 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -18,6 +18,7 @@
 #include "tb.h"
 
 #define XDOMAIN_DEFAULT_TIMEOUT			5000 /* ms */
+#define XDOMAIN_UUID_RETRIES			10
 #define XDOMAIN_PROPERTIES_RETRIES		60
 #define XDOMAIN_PROPERTIES_CHANGED_RETRIES	10
 
@@ -222,6 +223,50 @@ static int tb_xdp_handle_error(const struct tb_xdp_header *hdr)
 	return 0;
 }
 
+static int tb_xdp_uuid_request(struct tb_ctl *ctl, u64 route, int retry,
+			       uuid_t *uuid)
+{
+	struct tb_xdp_uuid_response res;
+	struct tb_xdp_uuid req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	tb_xdp_fill_header(&req.hdr, route, retry % 4, UUID_REQUEST,
+			   sizeof(req));
+
+	memset(&res, 0, sizeof(res));
+	ret = __tb_xdomain_request(ctl, &req, sizeof(req),
+				   TB_CFG_PKG_XDOMAIN_REQ, &res, sizeof(res),
+				   TB_CFG_PKG_XDOMAIN_RESP,
+				   XDOMAIN_DEFAULT_TIMEOUT);
+	if (ret)
+		return ret;
+
+	ret = tb_xdp_handle_error(&res.hdr);
+	if (ret)
+		return ret;
+
+	uuid_copy(uuid, &res.src_uuid);
+	return 0;
+}
+
+static int tb_xdp_uuid_response(struct tb_ctl *ctl, u64 route, u8 sequence,
+				const uuid_t *uuid)
+{
+	struct tb_xdp_uuid_response res;
+
+	memset(&res, 0, sizeof(res));
+	tb_xdp_fill_header(&res.hdr, route, sequence, UUID_RESPONSE,
+			   sizeof(res));
+
+	uuid_copy(&res.src_uuid, uuid);
+	res.src_route_hi = upper_32_bits(route);
+	res.src_route_lo = lower_32_bits(route);
+
+	return __tb_xdomain_response(ctl, &res, sizeof(res),
+				     TB_CFG_PKG_XDOMAIN_RESP);
+}
+
 static int tb_xdp_error_response(struct tb_ctl *ctl, u64 route, u8 sequence,
 				 enum tb_xdp_error error)
 {
@@ -512,7 +557,14 @@ static void tb_xdp_handle_request(struct work_struct *work)
 		break;
 	}
 
+	case UUID_REQUEST_OLD:
+	case UUID_REQUEST:
+		ret = tb_xdp_uuid_response(ctl, route, sequence, uuid);
+		break;
+
 	default:
+		tb_xdp_error_response(ctl, route, sequence,
+				      ERROR_NOT_SUPPORTED);
 		break;
 	}
 
@@ -828,6 +880,55 @@ static void tb_xdomain_restore_paths(struct tb_xdomain *xd)
 	}
 }
 
+static void tb_xdomain_get_uuid(struct work_struct *work)
+{
+	struct tb_xdomain *xd = container_of(work, typeof(*xd),
+					     get_uuid_work.work);
+	struct tb *tb = xd->tb;
+	uuid_t uuid;
+	int ret;
+
+	ret = tb_xdp_uuid_request(tb->ctl, xd->route, xd->uuid_retries, &uuid);
+	if (ret < 0) {
+		if (xd->uuid_retries-- > 0) {
+			queue_delayed_work(xd->tb->wq, &xd->get_uuid_work,
+					   msecs_to_jiffies(100));
+		} else {
+			dev_dbg(&xd->dev, "failed to read remote UUID\n");
+		}
+		return;
+	}
+
+	if (uuid_equal(&uuid, xd->local_uuid)) {
+		dev_dbg(&xd->dev, "intra-domain loop detected\n");
+		return;
+	}
+
+	/*
+	 * If the UUID is different, there is another domain connected
+	 * so mark this one unplugged and wait for the connection
+	 * manager to replace it.
+	 */
+	if (xd->remote_uuid && !uuid_equal(&uuid, xd->remote_uuid)) {
+		dev_dbg(&xd->dev, "remote UUID is different, unplugging\n");
+		xd->is_unplugged = true;
+		return;
+	}
+
+	/* First time fill in the missing UUID */
+	if (!xd->remote_uuid) {
+		xd->remote_uuid = kmemdup(&uuid, sizeof(uuid_t), GFP_KERNEL);
+		if (!xd->remote_uuid)
+			return;
+	}
+
+	/* Now we can start the normal properties exchange */
+	queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
+			   msecs_to_jiffies(100));
+	queue_delayed_work(xd->tb->wq, &xd->get_properties_work,
+			   msecs_to_jiffies(1000));
+}
+
 static void tb_xdomain_get_properties(struct work_struct *work)
 {
 	struct tb_xdomain *xd = container_of(work, typeof(*xd),
@@ -1034,21 +1135,29 @@ static void tb_xdomain_release(struct device *dev)
 
 static void start_handshake(struct tb_xdomain *xd)
 {
+	xd->uuid_retries = XDOMAIN_UUID_RETRIES;
 	xd->properties_retries = XDOMAIN_PROPERTIES_RETRIES;
 	xd->properties_changed_retries = XDOMAIN_PROPERTIES_CHANGED_RETRIES;
 
-	/* Start exchanging properties with the other host */
-	queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
-			   msecs_to_jiffies(100));
-	queue_delayed_work(xd->tb->wq, &xd->get_properties_work,
-			   msecs_to_jiffies(1000));
+	if (xd->needs_uuid) {
+		queue_delayed_work(xd->tb->wq, &xd->get_uuid_work,
+				   msecs_to_jiffies(100));
+	} else {
+		/* Start exchanging properties with the other host */
+		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
+				   msecs_to_jiffies(100));
+		queue_delayed_work(xd->tb->wq, &xd->get_properties_work,
+				   msecs_to_jiffies(1000));
+	}
 }
 
 static void stop_handshake(struct tb_xdomain *xd)
 {
+	xd->uuid_retries = 0;
 	xd->properties_retries = 0;
 	xd->properties_changed_retries = 0;
 
+	cancel_delayed_work_sync(&xd->get_uuid_work);
 	cancel_delayed_work_sync(&xd->get_properties_work);
 	cancel_delayed_work_sync(&xd->properties_changed_work);
 }
@@ -1091,7 +1200,7 @@ EXPORT_SYMBOL_GPL(tb_xdomain_type);
  *	    other domain is reached).
  * @route: Route string used to reach the other domain
  * @local_uuid: Our local domain UUID
- * @remote_uuid: UUID of the other domain
+ * @remote_uuid: UUID of the other domain (optional)
  *
  * Allocates new XDomain structure and returns pointer to that. The
  * object must be released by calling tb_xdomain_put().
@@ -1110,6 +1219,7 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 	xd->route = route;
 	ida_init(&xd->service_ids);
 	mutex_init(&xd->lock);
+	INIT_DELAYED_WORK(&xd->get_uuid_work, tb_xdomain_get_uuid);
 	INIT_DELAYED_WORK(&xd->get_properties_work, tb_xdomain_get_properties);
 	INIT_DELAYED_WORK(&xd->properties_changed_work,
 			  tb_xdomain_properties_changed);
@@ -1118,9 +1228,14 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 	if (!xd->local_uuid)
 		goto err_free;
 
-	xd->remote_uuid = kmemdup(remote_uuid, sizeof(uuid_t), GFP_KERNEL);
-	if (!xd->remote_uuid)
-		goto err_free_local_uuid;
+	if (remote_uuid) {
+		xd->remote_uuid = kmemdup(remote_uuid, sizeof(uuid_t),
+					  GFP_KERNEL);
+		if (!xd->remote_uuid)
+			goto err_free_local_uuid;
+	} else {
+		xd->needs_uuid = true;
+	}
 
 	device_initialize(&xd->dev);
 	xd->dev.parent = get_device(parent);
@@ -1291,7 +1406,8 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 			xd = port->xdomain;
 
 			if (lookup->uuid) {
-				if (uuid_equal(xd->remote_uuid, lookup->uuid))
+				if (xd->remote_uuid &&
+				    uuid_equal(xd->remote_uuid, lookup->uuid))
 					return xd;
 			} else if (lookup->link &&
 				   lookup->link == xd->link &&
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index bf6ec83e60ee..2d7e012db03f 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -181,6 +181,8 @@ void tb_unregister_property_dir(const char *key, struct tb_property_dir *dir);
  * @device_name: Name of the device (or %NULL if not known)
  * @is_unplugged: The XDomain is unplugged
  * @resume: The XDomain is being resumed
+ * @needs_uuid: If the XDomain does not have @remote_uuid it will be
+ *		queried first
  * @transmit_path: HopID which the remote end expects us to transmit
  * @transmit_ring: Local ring (hop) where outgoing packets are pushed
  * @receive_path: HopID which we expect the remote end to transmit
@@ -189,6 +191,9 @@ void tb_unregister_property_dir(const char *key, struct tb_property_dir *dir);
  * @properties: Properties exported by the remote domain
  * @property_block_gen: Generation of @properties
  * @properties_lock: Lock protecting @properties.
+ * @get_uuid_work: Work used to retrieve @remote_uuid
+ * @uuid_retries: Number of times left @remote_uuid is requested before
+ *		  giving up
  * @get_properties_work: Work used to get remote domain properties
  * @properties_retries: Number of times left to read properties
  * @properties_changed_work: Work used to notify the remote domain that
@@ -220,6 +225,7 @@ struct tb_xdomain {
 	const char *device_name;
 	bool is_unplugged;
 	bool resume;
+	bool needs_uuid;
 	u16 transmit_path;
 	u16 transmit_ring;
 	u16 receive_path;
@@ -227,6 +233,8 @@ struct tb_xdomain {
 	struct ida service_ids;
 	struct tb_property_dir *properties;
 	u32 property_block_gen;
+	struct delayed_work get_uuid_work;
+	int uuid_retries;
 	struct delayed_work get_properties_work;
 	int properties_retries;
 	struct delayed_work properties_changed_work;
-- 
2.20.1

