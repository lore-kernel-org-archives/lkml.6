Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELupIlHWdXw+DvqIpj6E9ACY1IUhFMeCX2QOT5AlykNdU6yfxlNYVQBUgaU1zXkD4ZrbN8dV
ARC-Seal: i=1; a=rsa-sha256; t=1519670368; cv=none;
        d=google.com; s=arc-20160816;
        b=BT20MFFpOj+2AxJx54nKySl46w8+spx3OjsJQtdnnYxEfGNh6ALny435g+R3suFcnH
         UT6UIxint8VIv7AZ9lGAABdZHdY4VjOZEDUUl8r34eR2nKF7HwkcuL7zLNbqyOgOTSLN
         TpE3MOJ51dNuLryCslWZVvzXwRvRdfgbIJqH3WaTDbaiI3j8AD8hEhBp8D1P7u0ZRoIz
         8X/RbPi0rGkR4PmmK5GvH22cCJvNsaBkxlihJKVo3wL9E3lI6RHEG436Kf6rGm2qPQGL
         9oq///2leCafN4rQA9Su04VFIryKB9HtB9q3yJpX1KN03tE64NpgfMiRAFMBfOyBf5/3
         e3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jLCPamjNbLGGzH99LrB79438Ormt/aCt1hM5U43OPDc=;
        b=zHO1pa9x9I9wuKCXbwO1kzIHOuzkIv50l+uuyWz/MPVwxLOJy9KSeymEZUnEm4Knjf
         +6vydy7JjPrF9lo/3cLt+vzqkDoy1XE6IVrHRoJJTG3OEeB7Uw4Z61Vc/Q2bh1AprXOA
         6vUQbAhJJy02BEeQOKTQVyV3vTbZBPD+NYwXOzLb92xQqukcB9CUwBhQCPtdTbjfhA+z
         rFvx3ORixlUXrLWr4vsIWVb6dCsYKb4gFlFCEpGJb2aZ6rwwE/tAf6n5Ih9vWnon2byY
         XQfTGhEXLtRJGylJk00rV2AktKV5sfmISUSvy2+6vBcHtg31qL4GYUpb3gZ6U8goWSxx
         eFeA==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v4 02/12] usb: typec: Start using ERR_PTR
Date: Mon, 26 Feb 2018 19:39:09 +0100
Message-Id: <20180226183919.24353-3-hdegoede@redhat.com>
In-Reply-To: <20180226183919.24353-1-hdegoede@redhat.com>
References: <20180226183919.24353-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454020032800489?=
X-GMAIL-MSGID: =?utf-8?q?1593489875576700443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

In order to allow the USB Type-C Class driver take care of
things like muxes and other possible dependencies for the
port drivers, returning ERR_PTR instead of NULL from the
registration functions in case of failure.

The reason for taking over control of the muxes for example
is because handling them in the port drivers would be just
boilerplate.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-Add Andy's Reviewed-by

Changes in v3:
-Add Guenter's Reviewed-by

Changes in v2:
-Add IS_ERR_OR_NULL() checks to the unregister functions
---
 drivers/usb/typec/tcpm.c      | 16 +++++++++-------
 drivers/usb/typec/tps6598x.c  | 15 ++++++++-------
 drivers/usb/typec/typec.c     | 44 +++++++++++++++++++++----------------------
 drivers/usb/typec/ucsi/ucsi.c | 31 ++++++++++++++++++------------
 4 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index f4d563ee7690..7cd28b700a7f 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -1044,7 +1044,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		break;
 	case CMDT_RSP_ACK:
 		/* silently drop message if we are not connected */
-		if (!port->partner)
+		if (IS_ERR_OR_NULL(port->partner))
 			break;
 
 		switch (cmd) {
@@ -3743,8 +3743,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->port_type = tcpc->config->type;
 
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
-	if (!port->typec_port) {
-		err = -ENOMEM;
+	if (IS_ERR(port->typec_port)) {
+		err = PTR_ERR(port->typec_port);
 		goto out_destroy_wq;
 	}
 
@@ -3753,15 +3753,17 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 		i = 0;
 		while (paltmode->svid && i < ARRAY_SIZE(port->port_altmode)) {
-			port->port_altmode[i] =
-			  typec_port_register_altmode(port->typec_port,
-						      paltmode);
-			if (!port->port_altmode[i]) {
+			struct typec_altmode *alt;
+
+			alt = typec_port_register_altmode(port->typec_port,
+							  paltmode);
+			if (IS_ERR(alt)) {
 				tcpm_log(port,
 					 "%s: failed to register port alternate mode 0x%x",
 					 dev_name(dev), paltmode->svid);
 				break;
 			}
+			port->port_altmode[i] = alt;
 			i++;
 			paltmode++;
 		}
diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 2719f5d382f7..37a15c14a6c6 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -158,15 +158,15 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 		desc.identity = &tps->partner_identity;
 	}
 
-	tps->partner = typec_register_partner(tps->port, &desc);
-	if (!tps->partner)
-		return -ENODEV;
-
 	typec_set_pwr_opmode(tps->port, mode);
 	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
 	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
 	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
 
+	tps->partner = typec_register_partner(tps->port, &desc);
+	if (IS_ERR(tps->partner))
+		return PTR_ERR(tps->partner);
+
 	if (desc.identity)
 		typec_partner_set_identity(tps->partner);
 
@@ -175,7 +175,8 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 
 static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 {
-	typec_unregister_partner(tps->partner);
+	if (!IS_ERR(tps->partner))
+		typec_unregister_partner(tps->partner);
 	tps->partner = NULL;
 	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
 	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
@@ -418,8 +419,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	tps->typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
 
 	tps->port = typec_register_port(&client->dev, &tps->typec_cap);
-	if (!tps->port)
-		return -ENODEV;
+	if (IS_ERR(tps->port))
+		return PTR_ERR(tps->port);
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_connect(tps, status);
diff --git a/drivers/usb/typec/typec.c b/drivers/usb/typec/typec.c
index 735726ced602..dc28ad868d93 100644
--- a/drivers/usb/typec/typec.c
+++ b/drivers/usb/typec/typec.c
@@ -386,7 +386,7 @@ typec_register_altmode(struct device *parent,
 
 	alt = kzalloc(sizeof(*alt), GFP_KERNEL);
 	if (!alt)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	alt->svid = desc->svid;
 	alt->n_modes = desc->n_modes;
@@ -402,7 +402,7 @@ typec_register_altmode(struct device *parent,
 		dev_err(parent, "failed to register alternate mode (%d)\n",
 			ret);
 		put_device(&alt->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return alt;
@@ -417,7 +417,7 @@ typec_register_altmode(struct device *parent,
  */
 void typec_unregister_altmode(struct typec_altmode *alt)
 {
-	if (alt)
+	if (!IS_ERR_OR_NULL(alt))
 		device_unregister(&alt->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_altmode);
@@ -509,7 +509,7 @@ EXPORT_SYMBOL_GPL(typec_partner_register_altmode);
  *
  * Registers a device for USB Type-C Partner described in @desc.
  *
- * Returns handle to the partner on success or NULL on failure.
+ * Returns handle to the partner on success or ERR_PTR on failure.
  */
 struct typec_partner *typec_register_partner(struct typec_port *port,
 					     struct typec_partner_desc *desc)
@@ -519,7 +519,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 
 	partner = kzalloc(sizeof(*partner), GFP_KERNEL);
 	if (!partner)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	partner->usb_pd = desc->usb_pd;
 	partner->accessory = desc->accessory;
@@ -542,7 +542,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	if (ret) {
 		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
 		put_device(&partner->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return partner;
@@ -557,7 +557,7 @@ EXPORT_SYMBOL_GPL(typec_register_partner);
  */
 void typec_unregister_partner(struct typec_partner *partner)
 {
-	if (partner)
+	if (!IS_ERR_OR_NULL(partner))
 		device_unregister(&partner->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_partner);
@@ -587,7 +587,7 @@ static const struct device_type typec_plug_dev_type = {
  * the plug lists in response to Discover Modes command need to be listed in an
  * array in @desc.
  *
- * Returns handle to the alternate mode on success or NULL on failure.
+ * Returns handle to the alternate mode on success or ERR_PTR on failure.
  */
 struct typec_altmode *
 typec_plug_register_altmode(struct typec_plug *plug,
@@ -606,7 +606,7 @@ EXPORT_SYMBOL_GPL(typec_plug_register_altmode);
  * Cable Plug represents a plug with electronics in it that can response to USB
  * Power Delivery SOP Prime or SOP Double Prime packages.
  *
- * Returns handle to the cable plug on success or NULL on failure.
+ * Returns handle to the cable plug on success or ERR_PTR on failure.
  */
 struct typec_plug *typec_register_plug(struct typec_cable *cable,
 				       struct typec_plug_desc *desc)
@@ -617,7 +617,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 
 	plug = kzalloc(sizeof(*plug), GFP_KERNEL);
 	if (!plug)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	sprintf(name, "plug%d", desc->index);
 
@@ -631,7 +631,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 	if (ret) {
 		dev_err(&cable->dev, "failed to register plug (%d)\n", ret);
 		put_device(&plug->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return plug;
@@ -646,7 +646,7 @@ EXPORT_SYMBOL_GPL(typec_register_plug);
  */
 void typec_unregister_plug(struct typec_plug *plug)
 {
-	if (plug)
+	if (!IS_ERR_OR_NULL(plug))
 		device_unregister(&plug->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_plug);
@@ -724,7 +724,7 @@ EXPORT_SYMBOL_GPL(typec_cable_set_identity);
  * Registers a device for USB Type-C Cable described in @desc. The cable will be
  * parent for the optional cable plug devises.
  *
- * Returns handle to the cable on success or NULL on failure.
+ * Returns handle to the cable on success or ERR_PTR on failure.
  */
 struct typec_cable *typec_register_cable(struct typec_port *port,
 					 struct typec_cable_desc *desc)
@@ -734,7 +734,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 
 	cable = kzalloc(sizeof(*cable), GFP_KERNEL);
 	if (!cable)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	cable->type = desc->type;
 	cable->active = desc->active;
@@ -757,7 +757,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 	if (ret) {
 		dev_err(&port->dev, "failed to register cable (%d)\n", ret);
 		put_device(&cable->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return cable;
@@ -772,7 +772,7 @@ EXPORT_SYMBOL_GPL(typec_register_cable);
  */
 void typec_unregister_cable(struct typec_cable *cable)
 {
-	if (cable)
+	if (!IS_ERR_OR_NULL(cable))
 		device_unregister(&cable->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_cable);
@@ -1256,7 +1256,7 @@ EXPORT_SYMBOL_GPL(typec_set_pwr_opmode);
  * This routine is used to register an alternate mode that @port is capable of
  * supporting.
  *
- * Returns handle to the alternate mode on success or NULL on failure.
+ * Returns handle to the alternate mode on success or ERR_PTR on failure.
  */
 struct typec_altmode *
 typec_port_register_altmode(struct typec_port *port,
@@ -1273,7 +1273,7 @@ EXPORT_SYMBOL_GPL(typec_port_register_altmode);
  *
  * Registers a device for USB Type-C Port described in @cap.
  *
- * Returns handle to the port on success or NULL on failure.
+ * Returns handle to the port on success or ERR_PTR on failure.
  */
 struct typec_port *typec_register_port(struct device *parent,
 				       const struct typec_capability *cap)
@@ -1285,12 +1285,12 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&typec_index_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		kfree(port);
-		return NULL;
+		return ERR_PTR(id);
 	}
 
 	if (cap->type == TYPEC_PORT_DFP)
@@ -1326,7 +1326,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
 		put_device(&port->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return port;
@@ -1341,7 +1341,7 @@ EXPORT_SYMBOL_GPL(typec_register_port);
  */
 void typec_unregister_port(struct typec_port *port)
 {
-	if (port)
+	if (!IS_ERR_OR_NULL(port))
 		device_unregister(&port->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_port);
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 79046fe66426..69d544cfcd45 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -260,38 +260,45 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 
 static int ucsi_register_partner(struct ucsi_connector *con)
 {
-	struct typec_partner_desc partner;
+	struct typec_partner_desc desc;
+	struct typec_partner *partner;
 
 	if (con->partner)
 		return 0;
 
-	memset(&partner, 0, sizeof(partner));
+	memset(&desc, 0, sizeof(desc));
 
 	switch (con->status.partner_type) {
 	case UCSI_CONSTAT_PARTNER_TYPE_DEBUG:
-		partner.accessory = TYPEC_ACCESSORY_DEBUG;
+		desc.accessory = TYPEC_ACCESSORY_DEBUG;
 		break;
 	case UCSI_CONSTAT_PARTNER_TYPE_AUDIO:
-		partner.accessory = TYPEC_ACCESSORY_AUDIO;
+		desc.accessory = TYPEC_ACCESSORY_AUDIO;
 		break;
 	default:
 		break;
 	}
 
-	partner.usb_pd = con->status.pwr_op_mode == UCSI_CONSTAT_PWR_OPMODE_PD;
+	desc.usb_pd = con->status.pwr_op_mode == UCSI_CONSTAT_PWR_OPMODE_PD;
 
-	con->partner = typec_register_partner(con->port, &partner);
-	if (!con->partner) {
-		dev_err(con->ucsi->dev, "con%d: failed to register partner\n",
-			con->num);
-		return -ENODEV;
+	partner = typec_register_partner(con->port, &desc);
+	if (IS_ERR(partner)) {
+		dev_err(con->ucsi->dev,
+			"con%d: failed to register partner (%ld)\n", con->num,
+			PTR_ERR(partner));
+		return PTR_ERR(partner);
 	}
 
+	con->partner = partner;
+
 	return 0;
 }
 
 static void ucsi_unregister_partner(struct ucsi_connector *con)
 {
+	if (!con->partner)
+		return;
+
 	typec_unregister_partner(con->partner);
 	con->partner = NULL;
 }
@@ -606,8 +613,8 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 
 	/* Register the connector */
 	con->port = typec_register_port(ucsi->dev, cap);
-	if (!con->port)
-		return -ENODEV;
+	if (IS_ERR(con->port))
+		return PTR_ERR(con->port);
 
 	/* Get the status */
 	UCSI_CMD_GET_CONNECTOR_STATUS(ctrl, con->num);
-- 
2.14.3
