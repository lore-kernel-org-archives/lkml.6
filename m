Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpXVEOwCDBbpwuRIYImT2fEIr8SKc6d5CRaMKItNOSeWvVmkfXO6igIJTPKPEHoWK7GiHyK
ARC-Seal: i=1; a=rsa-sha256; t=1527156322; cv=none;
        d=google.com; s=arc-20160816;
        b=mUBY/TedU/OUvVd2vZ/0pI8YRSBP8hHbE+qnaYnRM5z1g9Mmh1chDlHdvvolhQoV3y
         mIgsNmSbrD4ameJAVPAvGddEOTlEH6Ei8DNT4qWYnfZRTheFEjBEuTJx8/I4s16WtOfP
         SgYyhqqbmPwdoFvz3K9qEkyv+pdnzOO9BiAzocF0VGX8sXgtbvI8Hhaaz0HLX3hkQZEy
         yfoe+v8yqxzzyfP3bWJf15seii2IBqidAXH3LF71WOTQV72cxS/heiaoE/hKY8ywzaXP
         x05VZb9KJwuBvePNfFF5dqCDqRaiN2PCkJSwbs9NtCh6pOoDwJ46/Ui8wRIR5PZBskFW
         2GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=myfi9ZX1aton/ZzXK33vFSMR4qGH9WrkpJ+iqPjjsPc=;
        b=ih9UCuI4QFfqbGtkS8MEDcMLYFjRBajshmXScHzvsYPDw7IHhyvQQ9sKDBst6AsUr3
         8Pqc+gfVC4UhQTqYyUEIxk19LTliNbQUlakeS0rxAMH8BgfcbvUCTix5yXbD6srzINyV
         +Pt42/WV0TvShx8Yn1ljlCvFuo+r8q5Oriqc74u97QIpS8hQViSc0V1w5SnYGAvoKM59
         jyl/7Dhj5xHjGzycv+2l4yxR4FR2IZzqU54pABWHYa5Lv/RSGN+MMHbcEDembmbc37Tb
         Vj0Dw0BBzm/RhzyBvX07G93VznS+5qnw3pqTHdokUtsOZ15DI+fCzrJ86OeyT3rCf+Dv
         TIGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Gfz1B1yZ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Gfz1B1yZ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Gabriel Matni <gabriel.matni@exfo.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 145/161] serial: mvebu-uart: fix tx lost characters
Date: Thu, 24 May 2018 11:39:30 +0200
Message-Id: <20180524093035.718574153@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339468039636639?=
X-GMAIL-MSGID: =?utf-8?q?1601339468039636639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Matni <gabriel.matni@exfo.com>

[ Upstream commit c685af1108d7c303f0b901413405d68eaeac4477 ]

Fixes missing characters on kernel console at low baud rates (i.e.9600).
The driver should poll TX_RDY or TX_FIFO_EMP instead of TX_EMP to ensure
that the transmitter holding register (THR) is ready to receive a new byte.

TX_EMP tells us when it is possible to send a break sequence via
SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
empty, it does not guarantee that a new byte can be written just yet.

Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700 serial port")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/mvebu-uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -617,7 +617,7 @@ static void wait_for_xmitr(struct uart_p
 	u32 val;
 
 	readl_poll_timeout_atomic(port->membase + UART_STAT, val,
-				  (val & STAT_TX_EMP), 1, 10000);
+				  (val & STAT_TX_RDY(port)), 1, 10000);
 }
 
 static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
