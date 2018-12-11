Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3682AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1DB20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1DB20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeLKTMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:12:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57712 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeLKTMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:12:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBJCEjk114460;
        Tue, 11 Dec 2018 13:12:14 -0600
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBJCEiZ101998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 13:12:14 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 13:12:14 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 13:12:14 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBJCEVl008735;
        Tue, 11 Dec 2018 13:12:14 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.100.89])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wBBJCEU05336;
        Tue, 11 Dec 2018 13:12:14 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 4/4] iio: ti-ads8688: Migrate to device managed IIO calls
Date:   Tue, 11 Dec 2018 13:12:07 -0600
Message-ID: <20181211191207.21900-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181211191207.21900-1-dmurphy@ti.com>
References: <20181211191207.21900-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate the driver to use the devm IIO calls as opposed to
the unmanaged calls.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - New patch

 drivers/iio/adc/ti-ads8688.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 3597bc0697ee..8f42103a1fd9 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -462,21 +462,21 @@ static int ads8688_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      ads8688_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
 		goto err_regulator_disable;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto err_buffer_cleanup;
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "iio device registration failed\n");
+		goto err_regulator_disable;
+	}
 
 	return 0;
 
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-
 err_regulator_disable:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
@@ -489,9 +489,6 @@ static int ads8688_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ads8688_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 
-- 
2.20.0.rc2.7.g965798d1f2

