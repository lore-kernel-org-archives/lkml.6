Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83475C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476D120881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tvj0wNSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476D120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeLCIBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:01:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42692 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeLCIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:01:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB380itZ103278;
        Mon, 3 Dec 2018 02:00:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543824044;
        bh=UAQGemgoN+kqy6WpL1SIf3iBiOQ/DROHcMOufSSlNx0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tvj0wNSd3srbQND2rMhPNeDL7TY39DnFYTMdwznL2OdcytdgGsukJ8Vqvorg0Qcz3
         fXl7VL5Y2058tp0J6g1Dd0UzwVOY9WIknpkWEorhWOuFIh1Ps3dVinpXb+9VIOItah
         ORhGb75QfMD2OvX+BxBB/zRFay/jdyELJEXzFk98=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB380ir6119840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 02:00:44 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 02:00:43 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 02:00:43 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB380bfa024335;
        Mon, 3 Dec 2018 02:00:41 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
Date:   Mon, 3 Dec 2018 13:31:17 +0530
Message-ID: <20181203080118.17504-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203080118.17504-1-vigneshr@ti.com>
References: <20181203080118.17504-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PLATFORM_DEVID_AUTO to number mfd cells while registering, so that
different instances are uniquely identified. This is required in order
to support registering of multiple instances of same ti_am335x_tscadc IP.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
v2: use PLATFORM_DEVID_AUTO as suggested by Lee Jones

 drivers/mfd/ti_am335x_tscadc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index c2d47d78705b..fd111296b959 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -264,8 +264,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		cell->pdata_size = sizeof(tscadc);
 	}
 
-	err = mfd_add_devices(&pdev->dev, pdev->id, tscadc->cells,
-			tscadc->used_cells, NULL, 0, NULL);
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+			      tscadc->cells, tscadc->used_cells, NULL,
+			      0, NULL);
 	if (err < 0)
 		goto err_disable_clk;
 
-- 
2.19.2

