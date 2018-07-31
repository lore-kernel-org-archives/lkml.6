Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5A2208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5A2208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbeGaP2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:28:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38693 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732233AbeGaP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:28:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 38A84207CF; Tue, 31 Jul 2018 15:47:52 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0684F20765;
        Tue, 31 Jul 2018 15:47:42 +0200 (CEST)
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
Subject: [PATCH v2 1/6] i2c: designware: use generic table matching
Date:   Tue, 31 Jul 2018 15:47:35 +0200
Message-Id: <20180731134740.441-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731134740.441-1-alexandre.belloni@bootlin.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to device_get_match_data in probe to match the device specific data
instead of using the acpi specific function.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ddf13527aaee..00bf62f77c47 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -119,10 +119,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 		break;
 	}
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (id && id->driver_data)
-		dev->flags |= (u32)id->driver_data;
-
 	if (acpi_bus_get_device(handle, &adev))
 		return -ENODEV;
 
@@ -269,6 +265,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	else
 		i2c_parse_fw_timings(&pdev->dev, t, false);
 
+	dev->flags |= (u32)device_get_match_data(&pdev->dev);
+
 	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
 	/*
 	 * Some DSTDs use a non standard speed, round down to the lowest
-- 
2.18.0

