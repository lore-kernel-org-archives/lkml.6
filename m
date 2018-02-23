Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBWMxB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:53:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751089AbeBWMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:52:01 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 4/7] iio: adc: stm32-dfsdm: fix multiple channel initialization
Date: Fri, 23 Feb 2018 13:50:58 +0100
Message-ID: <1519390261-25453-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When several channels are registered (e.g. via st,adc-channels property):
- channels array is wrongly filled in. Only 1st element in array is being
  initialized with last registered channel.
  Fix it by passing reference to relevant channel (e.g. array[index]).
- only last initialized channel can work properly (e.g. unique 'ch_id'
  is used). Converting any other channel result in conversion timeout.
  Fix it by getting rid of 'ch_id', use chan->channel instead.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 0eff811..01422d1 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -54,7 +54,6 @@ struct stm32_dfsdm_adc {
 	struct stm32_dfsdm *dfsdm;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	unsigned int fl_id;
-	unsigned int ch_id;
 
 	/* ADC specific */
 	unsigned int oversamp;
@@ -384,7 +383,7 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
-	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[adc->ch_id];
+	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[chan->channel];
 	unsigned int sample_freq = adc->sample_freq;
 	unsigned int spi_freq;
 	int ret;
@@ -419,18 +418,20 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
 	return len;
 }
 
-static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc, bool dma)
+static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
+				  const struct iio_chan_spec *chan,
+				  bool dma)
 {
 	struct regmap *regmap = adc->dfsdm->regmap;
 	int ret;
 	unsigned int dma_en = 0, cont_en = 0;
 
-	ret = stm32_dfsdm_start_channel(adc->dfsdm, adc->ch_id);
+	ret = stm32_dfsdm_start_channel(adc->dfsdm, chan->channel);
 	if (ret < 0)
 		return ret;
 
 	ret = stm32_dfsdm_filter_configure(adc->dfsdm, adc->fl_id,
-					   adc->ch_id);
+					   chan->channel);
 	if (ret < 0)
 		goto stop_channels;
 
@@ -464,12 +465,13 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc, bool dma)
 
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_RCONT_MASK, 0);
-	stm32_dfsdm_stop_channel(adc->dfsdm, adc->ch_id);
+	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
 
 	return ret;
 }
 
-static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc)
+static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc,
+				  const struct iio_chan_spec *chan)
 {
 	struct regmap *regmap = adc->dfsdm->regmap;
 
@@ -482,7 +484,7 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc)
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_RCONT_MASK, 0);
 
-	stm32_dfsdm_stop_channel(adc->dfsdm, adc->ch_id);
+	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
 }
 
 static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
@@ -609,6 +611,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan = &indio_dev->channels[0];
 	int ret;
 
 	/* Reset adc buffer index */
@@ -618,7 +621,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = stm32_dfsdm_start_conv(adc, true);
+	ret = stm32_dfsdm_start_conv(adc, chan, true);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Can't start conversion\n");
 		goto stop_dfsdm;
@@ -635,7 +638,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_stop_conv:
-	stm32_dfsdm_stop_conv(adc);
+	stm32_dfsdm_stop_conv(adc, chan);
 stop_dfsdm:
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
@@ -645,11 +648,12 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan = &indio_dev->channels[0];
 
 	if (adc->dma_chan)
 		dmaengine_terminate_all(adc->dma_chan);
 
-	stm32_dfsdm_stop_conv(adc);
+	stm32_dfsdm_stop_conv(adc, chan);
 
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
@@ -730,7 +734,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto stop_dfsdm;
 
-	ret = stm32_dfsdm_start_conv(adc, false);
+	ret = stm32_dfsdm_start_conv(adc, chan, false);
 	if (ret < 0) {
 		regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 				   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
@@ -751,7 +755,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	else
 		ret = IIO_VAL_INT;
 
-	stm32_dfsdm_stop_conv(adc);
+	stm32_dfsdm_stop_conv(adc, chan);
 
 stop_dfsdm:
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
@@ -765,7 +769,7 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
-	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[adc->ch_id];
+	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[chan->channel];
 	unsigned int spi_freq = adc->spi_freq;
 	int ret = -EINVAL;
 
@@ -972,7 +976,6 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 	}
 	ch->scan_type.realbits = 24;
 	ch->scan_type.storagebits = 32;
-	adc->ch_id = ch->channel;
 
 	return stm32_dfsdm_chan_configure(adc->dfsdm,
 					  &adc->dfsdm->ch_list[ch->channel]);
@@ -1001,7 +1004,7 @@ static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
 	}
 	ch->info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
-	d_ch = &adc->dfsdm->ch_list[adc->ch_id];
+	d_ch = &adc->dfsdm->ch_list[ch->channel];
 	if (d_ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
 		adc->spi_freq = adc->dfsdm->spi_master_freq;
 
@@ -1042,8 +1045,8 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
-		ch->scan_index = chan_idx;
-		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, ch);
+		ch[chan_idx].scan_index = chan_idx;
+		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &ch[chan_idx]);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Channels init failed\n");
 			return ret;
-- 
1.9.1
