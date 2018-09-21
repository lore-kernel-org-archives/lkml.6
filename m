Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A3ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07E32086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7/wmq7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07E32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbeIUT3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56010 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389870AbeIUT3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:31 -0400
Received: by mail-it1-f196.google.com with SMTP id d10-v6so2002163itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TyrJA8rFdaHKp9ncwV+/fPKK1X9mZxeny1nGtBgA+NA=;
        b=A7/wmq7Rjf/cp8IjDYLIsnASdZYSHpda3l2ZfxhWhr5otQAXBS/FTC51txu0vzdpZ3
         WPR3R/+DVSkqBvJjSeVQxZtvMyoaHDB9Yu1xnuwMOziiQae37pqHYKhJ0W32HKrjwmMh
         mIwtAAcFDjVn9Zxy7tU/T3fQnh3Um6SOrAyUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TyrJA8rFdaHKp9ncwV+/fPKK1X9mZxeny1nGtBgA+NA=;
        b=NhmxoRrgbFHGOK/yzphH6uRX3OG+hVeXAiHiLHXRTsEPz9uwtwHjW5Yk0yEA0KuFmU
         55OxUsrMYwlMAPlnWJsFA2w6ryC+qvVmEcmQae66zqyz4aAFqw+0WXFSzbY+V2MwmNTn
         /MEZcG9E+pAwm01qZ3QJVqdNxmkysSrv+yFzPq6nCcarswl3XPkoxLcQ7MMpQk6o4ff0
         F7/cnGBuIZCtnfugvurBCawKS5PqFc4g7JZiUKSimr3U59c0QjqcEgguvQPrCCkIWPjV
         BDm+BLHD0nQibMf5T9RGpd1pMWgdzYgbiEoW/S1DlXxuE4o6yW1jEnR6c4iKHrhc7SEF
         0TxQ==
X-Gm-Message-State: APzg51C6s6XkEjhFzQiCGIE4k+e0g99HANUGcdNNMhJk/EoOFTuPzAoE
        WUK7jNr8oVQTygJuVbKcpkTtVQ==
X-Google-Smtp-Source: ANB0VdbXSj0kLaSP4Mn/fivvLPx3doRFWqHcHN8/PMqskYS0wXheFFTiUkNE1TRTGWTjGu3G+E+OoQ==
X-Received: by 2002:a24:f60a:: with SMTP id u10-v6mr6038065ith.116.1537537236436;
        Fri, 21 Sep 2018 06:40:36 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:35 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/26] eeprom: eeprom_93xx46: use resource management
Date:   Fri, 21 Sep 2018 06:40:01 -0700
Message-Id: <20180921134026.4596-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use resource managed variants of nvmem_register() and kzalloc().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 38766968bfa2..c6dd9ad9bf7b 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -439,7 +439,7 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	edev = devm_kzalloc(&spi->dev, sizeof(*edev), GFP_KERNEL);
 	if (!edev)
 		return -ENOMEM;
 
@@ -449,8 +449,7 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 		edev->addrlen = 6;
 	else {
 		dev_err(&spi->dev, "unspecified address type\n");
-		err = -EINVAL;
-		goto fail;
+		return -EINVAL;
 	}
 
 	mutex_init(&edev->lock);
@@ -473,11 +472,9 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->nvmem_config.word_size = 1;
 	edev->nvmem_config.size = edev->size;
 
-	edev->nvmem = nvmem_register(&edev->nvmem_config);
-	if (IS_ERR(edev->nvmem)) {
-		err = PTR_ERR(edev->nvmem);
-		goto fail;
-	}
+	edev->nvmem = devm_nvmem_register(&spi->dev, &edev->nvmem_config);
+	if (IS_ERR(edev->nvmem))
+		return PTR_ERR(edev->nvmem);
 
 	dev_info(&spi->dev, "%d-bit eeprom %s\n",
 		(pd->flags & EE_ADDR8) ? 8 : 16,
@@ -490,21 +487,15 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, edev);
 	return 0;
-fail:
-	kfree(edev);
-	return err;
 }
 
 static int eeprom_93xx46_remove(struct spi_device *spi)
 {
 	struct eeprom_93xx46_dev *edev = spi_get_drvdata(spi);
 
-	nvmem_unregister(edev->nvmem);
-
 	if (!(edev->pdata->flags & EE_READONLY))
 		device_remove_file(&spi->dev, &dev_attr_erase);
 
-	kfree(edev);
 	return 0;
 }
 
-- 
2.19.0

