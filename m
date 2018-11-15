Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE957C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7978B2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nWCN+e5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7978B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbeKPDKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:10:20 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46652 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeKPDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:10:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAFH1W9T102147;
        Thu, 15 Nov 2018 11:01:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542301292;
        bh=e3XYaeGbGXkUVPfXmZDIkJa6BQXB6yz56CJfZigHIoM=;
        h=From:To:CC:Subject:Date;
        b=nWCN+e5pm+W1CJxeAFmkcacxFyCPSQYr4XUr72narpcSlPmU5nsPKq0iC0dubSruv
         OpuBOtOJOwWuij0LFyc7eXkceaKmti74U00A8h2nK5RVdp9bVb9K+KcclQKfEHUMPZ
         OzjpLRp5EqvH1CyglyFkES4zV7obljiIHVEyF1/A=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAFH1WIC016201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 11:01:32 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 15
 Nov 2018 11:01:32 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 15 Nov 2018 11:01:32 -0600
Received: from jiji.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAFH1WIt014400;
        Thu, 15 Nov 2018 11:01:32 -0600
From:   Andreas Dannenberg <dannenberg@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Andreas Dannenberg <dannenberg@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Andrew F Davis <afd@ti.com>
Subject: [PATCH] ASoC: pcm186x: Fix device reset-registers trigger value
Date:   Thu, 15 Nov 2018 11:01:31 -0600
Message-ID: <20181115170131.1839-1-dannenberg@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the current device datasheet (TI Lit # SLAS831D, revised
March 2018) the value written to the device's PAGE register to trigger
a complete register reset should be 0xfe, not 0xff. So go ahead and
update to the correct value.

Reported-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Tested-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 sound/soc/codecs/pcm186x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm186x.h b/sound/soc/codecs/pcm186x.h
index 2c6ba55bf394..bb3f0c42a1cd 100644
--- a/sound/soc/codecs/pcm186x.h
+++ b/sound/soc/codecs/pcm186x.h
@@ -139,7 +139,7 @@ enum pcm186x_type {
 #define PCM186X_MAX_REGISTER		PCM186X_CURR_TRIM_CTRL
 
 /* PCM186X_PAGE */
-#define PCM186X_RESET			0xff
+#define PCM186X_RESET			0xfe
 
 /* PCM186X_ADCX_INPUT_SEL_X */
 #define PCM186X_ADC_INPUT_SEL_POL	BIT(7)
-- 
2.15.1

