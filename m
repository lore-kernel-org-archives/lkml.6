Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4941EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111E320881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eJ8f25CZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111E320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeLCIBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:01:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42670 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLCIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:01:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB380lU0103284;
        Mon, 3 Dec 2018 02:00:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543824047;
        bh=ki3wadxapcwwi7aaamt7L3VIEtYjf1ugmOR0RksSZZA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eJ8f25CZGSRS5aHsS5LwVyocz/xcGvoTzMNkGjJmDd8258iQhjs9xNCBw/SKSzNmC
         1aufxDvoYFvsR8AsT/8MdU3ACH/miHatp/Yh+VDwUQHYV4REve2VuABkHZw90qJdyJ
         vUOQ8xO5c3DUUIKygbeWRXBf5KpdLLr3wls1H3vw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB380lN2119867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 02:00:47 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 02:00:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 02:00:46 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB380bfb024335;
        Mon, 3 Dec 2018 02:00:44 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: ti_am335x_tscadc: Improve accuracy of measurement
Date:   Mon, 3 Dec 2018 13:31:18 +0530
Message-ID: <20181203080118.17504-3-vigneshr@ti.com>
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

When performing single ended measurements with TSCADC, its recommended
to set negative input (SEL_INM_SWC_3_0) of ADC step to ADC's VREFN in the
corresponding STEP_CONFIGx register.
Also, the positive(SEL_RFP_SWC_2_0) and negative(SEL_RFM_SWC_1_0)
reference voltage for ADC step needs to be set to VREFP and VREFN
respectively in STEP_CONFIGx register.
Without these changes, there may be variation of as much as ~2% in the
ADC's digital output which is bad for precise measurement.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

v2: No change

 drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-
 include/linux/mfd/ti_am335x_tscadc.h | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index cafb1dcadc48..9d984f2a8ba7 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -142,7 +142,10 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 			stepconfig |= STEPCONFIG_MODE_SWCNT;
 
 		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
-				stepconfig | STEPCONFIG_INP(chan));
+				stepconfig | STEPCONFIG_INP(chan) |
+				STEPCONFIG_INM_ADCREFM |
+				STEPCONFIG_RFP_VREFP |
+				STEPCONFIG_RFM_VREFN);
 
 		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
 			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index b9a53e013bff..483168403ae5 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -78,6 +78,8 @@
 #define STEPCONFIG_YNN		BIT(8)
 #define STEPCONFIG_XNP		BIT(9)
 #define STEPCONFIG_YPN		BIT(10)
+#define STEPCONFIG_RFP(val)	((val) << 12)
+#define STEPCONFIG_RFP_VREFP	(0x3 << 12)
 #define STEPCONFIG_INM_MASK	(0xF << 15)
 #define STEPCONFIG_INM(val)	((val) << 15)
 #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
@@ -86,6 +88,8 @@
 #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
 #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
 #define STEPCONFIG_FIFO1	BIT(26)
+#define STEPCONFIG_RFM(val)	((val) << 23)
+#define STEPCONFIG_RFM_VREFN	(0x3 << 23)
 
 /* Delay register */
 #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
-- 
2.19.2

