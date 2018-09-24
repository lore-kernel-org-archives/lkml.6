Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F23C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7BB2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7BB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeIXN6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:58:18 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:38679 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeIXN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:58:17 -0400
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="18307557"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Sep 2018 00:57:28 -0700
Received: from eh-station.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Mon, 24 Sep 2018 00:57:26 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 1/2] iio: adc: at91: fix acking DRDY irq on simple conversions
Date:   Mon, 24 Sep 2018 10:51:43 +0300
Message-ID: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing simple conversions, the driver did not acknowledge the DRDY irq.
If this irq status is not acked, it will be left pending, and as soon as a
trigger is enabled, the irq handler will be called, it doesn't know why
this status has occurred because no channel is pending, and then it will go
int a irq loop and board will hang.
To avoid this situation, read the LCDR after a raw conversion is done.

Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Hello Jonathan,

I moved this LCDR read/acknowledge into the IRQ handler after the conversion
value is being read.
Sorry about the noise to stable@vger, removed from message.

Thanks,
Eugen

 drivers/iio/adc/at91_adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 44b5168..e3be88e 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -279,6 +279,8 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
 		iio_trigger_poll(idev->trig);
 	} else {
 		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_ADC_LCDR);
 		st->done = true;
 		wake_up_interruptible(&st->wq_data_avail);
 	}
-- 
2.7.4

