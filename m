Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15840206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLMAbai+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeLQBoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:44:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44081 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeLQBoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:44:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so8210579lfe.11;
        Sun, 16 Dec 2018 17:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kTnhgtwpfxicbN6KFsH1HCILRT8Pag/tFGzMh/2QixI=;
        b=mLMAbai+aSDZkrs2M9kSb6pMuFWnFL4uthBVajwsqXqKaTrkfIUM9DUSLZgibwIXnx
         /tvl+YzymCD1m15MrgEd5zDfHtIRxBaEG41y6NqyIAgVWPU+QK8reqQceLZV1GrnIjE1
         cJ24vQp0NCE35DkxEU+X0kcPt1BjeCJxTpzqU29vYdMMFHpkwGpqBWsegN4PQiJEBUqW
         n8K6W9xrTmmorm6o0TcsPxkQv53jdOjghBX6pQ7H72LaZyO9vaOy9PtC4Gb+GkLJOv0m
         UWyfonOsExcqzJec6VYMdr5H4niB/a3vxeRIPpLIsmPdGJtZIDIwrbj3r5nCYzNmhq5e
         2HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kTnhgtwpfxicbN6KFsH1HCILRT8Pag/tFGzMh/2QixI=;
        b=O4upCJ58wR3lYaKhb0KlAGbozX2xGG0oV6HX+HxBO1JNyLtyddpyI3JfI9hEnuvsA1
         um6YraSCnXj/HkLSTpgztMo8y05lOtfINvkTaK8G+6L995jHNOrQ2MNGopB25T/Q3P87
         s+BNeP4cibzRlM00fAzcjLg5q8WjNc4980G/JXerQfh5m5he1jqhqOtRSoYd52ThelBo
         d/KGweHQnNJmNHHBtswrY4h/kWAdoTOckRTktbh/gY5mvBudZFS2K0Gxqids+IQAvvP7
         sEpXXG4/rMz8R/2fY8KaLF0tURht+ag7XOGD/CIn/ArTzUFZnCZzv7k+b1Mk+JIhvJuv
         sH8A==
X-Gm-Message-State: AA+aEWZ3oFFN+Uy1k05qg6zOyQVnpZ6x04IKYdNmOPjSV3L+NlfXF0br
        PIrb8ZdJHBck7AoR2DXmaWo=
X-Google-Smtp-Source: AFSGD/UXOAvwRpExn/EHNlj7Iid9gdwvCh2CdyqoF9csJnibAmXNxMrr8HtxWUwo9hpKPnHCeQsl7A==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr6516402lfe.63.1545011052110;
        Sun, 16 Dec 2018 17:44:12 -0800 (PST)
Received: from localhost.localdomain ([93.175.28.9])
        by smtp.gmail.com with ESMTPSA id m63-v6sm2599753lje.81.2018.12.16.17.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 17:44:11 -0800 (PST)
From:   Sergey Efimochkin <sergeyanton2007@gmail.com>
X-Google-Original-From: Sergey Efimochkin <efimochkin.sv@phystech.edu>
Cc:     Sergey Efimochkin <efimochkin.sv@phystech.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging:iio:adc: fix codestyle
Date:   Mon, 17 Dec 2018 04:43:33 +0300
Message-Id: <20181217014333.75969-1-efimochkin.sv@phystech.edu>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

staging:iio:adc: fix codestyle
Signed-off-by: Sergey Efimochkin <efimochkin.sv@phystech.edu>
---
 drivers/staging/iio/adc/ad7280a.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..52e12d1201b3 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -706,8 +706,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 				st->cell_threshhigh)
 				iio_push_event(indio_dev,
 					       IIO_EVENT_CODE(IIO_VOLTAGE,
-							1,
-							0,
+							      1,
+							      0,
 							IIO_EV_DIR_RISING,
 							IIO_EV_TYPE_THRESH,
 							0, 0, 0),
@@ -716,8 +716,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 				st->cell_threshlow)
 				iio_push_event(indio_dev,
 					       IIO_EVENT_CODE(IIO_VOLTAGE,
-							1,
-							0,
+							      1,
+							      0,
 							IIO_EV_DIR_FALLING,
 							IIO_EV_TYPE_THRESH,
 							0, 0, 0),
@@ -725,18 +725,16 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		} else {
 			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
-							0,
+					       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
+								    0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_RISING),
 					       iio_get_time_ns(indio_dev));
 			else if (((channels[i] >> 11) & 0xFFF) <=
 				st->aux_threshlow)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
-							0,
+					       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
+								    0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_FALLING),
 					       iio_get_time_ns(indio_dev));
@@ -987,6 +985,6 @@ static struct spi_driver ad7280_driver = {
 };
 module_spi_driver(ad7280_driver);
 
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD7280A");
 MODULE_LICENSE("GPL v2");
-- 
2.15.1 (Apple Git-101)

