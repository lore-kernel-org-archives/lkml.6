Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07565C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7715208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E23GK7Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7715208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeKUD2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:28:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42309 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeKUD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:28:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so1266338pfr.9;
        Tue, 20 Nov 2018 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=+6XVtq4oJHjTw6cvWsMsqPWuyqZ5zrnnSTv1YyHvuZo=;
        b=E23GK7WjxA+pnZjRt0Mu1Zw1AjfZ64PXf4DCFk74gRs0dk5LaJa0opg1MuK1RNvLya
         c10Xcqo6uKEtGwBrW9ipKUl2itneyJCu4kkaXTDrHZSlKctoU5AnqHOpiTbmdRVjJ4Dy
         jmyNBD6UotKEVtzjOVUmf00PNsykTZwF/GjCwwBYAln6QhbLRGHymexkpQ1EwGpPzwzE
         edzv9Yg7PXmiDJXWZOKAyUacIJ9r8Ga9zUFnAZivyPVJKhWXUWAYjD/WGMkEBDyVBn+x
         o61mhUjnMvMRZrKHvohlCKFZMN5TtAQmXuTVORhTe/i6QUMQRJplCG21qjBGLn2z4KoG
         lbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+6XVtq4oJHjTw6cvWsMsqPWuyqZ5zrnnSTv1YyHvuZo=;
        b=MPcQqEi/eHHrJPXrcjPKnI0B45S51psZvgzRec8H5Zi/Fk0QnPnPsAC/fNWVoJKKaI
         B/uFyPe1CLvWD6LG4P5zuLby4Y02e5xWqzaSHltVRk60Q7LQLjzUJKTdVhjELts9zLYR
         +7Cm5bAjiIFkFStyut33nf9Y8mgkx5toGXthSI4hTQJc85E2hv6lLz2T0g2v0Q1hDCqm
         s6P8VRb10vg903nWKycRdLIJjiJg3q/Bm3L4HGiFVbi/2EPtWkzEY3MPLcxRJgcpNUK6
         jDwTfrgfuSoeMNlf61QMbhR4xQPIz6cMDQrA4Mqbsoy1evfHhmuqUASeY9656jZLRXiS
         ljWQ==
X-Gm-Message-State: AA+aEWbpjwN7okJmLuj08xLMl+KkF7hEybnEDUxHTExomq5G8sO74nua
        n3VvftrvhwAuoBVuSoP9e2k=
X-Google-Smtp-Source: AFSGD/XXerMvLxHix+qRf8A8fOHK2uibp0UNAHyqv7CV5Qk3KT4DPmOklYb+9vgIxoR0FpLWo5BOvQ==
X-Received: by 2002:a63:6045:: with SMTP id u66mr2628089pgb.204.1542733123867;
        Tue, 20 Nov 2018 08:58:43 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.152])
        by smtp.gmail.com with ESMTPSA id h8sm19044899pfo.162.2018.11.20.08.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:58:43 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] Staging: iio: adt7316: Change the name from irq_flags to irq_type
Date:   Tue, 20 Nov 2018 22:28:36 +0530
Message-Id: <20181120165836.7335-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the drivers in IIO uses irq_type as the name for
storing the interrupt type and hence change the name from
irq_flags to irq_type for maintaining the consistency.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index dfae22619287..9c72538baf9e 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2102,7 +2102,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
 	unsigned short *adt7316_platform_data = dev->platform_data;
-	int irq_flags = IRQF_TRIGGER_LOW;
+	int irq_type = IRQF_TRIGGER_LOW;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2147,18 +2147,18 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 
 	if (chip->bus.irq > 0) {
 		if (adt7316_platform_data[0])
-			irq_flags = adt7316_platform_data[0];
+			irq_type = adt7316_platform_data[0];
 
 		ret = devm_request_threaded_irq(dev, chip->bus.irq,
 						NULL,
 						adt7316_event_handler,
-						irq_flags | IRQF_ONESHOT,
+						irq_type | IRQF_ONESHOT,
 						indio_dev->name,
 						indio_dev);
 		if (ret)
 			return ret;
 
-		if (irq_flags & IRQF_TRIGGER_HIGH)
+		if (irq_type & IRQF_TRIGGER_HIGH)
 			chip->config1 |= ADT7316_INT_POLARITY;
 	}
 
-- 
2.17.1

