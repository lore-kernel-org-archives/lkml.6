Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F67C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57713208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57713208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbeHAPV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:21:27 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:59737 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389272AbeHAPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:21:26 -0400
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="15042267"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Aug 2018 06:35:37 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 1 Aug 2018 06:35:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] i2c: at91: Save the bus clock frequency in adapter
Date:   Wed, 1 Aug 2018 16:35:12 +0300
Message-ID: <20180801133512.12276-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180801133512.12276-1-tudor.ambarus@microchip.com>
References: <20180801133512.12276-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwise,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and provide the bus clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/i2c/busses/i2c-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3..9aa0937 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1124,6 +1124,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	dev->adapter.quirks = &at91_twi_quirks;
 	dev->adapter.dev.parent = dev->dev;
 	dev->adapter.nr = pdev->id;
+	dev->adapter.bus_freq_hz = bus_clk_rate;
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node = pdev->dev.of_node;
 
-- 
2.9.4

