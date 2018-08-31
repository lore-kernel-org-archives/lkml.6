Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B855C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C330C2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QE2fOoTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C330C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeHaTWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:22:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45996 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:22:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VFE9S5006420;
        Fri, 31 Aug 2018 10:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535728449;
        bh=RTpRZYg25nhyRAAlE9npB6x05adjYTxmEE0UYgeGVj0=;
        h=From:To:CC:Subject:Date;
        b=QE2fOoTOuhJnPxsz4fbi+ny1d1ITYGDs+ePODsOMbaKqobJTpEOzGNuHhwbQ0kc7o
         W+buoiFg+SLHCBurGmyxFJsJYDXiXp6ieQmDZwA/6QWDfSvKeidqB1F9Zan6A/FCiR
         7BYoOQEwvwekH3LlK2fhxrEvb3nn/M4xSTjM9K6Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFE9RT012652;
        Fri, 31 Aug 2018 10:14:09 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 10:14:08 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 10:14:08 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFE8vp025649;
        Fri, 31 Aug 2018 10:14:08 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VFE8x19322;
        Fri, 31 Aug 2018 10:14:08 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 1/3] ASoC: tas6424: Save last fault register even when clear
Date:   Fri, 31 Aug 2018 10:14:05 -0500
Message-ID: <20180831151407.18864-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is no fault bit set in a fault register we skip the fault
reporting section for that register. This also skips over saving that
registers value. We save the value so we will not double report an
error, but if an error clears then returns we will also not report it
as we did not save the all cleared register value. Fix this by saving
the fault register value in the all clear path.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tas6424.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 14999b999fd3..0d6145549a98 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -424,8 +424,10 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	       TAS6424_FAULT_PVDD_UV |
 	       TAS6424_FAULT_VBAT_UV;
 
-	if (reg)
+	if (!reg) {
+		tas6424->last_fault1 = reg;
 		goto check_global_fault2_reg;
+	}
 
 	/*
 	 * Only flag errors once for a given occurrence. This is needed as
@@ -461,8 +463,10 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	       TAS6424_FAULT_OTSD_CH3 |
 	       TAS6424_FAULT_OTSD_CH4;
 
-	if (!reg)
+	if (!reg) {
+		tas6424->last_fault2 = reg;
 		goto check_warn_reg;
+	}
 
 	if ((reg & TAS6424_FAULT_OTSD) && !(tas6424->last_fault2 & TAS6424_FAULT_OTSD))
 		dev_crit(dev, "experienced a global overtemp shutdown\n");
@@ -497,8 +501,10 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	       TAS6424_WARN_VDD_OTW_CH3 |
 	       TAS6424_WARN_VDD_OTW_CH4;
 
-	if (!reg)
+	if (!reg) {
+		tas6424->last_warn = reg;
 		goto out;
+	}
 
 	if ((reg & TAS6424_WARN_VDD_UV) && !(tas6424->last_warn & TAS6424_WARN_VDD_UV))
 		dev_warn(dev, "experienced a VDD under voltage condition\n");
-- 
2.18.0

