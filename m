Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELvl7er1bWgohg8MftqK6NnBlSwmXzsArQh1d95aPeJRTqnLKzxfE3cddUFKjX2j9DdtYUiT
ARC-Seal: i=1; a=rsa-sha256; t=1520865296; cv=none;
        d=google.com; s=arc-20160816;
        b=dHnJ3qisGDlx02vJSmmbG5GSPVChQ7rDtGIZG7tkltdhnDTGy1v2nPGvyAHCQ7OKyC
         IoX0QhEJOrHh3coOZqx8WPJorrOSkYDyBK6K0i8kiU6GTsAdTdO7T8WbeKb/INdq0r1y
         +kqw0l2rdL+UtvxJMjkMaQnD0iHnUPSHF7KttA2gROjPdwCYgXLJkCje42nq3BYsskfu
         pOijuPuFVcz1YcwJ/ZuV59Jz32VPwCHQnZ6cOVtFcMBwy0Zdk0tNNq6l6USoVPM3IMTW
         8jiyMR6mNQ9tJokoe31qeYb/Ba8SXsbABOwWEyZsq0y+rXo+eIfmf2bUcC60fEO2LDFv
         0tRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Si2xf8EBc+A8b7ZxuaxdxhN/1z49l2WRkEpdScrE3o4=;
        b=thpL2fqnZ332qQIqiW7ny+vV+8cqHKA90XlDmYoTTny2+cL7g8Yxab/fVFZHhujtEL
         nNMfgdIN0bEUmGe8wrMy2drIVCwL4P3GFOFvtFkT3XW5hNjZDNt/WJXP9Wy+1OjvEY9o
         3ha5IOMku2/uVaOjVHPODjY9+a3END/dQBcSsAhRG+/GhntShj3kqyCtzat6xM2PpeXk
         xxmtyqE0H9gASZnD7CDW6AvI1n2+opKeYA7oeEI2gmf1rLgkxnO9LZwBTcMjb9Rp5Oi2
         dF5kUqE6ZfT/AGpXOk5y334Jg5TT94tDJtq2+9gfn65Zu8vSRENntAaEoz9IReKk1388
         1ldw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="37470881"
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
Subject: [PATCH v7 06/12] usb: typec: tcpm: Use new Type-C switch/mux and usb-role-switch functions
Date: Mon, 12 Mar 2018 17:34:25 +0300
Message-Id: <20180312143431.82396-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594742849233315217?=
X-GMAIL-MSGID: =?utf-8?q?1594742849233315217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

Remove the unused (not implemented anywhere) tcpc_mux_dev abstraction
and replace it with calling the new typec_set_orientation,
usb_role_switch_set and typec_set_mode functions.

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
 drivers/usb/typec/Kconfig           |  1 +
 drivers/usb/typec/fusb302/fusb302.c |  1 -
 drivers/usb/typec/tcpm.c            | 46 ++++++++++++++++++++++++++++---------
 include/linux/usb/tcpm.h            | 10 --------
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index bcb2744c5977..a2a0684e7c82 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -48,6 +48,7 @@ if TYPEC
 config TYPEC_TCPM
 	tristate "USB Type-C Port Controller Manager"
 	depends on USB
+	select USB_ROLE_SWITCH
 	help
 	  The Type-C Port Controller Manager provides a USB PD and USB Type-C
 	  state machine for use with Type-C Port Controllers.
diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index f2d98c3c1f30..f0a2f8954bbd 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -1239,7 +1239,6 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
 	fusb302_tcpc_dev->set_roles = tcpm_set_roles;
 	fusb302_tcpc_dev->start_drp_toggling = tcpm_start_drp_toggling;
 	fusb302_tcpc_dev->pd_transmit = tcpm_pd_transmit;
-	fusb302_tcpc_dev->mux = NULL;
 }
 
 static const char * const cc_polarity_name[] = {
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 5e527e2e1506..3f0851bfe18f 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -20,6 +20,7 @@
 #include <linux/usb/pd.h>
 #include <linux/usb/pd_bdo.h>
 #include <linux/usb/pd_vdo.h>
+#include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 #include <linux/workqueue.h>
@@ -176,6 +177,7 @@ struct tcpm_port {
 	struct typec_port *typec_port;
 
 	struct tcpc_dev	*tcpc;
+	struct usb_role_switch *role_sw;
 
 	enum typec_role vconn_role;
 	enum typec_role pwr_role;
@@ -607,18 +609,25 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
 
 static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
-			enum usb_role usb_role)
+			enum usb_role usb_role,
+			enum typec_orientation orientation)
 {
-	int ret = 0;
+	int ret;
 
-	tcpm_log(port, "Requesting mux mode %d, usb-role %d, polarity %d",
-		 mode, usb_role, port->polarity);
+	tcpm_log(port, "Requesting mux mode %d, usb-role %d, orientation %d",
+		 mode, usb_role, orientation);
 
-	if (port->tcpc->mux)
-		ret = port->tcpc->mux->set(port->tcpc->mux, mode, usb_role,
-					   port->polarity);
+	ret = typec_set_orientation(port->typec_port, orientation);
+	if (ret)
+		return ret;
 
-	return ret;
+	if (port->role_sw) {
+		ret = usb_role_switch_set_role(port->role_sw, usb_role);
+		if (ret)
+			return ret;
+	}
+
+	return typec_set_mode(port->typec_port, mode);
 }
 
 static int tcpm_set_polarity(struct tcpm_port *port,
@@ -731,15 +740,21 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 			  enum typec_role role, enum typec_data_role data)
 {
+	enum typec_orientation orientation;
 	enum usb_role usb_role;
 	int ret;
 
+	if (port->polarity == TYPEC_POLARITY_CC1)
+		orientation = TYPEC_ORIENTATION_NORMAL;
+	else
+		orientation = TYPEC_ORIENTATION_REVERSE;
+
 	if (data == TYPEC_HOST)
 		usb_role = USB_ROLE_HOST;
 	else
 		usb_role = USB_ROLE_DEVICE;
 
-	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role);
+	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -2086,7 +2101,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+		     TYPEC_ORIENTATION_NONE);
 	return ret;
 }
 
@@ -2130,7 +2146,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+		     TYPEC_ORIENTATION_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
@@ -3732,6 +3749,12 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 	port->port_type = tcpc->config->type;
 
+	port->role_sw = usb_role_switch_get(port->dev);
+	if (IS_ERR(port->role_sw)) {
+		err = PTR_ERR(port->role_sw);
+		goto out_destroy_wq;
+	}
+
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
 		err = PTR_ERR(port->typec_port);
@@ -3767,6 +3790,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	return port;
 
 out_destroy_wq:
+	usb_role_switch_put(port->role_sw);
 	destroy_workqueue(port->wq);
 	return ERR_PTR(err);
 }
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 3e8bdaa5085a..f0d839daeaea 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -16,7 +16,6 @@
 #define __LINUX_USB_TCPM_H
 
 #include <linux/bitops.h>
-#include <linux/usb/role.h>
 #include <linux/usb/typec.h>
 #include "pd.h"
 
@@ -113,14 +112,6 @@ enum tcpc_mux_mode {
 			  TCPC_MUX_DP_ENABLED,
 };
 
-struct tcpc_mux_dev {
-	int (*set)(struct tcpc_mux_dev *dev, enum tcpc_mux_mode mux_mode,
-		   enum usb_role usb_role,
-		   enum typec_cc_polarity polarity);
-	bool dfp_only;
-	void *priv_data;
-};
-
 /**
  * struct tcpc_dev - Port configuration and callback functions
  * @config:	Pointer to port configuration
@@ -172,7 +163,6 @@ struct tcpc_dev {
 	int (*try_role)(struct tcpc_dev *dev, int role);
 	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
 			   const struct pd_message *msg);
-	struct tcpc_mux_dev *mux;
 };
 
 struct tcpm_port;
-- 
2.16.1
