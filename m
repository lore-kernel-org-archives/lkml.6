Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A432327D9F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A432327D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964922AbeF2LPi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:15:38 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:51594 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935467AbeF2LPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:15:33 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id DEA9141BDB; Fri, 29 Jun 2018 13:05:34 +0200 (CEST)
Message-Id: <cd02d632857c0c1e351c86cfe58af023d75c6e86.1530268235.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Fri, 29 Jun 2018 10:19:58 +0200
Subject: [PATCH 2/3] IIO: st_sensors_i2c.c: Don't print error on failed ACPI
 match
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a ACPI node for a i2c device but HID/CID doesn't match, there
could still be a ACPI_DT_NAMESPACE_HID / PRP0001 HID entry which is
matched against the i2c device ID table, so don't print an error
message.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index b81e48e9f27e..0c1a77f9b08c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -87,10 +87,9 @@ int st_sensors_match_acpi_device(struct device *dev)
 
 	if (ACPI_HANDLE(dev)) {
 		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id) {
-			dev_err(dev, "No driver data\n");
+		if (!acpi_id)
 			return -EINVAL;
-		}
+
 		driver_data = acpi_id->driver_data;
 	}
 	return driver_data;
-- 
2.17.1

