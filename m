Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C829C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB59223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="c8r29l6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB59223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbeKODx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:53:57 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:50464 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeKODx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:53:57 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EC4895C1859;
        Wed, 14 Nov 2018 18:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542217786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dzvl57LvFMfN5DFhcVfqX8K/ZN+XEYte00Y/654CsE=;
        b=c8r29l6jdWAqu3Bea6dyVQDikUe/AAxOGcOjS/K6+aGlOeqieErOOUXRN68B1711dsC2qS
        WKVtc7nh8A8RFwjciYO4lgpBzvoHz5s/e6pZtbsysaTdSHkxOkMyrliFQtGXmV1QHegi9a
        pUsprB+Ls4x1Z7uSA7zb2CznplHLkCY=
From:   Stefan Agner <stefan@agner.ch>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     fabio.estevam@nxp.com, u.kleine-koenig@pengutronix.de,
        s.hauer@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] serial: imx: avoid crash when un/re-binding serial console device
Date:   Wed, 14 Nov 2018 18:49:40 +0100
Message-Id: <20181114174940.7865-3-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114174940.7865-1-stefan@agner.ch>
References: <20181114174940.7865-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device used as a serial console gets un/re-binded, then
register_console() will call imx_uart_setup_console() again.
Drop __init so that imx_uart_setup_console() can be safely called
at runtime.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This addresses a kernel panic seen when unbinding/rebinding the i.MX
UART which is serial console on i.MX 6/7 via SSH:
# cd /sys/bus/platform/drivers/imx-uart/
# echo 30860000.serial > unbind && echo 30860000.serial > bind

console [ttymxc0] disabled
30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 52, base_baud = 1500000) is a IMX
Unable to handle kernel paging request at virtual address c0c4b830
pgd = 5e12e3d4
[c0c4b830] *pgd=80c1141e(bad)
Internal error: Oops: 8000000d [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 866 Comm: sh Not tainted 4.18.15-00048-gb3b505988801-dirty #403
Hardware name: Freescale i.MX7 Dual (Device Tree)
PC is at imx_uart_console_setup+0x0/0x274
LR is at register_console+0x184/0x3c4
pc : [<c0c4b830>]    lr : [<c0171314>]    psr: a0070013
sp : e8015db8  ip : c0d06548  fp : c0b4a158
r10: ec1d9380  r9 : 00000001  r8 : 00000000
r7 : 00000000  r6 : c0d819e0  r5 : c0d81e48  r4 : c0d47d68
r3 : c0c4b830  r2 : 00000000  r1 : efffca03  r0 : c0d47d68
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: a803806a  DAC: 00000051
Process sh (pid: 866, stack limit = 0x9c2f1d49)

It seems that also other drivers are affected. An alternative might be
to disallow unbinding/rebinding instead.

 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757c91e5105a..674bd0ea2491 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1966,7 +1966,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
+static void
 imx_uart_console_get_options(struct imx_port *sport, int *baud,
 			     int *parity, int *bits)
 {
@@ -2025,7 +2025,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
 	}
 }
 
-static int __init
+static int
 imx_uart_console_setup(struct console *co, char *options)
 {
 	struct imx_port *sport;
-- 
2.19.1

