Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB7FC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F22084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfBCOVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55630 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730286AbfBCOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:58 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdk-0006NU-N6; Sun, 03 Feb 2019 14:20:56 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006rE-BH; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.531648849@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 051/305] pcmcia: Implement CLKRUN protocol disabling
 for Ricoh bridges
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

commit 95691e3eddc41da2d1cd3cca51fecdfb46bd85bc upstream.

Currently, "disable_clkrun" yenta_socket module parameter is only
implemented for TI CardBus bridges.
Add also an implementation for Ricoh bridges that have the necessary
setting documented in publicly available datasheets.

Tested on a RL5C476II with a Sunrich C-160 CardBus NIC that doesn't work
correctly unless the CLKRUN protocol is disabled.

Let's also make it clear in its description that the "disable_clkrun"
module parameter only works on these two previously mentioned brands of
CardBus bridges.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pcmcia/ricoh.h        | 35 +++++++++++++++++++++++++++++++++++
 drivers/pcmcia/yenta_socket.c |  3 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)

--- a/drivers/pcmcia/ricoh.h
+++ b/drivers/pcmcia/ricoh.h
@@ -119,6 +119,10 @@
 #define  RL5C4XX_MISC_CONTROL           0x2F /* 8 bit */
 #define  RL5C4XX_ZV_ENABLE              0x08
 
+/* Misc Control 3 Register */
+#define RL5C4XX_MISC3			0x00A2 /* 16 bit */
+#define  RL5C47X_MISC3_CB_CLKRUN_DIS	BIT(1)
+
 #ifdef __YENTA_H
 
 #define rl_misc(socket)		((socket)->private[0])
@@ -156,6 +160,35 @@ static void ricoh_set_zv(struct yenta_so
         }
 }
 
+static void ricoh_set_clkrun(struct yenta_socket *socket, bool quiet)
+{
+	u16 misc3;
+
+	/*
+	 * RL5C475II likely has this setting, too, however no datasheet
+	 * is publicly available for this chip
+	 */
+	if (socket->dev->device != PCI_DEVICE_ID_RICOH_RL5C476 &&
+	    socket->dev->device != PCI_DEVICE_ID_RICOH_RL5C478)
+		return;
+
+	if (socket->dev->revision < 0x80)
+		return;
+
+	misc3 = config_readw(socket, RL5C4XX_MISC3);
+	if (misc3 & RL5C47X_MISC3_CB_CLKRUN_DIS) {
+		if (!quiet)
+			dev_dbg(&socket->dev->dev,
+				"CLKRUN feature already disabled\n");
+	} else if (disable_clkrun) {
+		if (!quiet)
+			dev_info(&socket->dev->dev,
+				 "Disabling CLKRUN feature\n");
+		misc3 |= RL5C47X_MISC3_CB_CLKRUN_DIS;
+		config_writew(socket, RL5C4XX_MISC3, misc3);
+	}
+}
+
 static void ricoh_save_state(struct yenta_socket *socket)
 {
 	rl_misc(socket) = config_readw(socket, RL5C4XX_MISC);
@@ -172,6 +205,7 @@ static void ricoh_restore_state(struct y
 	config_writew(socket, RL5C4XX_16BIT_IO_0, rl_io(socket));
 	config_writew(socket, RL5C4XX_16BIT_MEM_0, rl_mem(socket));
 	config_writew(socket, RL5C4XX_CONFIG, rl_config(socket));
+	ricoh_set_clkrun(socket, true);
 }
 
 
@@ -197,6 +231,7 @@ static int ricoh_override(struct yenta_s
 	config_writew(socket, RL5C4XX_CONFIG, config);
 
 	ricoh_set_zv(socket);
+	ricoh_set_clkrun(socket, false);
 
 	return 0;
 }
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -26,7 +26,8 @@
 
 static bool disable_clkrun;
 module_param(disable_clkrun, bool, 0444);
-MODULE_PARM_DESC(disable_clkrun, "If PC card doesn't function properly, please try this option");
+MODULE_PARM_DESC(disable_clkrun,
+		 "If PC card doesn't function properly, please try this option (TI and Ricoh bridges only)");
 
 static bool isa_probe = 1;
 module_param(isa_probe, bool, 0444);

