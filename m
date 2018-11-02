Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD99C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8413420847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1rYWnhCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8413420847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbeKCD7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbeKCD7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:03 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7870B2082D;
        Fri,  2 Nov 2018 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184648;
        bh=gLtJf3Aro8zUo+POZnbFPvS1KiYUbgTh18Th8o/CrwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1rYWnhCBK6sPXF1JxwRqrQYYLwRJ/HlaFdk8q9BejUs1RjnPDhG6xynmanw31V2dA
         t5CGyg60AappoEhqQMtdSY+/1J8KXoa0NBP0NwEsJ0qQb0vyXfIH999/KpOyUibojc
         t9U3is9ARph627WbFyx4SGePRnwEUInlHUuBCKB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 059/143] s390/qeth: fix error handling in adapter command callbacks
Date:   Fri,  2 Nov 2018 19:34:04 +0100
Message-Id: <20181102182901.819496811@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 686c97ee29c886ee07d17987d0059874c5c3b5af ]

Make sure to check both return code fields before(!) processing the
command response. Otherwise we risk operating on invalid data.

This matches an earlier fix for SETASSPARMS commands, see
commit ad3cbf613329 ("s390/qeth: fix error handling in checksum cmd callback").

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 85 ++++++++++++++-----------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4f2747cd15a6..169dd7127f9e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3001,28 +3001,23 @@ static int qeth_send_startlan(struct qeth_card *card)
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
@@ -3030,7 +3025,7 @@ static int qeth_query_setadapterparms_cb(struct qeth_card *card,
 	}
 	card->options.adp.supported_funcs =
 		cmd->data.setadapterparms.data.query_cmds_supp.supported_cmds;
-	return qeth_default_setadapterparms_cb(card, reply, (unsigned long)cmd);
+	return 0;
 }
 
 static struct qeth_cmd_buffer *qeth_get_adapter_cmd(struct qeth_card *card,
@@ -3122,22 +3117,20 @@ EXPORT_SYMBOL_GPL(qeth_query_ipassists);
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
 
@@ -4188,16 +4181,13 @@ EXPORT_SYMBOL_GPL(qeth_do_send_packet);
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
@@ -4267,11 +4257,12 @@ EXPORT_SYMBOL_GPL(qeth_get_stats);
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
 		memcpy(card->dev->dev_addr,
@@ -4279,7 +4270,6 @@ static int qeth_setadpparms_change_macaddr_cb(struct qeth_card *card,
 		       OSA_ADDR_LEN);
 		card->info.mac_bits |= QETH_LAYER2_MAC_READ;
 	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
 	return 0;
 }
 
@@ -4310,13 +4300,15 @@ EXPORT_SYMBOL_GPL(qeth_setadpparms_change_macaddr);
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
@@ -4389,7 +4381,6 @@ static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 			card->options.isolation = card->options.prev_isolation;
 		break;
 	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
 	return 0;
 }
 
@@ -4677,14 +4668,15 @@ out:
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
@@ -4778,21 +4770,18 @@ out:
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
 
-- 
2.17.1



