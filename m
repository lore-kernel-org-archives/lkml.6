Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELv/u17pDm7ESdiU+9WfjZZtSEhAPph9bXh71+q8CA1AYMIoS93KpwNvHRlDPAYR8ZTeW1Hm
ARC-Seal: i=1; a=rsa-sha256; t=1519986070; cv=none;
        d=google.com; s=arc-20160816;
        b=iUjyWpZnVrSM0qGd3cEe+Fz/kHpHlxOrwIa1fwH7iElHeOBkBsB/qu24sb0SC1lzUu
         MsJPFqAgZGTF6M1HSBtlSNgpFTEm6xmTzz5o5Hyi1cU3eHwjkJFkpL0mlyPHKVFW0Zn0
         OAmy08OpKFRZDq+pVZUbLh5S7C2Keub5TNO90TxQso2eNxoyLu+CqW/B3GjZ3wl45o0P
         wqARgPwOMy3l73KCXwqfroQqYzBJ6VAQQCmYHpt4jfEC4wdSEBKKtc6M6QMWwIArU5EC
         Wu410QWPmLz7j0ijAJ8QrIyIDgacRHvgbctN/RFBtJmqMUMuBFEGM15ntIaDpOFzCKwr
         c09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7euodGnnm469zz+riw4NyRfFuhFW/4o6YTtDK4y9Tw0=;
        b=pZipBYkQ2P2s+aR8QQd7tjqp7ksyJ6m8NFfnkiAkknLR2tkZdwgH2JM1IEPsl9zfed
         9WqACUK3H7DvSf8vxDpg/4APIFXmLnjZ8gftrC/sZtSCwo/5zqjrM7oLqXG5mucg4UH1
         aJWrWxVDoiNevo4V5U02Ky9Iw06+wtHbn2ETgsH/XrnVJDPmmsfAwpKU6nzJr2sDiXqq
         3okXYNjNh1giSd1VabEw/5Kv+64+age7CWVU90RX3yXlWZ1UuZFapCaKIR/1zG0mT4DS
         Aehc1v1IsS5+33HLUBhxET4FIbiEWcdH5VxW+c+s10HKZeYkOcI159vkdEiMWUs+I6vr
         kR4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v6 05/12] usb: typec: tcpm: Set USB role switch to device mode when configured as such
Date: Fri,  2 Mar 2018 11:20:50 +0100
Message-Id: <20180302102057.8917-6-hdegoede@redhat.com>
In-Reply-To: <20180302102057.8917-1-hdegoede@redhat.com>
References: <20180302102057.8917-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593820913904562465?=
X-GMAIL-MSGID: =?utf-8?q?1593820913904562465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
index 7cd28b700a7f..00ca2822432f 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -618,15 +618,15 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
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
@@ -742,14 +742,15 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
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
 
@@ -2096,7 +2097,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, TCPC_USB_SWITCH_DISCONNECT);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
 	return ret;
 }
 
@@ -2140,6 +2141,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
@@ -2190,8 +2192,6 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 static void tcpm_snk_detach(struct tcpm_port *port)
 {
 	tcpm_detach(port);
-
-	/* XXX: (Dis)connect SuperSpeed mux? */
 }
 
 static int tcpm_acc_attach(struct tcpm_port *port)
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index ca1c0b57f03f..268721bff2c1 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -16,6 +16,7 @@
 #define __LINUX_USB_TCPM_H
 
 #include <linux/bitops.h>
+#include <linux/usb/role.h>
 #include <linux/usb/typec.h>
 #include "pd.h"
 
@@ -97,11 +98,6 @@ struct tcpc_config {
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
@@ -118,7 +114,7 @@ enum tcpc_mux_mode {
 
 struct tcpc_mux_dev {
 	int (*set)(struct tcpc_mux_dev *dev, enum tcpc_mux_mode mux_mode,
-		   enum tcpc_usb_switch usb_config,
+		   enum usb_role usb_role,
 		   enum typec_cc_polarity polarity);
 	bool dfp_only;
 	void *priv_data;
-- 
2.14.3
