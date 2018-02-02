Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224IxKQR24odrpSveExTKMHOMJihKKoGNdNGEwv2TqsIR77fMXhQzRxEpuNfMW2xa4eT88q1
ARC-Seal: i=1; a=rsa-sha256; t=1517591829; cv=none;
        d=google.com; s=arc-20160816;
        b=ZH3hRGDCY6yrMW0+/N4B2F2sXlTYwB2EQuSY2oAVV7RF+Sd4t2DnpRGRE7ZQvl5fRl
         DaMzPY63/SY7KmXpO/3u0+1QuW8kyTH9sQ7fXNqmBv0+4I6qyeIcm0keHSUBKd7VLaak
         wvcGkBfaKalhezvjQYGYfFi0EMSXMNBsmf3Y5GkE9a96x+elg9+dEIH7jzG5WJ97eb8O
         TfpGSxXWSYsdZ11yW3e6QCwMBEnac7gkfUM+8YC9QOO6MJlO7thNuvFSPC2OGnQxnny7
         9/kAwZF800wl0eTVlv7+Pufa5SgnVyYbS2Fym3UiPmSOd8C/27rM/zJqVeraBPBivDkN
         kYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JWDkK0fD9oKBwI1yJrB2vHbbEyvxRY3cbmJx6S+kJSI=;
        b=LPjtOzO0NMuvi20BjBO10MLld+vlMUo2o8QF+di1Jnz0MR/djrjjlyCqgAxJj4xi4l
         pS1FXl4a4E122xDrXGgWap9G6cJNvaTN5PrTcS/OgzdMwL2cJqkxTnu2zfjQeih0wDFg
         dudpmKJ3DvmBm+N3M/yB7rvQPO+N1Lh+nLihyys142tV8p9v54alTywlYkzuGSft4b3i
         CbrVQCmPaMkl5OlX8wB4ynikravP437RGEOI0jZHi7tbbdy3NYN6UuhMqUbwnvsw/Jwh
         WbS4PgJsUWuSL9fuzkaFAgc+8C1N02j8s7S21BiLiuYp5SQuAGDY/ym8+cx2D9nMxT8q
         ZNHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 50/55] iio: adc: stm32: fix scan of multiple channels with DMA
Date: Fri,  2 Feb 2018 17:59:08 +0100
Message-Id: <20180202140830.923503066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310186330716542?=
X-GMAIL-MSGID: =?utf-8?q?1591310370318283474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit 04e491ca9df60ffe8637d00d68e5ab8bc73b30d5 upstream.

By default, watermark is set to '1'. Watermark is used to fine tune
cyclic dma buffer period. In case watermark is left untouched (e.g. 1)
and several channels are being scanned, buffer period is wrongly set
(e.g. to 1 sample). As a consequence, data is never pushed to upper layer.
Fix buffer period size, by taking scan channels number into account.

Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/stm32-adc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1315,6 +1315,7 @@ static int stm32_adc_set_watermark(struc
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	unsigned int watermark = STM32_DMA_BUFFER_SIZE / 2;
+	unsigned int rx_buf_sz = STM32_DMA_BUFFER_SIZE;
 
 	/*
 	 * dma cyclic transfers are used, buffer is split into two periods.
@@ -1323,7 +1324,7 @@ static int stm32_adc_set_watermark(struc
 	 * - one buffer (period) driver can push with iio_trigger_poll().
 	 */
 	watermark = min(watermark, val * (unsigned)(sizeof(u16)));
-	adc->rx_buf_sz = watermark * 2;
+	adc->rx_buf_sz = min(rx_buf_sz, watermark * 2 * adc->num_conv);
 
 	return 0;
 }
