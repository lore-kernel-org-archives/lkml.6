Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28309C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9002070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfBVQhn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:37:43 -0500
Received: from mail.hanoverdisplays.com ([81.145.148.229]:35638 "EHLO
        mail.hanoverdisplays.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBVQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:37:43 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2019 11:37:42 EST
Received: from builder.hanover.local (192.168.0.21) by
 mail.hanoverdisplays.com (192.168.0.30) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Fri, 22 Feb 2019 16:32:13 +0000
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>, <cquast@hanoverdisplays.com>
Subject: [PATCH] tty/serial/imx.c: Rename URTX0 to UTXD0
Date:   Fri, 22 Feb 2019 16:31:27 +0000
Message-ID: <20190222163127.10172-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [192.168.0.21]
X-GFI-SMTP-Submission: 1
X-GFI-SMTP-HelloDomain: builder.hanover.local
X-GFI-SMTP-RemoteIP: 192.168.0.21
X-GFIME-MASPAM: SPAM
Disclaimer: hanoverdisplays.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename to be coherent with the datasheet.

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 drivers/tty/serial/imx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc94731..a405e0d21ec9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -40,7 +40,7 @@
 
 /* Register definitions */
 #define URXD0 0x0  /* Receiver Register */
-#define URTX0 0x40 /* Transmitter Register */
+#define UTXD0 0x40 /* Transmitter Register */
 #define UCR1  0x80 /* Control Register 1 */
 #define UCR2  0x84 /* Control Register 2 */
 #define UCR3  0x88 /* Control Register 3 */
@@ -502,7 +502,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 
 	if (sport->port.x_char) {
 		/* Send next char */
-		imx_uart_writel(sport, sport->port.x_char, URTX0);
+		imx_uart_writel(sport, sport->port.x_char, UTXD0);
 		sport->port.icount.tx++;
 		sport->port.x_char = 0;
 		return;
@@ -536,7 +536,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 	       !(imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL)) {
 		/* send xmit->buf[xmit->tail]
 		 * out the port here */
-		imx_uart_writel(sport, xmit->buf[xmit->tail], URTX0);
+		imx_uart_writel(sport, xmit->buf[xmit->tail], UTXD0);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		sport->port.icount.tx++;
 	}
@@ -1257,7 +1257,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	}
 
 	slave_config.direction = DMA_MEM_TO_DEV;
-	slave_config.dst_addr = sport->port.mapbase + URTX0;
+	slave_config.dst_addr = sport->port.mapbase + UTXD0;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	slave_config.dst_maxburst = TXTL_DMA;
 	ret = dmaengine_slave_config(sport->dma_chan_tx, &slave_config);
@@ -1812,7 +1812,7 @@ static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
 	} while (~status & USR1_TRDY);
 
 	/* write */
-	imx_uart_writel(sport, c, URTX0);
+	imx_uart_writel(sport, c, UTXD0);
 
 	/* flush */
 	do {
@@ -1894,7 +1894,7 @@ static void imx_uart_console_putchar(struct uart_port *port, int ch)
 	while (imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL)
 		barrier();
 
-	imx_uart_writel(sport, ch, URTX0);
+	imx_uart_writel(sport, ch, UTXD0);
 }
 
 /*
@@ -2091,7 +2091,7 @@ static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
 	while (imx_uart_readl(sport, IMX21_UTS) & UTS_TXFULL)
 		cpu_relax();
 
-	imx_uart_writel(sport, ch, URTX0);
+	imx_uart_writel(sport, ch, UTXD0);
 }
 
 static void imx_uart_console_early_write(struct console *con, const char *s,
-- 
2.20.1




 
Please consider the environment before printing this email
 

 
 
 
The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
If you received this in error, please contact the sender or postmaster (postmaster@hanoverdisplays.com) and delete the material from any computer.
Although we routinely screen for viruses, addressees should check this e-mail and any attachment for viruses. We make no warranty as to absence of viruses in this e-mail or any attachments.
Our Company's email policy is to permit incidental personal use. If this email is of a personal nature, it must not be relied upon as expressing the views or opinions of the company.

