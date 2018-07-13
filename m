Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C5B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tfXsRmhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C5B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGMOxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:53:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45282 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbeGMOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:53:45 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] serial: 8250_ingenic: Add support for the JZ4725B SoC
Date:   Fri, 13 Jul 2018 16:38:40 +0200
Message-Id: <20180713143840.9721-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531492726; bh=t49228rmCOyB7yDKBlFNqosZ261i/4msawYrbBd3pDU=; h=From:To:Cc:Subject:Date:Message-Id; b=tfXsRmhB1aea6IJcjYIQC6WN7HdVBgmKr4wTrbhhkXTnKHXAys6BnVGN+WMQ8uvBqVLaTWqEyCvtCf178EQNtTzeNKCg3rLTlB15f4cuGHITmbM9bHpADX6uXOgxfbKnYvWJx//ljV9ksP8GYX34c+X77zIJ4gnucqRLG3yBtwk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART in the jz4725b works just like in the other JZ SoCs, so this
commit simply adds a new compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.txt | 1 +
 drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
index c3c6406d5cfe..a0b34fd3b602 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible : One of:
   - "ingenic,jz4740-uart",
+  - "ingenic,jz4725b-uart",
   - "ingenic,jz4760-uart",
   - "ingenic,jz4770-uart",
   - "ingenic,jz4775-uart",
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 15a8c8dfa92b..760266559a5a 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -133,6 +133,10 @@ EARLYCON_DECLARE(jz4740_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
 		    ingenic_early_console_setup);
 
+EARLYCON_DECLARE(jz4725b_uart, ingenic_early_console_setup);
+OF_EARLYCON_DECLARE(jz4725b_uart, "ingenic,jz4725b-uart",
+		    ingenic_early_console_setup);
+
 EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
 		    ingenic_early_console_setup);
@@ -330,6 +334,7 @@ static const struct ingenic_uart_config jz4780_uart_config = {
 
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
+	{ .compatible = "ingenic,jz4725b-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
-- 
2.11.0

