Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 557BBC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A2A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A2A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933521AbeFLFmf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:42:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:3749 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933251AbeFLFlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:41:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 22:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="63299484"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2018 22:41:17 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com
Cc:     linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
Date:   Tue, 12 Jun 2018 13:40:31 +0800
Message-Id: <20180612054034.4969-5-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
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

 arch/mips/Kconfig           |   1 -
 drivers/tty/serial/lantiq.c | 236 ++++++++++++++++++++++++--------------------
 2 files changed, 128 insertions(+), 109 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c82cebeb6192..7bae259edd0b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -395,7 +395,6 @@ config LANTIQ
 	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_HAS_EARLY_PRINTK
 	select GPIOLIB
-	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select CLKDEV_LOOKUP
 	select USE_OF
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 044128277248..1127586dbc94 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -49,7 +49,8 @@
 #define LTQ_ASC_RXFCON		0x0040
 #define LTQ_ASC_CON		0x0010
 #define LTQ_ASC_BG		0x0050
-#define LTQ_ASC_IRNREN		0x00F4
+#define LTQ_ASC_FDV		0x0058
+#define LTQ_ASC_IRNEN		0x00F4
 
 #define ASC_IRNREN_TX		0x1
 #define ASC_IRNREN_RX		0x2
@@ -62,6 +63,7 @@
 #define ASCOPT_CSIZE		0x3
 #define TXFIFO_FL		1
 #define RXFIFO_FL		1
+#define ASCCLC_DISR		0x1
 #define ASCCLC_DISS		0x2
 #define ASCCLC_RMCMASK		0x0000FF00
 #define ASCCLC_RMCOFFSET	8
@@ -84,6 +86,7 @@
 #define ASCWHBSTATE_CLRPE	0x00000004
 #define ASCWHBSTATE_CLRFE	0x00000008
 #define ASCWHBSTATE_CLRROE	0x00000020
+#define ASCWHBSTATE_CLRALL	0x000000FC
 #define ASCTXFCON_TXFEN		0x0001
 #define ASCTXFCON_TXFFLU	0x0002
 #define ASCTXFCON_TXFITLMASK	0x3F00
@@ -97,6 +100,10 @@
 #define ASCFSTAT_TXFREEMASK	0x3F000000
 #define ASCFSTAT_TXFREEOFF	24
 
+#define asc_w32_mask(clear, set, reg)	\
+	({ typeof(reg) reg_ = (reg);	\
+	writel((readl(reg_) & ~(clear)) | (set), reg_); })
+
 static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
 static struct uart_driver lqasc_reg;
@@ -113,20 +120,17 @@ struct ltq_uart_port {
 	unsigned int		err_irq;
 };
 
-static inline struct
-ltq_uart_port *to_ltq_uart_port(struct uart_port *port)
+static inline struct ltq_uart_port *to_ltq_uart_port(struct uart_port *port)
 {
 	return container_of(port, struct ltq_uart_port, port);
 }
 
-static void
-lqasc_stop_tx(struct uart_port *port)
+static void lqasc_stop_tx(struct uart_port *port)
 {
 	return;
 }
 
-static void
-lqasc_start_tx(struct uart_port *port)
+static void lqasc_start_tx(struct uart_port *port)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
@@ -135,23 +139,21 @@ lqasc_start_tx(struct uart_port *port)
 	return;
 }
 
-static void
-lqasc_stop_rx(struct uart_port *port)
+static void lqasc_stop_rx(struct uart_port *port)
 {
-	ltq_w32(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
+	writel(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
 }
 
-static int
-lqasc_rx_chars(struct uart_port *port)
+static int lqasc_rx_chars(struct uart_port *port)
 {
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
@@ -163,16 +165,16 @@ lqasc_rx_chars(struct uart_port *port)
 		if (rsr & ASCSTATE_ANY) {
 			if (rsr & ASCSTATE_PE) {
 				port->icount.parity++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRPE,
+				asc_w32_mask(0, ASCWHBSTATE_CLRPE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			} else if (rsr & ASCSTATE_FE) {
 				port->icount.frame++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRFE,
+				asc_w32_mask(0, ASCWHBSTATE_CLRFE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 			if (rsr & ASCSTATE_ROE) {
 				port->icount.overrun++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRROE,
+				asc_w32_mask(0, ASCWHBSTATE_CLRROE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 
@@ -202,8 +204,7 @@ lqasc_rx_chars(struct uart_port *port)
 	return 0;
 }
 
-static void
-lqasc_tx_chars(struct uart_port *port)
+static void lqasc_tx_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	if (uart_tx_stopped(port)) {
@@ -211,10 +212,10 @@ lqasc_tx_chars(struct uart_port *port)
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
@@ -223,8 +224,8 @@ lqasc_tx_chars(struct uart_port *port)
 		if (uart_circ_empty(xmit))
 			break;
 
-		ltq_w8(port->state->xmit.buf[port->state->xmit.tail],
-			port->membase + LTQ_ASC_TBUF);
+		writeb(port->state->xmit.buf[port->state->xmit.tail],
+		       port->membase + LTQ_ASC_TBUF);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 	}
@@ -233,48 +234,58 @@ lqasc_tx_chars(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
-static irqreturn_t
-lqasc_tx_int(int irq, void *_port)
+static irqreturn_t lqasc_tx_int(int irq, void *_port)
 {
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	ltq_w32(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
+	writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	lqasc_start_tx(port);
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t
-lqasc_err_int(int irq, void *_port)
+static irqreturn_t lqasc_err_int(int irq, void *_port)
 {
 	unsigned long flags;
+	u32 stat;
 	struct uart_port *port = (struct uart_port *)_port;
+
 	spin_lock_irqsave(&ltq_asc_lock, flags);
 	/* clear any pending interrupts */
-	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
-		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
+	writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
+	stat = readl(port->membase + LTQ_ASC_STATE);
+	if ((stat & ASCCON_ROEN)) {
+		asc_w32_mask(0, ASCRXFCON_RXFFLU,
+			     port->membase + LTQ_ASC_RXFCON);
+		port->icount.overrun++;
+	}
+	if (stat & ASCCON_TOEN) {
+		asc_w32_mask(0, ASCTXFCON_TXFFLU,
+			     port->membase + LTQ_ASC_TXFCON);
+		port->icount.overrun++;
+	}
+	asc_w32_mask(0, ASCWHBSTATE_CLRALL, port->membase + LTQ_ASC_WHBSTATE);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
+
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t
-lqasc_rx_int(int irq, void *_port)
+static irqreturn_t lqasc_rx_int(int irq, void *_port)
 {
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	ltq_w32(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
+	writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
 	lqasc_rx_chars(port);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	return IRQ_HANDLED;
 }
 
-static unsigned int
-lqasc_tx_empty(struct uart_port *port)
+static unsigned int lqasc_tx_empty(struct uart_port *port)
 {
 	int status;
-	status = ltq_r32(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_TXFFLMASK;
+	status = readl(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_TXFFLMASK;
 	return status ? 0 : TIOCSER_TEMT;
 }
 
@@ -284,8 +295,7 @@ lqasc_get_mctrl(struct uart_port *port)
 	return TIOCM_CTS | TIOCM_CAR | TIOCM_DSR;
 }
 
-static void
-lqasc_set_mctrl(struct uart_port *port, u_int mctrl)
+static void lqasc_set_mctrl(struct uart_port *port, u_int mctrl)
 {
 }
 
@@ -304,48 +314,49 @@ lqasc_startup(struct uart_port *port)
 		clk_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
-	ltq_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
+	asc_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
 
-	ltq_w32(0, port->membase + LTQ_ASC_PISEL);
-	ltq_w32(
-		((TXFIFO_FL << ASCTXFCON_TXFITLOFF) & ASCTXFCON_TXFITLMASK) |
-		ASCTXFCON_TXFEN | ASCTXFCON_TXFFLU,
-		port->membase + LTQ_ASC_TXFCON);
-	ltq_w32(
-		((RXFIFO_FL << ASCRXFCON_RXFITLOFF) & ASCRXFCON_RXFITLMASK)
-		| ASCRXFCON_RXFEN | ASCRXFCON_RXFFLU,
-		port->membase + LTQ_ASC_RXFCON);
+	writel(0, port->membase + LTQ_ASC_PISEL);
+	writel(((TXFIFO_FL << ASCTXFCON_TXFITLOFF) & ASCTXFCON_TXFITLMASK) |
+		 ASCTXFCON_TXFEN | ASCTXFCON_TXFFLU,
+		 port->membase + LTQ_ASC_TXFCON);
+	writel(((RXFIFO_FL << ASCRXFCON_RXFITLOFF) & ASCRXFCON_RXFITLMASK) |
+		 ASCRXFCON_RXFEN | ASCRXFCON_RXFFLU,
+		 port->membase + LTQ_ASC_RXFCON);
 	/* make sure other settings are written to hardware before
 	 * setting enable bits
 	 */
 	wmb();
-	ltq_w32_mask(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
-		ASCCON_ROEN, port->membase + LTQ_ASC_CON);
+	asc_w32_mask(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
+		     ASCCON_ROEN, port->membase + LTQ_ASC_CON);
 
 	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
-		0, "asc_tx", port);
+			     0, "asc_tx", port);
 	if (retval) {
 		pr_err("failed to request lqasc_tx_int\n");
 		return retval;
 	}
 
 	retval = request_irq(ltq_port->rx_irq, lqasc_rx_int,
-		0, "asc_rx", port);
+			     0, "asc_rx", port);
 	if (retval) {
 		pr_err("failed to request lqasc_rx_int\n");
 		goto err1;
 	}
 
 	retval = request_irq(ltq_port->err_irq, lqasc_err_int,
-		0, "asc_err", port);
+			     0, "asc_err", port);
 	if (retval) {
 		pr_err("failed to request lqasc_err_int\n");
 		goto err2;
 	}
 
-	ltq_w32(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
-		port->membase + LTQ_ASC_IRNREN);
+	writel(ASC_IRNCR_RIR | ASC_IRNCR_EIR | ASC_IRNCR_TIR,
+	       port->membase + LTQ_ASC_IRNCR);
+	writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
+	       port->membase + LTQ_ASC_IRNEN);
+
 	return 0;
 
 err2:
@@ -355,26 +366,41 @@ lqasc_startup(struct uart_port *port)
 	return retval;
 }
 
-static void
-lqasc_shutdown(struct uart_port *port)
+static void lqasc_shutdown(struct uart_port *port)
 {
+	unsigned long flags;
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+	int i = 100;
+
+	writel(0, port->membase + LTQ_ASC_CON);
 	free_irq(ltq_port->tx_irq, port);
 	free_irq(ltq_port->rx_irq, port);
 	free_irq(ltq_port->err_irq, port);
 
-	ltq_w32(0, port->membase + LTQ_ASC_CON);
-	ltq_w32_mask(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
-		port->membase + LTQ_ASC_RXFCON);
-	ltq_w32_mask(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
-		port->membase + LTQ_ASC_TXFCON);
+	spin_lock_irqsave(&ltq_port->lock, flags);
+	/* TX/RX FIFO disable will flush TX/RX FIFO automatically */
+	asc_w32_mask(ASCRXFCON_RXFEN, 0, port->membase + LTQ_ASC_RXFCON);
+	asc_w32_mask(ASCTXFCON_TXFEN, 0, port->membase + LTQ_ASC_TXFCON);
+
+	/* Make sure flush is done, FIFO empty */
+	while ((readl(port->membase + LTQ_ASC_FSTAT) & (ASCFSTAT_RXFFLMASK |
+		ASCFSTAT_TXFFLMASK)) && i--)
+		;
+
+	/*
+	 * Clock off it, TX/RX free FIFO will be always one byte
+	 * Console TX free FIFO check will always pass
+	 */
+	asc_w32_mask(ASCCLC_DISR | ASCCLC_RMCMASK, 0,
+		     port->membase + LTQ_ASC_CLC);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
+
 	if (!IS_ERR(ltq_port->clk))
 		clk_disable(ltq_port->clk);
 }
 
-static void
-lqasc_set_termios(struct uart_port *port,
-	struct ktermios *new, struct ktermios *old)
+static void lqasc_set_termios(struct uart_port *port,
+			      struct ktermios *new, struct ktermios *old)
 {
 	unsigned int cflag;
 	unsigned int iflag;
@@ -382,6 +408,8 @@ lqasc_set_termios(struct uart_port *port,
 	unsigned int baud;
 	unsigned int con = 0;
 	unsigned long flags;
+	u32 fdv = 0;
+	u32 reload = 0;
 
 	cflag = new->c_cflag;
 	iflag = new->c_iflag;
@@ -394,7 +422,7 @@ lqasc_set_termios(struct uart_port *port,
 	case CS5:
 	case CS6:
 	default:
-		new->c_cflag &= ~ CSIZE;
+		new->c_cflag &= ~CSIZE;
 		new->c_cflag |= CS8;
 		con = ASCCON_M_8ASYNC;
 		break;
@@ -438,30 +466,29 @@ lqasc_set_termios(struct uart_port *port,
 	spin_lock_irqsave(&ltq_asc_lock, flags);
 
 	/* set up CON */
-	ltq_w32_mask(0, con, port->membase + LTQ_ASC_CON);
+	asc_w32_mask(0, con, port->membase + LTQ_ASC_CON);
 
 	/* Set baud rate - take a divider of 2 into account */
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
 	divisor = uart_get_divisor(port, baud);
 	divisor = divisor / 2 - 1;
 
-	/* disable the baudrate generator */
-	ltq_w32_mask(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
-
-	/* make sure the fractional divider is off */
-	ltq_w32_mask(ASCCON_FDE, 0, port->membase + LTQ_ASC_CON);
-
-	/* set up to use divisor of 2 */
-	ltq_w32_mask(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
+	asc_w32_mask(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
+	/* Ensure the setting is effect before enabling */
+	wmb();
+	/* make sure the fractional divider is enabled */
+	asc_w32_mask(0, ASCCON_FDE, port->membase + LTQ_ASC_CON);
 
 	/* now we can write the new baudrate into the register */
-	ltq_w32(divisor, port->membase + LTQ_ASC_BG);
+	writel(reload, port->membase + LTQ_ASC_BG);
+	/* now we can write the new baudrate into the register */
+	writel(fdv, port->membase + LTQ_ASC_FDV);
 
 	/* turn the baudrate generator back on */
-	ltq_w32_mask(0, ASCCON_R, port->membase + LTQ_ASC_CON);
+	asc_w32_mask(0, ASCCON_R, port->membase + LTQ_ASC_CON);
 
 	/* enable rx */
-	ltq_w32(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
+	writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
 
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 
@@ -472,8 +499,7 @@ lqasc_set_termios(struct uart_port *port,
 	uart_update_timeout(port, cflag, baud);
 }
 
-static const char*
-lqasc_type(struct uart_port *port)
+static const char *lqasc_type(struct uart_port *port)
 {
 	if (port->type == PORT_LTQ_ASC)
 		return DRVNAME;
@@ -481,8 +507,7 @@ lqasc_type(struct uart_port *port)
 		return NULL;
 }
 
-static void
-lqasc_release_port(struct uart_port *port)
+static void lqasc_release_port(struct uart_port *port)
 {
 	struct platform_device *pdev = to_platform_device(port->dev);
 
@@ -492,8 +517,7 @@ lqasc_release_port(struct uart_port *port)
 	}
 }
 
-static int
-lqasc_request_port(struct uart_port *port)
+static int lqasc_request_port(struct uart_port *port)
 {
 	struct platform_device *pdev = to_platform_device(port->dev);
 	struct resource *res;
@@ -507,7 +531,7 @@ lqasc_request_port(struct uart_port *port)
 	size = resource_size(res);
 
 	res = devm_request_mem_region(&pdev->dev, res->start,
-		size, dev_name(&pdev->dev));
+				      size, dev_name(&pdev->dev));
 	if (!res) {
 		dev_err(&pdev->dev, "cannot request I/O memory region");
 		return -EBUSY;
@@ -515,15 +539,14 @@ lqasc_request_port(struct uart_port *port)
 
 	if (port->flags & UPF_IOREMAP) {
 		port->membase = devm_ioremap_nocache(&pdev->dev,
-			port->mapbase, size);
+						     port->mapbase, size);
 		if (port->membase == NULL)
 			return -ENOMEM;
 	}
 	return 0;
 }
 
-static void
-lqasc_config_port(struct uart_port *port, int flags)
+static void lqasc_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
 		port->type = PORT_LTQ_ASC;
@@ -531,17 +554,17 @@ lqasc_config_port(struct uart_port *port, int flags)
 	}
 }
 
-static int
-lqasc_verify_port(struct uart_port *port,
-	struct serial_struct *ser)
+static int lqasc_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	int ret = 0;
+
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_LTQ_ASC)
 		ret = -EINVAL;
 	if (ser->irq < 0 || ser->irq >= NR_IRQS)
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;
+
 	return ret;
 }
 
@@ -563,8 +586,7 @@ static const struct uart_ops lqasc_pops = {
 	.verify_port =	lqasc_verify_port,
 };
 
-static void
-lqasc_console_putchar(struct uart_port *port, int ch)
+static void lqasc_console_putchar(struct uart_port *port, int ch)
 {
 	int fifofree;
 
@@ -572,10 +594,11 @@ lqasc_console_putchar(struct uart_port *port, int ch)
 		return;
 
 	do {
-		fifofree = (ltq_r32(port->membase + LTQ_ASC_FSTAT)
+		fifofree = (readl(port->membase + LTQ_ASC_FSTAT)
 			& ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
 	} while (fifofree == 0);
-	ltq_w8(ch, port->membase + LTQ_ASC_TBUF);
+
+	writeb(ch, port->membase + LTQ_ASC_TBUF);
 }
 
 static void lqasc_serial_port_write(struct uart_port *port, const char *s,
@@ -588,8 +611,7 @@ static void lqasc_serial_port_write(struct uart_port *port, const char *s,
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 }
 
-static void
-lqasc_console_write(struct console *co, const char *s, u_int count)
+static void lqasc_console_write(struct console *co, const char *s, u_int count)
 {
 	struct ltq_uart_port *ltq_port;
 
@@ -603,8 +625,7 @@ lqasc_console_write(struct console *co, const char *s, u_int count)
 	lqasc_serial_port_write(&ltq_port->port, s, count);
 }
 
-static int __init
-lqasc_console_setup(struct console *co, char *options)
+static int __init lqasc_console_setup(struct console *co, char *options)
 {
 	struct ltq_uart_port *ltq_port;
 	struct uart_port *port;
@@ -629,6 +650,7 @@ lqasc_console_setup(struct console *co, char *options)
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
@@ -642,8 +664,7 @@ static struct console lqasc_console = {
 	.data =		&lqasc_reg,
 };
 
-static int __init
-lqasc_console_init(void)
+static int __init lqasc_console_init(void)
 {
 	register_console(&lqasc_console);
 	return 0;
@@ -667,6 +688,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->con->write = lqasc_serial_early_console_write;
+
 	return 0;
 }
 OF_EARLYCON_DECLARE(lantiq, DRVNAME, lqasc_serial_early_console_setup);
@@ -681,8 +703,7 @@ static struct uart_driver lqasc_reg = {
 	.cons =		&lqasc_console,
 };
 
-static int __init
-lqasc_probe(struct platform_device *pdev)
+static int __init lqasc_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct ltq_uart_port *ltq_port;
@@ -693,7 +714,7 @@ lqasc_probe(struct platform_device *pdev)
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ret = of_irq_to_resource_table(node, irqres, 3);
-	if (!mmres || (ret != 3)) {
+	if (!mmres || ret != 3) {
 		dev_err(&pdev->dev,
 			"failed to get memory/irq for serial port\n");
 		return -ENODEV;
@@ -709,7 +730,7 @@ lqasc_probe(struct platform_device *pdev)
 	}
 
 	ltq_port = devm_kzalloc(&pdev->dev, sizeof(struct ltq_uart_port),
-			GFP_KERNEL);
+				GFP_KERNEL);
 	if (!ltq_port)
 		return -ENOMEM;
 
@@ -759,8 +780,7 @@ static struct platform_driver lqasc_driver = {
 	},
 };
 
-int __init
-init_lqasc(void)
+int __init init_lqasc(void)
 {
 	int ret;
 
-- 
2.11.0

