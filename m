Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3D8ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A28B2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A28B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeIXN6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:58:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:38679 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeIXN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:58:21 -0400
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="18307561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Sep 2018 00:57:33 -0700
Received: from eh-station.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Mon, 24 Sep 2018 00:57:31 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 2/2] iio: adc: at91: fix wrong channel number in triggered buffer mode
Date:   Mon, 24 Sep 2018 10:51:44 +0300
Message-ID: <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When channels are registered, the hardware channel number is not the
actual iio channel number.
This is because the driver is probed with a certain number of accessible
channels. Some pins are routed and some not, depending on the description of
the board in the DT.
Because of that, channels 0,1,2,3 can correspond to hardware channels
2,3,4,5 for example.
In the buffered triggered case, we need to do the translation accordingly.
Fixed the channel number to stop reading the wrong channel.

Fixes 0e589d5fb "ARM: AT91: IIO: Add AT91 ADC driver."
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
- Added 'const' spec to the declaration to avoid build warning

 drivers/iio/adc/at91_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index e3be88e..75d2f73 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -248,12 +248,14 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *idev = pf->indio_dev;
 	struct at91_adc_state *st = iio_priv(idev);
+	struct iio_chan_spec const *chan;
 	int i, j = 0;
 
 	for (i = 0; i < idev->masklength; i++) {
 		if (!test_bit(i, idev->active_scan_mask))
 			continue;
-		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, i));
+		chan = idev->channels + i;
+		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
 		j++;
 	}
 
-- 
2.7.4

