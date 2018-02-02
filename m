Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227NijnwX1sFGqYFrFjOa9DlTd84ATsQHnWQegePU/xOKesG2mHPVOTsHCaoQUpiR8CdfEFC
ARC-Seal: i=1; a=rsa-sha256; t=1517590963; cv=none;
        d=google.com; s=arc-20160816;
        b=ks1yWGSaHPWlFfvWFmPVeeEXYLpM9TQSBjYD2BryN/FinPR1mQwhboC0SW+6prrwCO
         nVN8Cekd+wBF++barLdT85eBZ0UuN7+V2NFPSGnxDRDUyno3PLHyAHywrfMX8QKGrGJg
         8gRQvb5avtC5egZfxstaXfE1kcSfyhgZLZldsJr/aG+YexcryG1aA9o6c1Cp8sqfgwrC
         n9aG7+KDw4p8m+WVAmtwB/vICEE/bY8BztyvsOCkOQz1C06qVqSunSXOtI/4TLRQ1Lat
         qcIpwWr1Ag9ZISWpeIELZGkfBHSx5/20KQhNOp4Zv1TbKOcbUuI9WyOsSJ3xvK5PdZYG
         2rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZEnpgdJHaCgMwsvggkblGnY0Zs5yRAOa632QFtGKDbg=;
        b=fVz/FpWGBnTkPGmUXHTHt0eLScCfxAom+bJBNjt8QdoTmuYRaLO3sbr2smETomN28z
         f7DUXPddEgXmtLAI3YC3ddl9wIYOM4opfpp/pQp8IDV7a5CuG1kj2TFAbWJfDORNZsr8
         iNxzMQUNmeDChcGCAn8Bu6AtOglg3M7EBUJwnJ/dutCw/6/o9DBD05MghnwxCqxZapWD
         T6+lUZnlWMnBT6iRncZ/3qStQbnODKSPgC54C0GuVUaWhm2tHgS3c+gMd4GeIFyrqG3B
         FsENltNPjqCiKnxJqxcDTQ5VlOatZe+kEH0J5VptNZRYxKtJ7A18ncTHHrXsm1oGi0p7
         tHWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Martin Kaiser <martin@kaiser.cx>,
	Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH 4.4 66/67] serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS
Date: Fri,  2 Feb 2018 17:58:35 +0100
Message-Id: <20180202140822.488256547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309461447387498?=
X-GMAIL-MSGID: =?utf-8?q?1591309461447387498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

commit 38b1f0fb42f772b8c9aac53593883a18ff5eb9d7 upstream.

The wakeup mechanism via RTSDEN bit relies on the system using the RTS/CTS
lines, so only allow such wakeup method when the system actually has
RTS/CTS support.

Fixes: bc85734b126f ("serial: imx: allow waking up on RTSD")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/imx.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2057,12 +2057,14 @@ static void serial_imx_enable_wakeup(str
 		val &= ~UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
 
-	val = readl(sport->port.membase + UCR1);
-	if (on)
-		val |= UCR1_RTSDEN;
-	else
-		val &= ~UCR1_RTSDEN;
-	writel(val, sport->port.membase + UCR1);
+	if (sport->have_rtscts) {
+		val = readl(sport->port.membase + UCR1);
+		if (on)
+			val |= UCR1_RTSDEN;
+		else
+			val &= ~UCR1_RTSDEN;
+		writel(val, sport->port.membase + UCR1);
+	}
 }
 
 static int imx_serial_port_suspend_noirq(struct device *dev)
