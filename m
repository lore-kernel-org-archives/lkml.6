Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551C8207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfA3QDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:03:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:60152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfA3QDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:03:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 08:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="142760922"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2019 08:03:14 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] usb: roles: Find the muxes by also matching against the device node
Date:   Wed, 30 Jan 2019 19:02:56 +0300
Message-Id: <20190130160259.46919-7-heikki.krogerus@linux.intel.com>
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
 drivers/usb/roles/class.c | 21 ++++++++++++++++++---
 include/linux/usb/role.h  |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 99116af07f1d..f45d8df5cfb8 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/usb/role.h>
+#include <linux/property.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static int __switch_match(struct device *dev, const void *name)
+static int switch_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static int switch_name_match(struct device *dev, const void *name)
 {
 	return !strcmp((const char *)name, dev_name(dev));
 }
@@ -94,8 +100,16 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 {
 	struct device *dev;
 
-	dev = class_find_device(role_class, NULL, con->endpoint[ep],
-				__switch_match);
+	if (con->fwnode) {
+		if (!fwnode_property_present(con->fwnode, con->id))
+			return NULL;
+
+		dev = class_find_device(role_class, NULL, con->fwnode,
+					switch_fwnode_match);
+	} else {
+		dev = class_find_device(role_class, NULL, con->endpoint[ep],
+					switch_name_match);
+	}
 
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
@@ -266,6 +280,7 @@ usb_role_switch_register(struct device *parent,
 	sw->get = desc->get;
 
 	sw->dev.parent = parent;
+	sw->dev.fwnode = desc->fwnode;
 	sw->dev.class = role_class;
 	sw->dev.type = &usb_role_dev_type;
 	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index edc51be4a77c..9684a8734757 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -32,6 +32,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
  * usb_role_switch_register() before registering the switch.
  */
 struct usb_role_switch_desc {
+	struct fwnode_handle *fwnode;
 	struct device *usb2_port;
 	struct device *usb3_port;
 	struct device *udc;
-- 
2.20.1

