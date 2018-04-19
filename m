Return-Path: <stefan@agner.ch>
X-Google-Smtp-Source: AIpwx49GUGlUz50mFaO3PBk1fzQcO+rtsW6zJRm6QnYVftJyknUImN9qjetA1p0En61fd49ae9rJ
ARC-Seal: i=1; a=rsa-sha256; t=1524152364; cv=none;
        d=google.com; s=arc-20160816;
        b=KtlrdW+IkmOiU8iM5RoXII7xrITW9Ro9h6+oevluxIo1jQiwh04eP3N9VSUzQ2LVnV
         bgeMkbdHUvU4NQj5AnETgJkDrlGelUKgUbIJKiUjhLEi/GYbWm7sqTEPxD+LRnWQcLsy
         KZ0/HZPw84Ojd/8M4DJBwn79iU+DAwFfX843eigJaoTAcOz3Q90Ox5A/n9RukMdi7H0B
         dYipAXag3fKa5TwxeZniZ1Wvl1c4CDmMHguopqaHSDncEeqVh2LVi+bt3JES/cN717HG
         rKWJzg25AGYawxDniPiyz45ZFmv20v1XU9s2Kc/YvPLPvsIotjsvuywguBiEMoB0YzyZ
         mEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Vu0uYOcRvk+/DMLWEfpg0IGK8oDyiCWKh1AddMSZVX8=;
        b=m92Ay8UfoJI9idqfJkDnwRQLSaTyhm+13k3VkW3gTvHTjU+DqdbFh8SHRFTTq/Ttih
         owGl3wfxM9SOYXmHvaDGwicKbcfoU2sO692bw39HPkGCyTbzs+b5KvEeAsrbGXExLRuS
         15o513um/FkNQp09ionhLFHb6g1lOTvCYS12dYUUqfzaHXA9Oj8B/KnCPlTm+coYBNtM
         wbhnOXPclnr6t1pEGIjM/vu12Tpv3axzg8lsJSnHMIq9oQTXycy9g/Z+SA1q6UsRZjTL
         3GVswWzxjGvuA0N4l9fwygi8egqlfq3YsnkexekeiIMgiTgF+iqKw1h+0OA9XqpgcDEs
         j68A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@agner.ch header.s=dkim header.b=YYoR4L/L;
       spf=pass (google.com: domain of stefan@agner.ch designates 2a02:418:6a02::a2 as permitted sender) smtp.mailfrom=stefan@agner.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@agner.ch header.s=dkim header.b=YYoR4L/L;
       spf=pass (google.com: domain of stefan@agner.ch designates 2a02:418:6a02::a2 as permitted sender) smtp.mailfrom=stefan@agner.ch
From: Stefan Agner <stefan@agner.ch>
To: gregkh@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de
Cc: lukas@wunner.de,
	jslaby@suse.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3] serial: imx: warn user when using unsupported configuration
Date: Thu, 19 Apr 2018 17:39:16 +0200
Message-Id: <20180419153916.21898-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-1.80 / 15.00];
	 RCVD_TLS_ALL(0.00)[];
	 ASN(0.00)[asn:13030, ipnet:2001:1620::/32, country:CH];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_HAS_DN(0.00)[];
	 MID_CONTAINS_FROM(1.00)[];
	 TO_DN_SOME(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FROM_EQ_ENVFROM(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.70)[98.69%];
	 ARC_NA(0.00)[];
	 DKIM_SIGNED(0.00)[];
	 RCPT_COUNT_SEVEN(0.00)[7]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598189589326510131?=
X-GMAIL-MSGID: =?utf-8?q?1598189589326510131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When using half-duplex mode (which disables receiver during txing)
the RTS signal cannot be driven low during transmission when using
i.MX UART RTS/CTS control. This seems to be a limitation of the
i.MX UART IP: The RTS (CTS_B) signal is controlled by the receiver.
When the receiver is disabled, the signal stays in UART logic idle
state which is high...

If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
transmission. Since this is the default state of the RTS (CTS_B)
signal when the receiver is off, half-duplex mode in this
configuration works fine.

However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
cannot be generated when the receiver is turned off.

Print an error if the user selects this unsupported configuration
(both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
configure the closest working configuration (set the
SER_RS485_RX_DURING_TX flag).

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..65d7a2bfb6d2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1833,6 +1833,11 @@ static int imx_uart_rs485_config(struct uart_port *port,
 		rs485conf->flags &= ~SER_RS485_ENABLED;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
+		/* Enable receiver if low-active RTS signal is requested */
+		if (sport->have_rtscts &&  !sport->have_rtsgpio &&
+		    !(rs485conf->flags & SER_RS485_RTS_ON_SEND))
+			rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
 		/* disable transmitter */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
@@ -2265,6 +2270,18 @@ static int imx_uart_probe(struct platform_device *pdev)
 	    (!sport->have_rtscts && !sport->have_rtsgpio))
 		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
 
+	/*
+	 * If using the i.MX UART RTS/CTS control then the RTS (CTS_B)
+	 * signal cannot be set low during transmission in case the
+	 * receiver is off (limitation of the i.MX UART IP).
+	 */
+	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
+	    sport->have_rtscts && !sport->have_rtsgpio &&
+	    (!(sport->port.rs485.flags & SER_RS485_RTS_ON_SEND) &&
+	     !(sport->port.rs485.flags & SER_RS485_RX_DURING_TX)))
+		dev_err(&pdev->dev,
+			"low-active RTS not possible when receiver is off, enabling receiver\n");
+
 	imx_uart_rs485_config(&sport->port, &sport->port.rs485);
 
 	/* Disable interrupts before requesting them */
-- 
2.17.0
