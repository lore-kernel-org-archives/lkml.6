Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WT1BE8VoGls7TwAAmS7hNA
	; Fri, 08 Jun 2018 11:31:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 30B47607E4; Fri,  8 Jun 2018 11:31:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86380606FA;
	Fri,  8 Jun 2018 11:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86380606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeFHLbc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:31:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:32416 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752780AbeFHL3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:29:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 04:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="62388990"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2018 04:29:48 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 3/8] usb: typec: mux: Get the mux identifier from function parameter
Date: Fri,  8 Jun 2018 14:29:36 +0300
Message-Id: <20180608112941.26332-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the muxes to be usable with alternate modes,
the alternate mode devices will need also to be able to get
a handle to the muxes on top of the port devices. To make
that possible, the muxes need to be possible to request with
an identifier.

This will change the API so that the mux identifier is given
as a function parameter to typec_mux_get(), and the hard-coded
"typec-mux" is replaced with that value.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c     | 2 +-
 drivers/usb/typec/mux.c       | 6 +++---
 include/linux/usb/typec_mux.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 02db9bcbac0c..49468f5329d6 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1356,7 +1356,7 @@ struct typec_port *typec_register_port(struct device *parent,
 		goto err_switch;
 	}
 
-	port->mux = typec_mux_get(cap->fwnode ? &port->dev : parent);
+	port->mux = typec_mux_get(parent, "typec-mux");
 	if (IS_ERR(port->mux)) {
 		ret = PTR_ERR(port->mux);
 		goto err_mux;
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 9d8330e9c431..ddaac63ecf12 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -123,19 +123,19 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 /**
  * typec_mux_get - Find USB Type-C Multiplexer
  * @dev: The caller device
+ * @name: Mux identifier
  *
  * Finds a mux linked to the caller. This function is primarily meant for the
  * Type-C drivers. Returns a reference to the mux on success, NULL if no
  * matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a connection
  * was found but the mux has not been enumerated yet.
  */
-struct typec_mux *typec_mux_get(struct device *dev)
+struct typec_mux *typec_mux_get(struct device *dev, const char *name)
 {
 	struct typec_mux *mux;
 
 	mutex_lock(&mux_lock);
-	mux = device_connection_find_match(dev, "typec-mux", NULL,
-					   typec_mux_match);
+	mux = device_connection_find_match(dev, name, NULL, typec_mux_match);
 	if (!IS_ERR_OR_NULL(mux))
 		get_device(mux->dev);
 	mutex_unlock(&mux_lock);
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 12c1b057834b..79293f630ee1 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -47,7 +47,7 @@ void typec_switch_put(struct typec_switch *sw);
 int typec_switch_register(struct typec_switch *sw);
 void typec_switch_unregister(struct typec_switch *sw);
 
-struct typec_mux *typec_mux_get(struct device *dev);
+struct typec_mux *typec_mux_get(struct device *dev, const char *name);
 void typec_mux_put(struct typec_mux *mux);
 int typec_mux_register(struct typec_mux *mux);
 void typec_mux_unregister(struct typec_mux *mux);
-- 
2.17.1
