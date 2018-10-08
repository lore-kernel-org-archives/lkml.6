Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E8B21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E8B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJIEWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:22:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39880 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:22:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g9cm0-0006si-QU; Mon, 08 Oct 2018 21:09:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ina2xx: fix missing break statement
Date:   Mon,  8 Oct 2018 22:09:04 +0100
Message-Id: <20181008210904.9362-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The IIO_CHAN_INFO_SCALE case is missing a break statement and in
the unlikely event that chan->address is not matched in the nested
switch statement then the code falls through to the following
IIO_CHAN_INFO_HARDWAREGAIN case.  Fix this by adding the missing
break.   While we are fixing this, it's probably a good idea to
add in a break statement to the IIO_CHAN_INFO_HARDWAREGAIN case
too (this is a moot point).

Detected by CoverityScan, CID#1462408 ("Missing break in switch")

Fixes: ca6a2d86acae ("iio: adc: ina2xx: Allow setting Shunt Voltage PGA gain and Bus Voltage range")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/ina2xx-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index d1239624187d..9bc5986780b9 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 			*val2 = chip->shunt_resistor_uohm;
 			return IIO_VAL_FRACTIONAL;
 		}
+		break;
 
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		switch (chan->address) {
@@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 			*val = chip->range_vbus == 32 ? 1 : 2;
 			return IIO_VAL_INT;
 		}
+		break;
 	}
 
 	return -EINVAL;
-- 
2.17.1

