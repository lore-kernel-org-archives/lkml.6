Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KhqSS3M/kk+zVjbWDCpfKa2IVao18sDoK4IKV9k+ctonqbNvXo3302p44CNXomUy7JjhM
ARC-Seal: i=1; a=rsa-sha256; t=1523399341; cv=none;
        d=google.com; s=arc-20160816;
        b=uS/C92QgINPnzcgcleRUymweG7AAYwhYINQ8cRZycZmFFryzGRZOdu74YXm3q3TZT3
         X6EIdOUoWbLF0A5fRCyBxUJSqPwPZmEEI2xRUrHkxtxmLmwmvC3n0LdQCgkSI50/5F3S
         QDxDsSM644+EThhXMzZ7l26tPCKXgbikCHdULOLXu+DLvoSGGobJ0maBWHBqfdW+bz2e
         KuI6FXfIDMwgozdOYMCs1H6oNhr2mxXJ8cPQsXEBSu8WmyqhbrtJyUcs645SlYdYLLid
         0EObd1UxR9zTFk0oV9j0sYhf+QH10vQ27gx2RA5AVTNLSD+gSBhMGIJQb5jFTGc8vvC2
         cRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CaTtowvVAZ+XDgPwcWH4QuEeXw57ZPbDGff2pb/e8t8=;
        b=p6CHPnUk0b6eWxI2qlsHL/irC5s5VVWfB2K6Y+WmJpZKRY5xf0SC90o3D8+YUwn7UB
         zadZ4m4WC7moWMbZytAyvGzH1TyGuW9M3Fn8dIqsoxjRIW5pB/3ok4EhPByCw6PCufuY
         GexAXUfsXyqXAKEthYt/+Wg2DajDd1ZP8Z8JYmFU98QFjKiRfxy82ni9qVTAl9srDZN9
         aMh/g4dAEw5vpSkQoZChh2wRHOafd6ZdIliG6Ku0utP2tykXevjrNkhA6/PoEs4+u/sg
         Tv0aVRZD0Le87AIt8BT/4l/IFycNgqZ1DnfKPc1D3yCiHqnvR+LqlC4ulb0QeEH2c3rK
         GGXg==
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
Subject: [PATCH 4.15 054/168] backlight: tdo24m: Fix the SPI CS between transfers
Date: Wed, 11 Apr 2018 00:23:16 +0200
Message-Id: <20180410212802.508966761@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399987909827945?=
X-GMAIL-MSGID: =?utf-8?q?1597399987909827945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
