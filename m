Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F772C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC3120684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6qSkPh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC3120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbeKUDax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:30:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33665 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:30:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so580913pfb.0;
        Tue, 20 Nov 2018 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=+/WUkaayRJ8LV3dIb3j9FE2qSHbPHPjvZWttEtLlGIc=;
        b=e6qSkPh76WCZuT5r4MdbxYMntXDli74QGRdhKJlOmJO34s7XfNqz9PyiMk2s0XMzTb
         85Bqxc8csqVuaYRdAO3nhVGWrFiym+uwzvn1L5jZcGZVHwclL/QFuErlw/KCtB/+311x
         zL7s97Y5TMO2mOWGFk/O00AhV34VXsGXYxU2k/bj7BqH0ZAY7aU2JIAIThdkNUfzi66d
         eKKyPLCF8RmCJPDeVwHPdOTQNg4sL5CXH37KBzMBHPi/Xf0yPqCiGU/KYNzdHx7wqy2H
         uMGyhlOaZToKHNkWuQeRQl6GIaF4GvmQWVyu/AocYMTEWAnYQSiqnOs6ofq9vHb9i1me
         igaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+/WUkaayRJ8LV3dIb3j9FE2qSHbPHPjvZWttEtLlGIc=;
        b=VQPMdILEa3ZCegY1+8nvjK7IRdrVHNKN9TVEvPAeD2SlLu5SjjV/VubRV6QeCs4HQJ
         3RioGyii/m13IqiyoGpUuBPHdJtDvStCs5x8WwualbsIGANj642Sci+N4qUCalyO/wIo
         IhIuHqB+KejfVkBKm72Egrp8t7kC03YKGZ4x4iSKu67MAqUf9yrIKE4D13S1RD9Qn7F1
         vHWy4old3VW8etjcKlu9/QAzQhZRT1sFXzyAj5j4FimiNhfpotQDakdw676IjDdpuyqb
         O81p5E9k4orOJWXZufBTvLlcGFGnL/WNy6CD3FYB8+YU20pnKXym+X6Xo5a1SiKQEs7N
         xr7g==
X-Gm-Message-State: AA+aEWbSoymtN2qlj55RBXRz9uwMqEUHNthCNXnFgtLw6hEWmyvm3zPq
        f2qP7EMBlEJzm0P4wMV9tPWdXHGA
X-Google-Smtp-Source: AFSGD/XAUqlAWhA1uF37fQ7ZObzJqs6si/12Xn7RsIJvL4yni4mERbI0LXmjsk0FQMMdkpe15B9mmQ==
X-Received: by 2002:a63:4342:: with SMTP id q63mr2618852pga.63.1542733244461;
        Tue, 20 Nov 2018 09:00:44 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.152])
        by smtp.gmail.com with ESMTPSA id 7sm31843166pfm.8.2018.11.20.09.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:00:43 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Staging: iio: adt7316: Use device tree data to assign irq_type
Date:   Tue, 20 Nov 2018 22:30:36 +0530
Message-Id: <20181120170036.7403-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7316 driver no more uses platform data and hence use device tree
data instead of platform data for assigning irq_type field.
Switch case figures out the type of irq and if it's the default case
then assign the default value to the irq_type i.e.
irq_type = IRQF_TRIGGER_LOW

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 9c72538baf9e..c647875a64f5 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2101,8 +2101,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
-	unsigned short *adt7316_platform_data = dev->platform_data;
-	int irq_type = IRQF_TRIGGER_LOW;
+	int irq_type;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2146,8 +2145,22 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (chip->bus.irq > 0) {
-		if (adt7316_platform_data[0])
-			irq_type = adt7316_platform_data[0];
+		irq_type =
+			irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
+
+		switch (irq_type) {
+		case IRQF_TRIGGER_HIGH:
+		case IRQF_TRIGGER_RISING:
+			break;
+		case IRQF_TRIGGER_LOW:
+		case IRQF_TRIGGER_FALLING:
+			break;
+		default:
+			dev_info(dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
+				 irq_type);
+			irq_type = IRQF_TRIGGER_LOW;
+			break;
+		}
 
 		ret = devm_request_threaded_irq(dev, chip->bus.irq,
 						NULL,
-- 
2.17.1

