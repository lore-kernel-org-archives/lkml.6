Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51417C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC7720656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfANBZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:25:58 -0500
Received: from muru.com ([72.249.23.125]:33544 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfANBZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 20:25:57 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9BCC58199;
        Mon, 14 Jan 2019 01:26:02 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>, Jiri Slaby <jslaby@suse.cz>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/3] n_gsm: Constify u8 and unsigned char usage
Date:   Sun, 13 Jan 2019 17:25:27 -0800
Message-Id: <20190114012528.2367-3-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114012528.2367-1-tony@atomide.com>
References: <20190114012528.2367-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for adding serdev driver support, let's constify
the use of u8 and unsigned char for n_gsm.

Note that gsm_control_modem() gsm_control_rls() read the data for tty
control characters and then call gsm_control_reply() that allocates a
new reply and copies the data.

Cc: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/n_gsm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -143,8 +143,8 @@ struct gsm_dlci {
 	struct sk_buff *skb;	/* Frame being sent */
 	struct sk_buff_head skb_list;	/* Queued frames */
 	/* Data handling callback */
-	void (*data)(struct gsm_dlci *dlci, u8 *data, int len);
-	void (*prev_data)(struct gsm_dlci *dlci, u8 *data, int len);
+	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
+	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	struct net_device *net; /* network interface, if created */
 };
 
@@ -988,7 +988,7 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
  *	Encode up and queue a UI/UIH frame containing our response.
  */
 
-static void gsm_control_reply(struct gsm_mux *gsm, int cmd, u8 *data,
+static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 					int dlen)
 {
 	struct gsm_msg *msg;
@@ -1073,14 +1073,14 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
  *	and if need be stuff a break message down the tty.
  */
 
-static void gsm_control_modem(struct gsm_mux *gsm, u8 *data, int clen)
+static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 {
 	unsigned int addr = 0;
 	unsigned int modem = 0;
 	unsigned int brk = 0;
 	struct gsm_dlci *dlci;
 	int len = clen;
-	u8 *dp = data;
+	const u8 *dp = data;
 	struct tty_struct *tty;
 
 	while (gsm_read_ea(&addr, *dp++) == 0) {
@@ -1134,13 +1134,13 @@ static void gsm_control_modem(struct gsm_mux *gsm, u8 *data, int clen)
  *	this into the uplink tty if present
  */
 
-static void gsm_control_rls(struct gsm_mux *gsm, u8 *data, int clen)
+static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 {
 	struct tty_port *port;
 	unsigned int addr = 0;
 	u8 bits;
 	int len = clen;
-	u8 *dp = data;
+	const u8 *dp = data;
 
 	while (gsm_read_ea(&addr, *dp++) == 0) {
 		len--;
@@ -1189,7 +1189,7 @@ static void gsm_dlci_begin_close(struct gsm_dlci *dlci);
  */
 
 static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
-							u8 *data, int clen)
+						const u8 *data, int clen)
 {
 	u8 buf[1];
 	unsigned long flags;
@@ -1261,7 +1261,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
  */
 
 static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
-							u8 *data, int clen)
+						const u8 *data, int clen)
 {
 	struct gsm_control *ctrl;
 	unsigned long flags;
@@ -1553,7 +1553,7 @@ static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
  *	open we shovel the bits down it, if not we drop them.
  */
 
-static void gsm_dlci_data(struct gsm_dlci *dlci, u8 *data, int clen)
+static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 {
 	/* krefs .. */
 	struct tty_port *port = &dlci->port;
@@ -1603,7 +1603,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, u8 *data, int clen)
  *	and we divide up the work accordingly.
  */
 
-static void gsm_dlci_command(struct gsm_dlci *dlci, u8 *data, int len)
+static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 {
 	/* See what command is involved */
 	unsigned int command = 0;
@@ -2702,7 +2702,7 @@ static void gsm_mux_net_tx_timeout(struct net_device *net)
 }
 
 static void gsm_mux_rx_netchar(struct gsm_dlci *dlci,
-				   unsigned char *in_buf, int size)
+				const unsigned char *in_buf, int size)
 {
 	struct net_device *net = dlci->net;
 	struct sk_buff *skb;
-- 
2.20.1
