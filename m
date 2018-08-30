Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4BFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2812082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2812082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeH3Q4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:56:08 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:49608 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbeH3Q4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:56:08 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id VQu51y00H3XaVaC06Qu550; Thu, 30 Aug 2018 14:54:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fvMSb-0007Yc-M3; Thu, 30 Aug 2018 14:54:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fvMSb-0005Wg-KV; Thu, 30 Aug 2018 14:54:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] Revert "serial: sh-sci: Allow for compressed SCIF address"
Date:   Thu, 30 Aug 2018 14:54:04 +0200
Message-Id: <20180830125404.21192-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830125404.21192-1-geert+renesas@glider.be>
References: <20180830125404.21192-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2d4dd0da45401c7ae7332b4d1eb7bbb1348edde9.

This broke earlycon on all Renesas ARM platforms using a SCIF port for the
serial console (R-Car, RZ/A1, RZ/G1, RZ/G2 SoCs), due to an incorrect value
of port->regshift.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5d42c9a63001575a..ab3f6e91853da3c2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -346,15 +346,15 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	[SCIx_SH4_SCIF_REGTYPE] = {
 		.regs = {
 			[SCSMR]		= { 0x00, 16 },
-			[SCBRR]		= { 0x02,  8 },
-			[SCSCR]		= { 0x04, 16 },
-			[SCxTDR]	= { 0x06,  8 },
-			[SCxSR]		= { 0x08, 16 },
-			[SCxRDR]	= { 0x0a,  8 },
-			[SCFCR]		= { 0x0c, 16 },
-			[SCFDR]		= { 0x0e, 16 },
-			[SCSPTR]	= { 0x10, 16 },
-			[SCLSR]		= { 0x12, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x0c,  8 },
+			[SCxSR]		= { 0x10, 16 },
+			[SCxRDR]	= { 0x14,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCSPTR]	= { 0x20, 16 },
+			[SCLSR]		= { 0x24, 16 },
 		},
 		.fifosize = 16,
 		.overrun_reg = SCLSR,
@@ -2837,7 +2837,7 @@ static int sci_init_single(struct platform_device *dev,
 {
 	struct uart_port *port = &sci_port->port;
 	const struct resource *res;
-	unsigned int i, regtype;
+	unsigned int i;
 	int ret;
 
 	sci_port->cfg	= p;
@@ -2874,7 +2874,6 @@ static int sci_init_single(struct platform_device *dev,
 	if (unlikely(sci_port->params == NULL))
 		return -EINVAL;
 
-	regtype = sci_port->params - sci_port_params;
 	switch (p->type) {
 	case PORT_SCIFB:
 		sci_port->rx_trigger = 48;
@@ -2929,10 +2928,6 @@ static int sci_init_single(struct platform_device *dev,
 			port->regshift = 1;
 	}
 
-	if (regtype == SCIx_SH4_SCIF_REGTYPE)
-		if (sci_port->reg_size >= 0x20)
-			port->regshift = 1;
-
 	/*
 	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
 	 * for the multi-IRQ ports, which is where we are primarily
-- 
2.17.1

