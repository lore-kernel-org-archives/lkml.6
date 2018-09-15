Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E2ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2475208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2475208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIOQJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 12:09:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57425 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbeIOQJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 12:09:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3AD2D9E7F8081;
        Sat, 15 Sep 2018 18:50:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Sat, 15 Sep 2018
 18:50:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iio: potentiometer: max5481: merge calls to of_match_device and of_device_get_match_data
Date:   Sat, 15 Sep 2018 18:50:33 +0800
Message-ID: <20180915105033.5928-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop call to of_match_device, which is subsumed by the subsequent
call to of_device_get_match_data.  The code becomes simpler, and a
temporary variable can be dropped.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/potentiometer/max5481.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index ffe2761..6d2f13f 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -137,7 +137,6 @@ static int max5481_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct max5481_data *data;
 	const struct spi_device_id *id = spi_get_device_id(spi);
-	const struct of_device_id *match;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
@@ -149,10 +148,8 @@ static int max5481_probe(struct spi_device *spi)
 
 	data->spi = spi;
 
-	match = of_match_device(of_match_ptr(max5481_match), &spi->dev);
-	if (match)
-		data->cfg = of_device_get_match_data(&spi->dev);
-	else
+	data->cfg = of_device_get_match_data(&spi->dev);
+	if (!data->cfg)
 		data->cfg = &max5481_cfg[id->driver_data];
 
 	indio_dev->name = id->name;
-- 
1.8.3.1


