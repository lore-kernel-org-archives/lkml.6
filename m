Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2AEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A2920817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wwzTP/+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A2920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeKSRE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:04:56 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36478 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeKSRE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:04:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJ6fl1r103653;
        Mon, 19 Nov 2018 00:41:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542609707;
        bh=ERGGLB2d3lY+LPrMoqmtJWx7XrbSZlrUs0z4PkwgZC0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wwzTP/+xlbbQc5teLW9byqFJa6PEHUqhvNPYEXbJJpiC7i0ne85ZvIpVg9yRz4EBo
         iqNvBWdPWQGN3aFibCTtoCU4AwzxPX3XFhpt0LJT7SztSr63wsq5nWyW4o/LGkeeNQ
         WqTHJ8VbVk9PiJ/WDeewA5PZbzKNQfIZqDCwbdUo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJ6fl3j072251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 00:41:47 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 00:41:47 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 00:41:47 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJ6ff3U017078;
        Mon, 19 Nov 2018 00:41:44 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>,
        <linux-iio@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mfd: ti_am335x_tscadc: Provide unique name for child mfd cells
Date:   Mon, 19 Nov 2018 12:12:35 +0530
Message-ID: <20181119064236.28902-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119064236.28902-1-vigneshr@ti.com>
References: <20181119064236.28902-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide unique names for child mfd cells, this is required in order to
support registering of multiple instances of same ti_am335x_tscadc IP.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index c2d47d78705b..ee08af34f81d 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -248,7 +248,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (tsc_wires > 0) {
 		tscadc->tsc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "TI-am335x-tsc";
+		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
+					    dev_name(&pdev->dev), "tsc");
 		cell->of_compatible = "ti,am3359-tsc";
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
@@ -258,7 +259,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (adc_channels > 0) {
 		tscadc->adc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "TI-am335x-adc";
+		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
+					    dev_name(&pdev->dev), "adc");
 		cell->of_compatible = "ti,am3359-adc";
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
-- 
2.19.1

