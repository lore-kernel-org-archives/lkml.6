Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4057DC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15061207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfA3QDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:03:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:60152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731898AbfA3QDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:03:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 08:03:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="142760912"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2019 08:03:12 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] usb: typec: mux: Find the muxes by also matching against the device node
Date:   Wed, 30 Jan 2019 19:02:55 +0300
Message-Id: <20190130160259.46919-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
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
 drivers/usb/typec/mux.c | 86 +++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 8975f58e1d60..a5947d98824d 100644
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
@@ -23,15 +25,25 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 {
 	struct typec_switch *sw;
 
-	list_for_each_entry(sw, &switch_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
-			return sw;
+	if (!con->fwnode) {
+		list_for_each_entry(sw, &switch_list, entry)
+			if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
+				return sw;
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the switch to show up.
+	 * With OF graph the mux node must have a boolean device property named
+	 * "orientation-switch".
 	 */
-	return ERR_PTR(-EPROBE_DEFER);
+	if (con->id && !fwnode_property_present(con->fwnode, con->id))
+		return NULL;
+
+	list_for_each_entry(sw, &switch_list, entry)
+		if (dev_fwnode(sw->dev) == con->fwnode)
+			return sw;
+
+	return con->id ? ERR_PTR(-EPROBE_DEFER) : NULL;
 }
 
 /**
@@ -112,17 +124,67 @@ EXPORT_SYMBOL_GPL(typec_switch_unregister);
 
 static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
+	const struct typec_altmode_desc *desc = data;
 	struct typec_mux *mux;
+	size_t nval;
+	bool match;
+	u16 *val;
+	int i;
 
-	list_for_each_entry(mux, &mux_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
-			return mux;
+	if (!con->fwnode) {
+		list_for_each_entry(mux, &mux_list, entry)
+			if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
+				return mux;
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the switch to show up.
+	 * Check has the identifier already been "consumed". If it
+	 * has, no need to do any extra connection identification.
 	 */
-	return ERR_PTR(-EPROBE_DEFER);
+	match = !con->id;
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
+
+find_mux:
+	list_for_each_entry(mux, &mux_list, entry)
+		if (dev_fwnode(mux->dev) == con->fwnode)
+			return mux;
+
+	return match ? ERR_PTR(-EPROBE_DEFER) : NULL;
 }
 
 /**
-- 
2.20.1

