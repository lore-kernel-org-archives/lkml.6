Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814CEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E20F21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="TitzJsTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfA1RFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:05:44 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25444 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387786AbfA1RFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:05:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548695116; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=g91bp7syCXroZg4J0+SNCuTJIobrWr9T1RUcmsLwPT3jwadM1KPy3t3J3YMjkOPYpjHMGpYxnQFrocjDrIl8wnh0/3HBDEUXQZi8Jl1K8FoltkfZU+5BmV+WKlgQAxKrwnCZVivGNcsMyiQM/rX9yCWGcXO79C7lGXyA4uguwC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548695116; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=dQN977S+lDsYB9BjnWvbv9MJFFPhQi+c6BVXKsopk+4=; 
        b=Z7RuzUWuaVuvDl1gfsamd4twlZ4z403mam8lt8t+a6+LcR7UunyD769WelXXH3VtpCutAZ8vm6XXBC57m6bhzpH87tGZ/prkuiwKMTaFQd0GgiN5gP5+UqTI97VN8tVILgkbxYoL7VhHY6HRWNIQZkmrv7e/EpkQgHZVTBzghrw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=Vfz7QqDISfuGjngO+8/l71nqfCzz41uLi+RxYD04qfJhzsdvIw1FIobhBn5Ob3DgD77oFApH+Gk3
    G9knQNcwtNWqeLXSJLD0c4hOL0P6JrWkVAcOaCf9dRAQYsTMecS0  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548695116;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=2165; bh=dQN977S+lDsYB9BjnWvbv9MJFFPhQi+c6BVXKsopk+4=;
        b=TitzJsTZ4WqOEGSJbfZyuHCmX7xp+VniP1qADQd1db/SuqPIffVw3pcU2YeWiCTV
        gC38mFJJdGoa1lSTYGR8DW/7djO501kjsUNRQN5nAo6YSnkq73tDWb3nVpZy456dP/S
        z78ML+cjSNb8U4md8KWn0EqRJEB5nBJbjvjGCgXM=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548695113512787.655982602064; Mon, 28 Jan 2019 09:05:13 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: [PATCH v3 1/2] Serial: Ingenic: Add support for the X1000.
Date:   Tue, 29 Jan 2019 01:03:48 +0800
Message-Id: <1548695029-11900-2-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548695029-11900-1-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548695029-11900-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the 8250_ingenic driver on the
X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/tty/serial/8250/8250_ingenic.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 15a8c8d..424c07c 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -129,22 +129,21 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 	return 0;
 }
 
-EARLYCON_DECLARE(jz4740_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
 		    ingenic_early_console_setup);
 
-EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
 		    ingenic_early_console_setup);
 
-EARLYCON_DECLARE(jz4775_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4775_uart, "ingenic,jz4775-uart",
 		    ingenic_early_console_setup);
 
-EARLYCON_DECLARE(jz4780_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart",
 		    ingenic_early_console_setup);
 
+OF_EARLYCON_DECLARE(x1000_uart, "ingenic,x1000-uart",
+		    ingenic_early_console_setup);
+
 static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 {
 	int ier;
@@ -328,12 +327,18 @@ static const struct ingenic_uart_config jz4780_uart_config = {
 	.fifosize = 64,
 };
 
+static const struct ingenic_uart_config x1000_uart_config = {
+	.tx_loadsz = 32,
+	.fifosize = 64,
+};
+
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
+	{ .compatible = "ingenic,x1000-uart", .data = &x1000_uart_config },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match);
-- 
2.7.4


