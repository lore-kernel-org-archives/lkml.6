Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3418DC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1F1218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfAYNPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:15:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfAYNPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141283973"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:29 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] usb: typec: mux: Find the muxes by also matching against the device node
Date:   Fri, 25 Jan 2019 16:15:15 +0300
Message-Id: <20190125131519.88416-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device, and the endpoint will not be used at all in that
case.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux.c | 78 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index c7b09cbcd45e..eea29024da25 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -11,6 +11,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
 #include <linux/usb/typec_mux.h>
 
 static DEFINE_MUTEX(switch_lock);
@@ -23,15 +25,22 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 {
 	struct typec_switch *sw;
 
+	if (!con->fwnode) {
+		list_for_each_entry(sw, &switch_list, entry)
+			if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
+				return sw;
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (con->id &&
+	    !fwnode_property_present(con->fwnode, "orientation-switch"))
+		return NULL;
+
 	list_for_each_entry(sw, &switch_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
+		if (dev_fwnode(sw->dev) == con->fwnode)
 			return sw;
 
-	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the switch to show up.
-	 */
-	return ERR_PTR(-EPROBE_DEFER);
+	return con->id ? ERR_PTR(-EPROBE_DEFER) : NULL;
 }
 
 /**
@@ -112,17 +121,62 @@ EXPORT_SYMBOL_GPL(typec_switch_unregister);
 
 static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
+	const struct typec_altmode_desc *desc = data;
 	struct typec_mux *mux;
+	bool match = !con->id;
+	size_t nval;
+	u16 *val;
+	int i;
+
+	if (!con->fwnode) {
+		list_for_each_entry(mux, &mux_list, entry)
+			if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
+				return mux;
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (match)
+		goto find_mux;
+
+	/* Accessory Mode muxes */
+	if (!desc) {
+		match = fwnode_property_present(con->fwnode, "accessory");
+		if (match)
+			goto find_mux;
+		return NULL;
+	}
+
+	/* Alternate Mode muxes */
+	nval = fwnode_property_read_u16_array(con->fwnode, "svid", NULL, 0);
+	if (nval <= 0)
+		return NULL;
+
+	val = kcalloc(nval, sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return ERR_PTR(-ENOMEM);
+
+	nval = fwnode_property_read_u16_array(con->fwnode, "svid", val, nval);
+	if (nval < 0) {
+		kfree(val);
+		return ERR_PTR(nval);
+	}
+
+	for (i = 0; i < nval; i++) {
+		match = val[i] == desc->svid;
+		if (match) {
+			kfree(val);
+			goto find_mux;
+		}
+	}
+	kfree(val);
+	return NULL;
 
+find_mux:
 	list_for_each_entry(mux, &mux_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
+		if (dev_fwnode(mux->dev) == con->fwnode)
 			return mux;
 
-	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the switch to show up.
-	 */
-	return ERR_PTR(-EPROBE_DEFER);
+	return match ? ERR_PTR(-EPROBE_DEFER) : NULL;
 }
 
 /**
-- 
2.20.1

