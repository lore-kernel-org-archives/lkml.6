Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1857DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF17214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoJ07IO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF17214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeIRADA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:03:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeIRAC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:02:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so8067665pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WH/Vo+B5WWaXNT9DiHeHYFHFiKjXCZtOJhhCxXmf7tE=;
        b=OoJ07IO9TflZX+amoiaCwH5GUCzM+VUSdTISOZYFXA+UvZcKFxoqhg+3t/xl7p/x1b
         Cc4jB06DtSs0a5Z+HnMPeeuvYFJPBHuOMQybmm1NPxdKAx7dTVNHYgK+46VqRE34QS9x
         SAIClrN4zZNg+97hDG/xxbQg31CcU8aluaCbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WH/Vo+B5WWaXNT9DiHeHYFHFiKjXCZtOJhhCxXmf7tE=;
        b=H1MNNxozD2w+cYv8N5DZHumYJPolBY4HbQISm0cOhdYcnhSxUUFe0Qj5b1Z+KNp3JD
         GF2DKD3C79JI7r/Akz65b++QluZi4d4oAuTSwgOdoDYL1I+lxb71Br1byewkufpkcUwk
         Ol2LLKpNiggyGXGQUvcc2v2TC3giGUww5qXnLkugJhMYLcE+ppES4XRrquDJGoFpTxrQ
         c+WtSFFBiHkP58imou2nxwsETn7y6VLXAY8Ebw3A99SnYn/JSjaCfmkoREPVdytFHdvh
         la4RWTwNa0SohtPgl6i4MKfwcrhzrFtEOWqc+QRyJ7oUCyPYY8XZyvb5/hRPkRywABYU
         10ow==
X-Gm-Message-State: APzg51ASkhkBdHQwhc0W96GF/bGszA3AnXKpv2t0spOszFsKi4ZyNDpg
        eIsNtl+5p7GMOtN8QBqifycx+A==
X-Google-Smtp-Source: ANB0VdbKAdprTbbB0aN2oM0F1PB1DMeUIopJZy6LDD9sOKXomnqugtCZXd/wc33py04DEVZ6no7Xdw==
X-Received: by 2002:a63:6a06:: with SMTP id f6-v6mr24537943pgc.63.1537209266132;
        Mon, 17 Sep 2018 11:34:26 -0700 (PDT)
Received: from ubuntu.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id i7-v6sm17544137pgs.17.2018.09.17.11.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Sep 2018 11:34:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] serial: sprd: Use readable macros instead of magic number
Date:   Mon, 17 Sep 2018 11:33:41 -0700
Message-Id: <feaa6d1c76b64cbd9e538c892bd2dbe53ec99e33.1537208449.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define readable macros instead of magic number to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1b0e3fb..e18d8af 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -45,6 +45,8 @@
 
 /* data number in TX and RX fifo */
 #define SPRD_STS1		0x000C
+#define SPRD_RX_FIFO_CNT_MASK	GENMASK(7, 0)
+#define SPRD_TX_FIFO_CNT_MASK	GENMASK(15, 8)
 
 /* interrupt enable register and its BITs */
 #define SPRD_IEN		0x0010
@@ -82,11 +84,15 @@
 /* fifo threshold register */
 #define SPRD_CTL2		0x0020
 #define THLD_TX_EMPTY	0x40
+#define THLD_TX_EMPTY_SHIFT	8
 #define THLD_RX_FULL	0x40
 
 /* config baud rate register */
 #define SPRD_CLKD0		0x0024
+#define SPRD_CLKD0_MASK		GENMASK(15, 0)
 #define SPRD_CLKD1		0x0028
+#define SPRD_CLKD1_MASK		GENMASK(20, 16)
+#define SPRD_CLKD1_SHIFT	16
 
 /* interrupt mask status register */
 #define SPRD_IMSR			0x002C
@@ -115,7 +121,7 @@ static inline void serial_out(struct uart_port *port, int offset, int value)
 
 static unsigned int sprd_tx_empty(struct uart_port *port)
 {
-	if (serial_in(port, SPRD_STS1) & 0xff00)
+	if (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
 		return 0;
 	else
 		return TIOCSER_TEMT;
@@ -213,7 +219,8 @@ static inline void sprd_rx(struct uart_port *port)
 	struct tty_port *tty = &port->state->port;
 	unsigned int ch, flag, lsr, max_count = SPRD_TIMEOUT;
 
-	while ((serial_in(port, SPRD_STS1) & 0x00ff) && max_count--) {
+	while ((serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK) &&
+	       max_count--) {
 		lsr = serial_in(port, SPRD_LSR);
 		ch = serial_in(port, SPRD_RXD);
 		flag = TTY_NORMAL;
@@ -303,16 +310,17 @@ static int sprd_startup(struct uart_port *port)
 	struct sprd_uart_port *sp;
 	unsigned long flags;
 
-	serial_out(port, SPRD_CTL2, ((THLD_TX_EMPTY << 8) | THLD_RX_FULL));
+	serial_out(port, SPRD_CTL2,
+		   THLD_TX_EMPTY << THLD_TX_EMPTY_SHIFT | THLD_RX_FULL);
 
 	/* clear rx fifo */
 	timeout = SPRD_TIMEOUT;
-	while (timeout-- && serial_in(port, SPRD_STS1) & 0x00ff)
+	while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK)
 		serial_in(port, SPRD_RXD);
 
 	/* clear tx fifo */
 	timeout = SPRD_TIMEOUT;
-	while (timeout-- && serial_in(port, SPRD_STS1) & 0xff00)
+	while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
 		cpu_relax();
 
 	/* clear interrupt */
@@ -433,10 +441,11 @@ static void sprd_set_termios(struct uart_port *port,
 	}
 
 	/* clock divider bit0~bit15 */
-	serial_out(port, SPRD_CLKD0, quot & 0xffff);
+	serial_out(port, SPRD_CLKD0, quot & SPRD_CLKD0_MASK);
 
 	/* clock divider bit16~bit20 */
-	serial_out(port, SPRD_CLKD1, (quot & 0x1f0000) >> 16);
+	serial_out(port, SPRD_CLKD1,
+		   (quot & SPRD_CLKD1_MASK) >> SPRD_CLKD1_SHIFT);
 	serial_out(port, SPRD_LCR, lcr);
 	fc |= RX_TOUT_THLD_DEF | RX_HFC_THLD_DEF;
 	serial_out(port, SPRD_CTL1, fc);
@@ -510,7 +519,7 @@ static void wait_for_xmitr(struct uart_port *port)
 		if (--tmout == 0)
 			break;
 		udelay(1);
-	} while (status & 0xff00);
+	} while (status & SPRD_TX_FIFO_CNT_MASK);
 }
 
 static void sprd_console_putchar(struct uart_port *port, int ch)
-- 
1.9.1

