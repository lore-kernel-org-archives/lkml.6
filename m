Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Cy7pMc8cHluwLgAAmS7hNA
	; Mon, 11 Jun 2018 06:55:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BD27660792; Mon, 11 Jun 2018 06:55:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CB217606FA;
	Mon, 11 Jun 2018 06:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB217606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeFKGzI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:55:08 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3331 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbeFKGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:55:06 -0400
X-IronPort-AV: E=Sophos;i="5.49,500,1520924400";
   d="scan'208";a="12936539"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jun 2018 23:55:07 -0700
Received: from eh-station.mchp-main.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Sun, 10 Jun 2018 23:55:05 -0700
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [RFC PATCH] iio: adc: at91-sama5d2_adc: add support for oversampling resolution
Date: Mon, 11 Jun 2018 09:52:34 +0300
Message-ID: <1528699954-2353-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is implements oversampling support for the SAMA5D2 ADC
device.
Enabling oversampling : OSR can improve resolution from 12 bits to
13 or 14 bits.
To not modify the scan element of the buffer , from 12 bits to 13 or 14,
I have added the extra bit(s) as MICRO values to the INT value from the
conversion.
Special care was required for the triggered buffer scenario (+ DMA).

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Hello Jonathan,

I marked this patch as RFC because I am not confident in the best way to handle
this oversampling support.

I modified the return value of the channels to use IIO_VALUE_INT_PLUS_MICRO
instead of IIO_VALUE_INT, so I can add an extra bit or two bits in there to the
INT value (0/500000 or 0/250000/500000/7500000) .
You know of a better way to add this support?
Looks like the iio channel spec cannot be modified at
runtime. Would be best if the real bits in the channel spec would be changed to
13 or 14, but then, the buffer would be confused, as the buffer spec is now
le:u12/16>>0 so how can I change that to reflect oversampling, or,
IIO_VALUE_INT_PLUS_MICRO ?
And I am not sure how to handle this w.r.t ABI and userspace changes.

At this moment I added the micro values just to the software trigger readings,
and triggered buffer + DMA does not provide the extra bits, but, I need
to shift all values with 2 bits to the right . The code is rather ugly
right now, but I can change it to look prettier if this is the proper way
to do it.

Thanks for all the feedback,
Eugen


 drivers/iio/adc/at91-sama5d2_adc.c | 198 ++++++++++++++++++++++++++++++++-----
 1 file changed, 172 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 58c4c2b..f1a89b7 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -130,6 +130,15 @@
 #define AT91_SAMA5D2_OVER	0x3c
 /* Extended Mode Register */
 #define AT91_SAMA5D2_EMR	0x40
+/* Extended Mode Register - Oversampling rate */
+#define AT91_SAMA5D2_EMR_OSR(V)			((V) << 16)
+#define AT91_SAMA5D2_EMR_OSR_MASK		GENMASK(17, 16)
+#define AT91_SAMA5D2_EMR_OSR_0SAMPLES		0
+#define AT91_SAMA5D2_EMR_OSR_4SAMPLES		1
+#define AT91_SAMA5D2_EMR_OSR_16SAMPLES		2
+
+/* Extended Mode Register - Averaging on single trigger event */
+#define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
 /* Compare Window Register */
 #define AT91_SAMA5D2_CWR	0x44
 /* Channel Gain Register */
@@ -248,6 +257,14 @@
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
+/* Possible values for oversampling ratio, and the string equivalent */
+#define AT91_OSR_0SAMPLES		0
+#define AT91_OSR_0SAMPLES_STR		"0"
+#define AT91_OSR_4SAMPLES		4
+#define AT91_OSR_4SAMPLES_STR		"4"
+#define AT91_OSR_16SAMPLES		16
+#define AT91_OSR_16SAMPLES_STR		"16"
+
 #define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
 	{								\
 		.type = IIO_VOLTAGE,					\
@@ -261,7 +278,8 @@
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = "CH"#num,				\
 		.indexed = 1,						\
 	}
@@ -281,7 +299,8 @@
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = "CH"#num"-CH"#num2,			\
 		.indexed = 1,						\
 	}
@@ -299,7 +318,8 @@
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = name,					\
 	}
 #define AT91_SAMA5D2_CHAN_PRESSURE(num, name)				\
@@ -313,7 +333,8 @@
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = name,					\
 	}
 
@@ -384,6 +405,7 @@ struct at91_adc_state {
 	const struct iio_chan_spec	*chan;
 	bool				conversion_done;
 	u32				conversion_value;
+	unsigned int			oversampling_ratio;
 	struct at91_adc_soc_info	soc_info;
 	wait_queue_head_t		wq_data_available;
 	struct at91_adc_dma		dma_st;
@@ -475,6 +497,76 @@ static inline int at91_adc_of_xlate(struct iio_dev *indio_dev,
 	return at91_adc_chan_xlate(indio_dev, iiospec->args[0]);
 }
 
+static void at91_adc_config_emr(struct at91_adc_state *st)
+{
+	/* configure the extended mode register */
+	unsigned int emr = at91_adc_readl(st, AT91_SAMA5D2_EMR);
+
+	/* select oversampling per single trigger event */
+	emr |= AT91_SAMA5D2_EMR_ASTE(1);
+
+	/* delete leftover content if it's the case */
+	emr &= ~AT91_SAMA5D2_EMR_OSR_MASK;
+
+	/* select oversampling ratio from configuration */
+	switch (st->oversampling_ratio) {
+	case AT91_OSR_0SAMPLES:
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_0SAMPLES) &
+		       AT91_SAMA5D2_EMR_OSR_MASK;
+		break;
+	case AT91_OSR_4SAMPLES:
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES) &
+		       AT91_SAMA5D2_EMR_OSR_MASK;
+		break;
+	case AT91_OSR_16SAMPLES:
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES) &
+		       AT91_SAMA5D2_EMR_OSR_MASK;
+		break;
+	};
+
+	at91_adc_writel(st, AT91_SAMA5D2_EMR, emr);
+}
+
+static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val,
+				    int *val2)
+{
+	u8 extra_bits;
+
+	switch (st->oversampling_ratio) {
+	case AT91_OSR_4SAMPLES:
+		/* in this case we need to report 1 extra bit */
+		extra_bits = *val & 0x1;
+		if (extra_bits)
+			*val2 = 500000;
+		else
+			*val2 = 0;
+		*val >>= 1; /* keep just 12 bits */
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AT91_OSR_16SAMPLES:
+		/* in this case we need to report 2 extra bits */
+		extra_bits = *val & 0x3;
+		switch (extra_bits) {
+		case 0:
+			*val2 = 0;
+			break;
+		case 1:
+			*val2 = 250000;
+			break;
+		case 2:
+			*val2 = 500000;
+			break;
+		case 3:
+			*val2 = 750000;
+			break;
+		};
+		*val >>= 2; /* keep just 12 bits */
+		return IIO_VAL_INT_PLUS_MICRO;
+	};
+
+	return IIO_VAL_INT;
+}
+
 static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
 {
 	u32 clk_khz = st->current_sample_rate / 1000;
@@ -916,6 +1008,9 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	int i = 0;
+	/* micro value for oversampling data */
+	int micro;
+	int val;
 	u8 bit;
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
@@ -936,7 +1031,9 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 		 * Thus, emit a warning.
 		 */
 		if (chan->type == IIO_VOLTAGE) {
-			st->buffer[i] = at91_adc_readl(st, chan->address);
+			val = at91_adc_readl(st, chan->address);
+			at91_adc_adjust_val_osr(st, &val, &micro);
+			st->buffer[i] = val;
 		} else {
 			st->buffer[i] = 0;
 			WARN(true, "This trigger cannot handle this type of channel");
@@ -954,6 +1051,9 @@ static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
 	s64 ns = iio_get_time_ns(indio_dev);
 	s64 interval;
 	int sample_index = 0, sample_count, sample_size;
+	/* micro value for oversampling data */
+	int micro;
+	int val, j;
 
 	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
 	/* if we reached this point, we cannot sample faster */
@@ -972,6 +1072,17 @@ static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
 	interval = div_s64((ns - st->dma_st.dma_ts), sample_count);
 
 	while (transferred_len >= sample_size) {
+		/*
+		 * for all the values in the current sample,
+		 * adjust the values inside the buffer for oversampling
+		 */
+		for (j = 0; j < sample_size / 2; j++) {
+			/* buffer is byte-based. we need the whole value */
+			val = *((u16 *)&st->dma_st.rx_buf[st->dma_st.buf_idx + j * 2]);
+			at91_adc_adjust_val_osr(st, &val, &micro);
+			*((u16 *)&st->dma_st.rx_buf[st->dma_st.buf_idx + j * 2]) = val;
+		}
+
 		iio_push_to_buffers_with_timestamp(indio_dev,
 				(st->dma_st.rx_buf + st->dma_st.buf_idx),
 				(st->dma_st.dma_ts + interval * sample_index));
@@ -1190,8 +1301,10 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+
 static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
-				  struct iio_chan_spec const *chan, int *val)
+				  struct iio_chan_spec const *chan, int *val,
+				  int *val2)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	u32 cor = 0;
@@ -1212,7 +1325,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
-		return ret;
+		return at91_adc_adjust_val_osr(st, val, val2);
 	}
 	if (chan->type == IIO_PRESSURE) {
 		ret = iio_device_claim_direct_mode(indio_dev);
@@ -1225,7 +1338,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
-		return ret;
+		return at91_adc_adjust_val_osr(st, val, val2);
 	}
 
 	/* in this case we have a voltage channel */
@@ -1254,9 +1367,9 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 
 	if (ret > 0) {
 		*val = st->conversion_value;
+		ret = at91_adc_adjust_val_osr(st, val, val2);
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val, 11);
-		ret = IIO_VAL_INT;
 		st->conversion_done = false;
 	}
 
@@ -1280,7 +1393,7 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return at91_adc_read_info_raw(indio_dev, chan, val);
+		return at91_adc_read_info_raw(indio_dev, chan, val, val2);
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uv / 1000;
 		if (chan->differential)
@@ -1292,6 +1405,10 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 		*val = at91_adc_get_sample_freq(st);
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling_ratio;
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -1303,16 +1420,28 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
-	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
-		return -EINVAL;
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if ((val != AT91_OSR_0SAMPLES) && (val != AT91_OSR_4SAMPLES) &&
+		    (val != AT91_OSR_16SAMPLES))
+			return -EINVAL;
+		/* if no change, optimize out */
+		if (val == st->oversampling_ratio)
+			return 0;
+		st->oversampling_ratio = val;
+		/* update ratio */
+		at91_adc_config_emr(st);
+		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < st->soc_info.min_sample_rate ||
+		    val > st->soc_info.max_sample_rate)
+			return -EINVAL;
 
-	if (val < st->soc_info.min_sample_rate ||
-	    val > st->soc_info.max_sample_rate)
+		at91_adc_setup_samp_freq(st, val);
+		return 0;
+	default:
 		return -EINVAL;
-
-	at91_adc_setup_samp_freq(st, val);
-
-	return 0;
+	};
 }
 
 static void at91_adc_dma_init(struct platform_device *pdev)
@@ -1446,14 +1575,6 @@ static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static const struct iio_info at91_adc_info = {
-	.read_raw = &at91_adc_read_raw,
-	.write_raw = &at91_adc_write_raw,
-	.update_scan_mode = &at91_adc_update_scan_mode,
-	.of_xlate = &at91_adc_of_xlate,
-	.hwfifo_set_watermark = &at91_adc_set_watermark,
-};
-
 static void at91_adc_hw_init(struct at91_adc_state *st)
 {
 	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
@@ -1466,6 +1587,9 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
 			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
 
 	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
+
+	/* configure extended mode register */
+	at91_adc_config_emr(st);
 }
 
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
@@ -1496,6 +1620,19 @@ static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
 static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
 
+static IIO_CONST_ATTR(oversampling_ratio_available,
+		      AT91_OSR_0SAMPLES_STR " " AT91_OSR_4SAMPLES_STR " "
+		      AT91_OSR_16SAMPLES_STR);
+
+static struct attribute *at91_adc_attributes[] = {
+	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group at91_adc_attribute_group = {
+	.attrs = at91_adc_attributes,
+};
+
 static const struct attribute *at91_adc_fifo_attributes[] = {
 	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
 	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
@@ -1504,6 +1641,15 @@ static const struct attribute *at91_adc_fifo_attributes[] = {
 	NULL,
 };
 
+static const struct iio_info at91_adc_info = {
+	.attrs = &at91_adc_attribute_group,
+	.read_raw = &at91_adc_read_raw,
+	.write_raw = &at91_adc_write_raw,
+	.update_scan_mode = &at91_adc_update_scan_mode,
+	.of_xlate = &at91_adc_of_xlate,
+	.hwfifo_set_watermark = &at91_adc_set_watermark,
+};
+
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
-- 
2.7.4
