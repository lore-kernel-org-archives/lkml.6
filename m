Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELtSGiabnkNsCgIto45//8gjBCd3L/yKQDmIBEMRta5Lqh27E/hYYryqaaI5paar+m6IWnXe
ARC-Seal: i=1; a=rsa-sha256; t=1520865293; cv=none;
        d=google.com; s=arc-20160816;
        b=eFX3h8BE4obDI5Fqn+l2Hp+Eh+ykZyl3p0N1ranhiDt/xsLvpT4JNVYHc+KQVQ4vou
         Yzju95GdCjiL8rBe88kW/6gQ2eP7SlL6adxs7gDaaX9ziRyTdy3+TuA3R8Xfvx6RIOiZ
         MCnMfNALAM2eJ67iDcXcHIJV3v0UxHNTcp6LevMv5Wd3iGtig1Fea8hM5PqFMGMLcjvZ
         5ojR1fphBmpFdKvYy5aThu/IPBFUdNj+xdrHZs8JnAQ9oTEEAr4h0s4/oX7H7sPYg59s
         HDlUngj9hzRsQoYf8627e1PC6E+sdbam5seobAHbzCAXzHURu1c+NlLbZNbaeLxIMqTS
         27Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wsXQYxoI30N37YBjIYQSTAwSDVTfiGPAkgq4evdpJPs=;
        b=VcNgkrvcF/nQ2hRx/1Ru6WZjDnXYXMixs77BBwvdMqt69AUij+2kikC6MjpavTC7T7
         DyGOAwb/GX46RA9eWh1ppKUZ8WwT0IceI60sRgqlDR/ayXiNW/Hi0p+BtfPHRpLikn7U
         ZAhFlpCW00pdc9SeRouqNTsJTtQ1L6RCPi+qRRyA0Ex4IBCd7IE5K8moCNMWqLz87jpo
         0McciEoKP8f0FTN6EbVpboOXYjxEvh5IDRRKnyEKWTbxl/qgf0Tmn3j07TR/+RXKwRR1
         KuZ4Hzll7wY7kpUo+cjVzBB5fPsITVeIjp0xe8BY39Bi/8kythGtLI/S90iIP+YV9BOa
         mifA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="37470860"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v7 05/12] usb: typec: tcpm: Set USB role switch to device mode when configured as such
Date: Mon, 12 Mar 2018 17:34:24 +0300
Message-Id: <20180312143431.82396-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594742846034117156?=
X-GMAIL-MSGID: =?utf-8?q?1594742846034117156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

Setting the mux to MUX_NONE and the switch to USB_SWITCH_DISCONNECT when
the data-role is device is not correct. Plenty of devices support
operating as USB device through a (separate) USB device controller.

We really need 2 different versions of USB_SWITCH_CONNECT,
USB_SWITCH_CONNECT_HOST and USB_SWITCH_DEVICE. Rather then modifying the
tcpc_usb_switch enum for this, simply remove it and switch to the
usb_role enum which provides exactly this, this will save use needing to
convert betweent the 2 enums when calling an usb-role-switch driver later.

Besides switching to the usb_role type, this commit also actually sets the
mux to TYPEC_MUX_USB and the switch to USB_ROLE_DEVICE instead of setting
both to none when the data-role is device.

This commit also makes tcpm_reset_port() call tcpm_mux_set(port,
TYPEC_MUX_NONE, USB_ROLE_NONE) so that the mux and switch
do _not_ stay in their last mode after a detach.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Revieved-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
-Add Andy's Reviewed-by

Changes in v3:
-Add Guenter's Reviewed-by

Changes in v2:
-Added Heikki's Reviewed-by
---
 drivers/usb/typec/tcpm.c | 22 +++++++++++-----------
 include/linux/usb/tcpm.h |  8 ++------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 064b456dcf04..5e527e2e1506 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -607,15 +607,15 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
 
 static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
-			enum tcpc_usb_switch config)
+			enum usb_role usb_role)
 {
 	int ret = 0;
 
-	tcpm_log(port, "Requesting mux mode %d, config %d, polarity %d",
-		 mode, config, port->polarity);
+	tcpm_log(port, "Requesting mux mode %d, usb-role %d, polarity %d",
+		 mode, usb_role, port->polarity);
 
 	if (port->tcpc->mux)
-		ret = port->tcpc->mux->set(port->tcpc->mux, mode, config,
+		ret = port->tcpc->mux->set(port->tcpc->mux, mode, usb_role,
 					   port->polarity);
 
 	return ret;
@@ -731,14 +731,15 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 			  enum typec_role role, enum typec_data_role data)
 {
+	enum usb_role usb_role;
 	int ret;
 
 	if (data == TYPEC_HOST)
-		ret = tcpm_mux_set(port, TYPEC_MUX_USB,
-				   TCPC_USB_SWITCH_CONNECT);
+		usb_role = USB_ROLE_HOST;
 	else
-		ret = tcpm_mux_set(port, TYPEC_MUX_NONE,
-				   TCPC_USB_SWITCH_DISCONNECT);
+		usb_role = USB_ROLE_DEVICE;
+
+	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role);
 	if (ret < 0)
 		return ret;
 
@@ -2085,7 +2086,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, TCPC_USB_SWITCH_DISCONNECT);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
 	return ret;
 }
 
@@ -2129,6 +2130,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
@@ -2179,8 +2181,6 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 static void tcpm_snk_detach(struct tcpm_port *port)
 {
 	tcpm_detach(port);
-
-	/* XXX: (Dis)connect SuperSpeed mux? */
 }
 
 static int tcpm_acc_attach(struct tcpm_port *port)
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 5a5e1d8c5b65..3e8bdaa5085a 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -16,6 +16,7 @@
 #define __LINUX_USB_TCPM_H
 
 #include <linux/bitops.h>
+#include <linux/usb/role.h>
 #include <linux/usb/typec.h>
 #include "pd.h"
 
@@ -98,11 +99,6 @@ struct tcpc_config {
 	const struct typec_altmode_desc *alt_modes;
 };
 
-enum tcpc_usb_switch {
-	TCPC_USB_SWITCH_CONNECT,
-	TCPC_USB_SWITCH_DISCONNECT,
-};
-
 /* Mux state attributes */
 #define TCPC_MUX_USB_ENABLED		BIT(0)	/* USB enabled */
 #define TCPC_MUX_DP_ENABLED		BIT(1)	/* DP enabled */
@@ -119,7 +115,7 @@ enum tcpc_mux_mode {
 
 struct tcpc_mux_dev {
 	int (*set)(struct tcpc_mux_dev *dev, enum tcpc_mux_mode mux_mode,
-		   enum tcpc_usb_switch usb_config,
+		   enum usb_role usb_role,
 		   enum typec_cc_polarity polarity);
 	bool dfp_only;
 	void *priv_data;
-- 
2.16.1
