Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELsYJGEDXEVqoX7Mmun0NKtlIngn0jx27Is4nQX9agS0EBZpoj1/OgmksYPE1qcpjW2Omky7
ARC-Seal: i=1; a=rsa-sha256; t=1521033156; cv=none;
        d=google.com; s=arc-20160816;
        b=m5WcfEHfSC2a8jWN49jjyynkW7WnhbXTeDuFliCBKvotLFPlJUHc/Z2mxkfBooPmJT
         PpAkUGZfB6wFTqXMz0xtEM28lBjxErwYYYAYjGCgSYWOZO/Mk+7xJydXlnuG0f9qwUu+
         +boD9y2n0actgpM79fNWQpNhAOFRwX3db2z0CIIAAHIS3A1YmukYc8mT/+uUlrHrsdU3
         M74J5UaS/BkFon5Y8w5yK9AlRrvfXcNf2ZUO3VE1NCUngJsm2Q7Y7Cl3AUQiQaJgdh8I
         RiW89F3cwmciIAX/+7X1QZBc0D3ut99khqAwNogVNUDw+nB8sQaT42ILs0aIx5hrAerV
         MV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ZqScEiCtLxwYoXWXnHkJRZt2qAeEISfkUC+vFews/XU=;
        b=SreHvzGtEBmlzT8SDRs/6L0beKaQL7fLcxzZ9/BfMRm6TQj7m2hINqu56Uj8j7Yctl
         QOXAAg6pP4xvNHeX91py8LAYQHZ7/xo6c0icW1zVvH8Fcedd5tCDCdoSDyav4WRTfMr/
         GESlVLu5+xd3Hgu06xTsrpPPApL+mKIBSgPjnUBN/lT6YqNqJqM/54eK9UDPEftM4UIn
         KNP14LIhXewsBD0DLg6+auIPjeHnLeJ1hctbV9bmAPSuhBBKE3eMSsDf9wD5V/ATCyey
         pLwo8yAYVHrIDH6FJ4D/AjXJBQ/ovPjKicET1P8zSTGUubI4clz9zCG4XCugdSHdV4Sd
         r12g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991653"
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
Subject: [PATCH v8 04/12] usb: typec: Separate the definitions for data and power roles
Date: Wed, 14 Mar 2018 16:12:07 +0300
Message-Id: <20180314131215.70833-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594918863096424166?=
X-GMAIL-MSGID: =?utf-8?q?1594918863096424166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

USB Type-C specification v1.2 separated the power and data
roles more clearly. Dual-Role-Data term was introduced, and
the meaning of DRP was changed from "Dual-Role-Port" to
"Dual-Role-Power".

In order to allow the port drivers to describe the
capabilities of the ports more clearly according to the
newest specifications, introducing separate definitions for
the data roles.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c           | 56 ++++++++++++++++++++++---------------
 drivers/usb/typec/fusb302/fusb302.c |  1 +
 drivers/usb/typec/tcpm.c            |  9 +++---
 drivers/usb/typec/tps6598x.c        | 26 +++++++++++------
 drivers/usb/typec/typec_wcove.c     |  1 +
 drivers/usb/typec/ucsi/ucsi.c       | 13 +++++++--
 include/linux/usb/tcpm.h            |  1 +
 include/linux/usb/typec.h           | 14 ++++++++--
 8 files changed, 80 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 2620a694704f..53df10df2f9d 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -282,10 +282,10 @@ typec_altmode_roles_show(struct device *dev, struct device_attribute *attr,
 	ssize_t ret;
 
 	switch (mode->roles) {
-	case TYPEC_PORT_DFP:
+	case TYPEC_PORT_SRC:
 		ret = sprintf(buf, "source\n");
 		break;
-	case TYPEC_PORT_UFP:
+	case TYPEC_PORT_SNK:
 		ret = sprintf(buf, "sink\n");
 		break;
 	case TYPEC_PORT_DRP:
@@ -797,14 +797,14 @@ static const char * const typec_data_roles[] = {
 };
 
 static const char * const typec_port_types[] = {
-	[TYPEC_PORT_DFP] = "source",
-	[TYPEC_PORT_UFP] = "sink",
+	[TYPEC_PORT_SRC] = "source",
+	[TYPEC_PORT_SNK] = "sink",
 	[TYPEC_PORT_DRP] = "dual",
 };
 
 static const char * const typec_port_types_drp[] = {
-	[TYPEC_PORT_DFP] = "dual [source] sink",
-	[TYPEC_PORT_UFP] = "dual source [sink]",
+	[TYPEC_PORT_SRC] = "dual [source] sink",
+	[TYPEC_PORT_SNK] = "dual source [sink]",
 	[TYPEC_PORT_DRP] = "[dual] source sink",
 };
 
@@ -875,9 +875,7 @@ static ssize_t data_role_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&port->port_type_lock);
-	if (port->port_type != TYPEC_PORT_DRP) {
-		dev_dbg(dev, "port type fixed at \"%s\"",
-			     typec_port_types[port->port_type]);
+	if (port->cap->data != TYPEC_PORT_DRD) {
 		ret = -EOPNOTSUPP;
 		goto unlock_and_ret;
 	}
@@ -897,7 +895,7 @@ static ssize_t data_role_show(struct device *dev,
 {
 	struct typec_port *port = to_typec_port(dev);
 
-	if (port->cap->type == TYPEC_PORT_DRP)
+	if (port->cap->data == TYPEC_PORT_DRD)
 		return sprintf(buf, "%s\n", port->data_role == TYPEC_HOST ?
 			       "[host] device" : "host [device]");
 
@@ -1328,7 +1326,6 @@ struct typec_port *typec_register_port(struct device *parent,
 				       const struct typec_capability *cap)
 {
 	struct typec_port *port;
-	int role;
 	int ret;
 	int id;
 
@@ -1354,21 +1351,36 @@ struct typec_port *typec_register_port(struct device *parent,
 		goto err_mux;
 	}
 
-	if (cap->type == TYPEC_PORT_DFP)
-		role = TYPEC_SOURCE;
-	else if (cap->type == TYPEC_PORT_UFP)
-		role = TYPEC_SINK;
-	else
-		role = cap->prefer_role;
-
-	if (role == TYPEC_SOURCE) {
-		port->data_role = TYPEC_HOST;
+	switch (cap->type) {
+	case TYPEC_PORT_SRC:
 		port->pwr_role = TYPEC_SOURCE;
 		port->vconn_role = TYPEC_SOURCE;
-	} else {
-		port->data_role = TYPEC_DEVICE;
+		break;
+	case TYPEC_PORT_SNK:
 		port->pwr_role = TYPEC_SINK;
 		port->vconn_role = TYPEC_SINK;
+		break;
+	case TYPEC_PORT_DRP:
+		if (cap->prefer_role != TYPEC_NO_PREFERRED_ROLE)
+			port->pwr_role = cap->prefer_role;
+		else
+			port->pwr_role = TYPEC_SINK;
+		break;
+	}
+
+	switch (cap->data) {
+	case TYPEC_PORT_DFP:
+		port->data_role = TYPEC_HOST;
+		break;
+	case TYPEC_PORT_UFP:
+		port->data_role = TYPEC_DEVICE;
+		break;
+	case TYPEC_PORT_DRD:
+		if (cap->prefer_role == TYPEC_SOURCE)
+			port->data_role = TYPEC_HOST;
+		else
+			port->data_role = TYPEC_DEVICE;
+		break;
 	}
 
 	port->id = id;
diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index da179aaf789e..f2d98c3c1f30 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -1219,6 +1219,7 @@ static const struct tcpc_config fusb302_tcpc_config = {
 	.max_snk_mw = 15000,
 	.operating_snk_mw = 2500,
 	.type = TYPEC_PORT_DRP,
+	.data = TYPEC_PORT_DRD,
 	.default_role = TYPEC_SINK,
 	.alt_modes = NULL,
 };
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index cd48a99ee913..064b456dcf04 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -348,7 +348,7 @@ static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
 		else if (port->tcpc->config->default_role == TYPEC_SINK)
 			return SNK_UNATTACHED;
 		/* Fall through to return SRC_UNATTACHED */
-	} else if (port->port_type == TYPEC_PORT_UFP) {
+	} else if (port->port_type == TYPEC_PORT_SNK) {
 		return SNK_UNATTACHED;
 	}
 	return SRC_UNATTACHED;
@@ -2236,7 +2236,7 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
 			return SRC_UNATTACHED;
 		else
 			return SNK_UNATTACHED;
-	} else if (port->port_type == TYPEC_PORT_DFP) {
+	} else if (port->port_type == TYPEC_PORT_SRC) {
 		return SRC_UNATTACHED;
 	}
 
@@ -3526,11 +3526,11 @@ static int tcpm_port_type_set(const struct typec_capability *cap,
 
 	if (!port->connected) {
 		tcpm_set_state(port, PORT_RESET, 0);
-	} else if (type == TYPEC_PORT_UFP) {
+	} else if (type == TYPEC_PORT_SNK) {
 		if (!(port->pwr_role == TYPEC_SINK &&
 		      port->data_role == TYPEC_DEVICE))
 			tcpm_set_state(port, PORT_RESET, 0);
-	} else if (type == TYPEC_PORT_DFP) {
+	} else if (type == TYPEC_PORT_SRC) {
 		if (!(port->pwr_role == TYPEC_SOURCE &&
 		      port->data_role == TYPEC_HOST))
 			tcpm_set_state(port, PORT_RESET, 0);
@@ -3720,6 +3720,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	port->typec_caps.prefer_role = tcpc->config->default_role;
 	port->typec_caps.type = tcpc->config->type;
+	port->typec_caps.data = tcpc->config->data;
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
 	port->typec_caps.pd_revision = 0x0200;	/* USB-PD spec release 2.0 */
 	port->typec_caps.dr_set = tcpm_dr_set;
diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 37a15c14a6c6..8b8406867c02 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -393,31 +393,39 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	tps->typec_cap.revision = USB_TYPEC_REV_1_2;
+	tps->typec_cap.pd_revision = 0x200;
+	tps->typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	tps->typec_cap.pr_set = tps6598x_pr_set;
+	tps->typec_cap.dr_set = tps6598x_dr_set;
+
 	switch (TPS_SYSCONF_PORTINFO(conf)) {
 	case TPS_PORTINFO_SINK_ACCESSORY:
 	case TPS_PORTINFO_SINK:
-		tps->typec_cap.type = TYPEC_PORT_UFP;
+		tps->typec_cap.type = TYPEC_PORT_SNK;
+		tps->typec_cap.data = TYPEC_PORT_UFP;
 		break;
 	case TPS_PORTINFO_DRP_UFP_DRD:
 	case TPS_PORTINFO_DRP_DFP_DRD:
-		tps->typec_cap.dr_set = tps6598x_dr_set;
-		/* fall through */
+		tps->typec_cap.type = TYPEC_PORT_DRP;
+		tps->typec_cap.data = TYPEC_PORT_DRD;
+		break;
 	case TPS_PORTINFO_DRP_UFP:
+		tps->typec_cap.type = TYPEC_PORT_DRP;
+		tps->typec_cap.data = TYPEC_PORT_UFP;
+		break;
 	case TPS_PORTINFO_DRP_DFP:
-		tps->typec_cap.pr_set = tps6598x_pr_set;
 		tps->typec_cap.type = TYPEC_PORT_DRP;
+		tps->typec_cap.data = TYPEC_PORT_DFP;
 		break;
 	case TPS_PORTINFO_SOURCE:
-		tps->typec_cap.type = TYPEC_PORT_DFP;
+		tps->typec_cap.type = TYPEC_PORT_SRC;
+		tps->typec_cap.data = TYPEC_PORT_DFP;
 		break;
 	default:
 		return -ENODEV;
 	}
 
-	tps->typec_cap.revision = USB_TYPEC_REV_1_2;
-	tps->typec_cap.pd_revision = 0x200;
-	tps->typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
-
 	tps->port = typec_register_port(&client->dev, &tps->typec_cap);
 	if (IS_ERR(tps->port))
 		return PTR_ERR(tps->port);
diff --git a/drivers/usb/typec/typec_wcove.c b/drivers/usb/typec/typec_wcove.c
index 2e990e0d917d..19cca7f1b2c5 100644
--- a/drivers/usb/typec/typec_wcove.c
+++ b/drivers/usb/typec/typec_wcove.c
@@ -572,6 +572,7 @@ static struct tcpc_config wcove_typec_config = {
 	.operating_snk_mw = 15000,
 
 	.type = TYPEC_PORT_DRP,
+	.data = TYPEC_PORT_DRD,
 	.default_role = TYPEC_SINK,
 };
 
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 69d544cfcd45..bf0977fbd100 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -592,11 +592,18 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 		return ret;
 
 	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_DRP)
-		cap->type = TYPEC_PORT_DRP;
+		cap->data = TYPEC_PORT_DRD;
 	else if (con->cap.op_mode & UCSI_CONCAP_OPMODE_DFP)
-		cap->type = TYPEC_PORT_DFP;
+		cap->data = TYPEC_PORT_DFP;
 	else if (con->cap.op_mode & UCSI_CONCAP_OPMODE_UFP)
-		cap->type = TYPEC_PORT_UFP;
+		cap->data = TYPEC_PORT_UFP;
+
+	if (con->cap.provider && con->cap.consumer)
+		cap->type = TYPEC_PORT_DRP;
+	else if (con->cap.provider)
+		cap->type = TYPEC_PORT_SRC;
+	else if (con->cap.consumer)
+		cap->type = TYPEC_PORT_SNK;
 
 	cap->revision = ucsi->cap.typec_version;
 	cap->pd_revision = ucsi->cap.pd_version;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index ca1c0b57f03f..5a5e1d8c5b65 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -91,6 +91,7 @@ struct tcpc_config {
 	unsigned int operating_snk_mw;
 
 	enum typec_port_type type;
+	enum typec_port_data data;
 	enum typec_role default_role;
 	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
 
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 2408e5c2ed91..672b39bb0adc 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -22,9 +22,15 @@ struct typec_port;
 struct fwnode_handle;
 
 enum typec_port_type {
+	TYPEC_PORT_SRC,
+	TYPEC_PORT_SNK,
+	TYPEC_PORT_DRP,
+};
+
+enum typec_port_data {
 	TYPEC_PORT_DFP,
 	TYPEC_PORT_UFP,
-	TYPEC_PORT_DRP,
+	TYPEC_PORT_DRD,
 };
 
 enum typec_plug_type {
@@ -186,10 +192,11 @@ struct typec_partner_desc {
 
 /*
  * struct typec_capability - USB Type-C Port Capabilities
- * @role: DFP (Host-only), UFP (Device-only) or DRP (Dual Role)
+ * @type: Supported power role of the port
+ * @data: Supported data role of the port
  * @revision: USB Type-C Specification release. Binary coded decimal
  * @pd_revision: USB Power Delivery Specification revision if supported
- * @prefer_role: Initial role preference
+ * @prefer_role: Initial role preference (DRP ports).
  * @accessory: Supported Accessory Modes
  * @sw: Cable plug orientation switch
  * @mux: Multiplexer switch for Alternate/Accessory Modes
@@ -205,6 +212,7 @@ struct typec_partner_desc {
  */
 struct typec_capability {
 	enum typec_port_type	type;
+	enum typec_port_data	data;
 	u16			revision; /* 0120H = "1.2" */
 	u16			pd_revision; /* 0300H = "3.0" */
 	int			prefer_role;
-- 
2.16.1
