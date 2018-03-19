Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtH8KT+E79xuDMBvdrozyDRjJR/0K6H9LNVC1e11CNBLytOud82iNQCXB3G0DAV18tCPDwm
ARC-Seal: i=1; a=rsa-sha256; t=1521483818; cv=none;
        d=google.com; s=arc-20160816;
        b=ELym+qXJ9kTEbpbQBB3P4wnMWCbTXGVzYqHVVYBRDo0GxE1DigjyJPKEkJwlXFR1tv
         HNohxEvMaFYIsev+P6uI/zttI3KQEZYze7OOwVS/J480ZoUC++OS2l7iGoVMsEjk50cx
         pQPdkpe93LI2sc0ahWmHC9pMtnQM2OsvWBzbFFgL72B6TvJgJxd+NwwIn4YDwMW6NmQJ
         R4CSIFmP+yfxhAve19Odi7TOe7F0oC2lT7flP0ERfz6mLCubpzmn0OChqTUHmM/ZnFEv
         TMCzeQGboCb+KohC+aqFcEr0b6tBJP6hXva6NjBJ/o+kQfJxT2i/myi5mXQhuIPtODVz
         DPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=muGasVB9x6Ob9mTdoW0wPdirqm9cMt2NLQfM4Co+JxM=;
        b=hW8yxviMNZGPVW7Ax7TGf0hjHeefYFO8zpKyw982CIdzh82t2mZrQIVXCpnxfnCUrr
         BR8VN6xfCMj6uXeaxaugKXMYz6KCGYkx4rM515tZHoLj6elwQhF0WIUBXzpcrLtVLSVv
         Gr+iNoOBi3YgOQ7sPnsh7Z+XNerWgxwHIL92Tfe1bAixeaoAyshTi4VxFE24gmcK+89V
         MkFTa3YD0jMIPV250eQ6MeveS0wTm+336XbjQf5gEavFk9Q9b1CsIkin82Uy0DREcnDd
         a+GvjkjRU+sHWTjUEquAn867ZdTW3pERAK9q5CmAi3nRG8a3yIrb8rw6RfSDhDV0MqIv
         tJNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 128/241] serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off
Date: Mon, 19 Mar 2018 19:06:33 +0100
Message-Id: <20180319180756.500425657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391416952285233?=
X-GMAIL-MSGID: =?utf-8?q?1595391416952285233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>


[ Upstream commit e61c38d85b7392e033ee03bca46f1d6006156175 ]

If the UART is operated in DTE mode and UCR3_DCD or UCR3_RI are 1 (which
is the reset default) and the opposite side pulls the respective line to
its active level the irq triggers after it is requested in .probe.

These irqs were already disabled in .startup but this might be too late.

Also setup of the UFCR_DCEDTE bit (currently done in .set_termios) is
done very late which is critical as it also controls direction of some
pins.

So setup UFCR_DCEDTE earlier (in .probe) and also disable the broken
irqs in DTE mode there before requesting irqs.

Acked-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Uwe Kleine-KÃ¶nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1316,19 +1316,10 @@ static int imx_startup(struct uart_port
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
 
-		/*
-		 * The effect of RI and DCD differs depending on the UFCR_DCEDTE
-		 * bit. In DCE mode they control the outputs, in DTE mode they
-		 * enable the respective irqs. At least the DCD irq cannot be
-		 * cleared on i.MX25 at least, so it's not usable and must be
-		 * disabled. I don't have test hardware to check if RI has the
-		 * same problem but I consider this likely so it's disabled for
-		 * now, too.
-		 */
-		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP |
-			UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
+		temp |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
 
 		if (sport->dte_mode)
+			/* disable broken interrupts */
 			temp &= ~(UCR3_RI | UCR3_DCD);
 
 		writel(temp, sport->port.membase + UCR3);
@@ -1583,8 +1574,6 @@ imx_set_termios(struct uart_port *port,
 
 	ufcr = readl(sport->port.membase + UFCR);
 	ufcr = (ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);
-	if (sport->dte_mode)
-		ufcr |= UFCR_DCEDTE;
 	writel(ufcr, sport->port.membase + UFCR);
 
 	writel(num, sport->port.membase + UBIR);
@@ -2149,6 +2138,27 @@ static int serial_imx_probe(struct platf
 		 UCR1_TXMPTYEN | UCR1_RTSDEN);
 	writel_relaxed(reg, sport->port.membase + UCR1);
 
+	if (!is_imx1_uart(sport) && sport->dte_mode) {
+		/*
+		 * The DCEDTE bit changes the direction of DSR, DCD, DTR and RI
+		 * and influences if UCR3_RI and UCR3_DCD changes the level of RI
+		 * and DCD (when they are outputs) or enables the respective
+		 * irqs. So set this bit early, i.e. before requesting irqs.
+		 */
+		writel(UFCR_DCEDTE, sport->port.membase + UFCR);
+
+		/*
+		 * Disable UCR3_RI and UCR3_DCD irqs. They are also not
+		 * enabled later because they cannot be cleared
+		 * (confirmed on i.MX25) which makes them unusable.
+		 */
+		writel(IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP | UCR3_DSR,
+		       sport->port.membase + UCR3);
+
+	} else {
+		writel(0, sport->port.membase + UFCR);
+	}
+
 	clk_disable_unprepare(sport->clk_ipg);
 
 	/*
