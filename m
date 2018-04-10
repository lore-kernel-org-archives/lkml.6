Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeDJJGI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:06:08 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:47501 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbeDJJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:06:03 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517900400";
   d="scan'208";a="10408591"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 01/11] iio: adc: at91-sama5d2_adc: fix channel configuration for differential channels
Date: Tue, 10 Apr 2018 11:57:47 +0300
Message-ID: <1523350677-27106-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iterating through the channels, the index in the array is not the
scan index. Added an xlate function to translate to the proper index.
The result of the bug is that the channel array is indexed with a wrong index,
thus instead of the proper channel, we access invalid memory, which may
lead to invalid results and/or corruption.
This will be used also for devicetree channel xlate.

Fixes: 5e1a1da0f ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Fixes: 073c66201 ("iio: adc: at91-sama5d2_adc: add support for DMA")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 41 ++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 4eff835..8729d65 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -333,6 +333,27 @@ static const struct iio_chan_spec at91_adc_channels[] = {
 				+ AT91_SAMA5D2_DIFF_CHAN_CNT + 1),
 };
 
+static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].scan_index == chan)
+			return i;
+	}
+	return -EINVAL;
+}
+
+static inline struct iio_chan_spec const *
+at91_adc_chan_get(struct iio_dev *indio_dev, int chan)
+{
+	int index = at91_adc_chan_xlate(indio_dev, chan);
+
+	if (index < 0)
+		return NULL;
+	return indio_dev->channels + index;
+}
+
 static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
@@ -350,8 +371,10 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
 
 	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
-		struct iio_chan_spec const *chan = indio->channels + bit;
+		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
 
+		if (!chan)
+			continue;
 		if (state) {
 			at91_adc_writel(st, AT91_SAMA5D2_CHER,
 					BIT(chan->channel));
@@ -448,7 +471,11 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->num_channels) {
-		struct iio_chan_spec const *chan = indio_dev->channels + bit;
+		struct iio_chan_spec const *chan =
+					 at91_adc_chan_get(indio_dev, bit);
+
+		if (!chan)
+			continue;
 
 		st->dma_st.rx_buf_sz += chan->scan_type.storagebits / 8;
 	}
@@ -526,8 +553,11 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 	 */
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->num_channels) {
-		struct iio_chan_spec const *chan = indio_dev->channels + bit;
+		struct iio_chan_spec const *chan =
+					at91_adc_chan_get(indio_dev, bit);
 
+		if (!chan)
+			continue;
 		if (st->dma_st.dma_chan)
 			at91_adc_readl(st, chan->address);
 	}
@@ -587,8 +617,11 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->num_channels) {
-		struct iio_chan_spec const *chan = indio_dev->channels + bit;
+		struct iio_chan_spec const *chan =
+					at91_adc_chan_get(indio_dev, bit);
 
+		if (!chan)
+			continue;
 		st->buffer[i] = at91_adc_readl(st, chan->address);
 		i++;
 	}
-- 
2.7.4
