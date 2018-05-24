Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpaPokO7oL2EZsClHV+ctRQL8h+dOfbE5PQDiNO0OhSOTu/ltC61tW+WdYha7fNQDvOcy/c
ARC-Seal: i=1; a=rsa-sha256; t=1527155938; cv=none;
        d=google.com; s=arc-20160816;
        b=AH4HFxAqNnH731WBkPdiytkRV19oDwfXRNGvrz960VPB9qGw4XTULn8qXKyJ5ugVO5
         kjGqIHYw1mqPfU+f/a7bvLzCzGXpnxTp3N2+o74XpoP9y29Q0++A6P8V4byo4k8S3zXv
         8FwcWOz144CYNjOGV8SlY2917et4/YdHoO/GhUtrLIeI5uqgdMMauXDvdlKBG2BlQexf
         qz2NIeHBxCpV9eNlzq76qIeNm2i2E8ABeFh/ASNrH7SSbn+YaOL6z0HUexgwrBcOrpqb
         O06qoE5ZOOoQlrlzO6JmvmOntYs7NrNO+smDRf1tUrjVX8UCYGP8gvwJ6NyatI1P3XQN
         Jepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LTG+s8Kt6mxqHfsgSCS7MCz6+N/oB6EvpyU/8Y0Z/bs=;
        b=b5W3htj11UhVdQlc34Db5PnKTks133tx4aa55ttZrnaueS1G+FqkHUCxfXKmJiAQJB
         FWckP3/z0/2RytyK/bcPZ8gJ0odls7xnvM/hMhD8j2PXZmkpNOjbFyu2kjo0E6PmYzVx
         aOe3K0DONPsiWUvdxNmcGb8wWvHL3tX7uxcRxTAhGjiNZf0cLrPppnNdxYCO3Bydez+T
         gz0+awGsztnCVXWn6NhnTJkl9dHB2ZpsarxSXMU+X7lvPsxftz/Uvtqv19KF+CmseT8N
         AULF2V3eteTZnWMKgtyiXGZJiTPVTFMW6WVKJRnGCb7LdV5lTwWvCqUNUDkAy/2Pe2Fw
         0xgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dKePmujj;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dKePmujj;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tobias Klauser <tklauser@distanz.ch>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 158/165] serial: altera: ensure port->regshift is honored consistently
Date: Thu, 24 May 2018 11:39:24 +0200
Message-Id: <20180524093628.470594562@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339065589910831?=
X-GMAIL-MSGID: =?utf-8?q?1601339065589910831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>

[ Upstream commit 0e254963b6ba4d63ac911e79537fea38dd03dc50 ]

Most register accesses in the altera driver honor port->regshift by
using altera_uart_writel(). There are a few accesses however that were
missed when the driver was converted to use port->regshift and some
others were added later in commit 4d9d7d896d77 ("serial: altera_uart:
add earlycon support").

Fixes: 2780ad42f5fe ("tty: serial: altera_uart: Use port->regshift to store bus shift")
Signed-off-by: Uwe Kleine-KÃ¶nig <u.kleine-koenig@pengutronix.de>
Acked-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/altera_uart.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -331,7 +331,7 @@ static int altera_uart_startup(struct ua
 
 	/* Enable RX interrupts now */
 	pp->imr = ALTERA_UART_CONTROL_RRDY_MSK;
-	writel(pp->imr, port->membase + ALTERA_UART_CONTROL_REG);
+	altera_uart_writel(port, pp->imr, ALTERA_UART_CONTROL_REG);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -347,7 +347,7 @@ static void altera_uart_shutdown(struct
 
 	/* Disable all interrupts now */
 	pp->imr = 0;
-	writel(pp->imr, port->membase + ALTERA_UART_CONTROL_REG);
+	altera_uart_writel(port, pp->imr, ALTERA_UART_CONTROL_REG);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -436,7 +436,7 @@ static void altera_uart_console_putc(str
 		 ALTERA_UART_STATUS_TRDY_MSK))
 		cpu_relax();
 
-	writel(c, port->membase + ALTERA_UART_TXDATA_REG);
+	altera_uart_writel(port, c, ALTERA_UART_TXDATA_REG);
 }
 
 static void altera_uart_console_write(struct console *co, const char *s,
@@ -506,13 +506,13 @@ static int __init altera_uart_earlycon_s
 		return -ENODEV;
 
 	/* Enable RX interrupts now */
-	writel(ALTERA_UART_CONTROL_RRDY_MSK,
-	       port->membase + ALTERA_UART_CONTROL_REG);
+	altera_uart_writel(port, ALTERA_UART_CONTROL_RRDY_MSK,
+			   ALTERA_UART_CONTROL_REG);
 
 	if (dev->baud) {
 		unsigned int baudclk = port->uartclk / dev->baud;
 
-		writel(baudclk, port->membase + ALTERA_UART_DIVISOR_REG);
+		altera_uart_writel(port, baudclk, ALTERA_UART_DIVISOR_REG);
 	}
 
 	dev->con->write = altera_uart_earlycon_write;
