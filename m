Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49R5KlrehihhB/O51NToQwMbLFTclg+Y4IXWV84BeKntwyxbUIP8crGvmsBp9XYuJApXUpp
ARC-Seal: i=1; a=rsa-sha256; t=1523473033; cv=none;
        d=google.com; s=arc-20160816;
        b=NcHuluFL0cFSysE/9aI53ii/8BKS4T2EPDmInfkN59v9xqgAPMmdw7n4ooJwcHTCP5
         gUCHhotf9Vn6N5/Ol8Xl9TkMsBRxu3lQq3t3E05RSLtvX9/EPH7dgQAbMEXd3TiTYDBo
         5POZEdTPQdC0XGxJR7NXJiLZQ4/+VwfPASegTrtaAFM4iTR4HQBc5K9v6E8EOFelI/Zj
         s98vIL6T8LdrDMKuaJKdpPw6tNOmq5H+9wSO7oXmdXyeWQDspfNTj2bHJNxKwUEVdgcj
         O3SXxkfyjFMavnaSbMy0+QqT9mfjO6kKMhxpAQ6FjVlKEZq6i/a5S+4F8RZScolsMfCD
         LFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rX765y61XWhldgR0J0QWOY9ow2WROrQnaSfRiBsoUhM=;
        b=u+6Z51E4cuSo/Ydqzr5Ps8afbdpTxR23G11tyR/maiZDP1E/0iIEBBP15MPRWXKLmD
         dmu+7MdNfHg0oxkziQ6LV+07Fij/9wIl1ALqJt7+8yCcYk7c++ZBlva1xLg4tt0Xj3h/
         BkBNjYCm8n3hR9UmafXAc/AhFYkZoGq5YQl5/YSmGGMwmfYMbT2DkY8xzRrcN4Ck4GbK
         q3wfaBqO+ZosmDy8ZD0Mw+9r8ItRARUeDpcHM6GkS+FEdkcynnB3gfdyB+Vpm60FVKTb
         julEXzmZGA/EzlrE9oLjY3Lwd9Dhy2VYplvwrBJs2I1duPUn4wjXwzF0tHgLlPM0ns1z
         pC7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 071/310] serial: sh-sci: Fix race condition causing garbage during shutdown
Date: Wed, 11 Apr 2018 20:33:30 +0200
Message-Id: <20180411183625.365271302@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476524052399440?=
X-GMAIL-MSGID: =?utf-8?q?1597477259473486225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 1cf4a7efdc71cab84c42cfea7200608711ea954f ]

If DMA is enabled and used, a burst of old data may be seen on the
serial console during "poweroff" or "reboot".  uart_flush_buffer()
clears the circular buffer, but sci_port.tx_dma_len is not reset.
This leads to a circular buffer overflow, dumping (UART_XMIT_SIZE -
sci_port.tx_dma_len) bytes.

To fix this, add a .flush_buffer() callback that resets
sci_port.tx_dma_len.

Inspired by commit 31ca2c63fdc0aee7 ("tty/serial: atmel: fix race
condition (TX+DMA)").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1545,7 +1545,16 @@ static void sci_free_dma(struct uart_por
 	if (s->chan_rx)
 		sci_rx_dma_release(s, false);
 }
-#else
+
+static void sci_flush_buffer(struct uart_port *port)
+{
+	/*
+	 * In uart_flush_buffer(), the xmit circular buffer has just been
+	 * cleared, so we have to reset tx_dma_len accordingly.
+	 */
+	to_sci_port(port)->tx_dma_len = 0;
+}
+#else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
 }
@@ -1553,7 +1562,9 @@ static inline void sci_request_dma(struc
 static inline void sci_free_dma(struct uart_port *port)
 {
 }
-#endif
+
+#define sci_flush_buffer	NULL
+#endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
 static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 {
@@ -2551,6 +2562,7 @@ static const struct uart_ops sci_uart_op
 	.break_ctl	= sci_break_ctl,
 	.startup	= sci_startup,
 	.shutdown	= sci_shutdown,
+	.flush_buffer	= sci_flush_buffer,
 	.set_termios	= sci_set_termios,
 	.pm		= sci_pm,
 	.type		= sci_type,
