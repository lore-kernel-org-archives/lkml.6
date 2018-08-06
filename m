Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11267C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6CA21A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6CA21A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbeHFVEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:04:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbeHFVEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:04:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 62CED207B7; Mon,  6 Aug 2018 20:54:14 +0200 (CEST)
Received: from localhost (LPuteaux-656-1-243-71.w82-127.abo.wanadoo.fr [82.127.120.71])
        by mail.bootlin.com (Postfix) with ESMTPSA id 217492072D;
        Mon,  6 Aug 2018 20:54:14 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 1/6] i2c: designware: use generic table matching
Date:   Mon,  6 Aug 2018 20:54:07 +0200
Message-Id: <20180806185412.7210-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to device_get_match_data in probe to match the device specific data
instead of using the acpi specific function.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v3:
 - removed unused variable
 - switched to uintptr_t for the cast

 drivers/i2c/busses/i2c-designware-platdrv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ddf13527aaee..d117c120730d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -86,7 +86,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	struct i2c_timings *t = &dev->timings;
 	u32 ss_ht = 0, fp_ht = 0, hs_ht = 0, fs_ht = 0;
 	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
-	const struct acpi_device_id *id;
 	struct acpi_device *adev;
 	const char *uid;
 
@@ -119,10 +118,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 		break;
 	}
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (id && id->driver_data)
-		dev->flags |= (u32)id->driver_data;
-
 	if (acpi_bus_get_device(handle, &adev))
 		return -ENODEV;
 
@@ -291,6 +286,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	else
 		t->bus_freq_hz = 400000;
 
+	dev->flags |= (uintptr_t)device_get_match_data(&pdev->dev);
+
 	if (has_acpi_companion(&pdev->dev))
 		dw_i2c_acpi_configure(pdev);
 
-- 
2.18.0

