Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B2C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F79218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JG0t3YBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfAYSUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:20:35 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:37488 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfAYSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:20:35 -0500
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7AAA730C0A5;
        Fri, 25 Jan 2019 10:20:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7AAA730C0A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1548440429;
        bh=OnBTKt6woy+u6w5wYAW86X+xtJCsSnClrQJsvmKgaP8=;
        h=From:To:Cc:Subject:Date:From;
        b=JG0t3YBYG3o9k1hxzlEnmvlHZ9cIty5MU9hayH0MPDMF+RUg+YINy7TI8NLZGdO6s
         mwCTMN6G0sFA7HlB56zq0ZJIT+iebipS/BVAfmt8sud1PSCpE2/Iqzegsd0936fieV
         Gm4WthlueHWrwrKKrgo0exJhkVHTkgPYZwhQr7nQ=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 6D943AC0730;
        Fri, 25 Jan 2019 10:20:29 -0800 (PST)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id 5188A2800EA; Fri, 25 Jan 2019 10:20:29 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v2] iio: adc: ti-ads7950: inconsistency with spi msg
Date:   Fri, 25 Jan 2019 10:20:22 -0800
Message-Id: <1548440422-27943-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

To read a channel we require 3 cycles to send, process, and receive
the data. The transfer buffer for the third transaction is left blank.
This leaves it up to the SPI driver to decide what to do.

In one particular case, if the tx buffer is not set the spi driver
sets it to 0xff. This puts the ADC in a alarm programming state,
therefore the following read to a channel becomes erroneous.

Instead of leaving us to the mercy of the SPI driver, we send the
ADC cmd on the third transaction to prevent inconsistent behavior.

Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0ad6359..1255d8b 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -422,6 +422,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	st->scan_single_xfer[1].tx_buf = &st->single_tx;
 	st->scan_single_xfer[1].len = 2;
 	st->scan_single_xfer[1].cs_change = 1;
+	st->scan_single_xfer[2].tx_buf = &st->single_tx;
 	st->scan_single_xfer[2].rx_buf = &st->single_rx;
 	st->scan_single_xfer[2].len = 2;
 
-- 
2.7.4

