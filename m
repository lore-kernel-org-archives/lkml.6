Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445FEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4DC214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmT8nQFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4DC214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404402AbeKTDVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403835AbeKTDVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:21:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2BB3206BA;
        Mon, 19 Nov 2018 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646614;
        bh=R/TDA5Vcp0zXrIJ7hCyPoMzzv0DMSJ4/K3X7XTiXwL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmT8nQFNEpjqtOSmqPogYq9YC56qujlHZv+EqOALCdC5EDt2M1dR1wpVd2Jzai/3q
         a7vNM7dzap7QohYf8zxPqKge4et2BcOSmrAqFTyF5DExwk5cpfaT/px/5/wENtL4q0
         U1+6b+MQefHlw2XdbU0nFH3xY8q1kTS1+uDO7T+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 4.4 004/160] pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges
Date:   Mon, 19 Nov 2018 17:27:23 +0100
Message-Id: <20181119162630.527959147@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

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
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pcmcia/ricoh.h        |   35 +++++++++++++++++++++++++++++++++++
 drivers/pcmcia/yenta_socket.c |    3 ++-
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


