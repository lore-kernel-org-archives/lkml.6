Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELvwd8p1wOxz7boA2V/yYx0YuXn+R2soX4kIfL0hV9p4l7fLtS+nkNuPnxcg+LWydE2iYCz4
ARC-Seal: i=1; a=rsa-sha256; t=1520608770; cv=none;
        d=google.com; s=arc-20160816;
        b=Ey4o/eqph9HicQUX3sStnxbkmnvAKzTIQUBnOoCg49Dy0bExS3ewLIJ4uzxaiLpKx5
         +mChwdQzVYhncoPKxzCPPMp+ElZFDA4GJiqo2/XBUgjh7hZ4AXBgJnzm8Vb/iXbJZ5uq
         DmSom+4CL2cTLd/3tpqJM9d9PkNlR2JrLK6QH17gatrUIpWx2uBJ4rsQOHR3zWjU9NTG
         sCst5KlIreK4mzy8O8/bQ2Q5Wv9u09AnMH0rfykWARBfoElJ6IsvJ7vTgkpv3WykbJWQ
         mfh7KhuLxFli0w82A9/gEqY0uOrAMaHAieFImHGM+wronocVGcnuv01Do6UI9Zjh+Qzw
         EnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JAqb0+r98Axubl4yoYi+Uh945L1QZNCtUpMocNKB4ZI=;
        b=QOfTcop0atDAWrDttU/KPBqVWTzWqPdtaSedaYp3yof0GJodeUXd4z0Pj4QyYayEqg
         5EpJzbi4fqtK4G0z+Q1pUrUqbdVXa46aJZlIxjvbn6P9EPIB+reaUKPVNJHYNwokKxyA
         u65KUYNSsmlgBYj7au69dbqs8NopYf0j25jv/uJ2jimPG8h4zBg9kxHCKQbgWRSbFBdD
         8gwXiCbuhr/iiNSLwNLE9M9Vig8kgkoCMgpMBYsyi8k8xEa3Vt95JmkBKT3jVGn6lAPA
         jQ20Ok5I5OBAga1AKHJ/khiViB9YYb7f2qlr//o/la7QX0dkJQaNqZRCeFWnvkiwr3Lw
         BnMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,446,1515484800";
   d="scan'208";a="36826703"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Jun Li <jun.li@nxp.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] usb: typec: tcpm: Support for Alternate Modes
Date: Fri,  9 Mar 2018 18:19:18 +0300
Message-Id: <20180309151918.22048-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180309151918.22048-1-heikki.krogerus@linux.intel.com>
References: <20180309151918.22048-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594473861275572113?=
X-GMAIL-MSGID: =?utf-8?q?1594473861275572113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds more complete handling of VDMs and registration of
partner alternate modes, and introduces callbacks for
alternate mode operations.

Only DFP role is supported for now.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm.c | 133 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 111 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index bfb843ebffa6..34bf5c1f4d81 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -158,13 +158,14 @@ enum pd_msg_request {
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
 
 struct tcpm_port {
@@ -280,8 +281,8 @@ struct tcpm_port {
 	/* Alternate mode data */
 
 	struct pd_mode_data mode_data;
-	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX * 6];
-	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX * 6];
+	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
+	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
 
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
@@ -985,36 +986,53 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
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
+	struct typec_altmode *altmode;
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
 
+	altmode = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
+				      PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
+
 	switch (cmd_type) {
 	case CMDT_INIT:
 		switch (cmd) {
@@ -1036,17 +1054,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		case CMD_EXIT_MODE:
 			break;
 		case CMD_ATTENTION:
-			break;
+			typec_altmode_attention(altmode, p[1]);
+			return 0;
 		default:
+			if (typec_altmode_vdm(altmode, p[0], &p[1], cnt) ==
+			    VDM_OK)
+				return 0;
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
@@ -1079,20 +1101,26 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
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
+			typec_altmode_enter(altmode);
+			break;
+		case CMD_EXIT_MODE:
+			typec_altmode_exit(altmode);
 			break;
 		default:
+			typec_altmode_vdm(altmode, p[0], &p[1], cnt);
 			break;
 		}
 		break;
 	default:
+		typec_altmode_vdm(altmode, p[0], &p[1], cnt);
 		break;
 	}
 
@@ -1352,6 +1380,47 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 	return 0;
 }
 
+static void tcpm_altmode_enter(struct typec_altmode *altmode)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	u32 header;
+
+	header = VDO(altmode->svid, 1, CMD_ENTER_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm(port, header, NULL, 0);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+}
+
+static void tcpm_altmode_exit(struct typec_altmode *altmode)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	u32 header;
+
+	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm(port, header, NULL, 0);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+}
+
+static int tcpm_altmode_vdm(struct typec_altmode *altmode,
+			    u32 header, const u32 *data, int count)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+
+	tcpm_queue_vdm(port, header, data, count - 1);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
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
@@ -3479,6 +3548,23 @@ static void tcpm_init(struct tcpm_port *port)
 	tcpm_set_state(port, PORT_RESET, 0);
 }
 
+static int tcpm_activate_mode(struct typec_altmode *alt, int activate)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(alt);
+	u32 header;
+
+	header = VDO(cpu_to_le16(alt->svid), 1,
+		     activate ? CMD_ENTER_MODE : CMD_EXIT_MODE);
+	header |= VDO_OPOS(alt->mode);
+
+	mutex_lock(&port->lock);
+	tcpm_queue_vdm(port, header, NULL, 0);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
 static int tcpm_port_type_set(const struct typec_capability *cap,
 			      enum typec_port_type type)
 {
@@ -3671,6 +3757,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->typec_caps.pr_set = tcpm_pr_set;
 	port->typec_caps.vconn_set = tcpm_vconn_set;
 	port->typec_caps.try_role = tcpm_try_role;
+	port->typec_caps.activate_mode = tcpm_activate_mode;
 	port->typec_caps.port_type_set = tcpm_port_type_set;
 
 	port->partner_desc.identity = &port->partner_ident;
@@ -3703,6 +3790,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 					 dev_name(dev), paltmode->svid);
 				break;
 			}
+			typec_altmode_set_drvdata(alt, port);
+			typec_altmode_register_ops(alt, &tcpm_altmode_ops);
 			port->port_altmode[i] = alt;
 			i++;
 			paltmode++;
-- 
2.16.1
