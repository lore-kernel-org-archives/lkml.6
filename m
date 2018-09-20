Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E97AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8C82152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8C82152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbeITS2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:28:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12618 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbeITS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:28:19 -0400
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="21047112"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2018 05:44:59 -0700
Received: from eh-station.microchip.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 20 Sep 2018 05:44:58 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/2] iio: adc: at91: fix acking DRDY irq on simple conversions
Date:   Thu, 20 Sep 2018 15:40:37 +0300
Message-ID: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing simple conversions, the driver did not acknowledge the DRDY irq.
If this irq is not acked, it will be left pending, and as soon as a trigger
is enabled, the irq handler will be called, it doesn't know why this irq
has occurred because no channel is pending, and then we will have irq loop
and board will hang.

Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 44b5168..e85f859 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -712,6 +712,11 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 		at91_adc_writel(st, AT91_ADC_CHDR,
 				AT91_ADC_CH(chan->channel));
 		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
+		/*
+		 * we need to ack the DRDY irq, otherwise it will be
+		 * left pending and irq handler will be confused
+		 */
+		at91_adc_readl(st, AT91_ADC_LCDR);
 
 		st->last_value = 0;
 		st->done = false;
-- 
2.7.4

