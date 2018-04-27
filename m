Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrLObJP42cpARRK8XND+h3Cds1d/mXClAnISd3mROWnp3SUomqvUTQgwJikd9AsiNCW+WBA
ARC-Seal: i=1; a=rsa-sha256; t=1524838281; cv=none;
        d=google.com; s=arc-20160816;
        b=KVTrwqmCysELx0eACT8ww0ZL91EYOroeBxrwgrMjTcFdNlT3oBGcdcNdyA79L4mXb5
         GNlAMA751Jvpmv9P5VfInH49fdDHm00X/v+vAUux1M/0wmXCYAQwxuttWfmI6mKzxRSI
         MdAfm7elPWwwMaTgA/b5XH77EybEhqtsRKdaNMEv3jeabrbg/t8SF9zNZ2ek27aKeSiM
         oY2Qn9I4bxdTUm1x9vpFf+WwPOrHNOZ+eRzvtsB/5GV/Vmb09J6dOoMzXWeBwgwU66mC
         P8o+bUi7lQRKJUXMyPd7e8ypzSRZF3Fq1FlDBmqv/XNQvRAfpZa/gf6KKtvs89WOryau
         C3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=HN9MliDuuSJr8daMEVM7x98Ozk1mkaKMiNLdOouuFCk=;
        b=YUv1eDpjxzabpetAIxd4w+jKLeh/sMLI2m+psyUwWTLZFZRyDDQaCwqaIupDXset0S
         vwr177G9yN0pouGKtRaGKtHhbFlQwRSctNprpwJ0Bp1bmvpDSoyRt91iQCfAR+q1wu9Z
         rvU/fHcIApa4iX1xM8kRoPYu0cy3Ju3q/jWPv7pvrZ2UlYvqo27qoE+B4TUZK+mkiK7I
         U6AVfWEgXvcJQ4fm1dNVqrA/6kH89nmWJIZZJHbf7ltSCyq239c6VyUcoGg9R1cEyN+Q
         AOl+K+Kx7jN5Eg2BavaYgu4feVQPUMY/AZoIHl6tZy4kHZapaGP9dc8FvaBL9oKO7cCa
         QdiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C1121892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 47/81] s390/qeth: fix error handling in adapter command callbacks
Date: Fri, 27 Apr 2018 15:58:49 +0200
Message-Id: <20180427135745.916829305@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908825978408515?=
X-GMAIL-MSGID: =?utf-8?q?1598908825978408515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 686c97ee29c886ee07d17987d0059874c5c3b5af ]

Make sure to check both return code fields before(!) processing the
command response. Otherwise we risk operating on invalid data.

This matches an earlier fix for SETASSPARMS commands, see
commit ad3cbf613329 ("s390/qeth: fix error handling in checksum cmd callback").

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   85 ++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3037,28 +3037,23 @@ static int qeth_send_startlan(struct qet
 	return rc;
 }
 
-static int qeth_default_setadapterparms_cb(struct qeth_card *card,
-		struct qeth_reply *reply, unsigned long data)
+static int qeth_setadpparms_inspect_rc(struct qeth_ipa_cmd *cmd)
 {
-	struct qeth_ipa_cmd *cmd;
-
-	QETH_CARD_TEXT(card, 4, "defadpcb");
-
-	cmd = (struct qeth_ipa_cmd *) data;
-	if (cmd->hdr.return_code == 0)
+	if (!cmd->hdr.return_code)
 		cmd->hdr.return_code =
 			cmd->data.setadapterparms.hdr.return_code;
-	return 0;
+	return cmd->hdr.return_code;
 }
 
 static int qeth_query_setadapterparms_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 
 	QETH_CARD_TEXT(card, 3, "quyadpcb");
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	if (cmd->data.setadapterparms.data.query_cmds_supp.lan_type & 0x7f) {
 		card->info.link_type =
 		      cmd->data.setadapterparms.data.query_cmds_supp.lan_type;
@@ -3066,7 +3061,7 @@ static int qeth_query_setadapterparms_cb
 	}
 	card->options.adp.supported_funcs =
 		cmd->data.setadapterparms.data.query_cmds_supp.supported_cmds;
-	return qeth_default_setadapterparms_cb(card, reply, (unsigned long)cmd);
+	return 0;
 }
 
 static struct qeth_cmd_buffer *qeth_get_adapter_cmd(struct qeth_card *card,
@@ -3158,22 +3153,20 @@ EXPORT_SYMBOL_GPL(qeth_query_ipassists);
 static int qeth_query_switch_attributes_cb(struct qeth_card *card,
 				struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
-	struct qeth_switch_info *sw_info;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_query_switch_attributes *attrs;
+	struct qeth_switch_info *sw_info;
 
 	QETH_CARD_TEXT(card, 2, "qswiatcb");
-	cmd = (struct qeth_ipa_cmd *) data;
-	sw_info = (struct qeth_switch_info *)reply->param;
-	if (cmd->data.setadapterparms.hdr.return_code == 0) {
-		attrs = &cmd->data.setadapterparms.data.query_switch_attributes;
-		sw_info->capabilities = attrs->capabilities;
-		sw_info->settings = attrs->settings;
-		QETH_CARD_TEXT_(card, 2, "%04x%04x", sw_info->capabilities,
-							sw_info->settings);
-	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
+	sw_info = (struct qeth_switch_info *)reply->param;
+	attrs = &cmd->data.setadapterparms.data.query_switch_attributes;
+	sw_info->capabilities = attrs->capabilities;
+	sw_info->settings = attrs->settings;
+	QETH_CARD_TEXT_(card, 2, "%04x%04x", sw_info->capabilities,
+			sw_info->settings);
 	return 0;
 }
 
@@ -4211,16 +4204,13 @@ EXPORT_SYMBOL_GPL(qeth_do_send_packet);
 static int qeth_setadp_promisc_mode_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_ipacmd_setadpparms *setparms;
 
 	QETH_CARD_TEXT(card, 4, "prmadpcb");
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	setparms = &(cmd->data.setadapterparms);
-
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long)cmd);
-	if (cmd->hdr.return_code) {
+	if (qeth_setadpparms_inspect_rc(cmd)) {
 		QETH_CARD_TEXT_(card, 4, "prmrc%x", cmd->hdr.return_code);
 		setparms->data.mode = SET_PROMISC_MODE_OFF;
 	}
@@ -4290,18 +4280,18 @@ EXPORT_SYMBOL_GPL(qeth_get_stats);
 static int qeth_setadpparms_change_macaddr_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 
 	QETH_CARD_TEXT(card, 4, "chgmaccb");
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	if (!card->options.layer2 ||
 	    !(card->info.mac_bits & QETH_LAYER2_MAC_READ)) {
 		ether_addr_copy(card->dev->dev_addr,
 				cmd->data.setadapterparms.data.change_addr.addr);
 		card->info.mac_bits |= QETH_LAYER2_MAC_READ;
 	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
 	return 0;
 }
 
@@ -4332,13 +4322,15 @@ EXPORT_SYMBOL_GPL(qeth_setadpparms_chang
 static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_set_access_ctrl *access_ctrl_req;
 	int fallback = *(int *)reply->param;
 
 	QETH_CARD_TEXT(card, 4, "setaccb");
+	if (cmd->hdr.return_code)
+		return 0;
+	qeth_setadpparms_inspect_rc(cmd);
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	access_ctrl_req = &cmd->data.setadapterparms.data.set_access_ctrl;
 	QETH_DBF_TEXT_(SETUP, 2, "setaccb");
 	QETH_DBF_TEXT_(SETUP, 2, "%s", card->gdev->dev.kobj.name);
@@ -4411,7 +4403,6 @@ static int qeth_setadpparms_set_access_c
 			card->options.isolation = card->options.prev_isolation;
 		break;
 	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
 	return 0;
 }
 
@@ -4699,14 +4690,15 @@ out:
 static int qeth_setadpparms_query_oat_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *)data;
 	struct qeth_qoat_priv *priv;
 	char *resdata;
 	int resdatalen;
 
 	QETH_CARD_TEXT(card, 3, "qoatcb");
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	cmd = (struct qeth_ipa_cmd *)data;
 	priv = (struct qeth_qoat_priv *)reply->param;
 	resdatalen = cmd->data.setadapterparms.hdr.cmdlength;
 	resdata = (char *)data + 28;
@@ -4800,21 +4792,18 @@ out:
 static int qeth_query_card_info_cb(struct qeth_card *card,
 				   struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct carrier_info *carrier_info = (struct carrier_info *)reply->param;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *)data;
 	struct qeth_query_card_info *card_info;
-	struct carrier_info *carrier_info;
 
 	QETH_CARD_TEXT(card, 2, "qcrdincb");
-	carrier_info = (struct carrier_info *)reply->param;
-	cmd = (struct qeth_ipa_cmd *)data;
-	card_info = &cmd->data.setadapterparms.data.card_info;
-	if (cmd->data.setadapterparms.hdr.return_code == 0) {
-		carrier_info->card_type = card_info->card_type;
-		carrier_info->port_mode = card_info->port_mode;
-		carrier_info->port_speed = card_info->port_speed;
-	}
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
+	card_info = &cmd->data.setadapterparms.data.card_info;
+	carrier_info->card_type = card_info->card_type;
+	carrier_info->port_mode = card_info->port_mode;
+	carrier_info->port_speed = card_info->port_speed;
 	return 0;
 }
 
