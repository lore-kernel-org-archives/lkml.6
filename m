Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747A1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF3B207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfA3QDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:03:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:60152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731574AbfA3QDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:03:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 08:03:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="142760884"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2019 08:03:04 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] usb: typec: Rationalize the API for the muxes
Date:   Wed, 30 Jan 2019 19:02:52 +0300
Message-Id: <20190130160259.46919-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since with accessory modes there is no need for additional
identification when requesting a handle to the mux, we can
replace the second parameter that is passed to the
typec_mux_get() function with a pointer to alternate mode
description structure, and simply passing NULL with
accessory modes.

This change means the naming of the mux device connections
can be updated. Alternate and Accessory Modes will both be
handled with muxes named "mode-switch", and the orientation
switches will be named "orientation-switch".

Future identification of the alternate modes will be later
done using device property "svid" of the mux.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c     |  7 ++-----
 drivers/usb/typec/mux.c       | 10 ++++++----
 include/linux/usb/typec_mux.h |  3 ++-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 5db0593ca0bd..f50278dbef59 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1496,11 +1496,8 @@ typec_port_register_altmode(struct typec_port *port,
 {
 	struct typec_altmode *adev;
 	struct typec_mux *mux;
-	char id[10];
 
-	sprintf(id, "id%04xm%02x", desc->svid, desc->mode);
-
-	mux = typec_mux_get(&port->dev, id);
+	mux = typec_mux_get(&port->dev, desc);
 	if (IS_ERR(mux))
 		return ERR_CAST(mux);
 
@@ -1593,7 +1590,7 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_CAST(port->sw);
 	}
 
-	port->mux = typec_mux_get(&port->dev, "typec-mux");
+	port->mux = typec_mux_get(&port->dev, NULL);
 	if (IS_ERR(port->mux)) {
 		put_device(&port->dev);
 		return ERR_CAST(port->mux);
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index d990aa510fab..8975f58e1d60 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -48,7 +48,7 @@ struct typec_switch *typec_switch_get(struct device *dev)
 	struct typec_switch *sw;
 
 	mutex_lock(&switch_lock);
-	sw = device_connection_find_match(dev, "typec-switch", NULL,
+	sw = device_connection_find_match(dev, "orientation-switch", NULL,
 					  typec_switch_match);
 	if (!IS_ERR_OR_NULL(sw)) {
 		WARN_ON(!try_module_get(sw->dev->driver->owner));
@@ -128,19 +128,21 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 /**
  * typec_mux_get - Find USB Type-C Multiplexer
  * @dev: The caller device
- * @name: Mux identifier
+ * @desc: Alt Mode description
  *
  * Finds a mux linked to the caller. This function is primarily meant for the
  * Type-C drivers. Returns a reference to the mux on success, NULL if no
  * matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a connection
  * was found but the mux has not been enumerated yet.
  */
-struct typec_mux *typec_mux_get(struct device *dev, const char *name)
+struct typec_mux *typec_mux_get(struct device *dev,
+				const struct typec_altmode_desc *desc)
 {
 	struct typec_mux *mux;
 
 	mutex_lock(&mux_lock);
-	mux = device_connection_find_match(dev, name, NULL, typec_mux_match);
+	mux = device_connection_find_match(dev, "mode-switch", (void *)desc,
+					   typec_mux_match);
 	if (!IS_ERR_OR_NULL(mux)) {
 		WARN_ON(!try_module_get(mux->dev->driver->owner));
 		get_device(mux->dev);
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 79293f630ee1..43f40685e53c 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -47,7 +47,8 @@ void typec_switch_put(struct typec_switch *sw);
 int typec_switch_register(struct typec_switch *sw);
 void typec_switch_unregister(struct typec_switch *sw);
 
-struct typec_mux *typec_mux_get(struct device *dev, const char *name);
+struct typec_mux *
+typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc);
 void typec_mux_put(struct typec_mux *mux);
 int typec_mux_register(struct typec_mux *mux);
 void typec_mux_unregister(struct typec_mux *mux);
-- 
2.20.1

