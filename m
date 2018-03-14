Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELuQLyypPlliH2zIB7oPjb0IVfjm1TM0ZGshBnGuCEfUyY9BuII9IRSg+LcGTG+/X2GqPgNW
ARC-Seal: i=1; a=rsa-sha256; t=1521033159; cv=none;
        d=google.com; s=arc-20160816;
        b=qmD9vlaxxGF9aPFGJVZ0kK/ajaXIMG1y0jTfWPn+cJWCGIQCvwDezUmEmA50VlWmyV
         IQz6k3wUBrSGBtHfjDAP9fA5aNmTuOvFebctFw5LFmcsco6hvW4no+x2cUSTvkxDmH4+
         T/KQq6BRwpI55FLKQOhOGG9iwUlhnvDr67iXkZcB+we4bcB/6sDVrNfR2U0IoRPsyYkS
         116jWmLbqD1oBrBvCJgd0kYl71Y+MpXV9MOOfIVAN4FUK7Lq87B5MTO0ErKio4ZPrG3u
         XNHp3XekB4vprULuTb8ZY4EdC9NNBC0C3VCfpIiR7D1xix1MfdcKJTvPVhA6nDC1Q1ro
         8aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6MpXMF+Bi++I9BKpxsPWA9x0YFW5NhKxFGRgo5V7m6s=;
        b=EB0iCqVkEk1BI1HCC3Go8Q22jedHVQul7RaDOw1v5SAFjdjMc8xTcv4mjY01Rxpn+C
         8w2q3HzNwgH7MCG0BlJhm6OUiOqYEHL9v64zxH5sMsl7srQ/dPwYSYiXsrWDbBuUXp2o
         FJ0X+B8bVHYPS1gWQ3t9wjseIzlO9h/pS6sFzurFRg/4zHW48skZpRkKNc4YuhlrzRab
         VdjOa7OKLvkjCGdYGW2yff8ZevSlnhCTJWM4KT8LKUf2mci54qi4w9+U9ghx5bewLEW7
         jttUoR5U4Io1zBbjGAkFtEeh6D7/Xcn2z/5W7qXlbeB0XTlrNCokobVABTgo/6VVk08h
         9/lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991665"
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
Subject: [PATCH v8 05/12] usb: typec: tcpm: Set USB role switch to device mode when configured as such
Date: Wed, 14 Mar 2018 16:12:08 +0300
Message-Id: <20180314131215.70833-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594918866324636227?=
X-GMAIL-MSGID: =?utf-8?q?1594918866324636227?=
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
