Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpksebT+o1pryQivLIB+ruqpwd6Xchv/uwK7nM6Je1941VYmN/jthC4KIgWwb7v3BqAKPjA
ARC-Seal: i=1; a=rsa-sha256; t=1527156324; cv=none;
        d=google.com; s=arc-20160816;
        b=zYqGnFdAmD/Za0Wyc8xl5bBVDCDstquxmCLckO3hwPr07LzpdUCk2OSLH5SvaxUgRQ
         l6iReE/hmqSKinR6dHLwx11Z8UhCog3UyaEma2NI9o1sjQWbpMftOdenSSFDJDDgThwZ
         Md9QtNkh0pPSZ95DJzUQ18eIaUJXuOYhcYjpc8okYw9o7myBqzN3EsYTupTfDgmm1B8A
         GbFI+W9TAm4yBcrnVKaLlk7TkJUjvUqHppMZKeaMAfCa9SLWTFFlANlZBTB7yqwh7Eii
         wpoWZYAql5w2pOZF47RczIDy5lWz1P6ssV/vSjM/bHnob+2VYTuMjL1F5oDsdedCDxSi
         Artg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HxzUoSN2Jz3tY5Dv4761BNUGzEublPYjsdIlxSrgjaw=;
        b=Q7SwbynqBkguuHE/xcNyHB8o5+IkonmyzGsHyUOX+D7tIvPqw9XH1ZLCT0Am91s9/5
         WE/aX0iuI+PePDLnP/UL/FXtpbgMDL1uRGBYicwR0C++2wMm1LFM3oHB8LK2Q80bT3F5
         tAzwyhvY42UN29WbQN1SXEjto/pX7MqCsCqUm6CI0YVaYiH5YJTUrmRhuv7sftlR0T4D
         Hz0t3jNkhGc6VBFQcBAgaX8+aKRpfJhyLLTyNcBZa+2F5hCxFihsKu4ii7k4BIUWBZyu
         vOHC2Ire7bl2ej6UuUXaFzC2UugV0wuJMmL0ZZ8dPgE/mfu/+JGfYXAwsu5W5Iy/i6xC
         bxIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E976rN38;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E976rN38;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michal Simek <michal.simek@xilinx.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 146/161] serial: xuartps: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:31 +0200
Message-Id: <20180524093035.835781973@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338546961594801?=
X-GMAIL-MSGID: =?utf-8?q?1601339470452252499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit e7d75e18d0fc3f7193b65282b651f980c778d935 ]

The cdns_uart_port[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/xilinx_uartps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_p
 	struct uart_port *port;
 
 	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
 		/* Find the next unused port */
 		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
 			if (cdns_uart_port[id].mapbase == 0)
