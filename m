Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu3UgJ1Vn56aVM8EeAJYdRBsgZuPaOVamz0AygPso4wfk1Kx2TIT5w3tzsm+LB9cjAv2J6a
ARC-Seal: i=1; a=rsa-sha256; t=1521483193; cv=none;
        d=google.com; s=arc-20160816;
        b=epgoB2+WUEd+d15bo6eShHrROKlZ41GkAUrsSVkZiNPLhekNdPVjFO5Eczps9SpCw1
         K1GZ+6xg0/mjacqYNl7OXkGOI54l06gxw59PEr6MaJJLNRNT/wfkdai6RATC3O3Z2Dbw
         EkWvdcfApOs+CZ5YDRTnP4ziV+6HzAtipAP+5o5iVTw9nZYWthA66onr6cyi+5c/9M5o
         m4A+y5sXT3/m104a7KrbitOn1hLmp8QWfSV4j58A1V0yjD6ab6gK08HZ5R6i9YtOFERn
         UdYXd4JLap/Jxd7sEx9HxluHurpU0jz8Xf/oS5CusAUxtthcn7yE7qsXeQ5ndI/xl0cE
         HW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+mpfmKiZnEzGBa1COo2hLy+dofB2VonWrqAU68N/6aA=;
        b=YYGZFYppKJOKQC4nazCbDnCX46pfamo99TUAx9vXUeuWJVJbfpFv4vOLxf/U4akq58
         BiIWKxtajs3ywzPpM/+3TH0SsN/wEO0LRGAi6PR9MLc4sM6ukZI0Ujc6zSmzogaIoq3i
         Xs8XHLZOG7Kc4FoQ11U+YHK2j4n41nMYO2YDCymCq5QElLQZxjUYWGy16t0WdK8+Lnv2
         +oiWEAsEyJ4Tt1ifWUWKxC/weCPN0dt76+DXx/v9I4pyLCEQPRV8K6bhA0TwrVrdRrmd
         PpBQC19Wr6FXo6BFtfGHc5Y4BaKN1XaCxvoJj3gYB0X7rnfW6prJbmjQh4BHkoayltSZ
         9bcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 032/134] spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Date: Mon, 19 Mar 2018 19:05:15 +0100
Message-Id: <20180319171853.917407502@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390520568953936?=
X-GMAIL-MSGID: =?utf-8?q?1595390761275825359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akinobu Mita <akinobu.mita@gmail.com>


[ Upstream commit 812613591cb652344186c4cd912304ed02138566 ]

When running the spi-loopback-test with slower clock rate like 10 KHz,
the test for 251 bytes transfer was failed.  This failure triggered an
spi-omap2-mcspi's error message "DMA RX last word empty".

This message means that PIO for reading the remaining bytes due to the
DMA transfer length reduction is failed.  This problem can be fixed by
polling OMAP2_MCSPI_CHSTAT_RXS bit in channel status register to wait
until the receive buffer register is filled.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-omap2-mcspi.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -457,6 +457,8 @@ omap2_mcspi_rx_dma(struct spi_device *sp
 	int			elements = 0;
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
+	void __iomem		*chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
+
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 	count = xfer->len;
@@ -517,8 +519,8 @@ omap2_mcspi_rx_dma(struct spi_device *sp
 	if (l & OMAP2_MCSPI_CHCONF_TURBO) {
 		elements--;
 
-		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				   & OMAP2_MCSPI_CHSTAT_RXS)) {
+		if (!mcspi_wait_for_reg_bit(chstat_reg,
+					    OMAP2_MCSPI_CHSTAT_RXS)) {
 			u32 w;
 
 			w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
@@ -536,8 +538,7 @@ omap2_mcspi_rx_dma(struct spi_device *sp
 			return count;
 		}
 	}
-	if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				& OMAP2_MCSPI_CHSTAT_RXS)) {
+	if (!mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS)) {
 		u32 w;
 
 		w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
