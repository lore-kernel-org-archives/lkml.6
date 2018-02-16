Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeBPKqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:46:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933734AbeBPKna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:43:30 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] usb: typec: tcpm: Use new Type-C switch/mux and usb-role-switch functions
Date: Fri, 16 Feb 2018 11:43:15 +0100
Message-Id: <20180216104321.8259-7-hdegoede@redhat.com>
In-Reply-To: <20180216104321.8259-1-hdegoede@redhat.com>
References: <20180216104321.8259-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused (not implemented anywhere) tcpc_mux_dev abstraction
and replace it with calling the new typec_set_orientation,
usb_role_switch_set and typec_set_mode functions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
index 9ce4756adad6..b267b907bf24 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -1249,7 +1249,6 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
 	fusb302_tcpc_dev->set_roles = tcpm_set_roles;
 	fusb302_tcpc_dev->start_drp_toggling = tcpm_start_drp_toggling;
 	fusb302_tcpc_dev->pd_transmit = tcpm_pd_transmit;
-	fusb302_tcpc_dev->mux = NULL;
 }
 
 static const char * const cc_polarity_name[] = {
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 00ca2822432f..bfcaf6618a1f 100644
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
@@ -618,18 +620,25 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
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
@@ -742,15 +751,21 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
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
 
@@ -2097,7 +2112,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+		     TYPEC_ORIENTATION_NONE);
 	return ret;
 }
 
@@ -2141,7 +2157,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+		     TYPEC_ORIENTATION_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
@@ -3742,6 +3759,12 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
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
@@ -3777,6 +3800,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	return port;
 
 out_destroy_wq:
+	usb_role_switch_put(port->role_sw);
 	destroy_workqueue(port->wq);
 	return ERR_PTR(err);
 }
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 268721bff2c1..fe3508e6e1df 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -16,7 +16,6 @@
 #define __LINUX_USB_TCPM_H
 
 #include <linux/bitops.h>
-#include <linux/usb/role.h>
 #include <linux/usb/typec.h>
 #include "pd.h"
 
@@ -112,14 +111,6 @@ enum tcpc_mux_mode {
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
@@ -171,7 +162,6 @@ struct tcpc_dev {
 	int (*try_role)(struct tcpc_dev *dev, int role);
 	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
 			   const struct pd_message *msg);
-	struct tcpc_mux_dev *mux;
 };
 
 struct tcpm_port;
-- 
2.14.3
