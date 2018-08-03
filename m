Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A606C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A94C216F3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A94C216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeHCE60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:58:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:28368 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbeHCE6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:58:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="77931165"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2018 20:04:14 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 11/18] serial: intel: Use readl/writel instead of ltq_r32/ltq_w32
Date:   Fri,  3 Aug 2018 11:02:30 +0800
Message-Id: <20180803030237.3366-12-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous implementation uses platform-dependent functions
ltq_w32()/ltq_r32() to access registers. Those functions are not
available for other SoC which uses the same IP.
Change to OS provided readl()/writel() and readb()/writeb(), so
that different SoCs can use the same driver.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 drivers/tty/serial/lantiq.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index e36e6a267e7a..2e1b35b1cf4d 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -146,7 +146,7 @@ lqasc_start_tx(struct uart_port *port)
 static void
 lqasc_stop_rx(struct uart_port *port)
 {
-	ltq_w32(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
+	writel(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
 }
 
 static int
@@ -155,11 +155,11 @@ lqasc_rx_chars(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 	unsigned int ch = 0, rsr = 0, fifocnt;
 
-	fifocnt = ltq_r32(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_RXFFLMASK;
+	fifocnt = readl(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_RXFFLMASK;
 	while (fifocnt--) {
 		u8 flag = TTY_NORMAL;
-		ch = ltq_r8(port->membase + LTQ_ASC_RBUF);
-		rsr = (ltq_r32(port->membase + LTQ_ASC_STATE)
+		ch = readb(port->membase + LTQ_ASC_RBUF);
+		rsr = (readl(port->membase + LTQ_ASC_STATE)
 			& ASCSTATE_ANY) | UART_DUMMY_UER_RX;
 		tty_flip_buffer_push(tport);
 		port->icount.rx++;
@@ -219,10 +219,10 @@ lqasc_tx_chars(struct uart_port *port)
 		return;
 	}
 
-	while (((ltq_r32(port->membase + LTQ_ASC_FSTAT) &
+	while (((readl(port->membase + LTQ_ASC_FSTAT) &
 		ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF) != 0) {
 		if (port->x_char) {
-			ltq_w8(port->x_char, port->membase + LTQ_ASC_TBUF);
+			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
 			port->icount.tx++;
 			port->x_char = 0;
 			continue;
@@ -231,7 +231,7 @@ lqasc_tx_chars(struct uart_port *port)
 		if (uart_circ_empty(xmit))
 			break;
 
-		ltq_w8(port->state->xmit.buf[port->state->xmit.tail],
+		writeb(port->state->xmit.buf[port->state->xmit.tail],
 			port->membase + LTQ_ASC_TBUF);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
@@ -247,7 +247,7 @@ lqasc_tx_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	ltq_w32(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
+	writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	lqasc_start_tx(port);
 	return IRQ_HANDLED;
@@ -272,7 +272,7 @@ lqasc_rx_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	ltq_w32(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
+	writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
 	lqasc_rx_chars(port);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	return IRQ_HANDLED;
@@ -282,7 +282,7 @@ static unsigned int
 lqasc_tx_empty(struct uart_port *port)
 {
 	int status;
-	status = ltq_r32(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_TXFFLMASK;
+	status = readl(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_TXFFLMASK;
 	return status ? 0 : TIOCSER_TEMT;
 }
 
@@ -315,12 +315,12 @@ lqasc_startup(struct uart_port *port)
 	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
 
-	ltq_w32(0, port->membase + LTQ_ASC_PISEL);
-	ltq_w32(
+	writel(0, port->membase + LTQ_ASC_PISEL);
+	writel(
 		((TXFIFO_FL << ASCTXFCON_TXFITLOFF) & ASCTXFCON_TXFITLMASK) |
 		ASCTXFCON_TXFEN | ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
-	ltq_w32(
+	writel(
 		((RXFIFO_FL << ASCRXFCON_RXFITLOFF) & ASCRXFCON_RXFITLMASK)
 		| ASCRXFCON_RXFEN | ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
@@ -352,7 +352,7 @@ lqasc_startup(struct uart_port *port)
 		goto err2;
 	}
 
-	ltq_w32(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
+	writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
 		port->membase + LTQ_ASC_IRNREN);
 	return 0;
 
@@ -371,7 +371,7 @@ lqasc_shutdown(struct uart_port *port)
 	free_irq(ltq_port->rx_irq, port);
 	free_irq(ltq_port->err_irq, port);
 
-	ltq_w32(0, port->membase + LTQ_ASC_CON);
+	writel(0, port->membase + LTQ_ASC_CON);
 	asc_update_bits(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
 	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
@@ -463,13 +463,13 @@ lqasc_set_termios(struct uart_port *port,
 	asc_update_bits(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
 
 	/* now we can write the new baudrate into the register */
-	ltq_w32(divisor, port->membase + LTQ_ASC_BG);
+	writel(divisor, port->membase + LTQ_ASC_BG);
 
 	/* turn the baudrate generator back on */
 	asc_update_bits(0, ASCCON_R, port->membase + LTQ_ASC_CON);
 
 	/* enable rx */
-	ltq_w32(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
+	writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
 
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 
@@ -580,10 +580,10 @@ lqasc_console_putchar(struct uart_port *port, int ch)
 		return;
 
 	do {
-		fifofree = (ltq_r32(port->membase + LTQ_ASC_FSTAT)
+		fifofree = (readl(port->membase + LTQ_ASC_FSTAT)
 			& ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
 	} while (fifofree == 0);
-	ltq_w8(ch, port->membase + LTQ_ASC_TBUF);
+	writeb(ch, port->membase + LTQ_ASC_TBUF);
 }
 
 static void lqasc_serial_port_write(struct uart_port *port, const char *s,
-- 
2.11.0

