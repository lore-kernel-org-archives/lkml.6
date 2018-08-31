Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9962120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cvbWLPJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9962120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeHaTWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:22:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49368 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:22:13 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VFEAd6041575;
        Fri, 31 Aug 2018 10:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535728450;
        bh=mj83xnjgfF9fBUPa+jVaYw3qxeEut5oBe0TMCaOrySc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cvbWLPJ2lWKv2yvW6BqVspzZKComBz8q9/4R0PyR49Ge5/z0GRsn9jhmMu39ClrJF
         LrEavyX9E9WeQt8QCPqLC0X5uz3BNjSmL0FlGP54n8EQQfTKgePm/PJYeZS0eFm3bG
         QfaDVJ7rEV9ykgZB3MlVEv+HCKuY4tsrH7n4+YdM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFEA2x030829;
        Fri, 31 Aug 2018 10:14:10 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 10:14:10 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 10:14:10 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFEAE1016834;
        Fri, 31 Aug 2018 10:14:10 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VFE9x19335;
        Fri, 31 Aug 2018 10:14:09 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 3/3] ASoC: tas6424: Add channel fault reporting
Date:   Fri, 31 Aug 2018 10:14:07 -0500
Message-ID: <20180831151407.18864-3-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831151407.18864-1-afd@ti.com>
References: <20180831151407.18864-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS6426 has a register that reports channel faults such as
overcurrent and continuous DC output. Add reporting of this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tas6424.c | 52 +++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/tas6424.h | 10 ++++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index aac559fffc1a..36aebdb8f55c 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -41,6 +41,7 @@ struct tas6424_data {
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[TAS6424_NUM_SUPPLIES];
 	struct delayed_work fault_check_work;
+	unsigned int last_cfault;
 	unsigned int last_fault1;
 	unsigned int last_fault2;
 	unsigned int last_warn;
@@ -406,6 +407,51 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	unsigned int reg;
 	int ret;
 
+	ret = regmap_read(tas6424->regmap, TAS6424_CHANNEL_FAULT, &reg);
+	if (ret < 0) {
+		dev_err(dev, "failed to read CHANNEL_FAULT register: %d\n", ret);
+		goto out;
+	}
+
+	if (!reg) {
+		tas6424->last_cfault = reg;
+		goto check_global_fault1_reg;
+	}
+
+	/*
+	 * Only flag errors once for a given occurrence. This is needed as
+	 * the TAS6424 will take time clearing the fault condition internally
+	 * during which we don't want to bombard the system with the same
+	 * error message over and over.
+	 */
+	if ((reg & TAS6424_FAULT_OC_CH1) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH1))
+		dev_crit(dev, "experienced a channel 1 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_OC_CH2) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH2))
+		dev_crit(dev, "experienced a channel 2 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_OC_CH3) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH3))
+		dev_crit(dev, "experienced a channel 3 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_OC_CH4) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH4))
+		dev_crit(dev, "experienced a channel 4 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH1) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH1))
+		dev_crit(dev, "experienced a channel 1 DC fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH2) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH2))
+		dev_crit(dev, "experienced a channel 2 DC fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH3) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH3))
+		dev_crit(dev, "experienced a channel 3 DC fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH4) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH4))
+		dev_crit(dev, "experienced a channel 4 DC fault\n");
+
+	/* Store current fault1 value so we can detect any changes next time */
+	tas6424->last_cfault = reg;
+
+check_global_fault1_reg:
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT1, &reg);
 	if (ret < 0) {
 		dev_err(dev, "failed to read GLOB_FAULT1 register: %d\n", ret);
@@ -429,12 +475,6 @@ static void tas6424_fault_check_work(struct work_struct *work)
 		goto check_global_fault2_reg;
 	}
 
-	/*
-	 * Only flag errors once for a given occurrence. This is needed as
-	 * the TAS6424 will take time clearing the fault condition internally
-	 * during which we don't want to bombard the system with the same
-	 * error message over and over.
-	 */
 	if ((reg & TAS6424_FAULT_PVDD_OV) && !(tas6424->last_fault1 & TAS6424_FAULT_PVDD_OV))
 		dev_crit(dev, "experienced a PVDD overvoltage fault\n");
 
diff --git a/sound/soc/codecs/tas6424.h b/sound/soc/codecs/tas6424.h
index b5958c45ed0e..c67a7835ca66 100644
--- a/sound/soc/codecs/tas6424.h
+++ b/sound/soc/codecs/tas6424.h
@@ -115,6 +115,16 @@
 #define TAS6424_LDGBYPASS_SHIFT		0
 #define TAS6424_LDGBYPASS_MASK		BIT(TAS6424_LDGBYPASS_SHIFT)
 
+/* TAS6424_GLOB_FAULT1_REG */
+#define TAS6424_FAULT_OC_CH1		BIT(7)
+#define TAS6424_FAULT_OC_CH2		BIT(6)
+#define TAS6424_FAULT_OC_CH3		BIT(5)
+#define TAS6424_FAULT_OC_CH4		BIT(4)
+#define TAS6424_FAULT_DC_CH1		BIT(3)
+#define TAS6424_FAULT_DC_CH2		BIT(2)
+#define TAS6424_FAULT_DC_CH3		BIT(1)
+#define TAS6424_FAULT_DC_CH4		BIT(0)
+
 /* TAS6424_GLOB_FAULT1_REG */
 #define TAS6424_FAULT_CLOCK		BIT(4)
 #define TAS6424_FAULT_PVDD_OV		BIT(3)
-- 
2.18.0

