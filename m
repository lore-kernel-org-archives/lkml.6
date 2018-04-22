Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ndNJTXegTMQGI9eFm/kauZ+RSWnnIdUspjyKJoyLUSh0+xQo82NKfnIiCv8RJpi3Nsdw6
ARC-Seal: i=1; a=rsa-sha256; t=1524405865; cv=none;
        d=google.com; s=arc-20160816;
        b=zSBBz3uE9m2QkSMPdwMpjMsAipxJujb0uK/H8kice3QYWQ8HHclIE9ExHjuhFVR3OW
         xIucMxjR0tKYsg+9yhtYImLg9Y5IQYeFCKwa9UQJxi4ql1C+M9NKrYEPB6S4412Y/SWO
         DQzSyZS9SFT8eYeMTINT+pamsrSoiR27r1H/ADnMWUHbaxdwbWcjONnRc/2wjuUJjrG1
         b+4BULBKTSw4uSFylXLYjsDSC/LLoPykSyy43BTtvKn2yZWkRmlaXP3ZlnluXhJbK+X6
         bYBREqCYQxpnldAMLuiCnxhlWjZY2HJn0uA8KPxhFUrwYMZOTGVNJq21+RtYiACpeVEP
         lXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BQUEU4J5uNdXTkmiTwPGU1yY2j1UFt8DQW5vg6u3bU8=;
        b=ryIuQEBFoRZor4EpknJHJyueBeJlU1ubdRBFa6zVoFLRpvmoXJBOhA0IvGF2WGYzTX
         Q7zcYvh5uskmxbNgcVkZlN+kaNbRurVBEr5v8Zdg2Gr+2K2wO/vZoHY5uaHOU3HI5aRl
         VJpvZvE4v2imwOCGnoYxInqnunZKBdd5fN6d7s9u/11lO/dy/U1yzGL9JtvmZg7BrfNv
         dtLoRafwe1kN5MpjSV6VNVmCcgd6bt9Y68TgZXb9UA5645f19tTV8txTYmpRKS9SGcqb
         cX2tR53AJY5VY50kU0ElgJtf5juawzJGJ4dRAEtE80qHRQq1GWOqdUudMEXpEPNRQzqL
         gYUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eugen Hristev <eugen.hristev@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 026/164] spi: atmel: init FIFOs before spi enable
Date: Sun, 22 Apr 2018 15:51:33 +0200
Message-Id: <20180422135136.473088617@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454845634881024?=
X-GMAIL-MSGID: =?utf-8?q?1598455405231275694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 9581329eff9db72ab4fbb46a594fd7fdda3c51b0 upstream.

The datasheet recommends initializing FIFOs before
SPI enable. If we do not do it like this, there may be
a strange behavior. We noticed that DMA does not work properly
with FIFOs if we do not clear them beforehand or enable them
before SPIEN.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-atmel.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1489,6 +1489,11 @@ static void atmel_spi_init(struct atmel_
 {
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
+
+	/* It is recommended to enable FIFOs first thing after reset */
+	if (as->fifo_size)
+		spi_writel(as, CR, SPI_BIT(FIFOEN));
+
 	if (as->caps.has_wdrbt) {
 		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
 				| SPI_BIT(MSTR));
@@ -1499,9 +1504,6 @@ static void atmel_spi_init(struct atmel_
 	if (as->use_pdc)
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
-
-	if (as->fifo_size)
-		spi_writel(as, CR, SPI_BIT(FIFOEN));
 }
 
 static int atmel_spi_probe(struct platform_device *pdev)
