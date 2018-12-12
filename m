Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D0C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E730720811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9ypycKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E730720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeLLA4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:56:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39742 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeLLAzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:48 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so13460431iob.6;
        Tue, 11 Dec 2018 16:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5E07akhdcWo/3PoSb43yQur9QVQnOkKDZoez6erp7I=;
        b=d9ypycKjkwzd6rqksdJh8AddulggNHT3Ns1qjmlEnNh8wwTtLc+J4H1BvdGsAnt5Dp
         1YI0J2ebEyMRqEiMVhqp1EU+V7LhEqA3CPPILSPl4vOhr18NOMNxX8u/bzjsSEfA+OEV
         zThWhGujFHVV28PQNekszZW9gmhkr5mtr2exH2fFMEJEzXUI57zXQaMkx+v1R8dMFqLc
         nxBgEqtRMkfHOSVLL+TwXnPEgXcQLta+lEX/5zaGqRzDUG8x1lNtEV785f1TQJ3P4/+b
         +RnB0qgdakTrqnepEyHEnMiEUzV/N2okeeReMygGDOpqp0dNEHJTX66KqkJ/I1/hdrlo
         ZXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5E07akhdcWo/3PoSb43yQur9QVQnOkKDZoez6erp7I=;
        b=Yoqbx1y+wdFpz7NrxDxBQKmZVnEDcIt8LRAp+VL8rMJJcL0MayJ8e62jSXYA4GkZVn
         2ZICRPaLoc5/WOQkfHgZ3g1AfBS0fuU911Pd8b4iYTmg0byd5QaID7O6psl/K50AF1iU
         uKnRvfHpl0EG5saN/byyup4yJpeVJAf1iknrgpBSL8a33t5Ski8jydorQRl5vzfLMOkD
         2L3yCuifbFWGXQYTDYG3d9if0IgxqfeUOWJxabZ6GMywrdMaFHTeAUn7MzZ4lDdqDOrd
         qFNcSNXi1UV3yUtn01LimRCK7fPalWygZibQHUQjqCSZReSJzy8EAiFfxXS77yDb3VEh
         3Ytw==
X-Gm-Message-State: AA+aEWZGMCmAGUB6w4BZOzV+4P1GPt4ZyyNozlFiE5ea4G6xtm2Qb9eY
        jNGJvHM3hHCnwoIRepf2pG8=
X-Google-Smtp-Source: AFSGD/W9lZHjxkQ4LfQfOa89lNKtI/Wf2Sjgfy7IBPZBbs6hTi8RZjmQkGfOLV6GttLxw7d2tZuhWg==
X-Received: by 2002:a5d:9405:: with SMTP id v5mr2635510ion.250.1544576146266;
        Tue, 11 Dec 2018 16:55:46 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:45 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH 03/11] staging: iio: adt7316: fix dac_bits assignment
Date:   Tue, 11 Dec 2018 17:54:55 -0700
Message-Id: <20181212005503.28054-4-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only assignment to dac_bits is in adt7316_store_da_high_resolution().
This function enables or disables 10 bit dac resolution for the adt7316/7
and adt7516/7 when they're set to output voltage proportional to
temperature. Remove these assignments since they're unnecessary for the
dac high resolution functionality.

Instead, assign a value to dac_bits in adt7316_probe() since the number
of dac bits might be needed as soon as the device is registered and
available to userspace.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index e5e1f9d6357f..a9990e7f2a4d 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -651,17 +651,10 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 	u8 config3;
 	int ret;
 
-	chip->dac_bits = 8;
-
-	if (buf[0] == '1') {
+	if (buf[0] == '1')
 		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
-		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
-			chip->dac_bits = 12;
-		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
-			chip->dac_bits = 10;
-	} else {
+	else
 		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
-	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -2123,6 +2116,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	else
 		return -ENODEV;
 
+	if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
+		chip->dac_bits = 12;
+	else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
+		chip->dac_bits = 10;
+	else
+		chip->dac_bits = 8;
+
 	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac", GPIOD_OUT_LOW);
 	if (IS_ERR(chip->ldac_pin)) {
 		ret = PTR_ERR(chip->ldac_pin);
-- 
2.19.1

