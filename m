Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0025C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A530C20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfAQJBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:01:02 -0500
Received: from mail.windriver.com ([147.11.1.11]:47299 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfAQJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:01:02 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0H90TLd018125
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 17 Jan 2019 01:00:29 -0800 (PST)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Thu, 17 Jan 2019 01:00:22 -0800
From:   <zhe.he@windriver.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <andriy.shevchenko@linux.intel.com>, <bigeasy@linutronix.de>,
        <Jisheng.Zhang@synaptics.com>, <darwin.dingel@alliedtelesis.co.nz>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] serial: 8250: Fix serial8250 initialization crash
Date:   Thu, 17 Jan 2019 17:00:19 +0800
Message-ID: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The initialization code of interrupt backoff work might reference NULL
pointer and cause the following crash, if no port was found.

[   10.017727] CPU 0 Unable to handle kernel paging request at virtual address 000001b0, epc == 807088e0, ra == 8070863c
---- snip ----
[   11.704470] [<807088e0>] serial8250_register_8250_port+0x318/0x4ac
[   11.747251] [<80708d74>] serial8250_probe+0x148/0x1c0
[   11.789301] [<80728450>] platform_drv_probe+0x40/0x94
[   11.830515] [<807264f8>] really_probe+0xf8/0x318
[   11.870876] [<80726b7c>] __driver_attach+0x110/0x12c
[   11.910960] [<80724374>] bus_for_each_dev+0x78/0xcc
[   11.951134] [<80725958>] bus_add_driver+0x200/0x234
[   11.989756] [<807273d8>] driver_register+0x84/0x148
[   12.029832] [<80d72f84>] serial8250_init+0x138/0x198
[   12.070447] [<80100e6c>] do_one_initcall+0x5c/0x2a0
[   12.110104] [<80d3a208>] kernel_init_freeable+0x370/0x484
[   12.150722] [<80a49420>] kernel_init+0x10/0xf8
[   12.191517] [<8010756c>] ret_from_kernel_thread+0x14/0x1c

This patch makes sure the initialization code can be reached only if a port
is found.

Fixes: commit 6d7f677a2afa ("serial: 8250: Rate limit serial port rx interrupts during input overruns")
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 189ab12..e441221 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1070,15 +1070,16 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 			ret = 0;
 		}
-	}
 
-	/* Initialise interrupt backoff work if required */
-	if (up->overrun_backoff_time_ms > 0) {
-		uart->overrun_backoff_time_ms = up->overrun_backoff_time_ms;
-		INIT_DELAYED_WORK(&uart->overrun_backoff,
-				  serial_8250_overrun_backoff_work);
-	} else {
-		uart->overrun_backoff_time_ms = 0;
+		/* Initialise interrupt backoff work if required */
+		if (up->overrun_backoff_time_ms > 0) {
+			uart->overrun_backoff_time_ms =
+				up->overrun_backoff_time_ms;
+			INIT_DELAYED_WORK(&uart->overrun_backoff,
+					serial_8250_overrun_backoff_work);
+		} else {
+			uart->overrun_backoff_time_ms = 0;
+		}
 	}
 
 	mutex_unlock(&serial_mutex);
-- 
2.7.4

