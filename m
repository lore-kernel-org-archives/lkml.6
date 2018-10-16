Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D3CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72735208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72735208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJQAFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:05:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38589 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJQAFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:05:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gCRz9-0005PV-6p; Tue, 16 Oct 2018 16:14:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] iio: adc: ina2xx: add in early -EINVAL returns in case statements
Date:   Tue, 16 Oct 2018 17:14:18 +0100
Message-Id: <20181016161418.29213-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Static analysis with CoverityScan is throwing warnings that specific
case statements are missing breaks.  Rather than adding breaks, add
return -EINVAL to the specific case statements to clarify the
error return paths. Fix also saves 50 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  21418	   4936	    128	  26482	   6772	drivers/iio/adc/ina2xx-adc.o

After:
  dec	    hex	filename
  21370	   4936	    128	  26434	   6742	drivers/iio/adc/ina2xx-adc.o

(gcc 8.2, x86-64)

Detected by CoverityScan, CID#1462408 ("Missing break in switch")

---

V2: use returns instead of break statements to keep with the
current style used in the switch statement.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/ina2xx-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index d1239624187d..bdd7cba6f6b0 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 			*val2 = chip->shunt_resistor_uohm;
 			return IIO_VAL_FRACTIONAL;
 		}
+		return -EINVAL;
 
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		switch (chan->address) {
@@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 			*val = chip->range_vbus == 32 ? 1 : 2;
 			return IIO_VAL_INT;
 		}
+		return -EINVAL;
 	}
 
 	return -EINVAL;
-- 
2.19.1

