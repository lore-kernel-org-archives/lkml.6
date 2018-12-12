Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C913C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68B020839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffXGJmtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68B020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeLLR5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:57:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43605 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:57:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so8664935pgk.10;
        Wed, 12 Dec 2018 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DA8Mk5U48AtUQez3Hhs0oXRls5co3Oyr1gu2A2vPDgs=;
        b=ffXGJmtGvnqaxv3mWAg6/NR91TEUSuoA0a/pUJKDP3rQ3thRUK5+q+Et6y/kaAyIBW
         E+srMqam7uZ/QCEZhQ5TPw3WjSMIBlgD3wAsTRPS/Pl8+jpqFHIaj6Ss0cB4Rb3DCWTZ
         kbQjFqe5deOK3DR0OEf9yZhTyFxBowU8rlgGHFOOkDwMlJC1GSaLZJrRhhgcYgfQhdFz
         n1SVHoEzED/YwLgNkabQnitmXs0MrGyo/QYqGiT5gElsvKZbKzAsouqPX3ShrL/jYVN3
         N2GYihrwrCOz1zVfHP8kkO8IGTIzD24aacmHyFdD+Pm4mVFGKzOZSOEyREQvcyxq779W
         7bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DA8Mk5U48AtUQez3Hhs0oXRls5co3Oyr1gu2A2vPDgs=;
        b=GwW3ie+IFmpYHvKxpcK25bS5B98+p0WBmqQHDrptjiaLUzojCgAb9lID/n0MPYyFEK
         ePigOyGRR01CCbYJ4Wle16OOH0/j6/7qvrHWwQZZZVoEMeyeXQAxmQT0wqMFiBFnsuIM
         h2McMwK6i6hrjrP/kWdc0n2eep0HguYHG966G4HqsN7hDCGQ50r+02cD2Lx1D4p0WJIE
         iML54KGbeJ2NtkYcphqB2+iSL1EXZdnVFuwdxa0BE0hkiaEsasTWmFsh35u7Bgrdr3m5
         RK5ZODlDL2ZVBpED/aFqOnAOMv/ajSk4PNmm7WZTCP9XBjaX6a8DIN2vT0IoJPwrPqi7
         wjug==
X-Gm-Message-State: AA+aEWaXV+f9PmLZQS/zNHYR39UAQX00NxADdXJx0qMGekOmfC5FiOn4
        sbv1SjwGYaQygjijMwVZAU8=
X-Google-Smtp-Source: AFSGD/XJn0Nw93/PqLyrXJ+J6+zPKMm53rhsfKn9AXuJFGBKtCvzYTyqY6qP8pQ8PLjJ/bUr984LvA==
X-Received: by 2002:a63:40c6:: with SMTP id n189mr18671707pga.355.1544637472955;
        Wed, 12 Dec 2018 09:57:52 -0800 (PST)
Received: from localhost.localdomain ([27.59.69.235])
        by smtp.googlemail.com with ESMTPSA id w136sm26430922pfd.169.2018.12.12.09.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 09:57:52 -0800 (PST)
From:   Hardik Singh Rathore <hardiksingh.k@gmail.com>
To:     jic23@kernel.org
Cc:     Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad7816: drop unnecessary initialization of variables
Date:   Wed, 12 Dec 2018 23:27:07 +0530
Message-Id: <20181212175707.12513-1-hardiksingh.k@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization is unnecessary when the variable is written before it is
read. There were some occasions in which the driver would initialize `ret'
during declaration without need.

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 5209651a1b25..ee50e7296795 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -65,7 +65,7 @@ enum ad7816_type {
 static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
-	int ret = 0;
+	int ret;
 	__be16 buf;
 
 	gpiod_set_value(chip->rdwr_pin, 1);
@@ -106,7 +106,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
-	int ret = 0;
+	int ret;
 
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
@@ -354,8 +354,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 {
 	struct ad7816_chip_info *chip;
 	struct iio_dev *indio_dev;
-	int ret = 0;
-	int i;
+	int i, ret;
 
 	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
 	if (!indio_dev)
-- 
2.17.1

