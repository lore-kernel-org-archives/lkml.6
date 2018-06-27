Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C924DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749DF25E5C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749DF25E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964839AbeF0PUV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:20:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:43102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934694AbeF0PUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:20:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 08:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="67768752"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 08:20:01 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] usb: typec: Register a device for every mode
Date:   Wed, 27 Jun 2018 18:19:49 +0300
Message-Id: <20180627151953.30942-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before a device was created for every discovered SVID, but
this will create a device for every discovered mode of every
SVID. The idea is to make it easier to create mode specific
drivers once a bus for the alternate mode is added.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 172 ++++++++++++--------------------------
 drivers/usb/typec/tcpm.c  |  45 +++++-----
 include/linux/usb/typec.h |  37 ++------
 3 files changed, 83 insertions(+), 171 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index b860bd3a0acb..094ef617b527 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -13,31 +13,20 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_mux.h>
 
-struct typec_mode {
-	int				index;
+struct typec_altmode {
+	struct device			dev;
+	u16				svid;
+	u8				mode;
+
 	u32				vdo;
 	char				*desc;
 	enum typec_port_type		roles;
-
-	struct typec_altmode		*alt_mode;
-
 	unsigned int			active:1;
 
+	struct attribute		*attrs[5];
 	char				group_name[6];
 	struct attribute_group		group;
-	struct attribute		*attrs[5];
-	struct device_attribute		vdo_attr;
-	struct device_attribute		desc_attr;
-	struct device_attribute		active_attr;
-	struct device_attribute		roles_attr;
-};
-
-struct typec_altmode {
-	struct device			dev;
-	u16				svid;
-	int				n_modes;
-	struct typec_mode		modes[ALTMODE_MAX_MODES];
-	const struct attribute_group	*mode_groups[ALTMODE_MAX_MODES];
+	const struct attribute_group	*groups[2];
 };
 
 struct typec_plug {
@@ -177,23 +166,20 @@ static void typec_report_identity(struct device *dev)
 /**
  * typec_altmode_update_active - Report Enter/Exit mode
  * @alt: Handle to the alternate mode
- * @mode: Mode index
  * @active: True when the mode has been entered
  *
  * If a partner or cable plug executes Enter/Exit Mode command successfully, the
  * drivers use this routine to report the updated state of the mode.
  */
-void typec_altmode_update_active(struct typec_altmode *alt, int mode,
-				 bool active)
+void typec_altmode_update_active(struct typec_altmode *alt, bool active)
 {
-	struct typec_mode *m = &alt->modes[mode];
 	char dir[6];
 
-	if (m->active == active)
+	if (alt->active == active)
 		return;
 
-	m->active = active;
-	snprintf(dir, sizeof(dir), "mode%d", mode);
+	alt->active = active;
+	snprintf(dir, sizeof(dir), "mode%d", alt->mode);
 	sysfs_notify(&alt->dev.kobj, dir, "active");
 	kobject_uevent(&alt->dev.kobj, KOBJ_CHANGE);
 }
@@ -220,42 +206,36 @@ struct typec_port *typec_altmode2port(struct typec_altmode *alt)
 EXPORT_SYMBOL_GPL(typec_altmode2port);
 
 static ssize_t
-typec_altmode_vdo_show(struct device *dev, struct device_attribute *attr,
-		       char *buf)
+vdo_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       vdo_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 
-	return sprintf(buf, "0x%08x\n", mode->vdo);
+	return sprintf(buf, "0x%08x\n", alt->vdo);
 }
+static DEVICE_ATTR_RO(vdo);
 
 static ssize_t
-typec_altmode_desc_show(struct device *dev, struct device_attribute *attr,
-			char *buf)
+description_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       desc_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 
-	return sprintf(buf, "%s\n", mode->desc ? mode->desc : "");
+	return sprintf(buf, "%s\n", alt->desc ? alt->desc : "");
 }
+static DEVICE_ATTR_RO(description);
 
 static ssize_t
-typec_altmode_active_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
+active_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       active_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 
-	return sprintf(buf, "%s\n", mode->active ? "yes" : "no");
+	return sprintf(buf, "%s\n", alt->active ? "yes" : "no");
 }
 
-static ssize_t
-typec_altmode_active_store(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t size)
+static ssize_t active_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t size)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       active_attr);
-	struct typec_port *port = typec_altmode2port(mode->alt_mode);
+	struct typec_altmode *alt = to_altmode(dev);
+	struct typec_port *port = typec_altmode2port(alt);
 	bool activate;
 	int ret;
 
@@ -266,22 +246,22 @@ typec_altmode_active_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	ret = port->cap->activate_mode(port->cap, mode->index, activate);
+	ret = port->cap->activate_mode(port->cap, alt->mode, activate);
 	if (ret)
 		return ret;
 
 	return size;
 }
+static DEVICE_ATTR_RW(active);
 
 static ssize_t
-typec_altmode_roles_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+supported_roles_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       roles_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 	ssize_t ret;
 
-	switch (mode->roles) {
+	switch (alt->roles) {
 	case TYPEC_PORT_SRC:
 		ret = sprintf(buf, "source\n");
 		break;
@@ -295,61 +275,13 @@ typec_altmode_roles_show(struct device *dev, struct device_attribute *attr,
 	}
 	return ret;
 }
+static DEVICE_ATTR_RO(supported_roles);
 
-static void typec_init_modes(struct typec_altmode *alt,
-			     const struct typec_mode_desc *desc, bool is_port)
+static void typec_altmode_release(struct device *dev)
 {
-	int i;
-
-	for (i = 0; i < alt->n_modes; i++, desc++) {
-		struct typec_mode *mode = &alt->modes[i];
-
-		/* Not considering the human readable description critical */
-		mode->desc = kstrdup(desc->desc, GFP_KERNEL);
-		if (desc->desc && !mode->desc)
-			dev_err(&alt->dev, "failed to copy mode%d desc\n", i);
-
-		mode->alt_mode = alt;
-		mode->vdo = desc->vdo;
-		mode->roles = desc->roles;
-		mode->index = desc->index;
-		sprintf(mode->group_name, "mode%d", desc->index);
-
-		sysfs_attr_init(&mode->vdo_attr.attr);
-		mode->vdo_attr.attr.name = "vdo";
-		mode->vdo_attr.attr.mode = 0444;
-		mode->vdo_attr.show = typec_altmode_vdo_show;
-
-		sysfs_attr_init(&mode->desc_attr.attr);
-		mode->desc_attr.attr.name = "description";
-		mode->desc_attr.attr.mode = 0444;
-		mode->desc_attr.show = typec_altmode_desc_show;
-
-		sysfs_attr_init(&mode->active_attr.attr);
-		mode->active_attr.attr.name = "active";
-		mode->active_attr.attr.mode = 0644;
-		mode->active_attr.show = typec_altmode_active_show;
-		mode->active_attr.store = typec_altmode_active_store;
-
-		mode->attrs[0] = &mode->vdo_attr.attr;
-		mode->attrs[1] = &mode->desc_attr.attr;
-		mode->attrs[2] = &mode->active_attr.attr;
-
-		/* With ports, list the roles that the mode is supported with */
-		if (is_port) {
-			sysfs_attr_init(&mode->roles_attr.attr);
-			mode->roles_attr.attr.name = "supported_roles";
-			mode->roles_attr.attr.mode = 0444;
-			mode->roles_attr.show = typec_altmode_roles_show;
-
-			mode->attrs[3] = &mode->roles_attr.attr;
-		}
-
-		mode->group.attrs = mode->attrs;
-		mode->group.name = mode->group_name;
+	struct typec_altmode *alt = to_altmode(dev);
 
-		alt->mode_groups[i] = &mode->group;
-	}
+	kfree(alt);
 }
 
 static ssize_t svid_show(struct device *dev, struct device_attribute *attr,
@@ -367,16 +299,6 @@ static struct attribute *typec_altmode_attrs[] = {
 };
 ATTRIBUTE_GROUPS(typec_altmode);
 
-static void typec_altmode_release(struct device *dev)
-{
-	struct typec_altmode *alt = to_altmode(dev);
-	int i;
-
-	for (i = 0; i < alt->n_modes; i++)
-		kfree(alt->modes[i].desc);
-	kfree(alt);
-}
-
 static const struct device_type typec_altmode_dev_type = {
 	.name = "typec_alternate_mode",
 	.groups = typec_altmode_groups,
@@ -395,13 +317,27 @@ typec_register_altmode(struct device *parent,
 		return ERR_PTR(-ENOMEM);
 
 	alt->svid = desc->svid;
-	alt->n_modes = desc->n_modes;
-	typec_init_modes(alt, desc->modes, is_typec_port(parent));
+	alt->mode = desc->mode;
+	alt->vdo = desc->vdo;
+	alt->roles = desc->roles;
+
+	alt->attrs[0] = &dev_attr_vdo.attr;
+	alt->attrs[1] = &dev_attr_description.attr;
+	alt->attrs[2] = &dev_attr_active.attr;
+
+	if (is_typec_port(parent))
+		alt->attrs[3] = &dev_attr_supported_roles.attr;
+
+	sprintf(alt->group_name, "mode%d", desc->mode);
+	alt->group.name = alt->group_name;
+	alt->group.attrs = alt->attrs;
+	alt->groups[0] = &alt->group;
 
 	alt->dev.parent = parent;
-	alt->dev.groups = alt->mode_groups;
+	alt->dev.groups = alt->groups;
 	alt->dev.type = &typec_altmode_dev_type;
-	dev_set_name(&alt->dev, "svid-%04x", alt->svid);
+	dev_set_name(&alt->dev, "%s-%04x:%u", dev_name(parent),
+		     alt->svid, alt->mode);
 
 	ret = device_register(&alt->dev);
 	if (ret) {
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index d961f1ec0e08..026be4e1ec75 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -310,8 +310,8 @@ struct tcpm_port {
 
 	/* Alternate mode data */
 	struct pd_mode_data mode_data;
-	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX];
-	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX];
+	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX * 6];
+	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX * 6];
 
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
@@ -995,7 +995,6 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
 {
 	struct pd_mode_data *pmdata = &port->mode_data;
 	struct typec_altmode_desc *paltmode;
-	struct typec_mode_desc *pmode;
 	int i;
 
 	if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
@@ -1003,32 +1002,28 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
 		return;
 	}
 
-	paltmode = &pmdata->altmode_desc[pmdata->altmodes];
-	memset(paltmode, 0, sizeof(*paltmode));
+	for (i = 1; i < cnt; i++) {
+		paltmode = &pmdata->altmode_desc[pmdata->altmodes];
+		memset(paltmode, 0, sizeof(*paltmode));
 
-	paltmode->svid = pmdata->svids[pmdata->svid_index];
+		paltmode->svid = pmdata->svids[pmdata->svid_index];
+		paltmode->mode = i;
+		paltmode->vdo = le32_to_cpu(payload[i]);
 
-	tcpm_log(port, " Alternate mode %d: SVID 0x%04x",
-		 pmdata->altmodes, paltmode->svid);
+		tcpm_log(port, " Alternate mode %d: SVID 0x%04x, VDO %d: 0x%08x",
+			 pmdata->altmodes, paltmode->svid,
+			 paltmode->mode, paltmode->vdo);
 
-	for (i = 1; i < cnt && paltmode->n_modes < ALTMODE_MAX_MODES; i++) {
-		pmode = &paltmode->modes[paltmode->n_modes];
-		memset(pmode, 0, sizeof(*pmode));
-		pmode->vdo = le32_to_cpu(payload[i]);
-		pmode->index = i - 1;
-		paltmode->n_modes++;
-		tcpm_log(port, "  VDO %d: 0x%08x",
-			 pmode->index, pmode->vdo);
-	}
-	port->partner_altmode[pmdata->altmodes] =
-		typec_partner_register_altmode(port->partner, paltmode);
-	if (!port->partner_altmode[pmdata->altmodes]) {
-		tcpm_log(port,
-			 "Failed to register alternate modes for SVID 0x%04x",
-			 paltmode->svid);
-		return;
+		port->partner_altmode[pmdata->altmodes] =
+			typec_partner_register_altmode(port->partner, paltmode);
+		if (!port->partner_altmode[pmdata->altmodes]) {
+			tcpm_log(port,
+				 "Failed to register modes for SVID 0x%04x",
+				 paltmode->svid);
+			return;
+		}
+		pmdata->altmodes++;
 	}
-	pmdata->altmodes++;
 }
 
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index a5f6433e218b..51c76591c506 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -93,41 +93,23 @@ int typec_partner_set_identity(struct typec_partner *partner);
 int typec_cable_set_identity(struct typec_cable *cable);
 
 /*
- * struct typec_mode_desc - Individual Mode of an Alternate Mode
- * @index: Index of the Mode within the SVID
+ * struct typec_altmode_desc - USB Type-C Alternate Mode Descriptor
+ * @svid: Standard or Vendor ID
+ * @mode: Index of the Mode
  * @vdo: VDO returned by Discover Modes USB PD command
- * @desc: Optional human readable description of the mode
  * @roles: Only for ports. DRP if the mode is available in both roles
  *
- * Description of a mode of an Alternate Mode which a connector, cable plug or
- * partner supports. Every mode will have it's own sysfs group. The details are
- * the VDO returned by discover modes command, description for the mode and
- * active flag telling has the mode being entered or not.
+ * Description of an Alternate Mode which a connector, cable plug or partner
+ * supports.
  */
-struct typec_mode_desc {
-	int			index;
+struct typec_altmode_desc {
+	u16			svid;
+	u8			mode;
 	u32			vdo;
-	char			*desc;
 	/* Only used with ports */
 	enum typec_port_type	roles;
 };
 
-/*
- * struct typec_altmode_desc - USB Type-C Alternate Mode Descriptor
- * @svid: Standard or Vendor ID
- * @n_modes: Number of modes
- * @modes: Array of modes supported by the Alternate Mode
- *
- * Representation of an Alternate Mode that has SVID assigned by USB-IF. The
- * array of modes will list the modes of a particular SVID that are supported by
- * a connector, partner of a cable plug.
- */
-struct typec_altmode_desc {
-	u16			svid;
-	int			n_modes;
-	struct typec_mode_desc	modes[ALTMODE_MAX_MODES];
-};
-
 struct typec_altmode
 *typec_partner_register_altmode(struct typec_partner *partner,
 				const struct typec_altmode_desc *desc);
@@ -141,8 +123,7 @@ void typec_unregister_altmode(struct typec_altmode *altmode);
 
 struct typec_port *typec_altmode2port(struct typec_altmode *alt);
 
-void typec_altmode_update_active(struct typec_altmode *alt, int mode,
-				 bool active);
+void typec_altmode_update_active(struct typec_altmode *alt, bool active);
 
 enum typec_plug_index {
 	TYPEC_PLUG_SOP_P,
-- 
2.18.0

