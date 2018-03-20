Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELsBgVzpc8oIflRbK+s+maSpbNUqzfimALqbfByOwprnFLa/53+NSj+LvRMHKT+Q2zhPZy9k
ARC-Seal: i=1; a=rsa-sha256; t=1521550651; cv=none;
        d=google.com; s=arc-20160816;
        b=GbBR8PVD+cW6haDplKfwtDXRMJR+s2F6jnPwyuFHF3zNsbycFR+o/UUFBM1pB1e3CL
         kHcGtZk5rmB4TOH4bCDP8A3zmIKmz19tWGoDLT4fQiomEAhPwzBOiJj2m2aOWnqqUamG
         Qs0epSEHV8a1UCBXDvMqaI+aLr1rmUxgHfqHz3MSpdJeRblN1xZaoiODwj0R2dljo7Hk
         j6EdMKBBFEi12LpT2zexXkdpHw6WpRrrGswY+UPiS9phEGwFLlnpT9pFEOaeBA4C7wrl
         1RBhY5kQEZDxk0RARXfjwjtWVU7u/uEPbqcyQdHNHIyDpgnclSSlij9nMMxFZFwdS/MQ
         cgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7wrGeOQqOyvSDIlSamd5tbHRA6cb8ZdCZhCfEsDizCg=;
        b=hSiRpQfbY0QshkdPifZ2MpjCyN5aNq1swwQKmvBoXv63qieN4hbxqplmOhrFp9wWLg
         gaQTd0Iwmil3nn7Fqo5f+jXNbsMpULB7nNgLG2rMzAPTqiEgSqqPeGwXzccdl2ODGZ/U
         arjpegJqoldns/0O6mOBVVwcGZHYrQ6fcRLrXr7OT/1a29UV4Qr3YQSzOePxHByT47mu
         IDO1jVbWVhq1rA5NiY9gMKOqTVRldZgOmlg1BIlNRYUTMz05aWKbLI311mtCchBbGSs4
         4wB7/41QbzWjw769mkXcIJpnfADqIUrXuAh8J17V4g36K0gQBjxxsTTMb3WDUvVv3ITr
         6t2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="39592522"
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
Subject: [PATCH v9 04/12] usb: typec: Separate the definitions for data and power roles
Date: Tue, 20 Mar 2018 15:57:05 +0300
Message-Id: <20180320125713.85465-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
References: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595461496070643770?=
X-GMAIL-MSGID: =?utf-8?q?1595461496070643770?=
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
index 06794c06330f..82bf7c0ed53c 100644
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
index 4c0fc5493d58..62e710bb6367 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -345,7 +345,7 @@ static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
 		else if (port->tcpc->config->default_role == TYPEC_SINK)
 			return SNK_UNATTACHED;
 		/* Fall through to return SRC_UNATTACHED */
-	} else if (port->port_type == TYPEC_PORT_UFP) {
+	} else if (port->port_type == TYPEC_PORT_SNK) {
 		return SNK_UNATTACHED;
 	}
 	return SRC_UNATTACHED;
@@ -2179,7 +2179,7 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
 			return SRC_UNATTACHED;
 		else
 			return SNK_UNATTACHED;
-	} else if (port->port_type == TYPEC_PORT_DFP) {
+	} else if (port->port_type == TYPEC_PORT_SRC) {
 		return SRC_UNATTACHED;
 	}
 
@@ -3469,11 +3469,11 @@ static int tcpm_port_type_set(const struct typec_capability *cap,
 
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
@@ -3641,6 +3641,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
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
2.16.2
