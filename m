Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FDEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484FA20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484FA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeLMGYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:24:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:19622 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726542AbeLMGYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:24:17 -0500
X-UUID: 35a6abd02c5843f08f5d7c11ce4d7926-20181213
X-UUID: 35a6abd02c5843f08f5d7c11ce4d7926-20181213
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1569045343; Thu, 13 Dec 2018 14:24:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 14:24:08 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 14:24:08 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] tty: serial: don't do termios for BTIF
Date:   Thu, 13 Dec 2018 14:24:03 +0800
Message-ID: <972976519be8e28ee600651fe14d1f6d5f23e697.1544679557.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek BTIF controller doesn't need to set termios so add
a new capability 'UART_CAP_NMOD' for the unsupported case.


Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/tty/serial/8250/8250.h      | 1 +
 drivers/tty/serial/8250/8250_port.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd..2b9ba39 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -80,6 +80,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_NMOD	(1 << 18)	/* UART doesn't do termios */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c39482b..e4a69a0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -297,7 +297,7 @@
 		.tx_loadsz	= 16,
 		.fcr		= UART_FCR_ENABLE_FIFO |
 				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
-		.flags		= UART_CAP_FIFO,
+		.flags		= UART_CAP_FIFO | UART_CAP_NMOD,
 	},
 	[PORT_NPCM] = {
 		.name		= "Nuvoton 16550",
@@ -2663,6 +2663,11 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	unsigned long flags;
 	unsigned int baud, quot, frac = 0;
 
+	if (up->capabilities & UART_CAP_NMOD) {
+		termios->c_cflag = 0;
+		return;
+	}
+
 	if (up->capabilities & UART_CAP_MINI) {
 		termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CMSPAR);
 		if ((termios->c_cflag & CSIZE) == CS5 ||
-- 
1.9.1

