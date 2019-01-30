Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD01C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D592C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfA3N5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:57:15 -0500
Received: from mail1.abatec.at ([81.10.186.19]:34348 "EHLO mail1.abatec.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfA3N5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:57:15 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 08:57:14 EST
Received: from exchange02.regau.abatec.at (192.168.100.22) by
 exchange02.regau.abatec.at (192.168.100.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Wed, 30 Jan 2019 14:42:11 +0100
Received: from OTTINGER (192.168.115.56) by exchange02.regau.abatec.at
 (192.168.100.22) with Microsoft SMTP Server id 15.1.1415.2 via Frontend
 Transport; Wed, 30 Jan 2019 14:42:11 +0100
From:   <g.ottinger@abatec.at>
CC:     <g.ottinger@abatec.at>, <eugen.hristev@microchip.com>,
        <s.etzlstorfer@abatec.at>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout case
Date:   Wed, 30 Jan 2019 14:42:02 +0100
Message-ID: <20190130134202.5831-1-g.ottinger@abatec.at>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georg Ottinger <g.ottinger@abatec.at>

Having a brief look at at91_adc_read_raw() it is obvious that in the case
of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR registers is
omitted. If 2 different channels are queried we can end up with a
situation where two interrupts are enabled, but only one interrupt is
cleared in the interrupt handler. Resulting in a interrupt loop and a
system hang.

Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>
---
 drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 75d2f7358..596841a3c 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 		ret = wait_event_interruptible_timeout(st->wq_data_avail,
 						       st->done,
 						       msecs_to_jiffies(1000));
-		if (ret == 0)
-			ret = -ETIMEDOUT;
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
-		}
-
-		*val = st->last_value;
 
+		/* Disable interrupts, regardless if adc conversion was
+		 * successful or not
+		 */
 		at91_adc_writel(st, AT91_ADC_CHDR,
 				AT91_ADC_CH(chan->channel));
 		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
 
-		st->last_value = 0;
-		st->done = false;
+		if (ret > 0) {
+			/* a valid conversion took place */
+			*val = st->last_value;
+			st->last_value = 0;
+			st->done = false;
+			ret = IIO_VAL_INT;
+		} else if (ret == 0) {
+			/* conversion timeout */
+			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
+				chan->channel);
+			ret = -ETIMEDOUT;
+		}
+
 		mutex_unlock(&st->lock);
-		return IIO_VAL_INT;
+		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
-- 
2.17.1

