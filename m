Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A0C282C5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E7B218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gx9mFuZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfAYCFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:05:36 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:36094 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbfAYCFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:05:35 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 21:05:35 EST
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id E1AAC30C012;
        Thu, 24 Jan 2019 17:57:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com E1AAC30C012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1548381431;
        bh=cZOP/nX3nnggIGwSwr68BY+QBEhuNcDNNNnqUyDj8rk=;
        h=From:To:Cc:Subject:Date:From;
        b=gx9mFuZ3mwaDlKdhz9+KpZ8SL8CA5iHUJdvyFcGDOazTGM/71Uvn9cB9V5uMO+o7+
         jIfOwhvgJKp6nMwn5GRVkKk/SUF++5ykFUF5mDtUaBu15LZOoZ3WhhyT4li5ARhZm7
         fRSsTTsTJe2WzxW2/yWYyUjzZNELMo4jyy5O9Kjg=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 3690DAC074C;
        Thu, 24 Jan 2019 17:57:12 -0800 (PST)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id 15E2A2800EA; Thu, 24 Jan 2019 17:57:12 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] iio: adc: ti-ads7950: inconsistency with spi msg
Date:   Thu, 24 Jan 2019 17:56:54 -0800
Message-Id: <1548381414-20561-1-git-send-email-justinpopo6@gmail.com>
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

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0ad6359..5453e10 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -422,6 +422,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	st->scan_single_xfer[1].tx_buf = &st->single_tx;
 	st->scan_single_xfer[1].len = 2;
 	st->scan_single_xfer[1].cs_change = 1;
+	st->scan_single_xfer[2].rx_buf = &st->single_tx;
 	st->scan_single_xfer[2].rx_buf = &st->single_rx;
 	st->scan_single_xfer[2].len = 2;
 
-- 
2.7.4

