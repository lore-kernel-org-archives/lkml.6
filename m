Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6956C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7672083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vlprVNEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7672083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeHaWOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:14:00 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58952 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:14:00 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VI59xO069995;
        Fri, 31 Aug 2018 13:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535738709;
        bh=XR/5xHMdo+WwuxOC3a1Coo6ISHSUvY+0FVyrxOcUnY4=;
        h=From:To:CC:Subject:Date;
        b=vlprVNEoZm88O/LOES4gg0JEUWxutzDWC+/Dr0AZbduk2N0J4vtKTxEoBwTiA+EHF
         Cen0orMr6Y4dtBHAmHjfbqdKAA6QXrIxjSrbVaamAXk3Inkv5QCu+6gu06GwacuS+z
         rfBoXi8oz7fXpNGZxhdS0qJlrDb41qZjQE43SDq0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VI59Hg029257;
        Fri, 31 Aug 2018 13:05:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 13:05:08 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 13:05:08 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VI58oZ031105;
        Fri, 31 Aug 2018 13:05:08 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VI57x02102;
        Fri, 31 Aug 2018 13:05:07 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
Date:   Fri, 31 Aug 2018 13:05:07 -0500
Message-ID: <20180831180507.28867-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaving microphone bias off is a valid setting and even used in the DT
binding document example. Add this setting here and document the same.
Although it may not make much sense to enable a microphone here without
any bias, it is a valid setting that can be chosen by DT and may be
needed for some boards.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 1 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h         | 1 +
 sound/soc/codecs/tlv320aic31xx.c                          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index 5b3c33bb99e5..411cc46a2c58 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -24,6 +24,7 @@ Optional properties:
 
 - reset-gpios - GPIO specification for the active low RESET input.
 - ai31xx-micbias-vg - MicBias Voltage setting
+        0 or MICBIAS_OFF - MICBIAS output is powered off
         1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
         2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
         3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD
diff --git a/include/dt-bindings/sound/tlv320aic31xx-micbias.h b/include/dt-bindings/sound/tlv320aic31xx-micbias.h
index c6895a18a455..069484070fcf 100644
--- a/include/dt-bindings/sound/tlv320aic31xx-micbias.h
+++ b/include/dt-bindings/sound/tlv320aic31xx-micbias.h
@@ -2,6 +2,7 @@
 #ifndef __DT_TLV320AIC31XX_MICBIAS_H
 #define __DT_TLV320AIC31XX_MICBIAS_H
 
+#define MICBIAS_OFF		0
 #define MICBIAS_2_0V		1
 #define MICBIAS_2_5V		2
 #define MICBIAS_AVDDV		3
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index bf92d36b8f8a..7d87df518fed 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1421,6 +1421,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	fwnode_property_read_u32(aic31xx->dev->fwnode, "ai31xx-micbias-vg",
 				 &micbias_value);
 	switch (micbias_value) {
+	case MICBIAS_OFF:
 	case MICBIAS_2_0V:
 	case MICBIAS_2_5V:
 	case MICBIAS_AVDDV:
-- 
2.18.0

