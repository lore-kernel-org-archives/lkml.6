Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrdk2Y7RL0kZiAihEjTZH9jo6xr7B7ciGS8rg4R/+8OmR6z7jjSlNtTwEu4psRKFQkQcANn
ARC-Seal: i=1; a=rsa-sha256; t=1527156348; cv=none;
        d=google.com; s=arc-20160816;
        b=f+nBJA2sNZ0i61wZ0cChJvvtA9TGIOClLpMHo3bDi+TjG9Wd6kaCWIoT3fLD+PzdsV
         0ApHLxdG97kYqT6iPWrLLYsePyKNcECYx9Mfbq4tkxj7dw03ZkgWDsGXnI0UiqHgotcu
         nKMNIJqqLcmepEqshDuEyAWUZEkHdeNc026qiDSgsalTXmlcyQm+F39cmLfbaUkWBCRb
         LNp/aH0C6uYsXSrYLPJLuKtfcGy089bQxAXmwBSIOXgQzpFQQdIa69xWVAssGfwvKnOD
         yvf0qAdYW5AeDvutRvDxriRiYGuGUA/ZLg5C1KK5vn8WokwSUM5MoSStQ1FF8uexfIif
         wTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QIo7dnH352tHRgZXdLZfyiLKdAoowaYazHeE3fEhUdE=;
        b=QY7qEOYbU3Jlntd/dTqfFgsfbVjKHRpJre4hQyxXyaxPxBekXcSW638/UzjOuoe9t6
         9n+RzZAUDmIsCypQv15Bs05tMefx/iQ5201nspbb+Brn2fGHsrAWCCkiDoipZuQ1deyG
         Uf0XY018zcoueKx5tpzAx3zionifBMAnDktfMAgpZqxoIr6ITYgVDKcB2YkPjQdcFVLV
         a8LE4Jit/T8UqMEffU0UqNhq1fGzYu8V56LSKNK4nOITG6ZDwf8cgfQZGtssoZFm8ngy
         s1e9GVA/fXAqBprj8mOcITZy2UtncdlbnEHabblJPVY1GKCRCVZ0HLKNZDfRv4ZEclGA
         fgNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Z/svxqEk;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Z/svxqEk;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tobias Klauser <tklauser@distanz.ch>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 154/161] serial: altera: ensure port->regshift is honored consistently
Date: Thu, 24 May 2018 11:39:39 +0200
Message-Id: <20180524093036.688598872@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339065589910831?=
X-GMAIL-MSGID: =?utf-8?q?1601339495622729845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -327,7 +327,7 @@ static int altera_uart_startup(struct ua
 
 	/* Enable RX interrupts now */
 	pp->imr = ALTERA_UART_CONTROL_RRDY_MSK;
-	writel(pp->imr, port->membase + ALTERA_UART_CONTROL_REG);
+	altera_uart_writel(port, pp->imr, ALTERA_UART_CONTROL_REG);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -343,7 +343,7 @@ static void altera_uart_shutdown(struct
 
 	/* Disable all interrupts now */
 	pp->imr = 0;
-	writel(pp->imr, port->membase + ALTERA_UART_CONTROL_REG);
+	altera_uart_writel(port, pp->imr, ALTERA_UART_CONTROL_REG);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -432,7 +432,7 @@ static void altera_uart_console_putc(str
 		 ALTERA_UART_STATUS_TRDY_MSK))
 		cpu_relax();
 
-	writel(c, port->membase + ALTERA_UART_TXDATA_REG);
+	altera_uart_writel(port, c, ALTERA_UART_TXDATA_REG);
 }
 
 static void altera_uart_console_write(struct console *co, const char *s,
@@ -502,13 +502,13 @@ static int __init altera_uart_earlycon_s
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
