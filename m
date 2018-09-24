Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2525C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970A62086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970A62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeIXQaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:30:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:50367 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbeIXQaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:30:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="82802448"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Sep 2018 03:28:38 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 04/14] serial: lantiq: Change ltq_w32_mask to asc_update_bits
Date:   Mon, 24 Sep 2018 18:27:53 +0800
Message-Id: <20180924102803.30263-5-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltq prefix is platform specific function, asc prefix
is more generic.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 66c671677761..4c14608b8ef8 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -113,6 +113,13 @@ struct ltq_uart_port {
 	unsigned int		err_irq;
 };
 
+static inline void asc_update_bits(u32 clear, u32 set, void __iomem *reg)
+{
+	u32 tmp = readl(reg);
+
+	writel((tmp & ~clear) | set, reg);
+}
+
 static inline struct
 ltq_uart_port *to_ltq_uart_port(struct uart_port *port)
 {
@@ -163,16 +170,16 @@ lqasc_rx_chars(struct uart_port *port)
 		if (rsr & ASCSTATE_ANY) {
 			if (rsr & ASCSTATE_PE) {
 				port->icount.parity++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRPE,
+				asc_update_bits(0, ASCWHBSTATE_CLRPE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			} else if (rsr & ASCSTATE_FE) {
 				port->icount.frame++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRFE,
+				asc_update_bits(0, ASCWHBSTATE_CLRFE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 			if (rsr & ASCSTATE_ROE) {
 				port->icount.overrun++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRROE,
+				asc_update_bits(0, ASCWHBSTATE_CLRROE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 
@@ -252,7 +259,7 @@ lqasc_err_int(int irq, void *_port)
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
 	/* clear any pending interrupts */
-	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
+	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	return IRQ_HANDLED;
@@ -304,7 +311,7 @@ lqasc_startup(struct uart_port *port)
 		clk_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
-	ltq_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
+	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
 
 	ltq_w32(0, port->membase + LTQ_ASC_PISEL);
@@ -320,7 +327,7 @@ lqasc_startup(struct uart_port *port)
 	 * setting enable bits
 	 */
 	wmb();
-	ltq_w32_mask(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
+	asc_update_bits(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
 		ASCCON_ROEN, port->membase + LTQ_ASC_CON);
 
 	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
@@ -364,9 +371,9 @@ lqasc_shutdown(struct uart_port *port)
 	free_irq(ltq_port->err_irq, port);
 
 	ltq_w32(0, port->membase + LTQ_ASC_CON);
-	ltq_w32_mask(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
+	asc_update_bits(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
-	ltq_w32_mask(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
+	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
 	if (!IS_ERR(ltq_port->clk))
 		clk_disable(ltq_port->clk);
@@ -438,7 +445,7 @@ lqasc_set_termios(struct uart_port *port,
 	spin_lock_irqsave(&ltq_asc_lock, flags);
 
 	/* set up CON */
-	ltq_w32_mask(0, con, port->membase + LTQ_ASC_CON);
+	asc_update_bits(0, con, port->membase + LTQ_ASC_CON);
 
 	/* Set baud rate - take a divider of 2 into account */
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
@@ -446,19 +453,19 @@ lqasc_set_termios(struct uart_port *port,
 	divisor = divisor / 2 - 1;
 
 	/* disable the baudrate generator */
-	ltq_w32_mask(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
 
 	/* make sure the fractional divider is off */
-	ltq_w32_mask(ASCCON_FDE, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_FDE, 0, port->membase + LTQ_ASC_CON);
 
 	/* set up to use divisor of 2 */
-	ltq_w32_mask(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
 
 	/* now we can write the new baudrate into the register */
 	ltq_w32(divisor, port->membase + LTQ_ASC_BG);
 
 	/* turn the baudrate generator back on */
-	ltq_w32_mask(0, ASCCON_R, port->membase + LTQ_ASC_CON);
+	asc_update_bits(0, ASCCON_R, port->membase + LTQ_ASC_CON);
 
 	/* enable rx */
 	ltq_w32(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
-- 
2.11.0

