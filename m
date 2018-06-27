Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDADEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F27425E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F27425E5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965140AbeF0PUi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:20:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:59532 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964840AbeF0PUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:20:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 08:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="67768823"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 08:20:12 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] usb: typec: tcpm: Support for Alternate Modes
Date:   Wed, 27 Jun 2018 18:19:53 +0300
Message-Id: <20180627151953.30942-9-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds more complete handling of VDMs and registration of
partner alternate modes, and introduces callbacks for
alternate mode operations.

Only DFP role is supported for now.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm.c | 165 ++++++++++++++++++++++++++++++++-------
 include/linux/usb/tcpm.h |   9 ---
 2 files changed, 135 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 026be4e1ec75..a15dfe35b0c8 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -26,7 +26,7 @@
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
-#include <linux/usb/typec.h>
+#include <linux/usb/typec_altmode.h>
 #include <linux/workqueue.h>
 
 #define FOREACH_STATE(S)			\
@@ -169,13 +169,14 @@ enum pd_msg_request {
 /* Alternate mode support */
 
 #define SVID_DISCOVERY_MAX	16
+#define ALTMODE_DISCOVERY_MAX	(SVID_DISCOVERY_MAX * MODE_DISCOVERY_MAX)
 
 struct pd_mode_data {
 	int svid_index;		/* current SVID index		*/
 	int nsvids;
 	u16 svids[SVID_DISCOVERY_MAX];
 	int altmodes;		/* number of alternate modes	*/
-	struct typec_altmode_desc altmode_desc[SVID_DISCOVERY_MAX];
+	struct typec_altmode_desc altmode_desc[ALTMODE_DISCOVERY_MAX];
 };
 
 struct pd_pps_data {
@@ -310,8 +311,8 @@ struct tcpm_port {
 
 	/* Alternate mode data */
 	struct pd_mode_data mode_data;
-	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX * 6];
-	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX * 6];
+	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
+	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
 
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
@@ -641,14 +642,14 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 }
 EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
 
-static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
+static int tcpm_mux_set(struct tcpm_port *port, int state,
 			enum usb_role usb_role,
 			enum typec_orientation orientation)
 {
 	int ret;
 
-	tcpm_log(port, "Requesting mux mode %d, usb-role %d, orientation %d",
-		 mode, usb_role, orientation);
+	tcpm_log(port, "Requesting mux state %d, usb-role %d, orientation %d",
+		 state, usb_role, orientation);
 
 	ret = typec_set_orientation(port->typec_port, orientation);
 	if (ret)
@@ -660,7 +661,7 @@ static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
 			return ret;
 	}
 
-	return typec_set_mode(port->typec_port, mode);
+	return typec_set_mode(port->typec_port, state);
 }
 
 static int tcpm_set_polarity(struct tcpm_port *port,
@@ -787,7 +788,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 	else
 		usb_role = USB_ROLE_DEVICE;
 
-	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -1014,36 +1015,57 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
 			 pmdata->altmodes, paltmode->svid,
 			 paltmode->mode, paltmode->vdo);
 
-		port->partner_altmode[pmdata->altmodes] =
-			typec_partner_register_altmode(port->partner, paltmode);
-		if (!port->partner_altmode[pmdata->altmodes]) {
-			tcpm_log(port,
-				 "Failed to register modes for SVID 0x%04x",
-				 paltmode->svid);
-			return;
-		}
 		pmdata->altmodes++;
 	}
 }
 
+static void tcpm_register_partner_altmodes(struct tcpm_port *port)
+{
+	struct pd_mode_data *modep = &port->mode_data;
+	struct typec_altmode *altmode;
+	int i;
+
+	for (i = 0; i < modep->altmodes; i++) {
+		altmode = typec_partner_register_altmode(port->partner,
+						&modep->altmode_desc[i]);
+		if (!altmode)
+			tcpm_log(port, "Failed to register partner SVID 0x%04x",
+				 modep->altmode_desc[i].svid);
+		port->partner_altmode[i] = altmode;
+	}
+}
+
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
 
 static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 			u32 *response)
 {
-	u32 p0 = le32_to_cpu(payload[0]);
-	int cmd_type = PD_VDO_CMDT(p0);
-	int cmd = PD_VDO_CMD(p0);
+	struct typec_altmode *adev;
+	struct typec_altmode *pdev;
 	struct pd_mode_data *modep;
+	u32 p[PD_MAX_PAYLOAD];
 	int rlen = 0;
-	u16 svid;
+	int cmd_type;
+	int cmd;
 	int i;
 
+	for (i = 0; i < cnt; i++)
+		p[i] = le32_to_cpu(payload[i]);
+
+	cmd_type = PD_VDO_CMDT(p[0]);
+	cmd = PD_VDO_CMD(p[0]);
+
 	tcpm_log(port, "Rx VDM cmd 0x%x type %d cmd %d len %d",
-		 p0, cmd_type, cmd, cnt);
+		 p[0], cmd_type, cmd, cnt);
 
 	modep = &port->mode_data;
 
+	adev = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
+				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
+
+	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
+				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
+
 	switch (cmd_type) {
 	case CMDT_INIT:
 		switch (cmd) {
@@ -1065,17 +1087,19 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		case CMD_EXIT_MODE:
 			break;
 		case CMD_ATTENTION:
-			break;
+			/* Attention command does not have response */
+			typec_altmode_attention(adev, p[1]);
+			return 0;
 		default:
 			break;
 		}
 		if (rlen >= 1) {
-			response[0] = p0 | VDO_CMDT(CMDT_RSP_ACK);
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_ACK);
 		} else if (rlen == 0) {
-			response[0] = p0 | VDO_CMDT(CMDT_RSP_NAK);
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 			rlen = 1;
 		} else {
-			response[0] = p0 | VDO_CMDT(CMDT_RSP_BUSY);
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_BUSY);
 			rlen = 1;
 		}
 		break;
@@ -1108,14 +1132,39 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 			svdm_consume_modes(port, payload, cnt);
 			modep->svid_index++;
 			if (modep->svid_index < modep->nsvids) {
-				svid = modep->svids[modep->svid_index];
+				u16 svid = modep->svids[modep->svid_index];
 				response[0] = VDO(svid, 1, CMD_DISCOVER_MODES);
 				rlen = 1;
 			} else {
-				/* enter alternate mode if/when implemented */
+				tcpm_register_partner_altmodes(port);
 			}
 			break;
 		case CMD_ENTER_MODE:
+			typec_altmode_update_active(pdev, true);
+
+			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
+				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
+				response[0] |= VDO_OPOS(adev->mode);
+				return 1;
+			}
+			return 0;
+		case CMD_EXIT_MODE:
+			typec_altmode_update_active(pdev, false);
+
+			/* Back to USB Operation */
+			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
+						     NULL));
+			break;
+		default:
+			break;
+		}
+		break;
+	case CMDT_RSP_NAK:
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			/* Back to USB Operation */
+			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
+						     NULL));
 			break;
 		default:
 			break;
@@ -1125,6 +1174,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		break;
 	}
 
+	/* Informing the alternate mode drivers about everything */
+	typec_altmode_vdm(adev, p[0], &p[1], cnt);
+
 	return rlen;
 }
 
@@ -1408,6 +1460,57 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 	return 0;
 }
 
+static int tcpm_altmode_enter(struct typec_altmode *altmode)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	u32 header;
+
+	mutex_lock(&port->lock);
+	header = VDO(altmode->svid, 1, CMD_ENTER_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm(port, header, NULL, 0);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
+static int tcpm_altmode_exit(struct typec_altmode *altmode)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	u32 header;
+
+	mutex_lock(&port->lock);
+	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm(port, header, NULL, 0);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
+static int tcpm_altmode_vdm(struct typec_altmode *altmode,
+			    u32 header, const u32 *data, int count)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+
+	mutex_lock(&port->lock);
+	tcpm_queue_vdm(port, header, data, count - 1);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
+static const struct typec_altmode_ops tcpm_altmode_ops = {
+	.enter = tcpm_altmode_enter,
+	.exit = tcpm_altmode_exit,
+	.vdm = tcpm_altmode_vdm,
+};
+
 /*
  * PD (data, control) command handling functions
  */
@@ -2539,7 +2642,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
 	return ret;
 }
@@ -2585,7 +2688,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
@@ -4618,6 +4721,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 					 dev_name(dev), paltmode->svid);
 				break;
 			}
+			typec_altmode_set_drvdata(alt, port);
+			alt->ops = &tcpm_altmode_ops;
 			port->port_altmode[i] = alt;
 			i++;
 			paltmode++;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index b231b9314240..8c3df3e11801 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -98,15 +98,6 @@ struct tcpc_config {
 #define TCPC_MUX_DP_ENABLED		BIT(1)	/* DP enabled */
 #define TCPC_MUX_POLARITY_INVERTED	BIT(2)	/* Polarity inverted */
 
-/* Mux modes, decoded to attributes */
-enum tcpc_mux_mode {
-	TYPEC_MUX_NONE	= 0,				/* Open switch */
-	TYPEC_MUX_USB	= TCPC_MUX_USB_ENABLED,		/* USB only */
-	TYPEC_MUX_DP	= TCPC_MUX_DP_ENABLED,		/* DP only */
-	TYPEC_MUX_DOCK	= TCPC_MUX_USB_ENABLED |	/* Both USB and DP */
-			  TCPC_MUX_DP_ENABLED,
-};
-
 /**
  * struct tcpc_dev - Port configuration and callback functions
  * @config:	Pointer to port configuration
-- 
2.18.0

