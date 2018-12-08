Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C570C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2B420892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p90N9VIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2B420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLHPQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:16:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34451 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLHPQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:16:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so3193938plz.1;
        Sat, 08 Dec 2018 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=d8j4BSBHgLLb1y8N2o89FumZInjolCQZpSlOVYn0aqA=;
        b=p90N9VIkjLLjkQhybGkbn/i6FAxVvunVKv6mx72C/yaXowBXzljYIxm2uGjyHTMnfv
         ZKoCbttRtWFdy02ByRvZei6SpVsrPQdgZAqJNNgGuNOz8D0eN6mVJm7BhO5imDjOfNeO
         Jh8B5zBhgrP7usad15Byhqy8O/tBvaDm5YPoPYLOAfLb5xtrLnnhaMbU1KnDMnSBt+zm
         QAr+eB2bQ0tVSsha8XjUGxQMT67KQVTszP4XYqz42/ZpY/owr6tMHJFr4bcIhSqYYM8C
         DTd6G1J08I6eBJc7It0U7KZBc4hC2c6jnK36MWDlYKGRtETwYkD+26SDGwy4tKeWW1ES
         TyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=d8j4BSBHgLLb1y8N2o89FumZInjolCQZpSlOVYn0aqA=;
        b=pPUMGy67hGAchRkbMJoWtgalILAk9aBRe1HtfotO+U7fCU8HFmC2ZV6QphcmwKAQq5
         J+J6vOqyR3KF/PpFliq75W2pYEmVbiygoAj7gqITPqQulmWsCPdhXhw65/lcbvGuJUMO
         HhAWnZEqbtOD8yemQOjmNg5zNQvHIMm7xoPmJx6AIHdtTu/6EAHsaT0zZDc5GgXKc3X4
         KShvc+5gOlyrJibSAi9CiRyGmrunilxrtGSYCsntTWhZGbPoz+bktW0TEEuMyDzJtG8H
         j3EZhTG3Vdodc8MfxFqO8x4Wjml+J1w7NLfnGucE8pzJujIEQ4JdEowp9lwwbjug7XtM
         6Wog==
X-Gm-Message-State: AA+aEWZDty+UHO/fYmhqWm+rns0dq0GZm+JCAqVnDLSno0Cp6Cs1K4Xy
        B1m4Cpc/95Vtvmojd5thZHs=
X-Google-Smtp-Source: AFSGD/WxH3AxJDGI9dZ2Hty8YeZjRwX/jvhXoL58ovcgh8NIm5dqrAwyxYirNqMozo12EKbTRLCzEg==
X-Received: by 2002:a17:902:a9c4:: with SMTP id b4mr6009503plr.298.1544282211290;
        Sat, 08 Dec 2018 07:16:51 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.153])
        by smtp.gmail.com with ESMTPSA id e23sm9774091pfh.68.2018.12.08.07.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 07:16:50 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v3 2/3] Staging: iio: adt7316: Move interrupt related code
Date:   Sat,  8 Dec 2018 20:46:37 +0530
Message-Id: <20181208151638.8759-3-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
References: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a function adt7316_irq_setup() where irq_type is being
set. It would be good to move devm_request_threaded_irq() function
and assignment of chip->config1 in adt7316_irq_setup() to unclutter
the code in probe function.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 86b2c3d53588..97dd48153293 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1807,11 +1807,12 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int adt7316_setup_irq(struct device *dev, int irq)
+static int adt7316_setup_irq(struct iio_dev *indio_dev)
 {
-	int irq_type;
+	struct adt7316_chip_info *chip = iio_priv(indio_dev);
+	int irq_type, ret;
 
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
@@ -1821,13 +1822,23 @@ static int adt7316_setup_irq(struct device *dev, int irq)
 	case IRQF_TRIGGER_FALLING:
 		break;
 	default:
-		dev_info(dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
+		dev_info(&indio_dev->dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
 			 irq_type);
 		irq_type = IRQF_TRIGGER_LOW;
 		break;
 	}
 
-	return irq_type;
+	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
+					NULL, adt7316_event_handler,
+					irq_type | IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	if (irq_type & IRQF_TRIGGER_HIGH)
+		chip->config1 |= ADT7316_INT_POLARITY;
+
+	return ret;
 }
 
 /*
@@ -2124,7 +2135,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
-	int irq_type;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2168,19 +2178,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (chip->bus.irq > 0) {
-		irq_type = adt7316_setup_irq(dev, chip->bus.irq);
-
-		ret = devm_request_threaded_irq(dev, chip->bus.irq,
-						NULL,
-						adt7316_event_handler,
-						irq_type | IRQF_ONESHOT,
-						indio_dev->name,
-						indio_dev);
+		ret = adt7316_setup_irq(indio_dev);
 		if (ret)
 			return ret;
-
-		if (irq_type & IRQF_TRIGGER_HIGH)
-			chip->config1 |= ADT7316_INT_POLARITY;
 	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);
-- 
2.17.1

