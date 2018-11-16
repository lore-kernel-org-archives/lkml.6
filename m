Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BBBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A9B2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G040RYyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A9B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbeKPXxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:53:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbeKPXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:53:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAGDejSi081009;
        Fri, 16 Nov 2018 07:40:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542375645;
        bh=rg6Z0TpWZUMfBcMoS+09EvWW0ab22fpU6x45TqAfBXA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=G040RYyBS8BVFvSjNVniMgLKdrSIqdiEdv7v2A6Ef6s2fgGJkeYuXGxakYfV8+UUQ
         AJfF7kMqQGzG18JZlF0lCY8n0XmNUtve9ff8yNwTx1Jb4NRAYTUjkQhelozKQFIbMp
         Od0PBaQYZs3++/QPNkZq2irJGlnQWtHqVK9yuo5U=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAGDejA5126434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 07:40:45 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 16
 Nov 2018 07:40:43 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 16 Nov 2018 07:40:43 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAGDeQwu005228;
        Fri, 16 Nov 2018 07:40:39 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ASoC: davinci-mcasp: Implement configurable dismod handling
Date:   Fri, 16 Nov 2018 15:41:41 +0200
Message-ID: <20181116134141.17396-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116134141.17396-1-peter.ujfalusi@ti.com>
References: <20181116134141.17396-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dismod is specified in the DT node, use the specified custom value
to configure the drive on state of the inactive TX slots.

If the dismod is not present or booted in legacy mode, the dismod is set
to low as it was the original behavior.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/davinci_asp.h |  1 +
 sound/soc/davinci/davinci-mcasp.c         | 19 ++++++++++++++++++-
 sound/soc/davinci/davinci-mcasp.h         |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 85ad68f9206a..7fe80f1c7e08 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -79,6 +79,7 @@ struct davinci_mcasp_pdata {
 	/* McASP specific fields */
 	int tdm_slots;
 	u8 op_mode;
+	u8 dismod;
 	u8 num_serializer;
 	u8 *serial_dir;
 	u8 version;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0f3911be1c8e..40d3a916fb74 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -85,6 +85,7 @@ struct davinci_mcasp {
 	u32	tdm_mask[2];
 	int	slot_width;
 	u8	op_mode;
+	u8	dismod;
 	u8	num_serializer;
 	u8	*serial_dir;
 	u8	version;
@@ -834,7 +835,7 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		if (mcasp->serial_dir[i] == TX_MODE &&
 					tx_ser < max_active_serializers) {
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-				       DISMOD_LOW, DISMOD_MASK);
+				       mcasp->dismod, DISMOD_MASK);
 			set_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			tx_ser++;
 		} else if (mcasp->serial_dir[i] == RX_MODE &&
@@ -847,6 +848,8 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		} else if (mcasp->serial_dir[i] == TX_MODE) {
 			/* Unused TX pins, clear PDIR  */
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+				       mcasp->dismod, DISMOD_MASK);
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		}
 	}
@@ -1709,6 +1712,7 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 
 	if (pdev->dev.platform_data) {
 		pdata = pdev->dev.platform_data;
+		pdata->dismod = DISMOD_LOW;
 		return pdata;
 	} else if (match) {
 		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
@@ -1798,6 +1802,18 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 	if (ret >= 0)
 		pdata->sram_size_capture = val;
 
+	ret = of_property_read_u32(np, "dismod", &val);
+	if (ret >= 0) {
+		if (val == 0 || val == 2 || val == 3) {
+			pdata->dismod = DISMOD_VAL(val);
+		} else {
+			dev_warn(&pdev->dev, "Invalid dismod value: %u\n", val);
+			pdata->dismod = DISMOD_LOW;
+		}
+	} else {
+		pdata->dismod = DISMOD_LOW;
+	}
+
 	return  pdata;
 
 nodata:
@@ -1973,6 +1989,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	mcasp->version = pdata->version;
 	mcasp->txnumevt = pdata->txnumevt;
 	mcasp->rxnumevt = pdata->rxnumevt;
+	mcasp->dismod = pdata->dismod;
 
 	mcasp->dev = &pdev->dev;
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index acb024ab6a9d..5e4060d8fe56 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -209,6 +209,7 @@
 #define DISMOD_3STATE	(0x0)
 #define DISMOD_LOW	(0x2 << 2)
 #define DISMOD_HIGH	(0x3 << 2)
+#define DISMOD_VAL(x)	((x) << 2)
 #define DISMOD_MASK	DISMOD_HIGH
 #define TXSTATE		BIT(4)
 #define RXSTATE		BIT(5)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

