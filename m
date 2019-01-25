Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E00218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfAYNPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:15:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfAYNPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141283996"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:34 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] usb: typec: Find the ports by also matching against the device node
Date:   Fri, 25 Jan 2019 16:15:17 +0300
Message-Id: <20190125131519.88416-7-heikki.krogerus@linux.intel.com>
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
 drivers/usb/typec/class.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index f50278dbef59..88adf0eaad34 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "bus.h"
@@ -204,15 +205,32 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	put_device(&adev->dev);
 }
 
-static int __typec_port_match(struct device *dev, const void *name)
+static int typec_port_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static int typec_port_name_match(struct device *dev, const void *name)
 {
 	return !strcmp((const char *)name, dev_name(dev));
 }
 
 static void *typec_port_match(struct device_connection *con, int ep, void *data)
 {
-	return class_find_device(typec_class, NULL, con->endpoint[ep],
-				 __typec_port_match);
+	struct device *dev;
+
+	/*
+	 * FIXME: Check does the fwnode supports the requested SVID. If it does
+	 * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
+	 */
+	if (con->fwnode)
+		return class_find_device(typec_class, NULL, con->fwnode,
+					 typec_port_fwnode_match);
+
+	dev = class_find_device(typec_class, NULL, con->endpoint[ep],
+				typec_port_name_match);
+
+	return dev ? dev : ERR_PTR(-EPROBE_DEFER);
 }
 
 struct typec_altmode *
-- 
2.20.1

