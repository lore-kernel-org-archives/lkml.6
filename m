Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3487C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BA92083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="tWoOwCNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BA92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937267AbeFSEzE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:55:04 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:40595 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937085AbeFSEzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ydtPFiCSjbtnpCqtIM6tg8r1MWp5rp7POmlT0HoEEwA=; b=tWoOwCNfLywrri6YLM5VyZCDQS
        be4gZuRuGjtFtExXQwT4keKrpCcaWR+hRWNGc7HKRoUWNJMRVFqwEZyxcVk8wD3JDWMU4Ku57K1ZP
        azoddPQ1xXFnxrlSq+vNzNoSGvoaxpiF10/qpAlmCqaqKNpsJNDkWLAgHZcPEN6yOWg9CHUQLi2x6
        GIVHo+Rn7/NWanqsk7GVd4o7RKCyYwr40XauCFzO1o84GGuHc6HSrUsqHA2zwpUDD/nvQNAEtY1It
        C9/e+pvrogGMVk1dKqIh9s2Ijs0WV4ll4+Xhw0YuK3efOMqXiMmiB7haMYBvlsRx3xz6mBNEGExnC
        F6uK6MGA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41150 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fV8fS-00HVQ6-UV; Tue, 19 Jun 2018 04:54:59 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] serial: mps2-uart: Initialize early console
Date:   Mon, 18 Jun 2018 21:54:57 -0700
Message-Id: <1529384097-1631-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early console code for mps2-uart assumes that the serial hardware is
enabled for transmit when the system boots. However, this is not the case
after reset. This results in a hang in mps2_early_putchar() if the serial
transmitter is not enabled by a boot loader or ROM monitor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/mps2-uart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 9f8f63719126..0743a0551ce1 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -448,6 +448,14 @@ static struct console mps2_uart_console = {
 
 #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
 
+static void mps2_early_init(struct uart_port *port)
+{
+	u8 control = readb(port->membase + UARTn_CTRL);
+
+	control |= UARTn_CTRL_TX_ENABLE;
+	writeb(control, port->membase + UARTn_CTRL);
+}
+
 static void mps2_early_putchar(struct uart_port *port, int ch)
 {
 	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
@@ -469,6 +477,7 @@ static int __init mps2_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	mps2_early_init(&device->port);
 	device->con->write = mps2_early_write;
 
 	return 0;
-- 
2.7.4

