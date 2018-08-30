Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E8C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4641820645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4641820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeH3Q4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:56:09 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:38494 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbeH3Q4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:56:09 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id VQu51y00Z3XaVaC01Qu5YP; Thu, 30 Aug 2018 14:54:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fvMSb-0007YR-Kr; Thu, 30 Aug 2018 14:54:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fvMSb-0005Wc-Jh; Thu, 30 Aug 2018 14:54:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
Date:   Thu, 30 Aug 2018 14:54:03 +0200
Message-Id: <20180830125404.21192-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830125404.21192-1-geert+renesas@glider.be>
References: <20180830125404.21192-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7acece71a517cad83a0842a94d94c13f271b680c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 31 +++++++++++++++++++++++++++++++
 include/linux/serial_sci.h  |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ac4424bf6b136cc4..5d42c9a63001575a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -291,6 +291,33 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
+	/*
+	 * The "SCIFA" that is in RZ/T and RZ/A2.
+	 * It looks like a normal SCIF with FIFO data, but with a
+	 * compressed address space. Also, the break out of interrupts
+	 * are different: ERI/BRI, RXI, TXI, TEI, DRI.
+	 */
+	[SCIx_RZ_SCIFA_REGTYPE] = {
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x02,  8 },
+			[SCSCR]		= { 0x04, 16 },
+			[SCxTDR]	= { 0x06,  8 },
+			[SCxSR]		= { 0x08, 16 },
+			[SCxRDR]	= { 0x0A,  8 },
+			[SCFCR]		= { 0x0C, 16 },
+			[SCFDR]		= { 0x0E, 16 },
+			[SCSPTR]	= { 0x10, 16 },
+			[SCLSR]		= { 0x12, 16 },
+		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
+	},
+
 	/*
 	 * Common SH-3 SCIF definitions.
 	 */
@@ -3110,6 +3137,10 @@ static const struct of_device_id of_sci_match[] = {
 		.compatible = "renesas,scif-r7s72100",
 		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH2_SCIF_FIFODATA_REGTYPE),
 	},
+	{
+		.compatible = "renesas,scif-r7s9210",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
+	},
 	/* Family-specific types */
 	{
 		.compatible = "renesas,rcar-gen1-scif",
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index c0e795d95477daea..1c89611e0e0634ae 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -36,6 +36,7 @@ enum {
 	SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 	SCIx_SH7705_SCIF_REGTYPE,
 	SCIx_HSCIF_REGTYPE,
+	SCIx_RZ_SCIFA_REGTYPE,
 
 	SCIx_NR_REGTYPES,
 };
-- 
2.17.1

