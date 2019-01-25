Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680D6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42158218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfAYNQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:16:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbfAYNP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141283958"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:24 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] usb: typec: Rationalize the API for the muxes
Date:   Fri, 25 Jan 2019 16:15:13 +0300
Message-Id: <20190125131519.88416-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can replace the second parameter that is passed to the
typec_mux_get() function with alt mode description
structure, and simply pass NULL with accessory modes.

With accessory modes there is no need for additional
identification (in practice the accessory mode can only be
Audio Accessory if muxing is needed), only with alternate
modes we need to identify the exact alternate mode.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c     | 7 ++-----
 drivers/usb/typec/mux.c       | 8 +++++---
 include/linux/usb/typec_mux.h | 3 ++-
 3 files changed, 9 insertions(+), 9 deletions(-)

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
index d990aa510fab..c7b09cbcd45e 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
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
+	mux = device_connection_find_match(dev, "typec-mux", (void *)desc,
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

