Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A8183C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE9A208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE9A208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeFLFmM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:42:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:13871 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933341AbeFLFlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:41:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 22:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="236379812"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2018 22:41:21 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com
Cc:     linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 5/7] tty: serial: lantiq: Convert global lock to per device lock
Date:   Tue, 12 Jun 2018 13:40:32 +0800
Message-Id: <20180612054034.4969-6-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous implementation uses one global lock to protect the resource.
If the serial driver have multiple entries, this kind of lock will
slow down the performance.
Add the lock at device level. This will lock only when the function
calling only to the same device.
So that it can avoid useless lock protection.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 51 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 1127586dbc94..72aab1b05265 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -107,7 +107,6 @@
 static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
 static struct uart_driver lqasc_reg;
-static DEFINE_SPINLOCK(ltq_asc_lock);
 
 struct ltq_uart_port {
 	struct uart_port	port;
@@ -118,6 +117,7 @@ struct ltq_uart_port {
 	unsigned int		tx_irq;
 	unsigned int		rx_irq;
 	unsigned int		err_irq;
+	spinlock_t		lock;  /* exclusive access for multi core */
 };
 
 static inline struct ltq_uart_port *to_ltq_uart_port(struct uart_port *port)
@@ -133,10 +133,11 @@ static void lqasc_stop_tx(struct uart_port *port)
 static void lqasc_start_tx(struct uart_port *port)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&ltq_asc_lock, flags);
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	spin_lock_irqsave(&ltq_port->lock, flags);
 	lqasc_tx_chars(port);
-	spin_unlock_irqrestore(&ltq_asc_lock, flags);
-	return;
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
 }
 
 static void lqasc_stop_rx(struct uart_port *port)
@@ -238,10 +239,14 @@ static irqreturn_t lqasc_tx_int(int irq, void *_port)
 {
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
-	spin_lock_irqsave(&ltq_asc_lock, flags);
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	spin_lock_irqsave(&ltq_port->lock, flags);
 	writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
-	spin_unlock_irqrestore(&ltq_asc_lock, flags);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
+
 	lqasc_start_tx(port);
+
 	return IRQ_HANDLED;
 }
 
@@ -250,8 +255,9 @@ static irqreturn_t lqasc_err_int(int irq, void *_port)
 	unsigned long flags;
 	u32 stat;
 	struct uart_port *port = (struct uart_port *)_port;
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
-	spin_lock_irqsave(&ltq_asc_lock, flags);
+	spin_lock_irqsave(&ltq_port->lock, flags);
 	/* clear any pending interrupts */
 	writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	stat = readl(port->membase + LTQ_ASC_STATE);
@@ -266,7 +272,7 @@ static irqreturn_t lqasc_err_int(int irq, void *_port)
 		port->icount.overrun++;
 	}
 	asc_w32_mask(0, ASCWHBSTATE_CLRALL, port->membase + LTQ_ASC_WHBSTATE);
-	spin_unlock_irqrestore(&ltq_asc_lock, flags);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -275,10 +281,13 @@ static irqreturn_t lqasc_rx_int(int irq, void *_port)
 {
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
-	spin_lock_irqsave(&ltq_asc_lock, flags);
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	spin_lock_irqsave(&ltq_port->lock, flags);
 	writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
 	lqasc_rx_chars(port);
-	spin_unlock_irqrestore(&ltq_asc_lock, flags);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -309,11 +318,13 @@ lqasc_startup(struct uart_port *port)
 {
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	int retval;
+	unsigned long flags;
 
 	if (!IS_ERR(ltq_port->clk))
 		clk_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
+	spin_lock_irqsave(&ltq_port->lock, flags);
 	asc_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
 
@@ -330,6 +341,7 @@ lqasc_startup(struct uart_port *port)
 	wmb();
 	asc_w32_mask(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
 		     ASCCON_ROEN, port->membase + LTQ_ASC_CON);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
 
 	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
 			     0, "asc_tx", port);
@@ -410,6 +422,7 @@ static void lqasc_set_termios(struct uart_port *port,
 	unsigned long flags;
 	u32 fdv = 0;
 	u32 reload = 0;
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
 	cflag = new->c_cflag;
 	iflag = new->c_iflag;
@@ -463,7 +476,7 @@ static void lqasc_set_termios(struct uart_port *port,
 	/* set error signals  - framing, parity  and overrun, enable receiver */
 	con |= ASCCON_FEN | ASCCON_TOEN | ASCCON_ROEN;
 
-	spin_lock_irqsave(&ltq_asc_lock, flags);
+	spin_lock_irqsave(&ltq_port->lock, flags);
 
 	/* set up CON */
 	asc_w32_mask(0, con, port->membase + LTQ_ASC_CON);
@@ -490,7 +503,7 @@ static void lqasc_set_termios(struct uart_port *port,
 	/* enable rx */
 	writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
 
-	spin_unlock_irqrestore(&ltq_asc_lock, flags);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(new))
@@ -604,16 +617,14 @@ static void lqasc_console_putchar(struct uart_port *port, int ch)
 static void lqasc_serial_port_write(struct uart_port *port, const char *s,
 				    u_int count)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ltq_asc_lock, flags);
 	uart_console_write(port, s, count, lqasc_console_putchar);
-	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 }
 
 static void lqasc_console_write(struct console *co, const char *s, u_int count)
 {
+	unsigned long flags;
 	struct ltq_uart_port *ltq_port;
+	struct uart_port *port;
 
 	if (co->index >= MAXPORTS)
 		return;
@@ -622,7 +633,11 @@ static void lqasc_console_write(struct console *co, const char *s, u_int count)
 	if (!ltq_port)
 		return;
 
-	lqasc_serial_port_write(&ltq_port->port, s, count);
+	port = &ltq_port->port;
+
+	spin_lock_irqsave(&ltq_port->lock, flags);
+	lqasc_serial_port_write(port, s, count);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
 }
 
 static int __init lqasc_console_setup(struct console *co, char *options)
@@ -760,6 +775,8 @@ static int __init lqasc_probe(struct platform_device *pdev)
 	ltq_port->rx_irq = irqres[1].start;
 	ltq_port->err_irq = irqres[2].start;
 
+	spin_lock_init(&ltq_port->lock);
+
 	lqasc_port[line] = ltq_port;
 	platform_set_drvdata(pdev, ltq_port);
 
-- 
2.11.0

