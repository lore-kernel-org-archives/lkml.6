Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ILdjiI0qWb/UJR4kyDslrWggPp4BqLpQ3T/ihK1Q9olHapsjn+A1z+xjhdEM/lgLcE27P
ARC-Seal: i=1; a=rsa-sha256; t=1523473236; cv=none;
        d=google.com; s=arc-20160816;
        b=lkpR36lNNfkQkiCVoraNhjBuLLMoUWQAEnriQHcm5xFkfO1+3IJbfXxd1bzMBR0CZK
         Ri7qjyQ3snj7zyuM7er+4EOGdPntRKH57VigMMxCdeCUmsloibO3NHPOk15YjfsR/VOs
         RMxR4JOtkeOn+IiRIC/gOLW2FH/QsaYPSVm4sSYHiqyyfz34GvN2n0he3xsl9e+d4ME7
         sQ/M1b/WjfFFXB1dIHPL7XFFH+XQLQwbQV6BtHkMAVCIrNlCTTlnyejsCO1mFo0WHNrJ
         2PgclMeWz21TI7YWXTACsS7gpVv6rpBLmvhCvi/pGhGAi4ARt+uOTo1wmr6Ezbnu4LIF
         mwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+BStIfeyKkwzuRjGri8udTdrQT+6ansggdEHlI7KGS0=;
        b=jheMC9t1EHLPiJ0Hxtwi+ze4yZ/jvYv32Ppw7uHuKJ5MQfvu/+zGKxa2b4qUSSZH13
         pqk/gesh/5U8s8jFVRd7jAxOvAjiiuip58vGva34SavZIjEkPhsCZCG/1VannMS2rS05
         WxpEolK+EBwcigYkK/MD0siqyOu3HB6JZKatdEWBu4A3K5Ru998rrrmk8fBHacNAbCgG
         aDWH+LeFMvkrapoqcABgfFnfika1cL0UqftQmF3bFq4mqiKP6A8RJScGK5aHyp/Odir+
         iJRWEdxt8Ar+az8Fj2IAqeaUEyNXfLyZtnKA/ERrL8pUtJUzX7xjEmW53y4t1X9qUPTs
         zzPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrea Adami <andrea.adami@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 143/310] backlight: tdo24m: Fix the SPI CS between transfers
Date: Wed, 11 Apr 2018 20:34:42 +0200
Message-Id: <20180411183628.600691032@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477472753460709?=
X-GMAIL-MSGID: =?utf-8?q?1597477472753460709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Jarzmik <robert.jarzmik@free.fr>


[ Upstream commit 2023b0524a6310e9ea80daf085f51c71bff9289f ]

Currently the LCD display (TD035S) on the cm-x300 platform is broken and
remains blank.

The TD0245S specification requires that the chipselect is toggled
between commands sent to the panel. This was also the purpose of the
former patch of commit f64dcac0b124 ("backlight: tdo24m: ensure chip
select changes between transfers").

Unfortunately, the "cs_change" field of a SPI transfer is
misleading. Its true meaning is that for a SPI message holding multiple
transfers, the chip select is toggled between each transfer, but for the
last transfer it remains asserted.

In this driver, all the SPI messages contain exactly one transfer, which
means that each transfer is the last of its message, and as a
consequence the chip select is never toggled.

Actually, there was a second bug hidding the first one, hence the
problem was not seen until v4.6. This problem was fixed by commit
a52db659c79c ("spi: pxa2xx: Fix cs_change management") for PXA based
boards.

This fix makes the TD035S work again on a cm-x300 board. The same
applies to other PXA boards, ie. corgi and tosa.

Fixes: a52db659c79c ("spi: pxa2xx: Fix cs_change management")
Reported-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/backlight/corgi_lcd.c |    2 +-
 drivers/video/backlight/tdo24m.c    |    2 +-
 drivers/video/backlight/tosa_lcd.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -177,7 +177,7 @@ static int corgi_ssp_lcdtg_send(struct c
 	struct spi_message msg;
 	struct spi_transfer xfer = {
 		.len		= 1,
-		.cs_change	= 1,
+		.cs_change	= 0,
 		.tx_buf		= lcd->buf,
 	};
 
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -369,7 +369,7 @@ static int tdo24m_probe(struct spi_devic
 
 	spi_message_init(m);
 
-	x->cs_change = 1;
+	x->cs_change = 0;
 	x->tx_buf = &lcd->buf[0];
 	spi_message_add_tail(x, m);
 
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -49,7 +49,7 @@ static int tosa_tg_send(struct spi_devic
 	struct spi_message msg;
 	struct spi_transfer xfer = {
 		.len		= 1,
-		.cs_change	= 1,
+		.cs_change	= 0,
 		.tx_buf		= buf,
 	};
 
