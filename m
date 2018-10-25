Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F74C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F892084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAxnebCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F892084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeJYWoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeJYWoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:05 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F062054F;
        Thu, 25 Oct 2018 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476669;
        bh=QKyX8MU3oYiw/u0eXzyOca+N25TVi+GjkBFPzaWYnFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAxnebCkwEndZ80bCXHFKMRSrum8hU/BGFYcMjO8Wf2E/1E/zCexZTVOQdrgLpigp
         8BRupVQ3U8Qf0PeJUHLfgLSlFrl9uwEWIaLD8AyQdro78vDPWqR6klYV0ufZulDaTM
         +m7UPdn5htVCH6YLyDmmV8C2dU3gCi98mMlZ1nHI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 10/46] s390/qeth: fix error handling in adapter command callbacks
Date:   Thu, 25 Oct 2018 10:10:17 -0400
Message-Id: <20181025141053.213330-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

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
 
@@ -4677,14 +4668,15 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
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
@@ -4778,21 +4770,18 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
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

