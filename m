Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TT1BE8VoGls7TwAAmS7hNA
	; Fri, 08 Jun 2018 11:30:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B7026089E; Fri,  8 Jun 2018 11:30:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3FD74601D2;
	Fri,  8 Jun 2018 11:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FD74601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeFHLaJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:30:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:32425 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbeFHLaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:30:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 04:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="62389035"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2018 04:30:01 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 8/8] usb: typec: tcpm: Support for Alternate Modes
Date: Fri,  8 Jun 2018 14:29:41 +0300
Message-Id: <20180608112941.26332-9-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
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
 drivers/usb/typec/tcpm.c | 161 +++++++++++++++++++++++++++++++--------
 include/linux/usb/tcpm.h |   9 ---
 2 files changed, 131 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 44ce3955cb59..e1b52b5e78b5 100644
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
@@ -640,14 +641,14 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
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
@@ -659,7 +660,7 @@ static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
 			return ret;
 	}
 
-	return typec_set_mode(port->typec_port, mode);
+	return typec_set_mode(port->typec_port, state);
 }
 
 static int tcpm_set_polarity(struct tcpm_port *port,
@@ -786,7 +787,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 	else
 		usb_role = USB_ROLE_DEVICE;
 
-	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -1013,36 +1014,57 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
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
@@ -1064,17 +1086,19 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
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
@@ -1107,14 +1131,39 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
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
@@ -1124,6 +1173,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		break;
 	}
 
+	/* Informing the alternate mode drivers about everything */
+	typec_altmode_vdm(adev, p[0], &p[1], cnt);
+
 	return rlen;
 }
 
@@ -1407,6 +1459,53 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 	return 0;
 }
 
+static void tcpm_altmode_enter(struct typec_altmode *altmode)
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
+}
+
+static void tcpm_altmode_exit(struct typec_altmode *altmode)
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
@@ -2538,7 +2637,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
 	return ret;
 }
@@ -2584,7 +2683,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
@@ -4616,6 +4715,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
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
2.17.1
