Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtQ5v9H6vdBCCyWvQ4TlfXBYbx5+KHjzHST+9DIyYggCZaDiB/4ZiixnfstQeVgpmTHhCkt
ARC-Seal: i=1; a=rsa-sha256; t=1521483688; cv=none;
        d=google.com; s=arc-20160816;
        b=Ak7KAJbFz4CrGM9pOmhuEfVE57fitXarCePJyTfSdHHRxtNsYkqWXePXuturG69JXo
         VcqbliRTdSL2a3woH5ytOf8FQuundi3qaEOdylpqSNtoLj/vFiBcWyeqhb3Oyw6obAF/
         6Jz36NrsockEE5x2Htpl1bdi24yMQhs2ODoRxkwcqNHZ9zOaH3/qjCtcqJjyf/YkIDc6
         d7ZVTmsjVGS06o298gjFejSao3Lg/QzkgKHQUWbEjJStxAmjDw0NjRFZaAhm5q9XevHP
         2NqEq9tnjCO/j8+jfX1dIbrkrwQaYqegCt30il7HNCLVmtBkqD0XKSP+lJjau4I9pNE2
         PSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VihABIU+AsGwm09SqpznluNQSjyX30Z2qkCqymLygck=;
        b=oK/+/xn/la/VijX6NDEKbYHUYFvZed0sf1WqkJvTY6bgav8LXNG7ZrJrpG5yHKCLxP
         w0k9twdrbeib8OFeebJwccYR9xnfBZ0ZonyU06SfjG5mkvOjQXACRR3Mz9gaIIR/eIHN
         HdOQVy8DUhOf/ZF9Xfm0E0gFTfJH3lpVuqsrAAxR3ezOwNKGQr0tvsXoE5ayuSe5MKYi
         ALm3IU8/DoPAicFE+eTLySv5pfH67XjKjRgaLJ94Qan0mEinxaVfhLj4NzxvhYvEUqAC
         EV8BhsOtkKWC+uvnkX/PfkxGYN4sFeviAhXvjwnvXzUHwo2mKPfdoXhjCeFgDkODKluX
         C1Ng==
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
Subject: [PATCH 4.9 063/241] spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Date: Mon, 19 Mar 2018 19:05:28 +0100
Message-Id: <20180319180753.809101115@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390520568953936?=
X-GMAIL-MSGID: =?utf-8?q?1595391279573924350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -454,6 +454,8 @@ omap2_mcspi_rx_dma(struct spi_device *sp
 	int			elements = 0;
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
+	void __iomem		*chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
+
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 	count = xfer->len;
@@ -549,8 +551,8 @@ omap2_mcspi_rx_dma(struct spi_device *sp
 	if (l & OMAP2_MCSPI_CHCONF_TURBO) {
 		elements--;
 
-		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				   & OMAP2_MCSPI_CHSTAT_RXS)) {
+		if (!mcspi_wait_for_reg_bit(chstat_reg,
+					    OMAP2_MCSPI_CHSTAT_RXS)) {
 			u32 w;
 
 			w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
@@ -568,8 +570,7 @@ omap2_mcspi_rx_dma(struct spi_device *sp
 			return count;
 		}
 	}
-	if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				& OMAP2_MCSPI_CHSTAT_RXS)) {
+	if (!mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS)) {
 		u32 w;
 
 		w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
