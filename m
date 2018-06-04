Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeFDHEE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753324AbeFDHEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:04:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.16 30/47] iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock
Date: Mon,  4 Jun 2018 08:58:42 +0200
Message-Id: <20180604065550.735504768@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit d58109dcf37fc9baec354385ec9fdcd8878d174d upstream.

When channel clk source is set to "CLKOUT_F" or "CLKOUT_R" (e.g. div2),
sample rate is currently set to half the requested value.

Fixes: eca949800d2d ("IIO: ADC: add stm32 DFSDM support for PDM
microphone")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/stm32-dfsdm-adc.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -771,7 +771,7 @@ static int stm32_dfsdm_write_raw(struct
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
 	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[chan->channel];
-	unsigned int spi_freq = adc->spi_freq;
+	unsigned int spi_freq;
 	int ret = -EINVAL;
 
 	switch (mask) {
@@ -785,8 +785,18 @@ static int stm32_dfsdm_write_raw(struct
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!val)
 			return -EINVAL;
-		if (ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
+
+		switch (ch->src) {
+		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL:
 			spi_freq = adc->dfsdm->spi_master_freq;
+			break;
+		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING:
+		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING:
+			spi_freq = adc->dfsdm->spi_master_freq / 2;
+			break;
+		default:
+			spi_freq = adc->spi_freq;
+		}
 
 		if (spi_freq % val)
 			dev_warn(&indio_dev->dev,
