Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E3920850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E3920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeH2QdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:33:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36325 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2QdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:33:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id v26-v6so4223752ljj.3;
        Wed, 29 Aug 2018 05:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aw6ZOIxSRAQ9FIfHStRWrmMCsRhoMcHpmVUU/8bQ3MQ=;
        b=aJxLRx10cnTJjlYFF9dSSIALllnJTy62UszQswU9gK5XXd9HOsmmDoMtRhZYvZaXmN
         eatwCc8/S183vVi4WX52VIBDx+t/sBUXGGEDvl2e13VjfJxKFO2S42WoLNlhwGgNqqmn
         4hlnYZ7agrqSx7ytUzypOTz81XJ+65AQmkbRDs9ZFGdGx3KznWJnZCKj0pRR2Bx9vNgU
         HwNeRth2rROt/19nbP1Dl5g5iHMwVxHzmIwvLh3HId7yYVFOLajmAT+IYRdVVkto9NRS
         7gQF24PtD86K99HiO4J27DwOV/UdQhBxHRS3lTkEdbaLFnDgeI6UvtefoTZ0zzo3LpNs
         WBkA==
X-Gm-Message-State: APzg51CmzENljjxzgzW/btlYBErd15H8j9Y/5rgeAqbf7eKsXj1AxOf3
        hYtw6ZWur7hDqEegjFyhxzI=
X-Google-Smtp-Source: ANB0VdZNLuxJvwC51W+zY4tiiOSS48MX/rcbFx+NkV2wgJexYk+my1qwb8hVpyMEtqyjD6fdXcEcJw==
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr4070331ljh.95.1535546184827;
        Wed, 29 Aug 2018 05:36:24 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y23-v6sm705191ljk.28.2018.08.29.05.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:36:24 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:36:10 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 1/8] regulator: bd71837: Disable voltage monitoring for LDO3/4
Message-ID: <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a HW quirk in BD71837. The shutdown sequence timings for
bucks/LDOs which are enabled via register interface are changed.
At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
beginning of shut-down sequence. This causes LDO5/6 voltage
monitoring to detect under voltage and force PMIC to emergency
state instead of poweroff. Disable voltage monitoring for LDO5 and
LDO6 at probe to avoid this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd71837-regulator.c | 19 +++++++++++++++++++
 include/linux/mfd/rohm-bd718x7.h      | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 0f8ac8dec3e1..a1bd8aaf4d98 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -569,6 +569,25 @@ static int bd71837_probe(struct platform_device *pdev)
 			BD71837_REG_REGLOCK);
 	}
 
+	/*
+	 * There is a HW quirk in BD71837. The shutdown sequence timings for
+	 * bucks/LDOs which are controlled via register interface are changed.
+	 * At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
+	 * beginning of shut-down sequence. As bucks 6 and 7 are parent
+	 * supplies for LDO5 and LDO6 - this causes LDO5/6 voltage
+	 * monitoring to errorneously detect under voltage and force PMIC to
+	 * emergency state instead of poweroff. In order to avoid this we
+	 * disable voltage monitoring for LDO5 and LDO6
+	 */
+	err = regmap_update_bits(pmic->mfd->regmap, BD718XX_REG_MVRFLTMASK2,
+				 BD718XX_LDO5_VRMON80 | BD718XX_LDO6_VRMON80,
+				 BD718XX_LDO5_VRMON80 | BD718XX_LDO6_VRMON80);
+	if (err) {
+		dev_err(&pmic->pdev->dev,
+			"Failed to disable voltage monitoring\n");
+		goto err;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(pmic_regulator_inits); i++) {
 
 		struct regulator_desc *desc;
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index a528747f8aed..e8338e5dc10b 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -78,9 +78,9 @@ enum {
 	BD71837_REG_TRANS_COND0        = 0x1F,
 	BD71837_REG_TRANS_COND1        = 0x20,
 	BD71837_REG_VRFAULTEN          = 0x21,
-	BD71837_REG_MVRFLTMASK0        = 0x22,
-	BD71837_REG_MVRFLTMASK1        = 0x23,
-	BD71837_REG_MVRFLTMASK2        = 0x24,
+	BD718XX_REG_MVRFLTMASK0        = 0x22,
+	BD718XX_REG_MVRFLTMASK1        = 0x23,
+	BD718XX_REG_MVRFLTMASK2        = 0x24,
 	BD71837_REG_RCVCFG             = 0x25,
 	BD71837_REG_RCVNUM             = 0x26,
 	BD71837_REG_PWRONCONFIG0       = 0x27,
@@ -159,6 +159,33 @@ enum {
 #define BUCK8_MASK		0x3F
 #define BUCK8_DEFAULT		0x1E
 
+/* BD718XX Voltage monitoring masks */
+#define BD718XX_BUCK1_VRMON80           0x1
+#define BD718XX_BUCK1_VRMON130          0x2
+#define BD718XX_BUCK2_VRMON80           0x4
+#define BD718XX_BUCK2_VRMON130          0x8
+#define BD718XX_1ST_NODVS_BUCK_VRMON80  0x1
+#define BD718XX_1ST_NODVS_BUCK_VRMON130 0x2
+#define BD718XX_2ND_NODVS_BUCK_VRMON80  0x4
+#define BD718XX_2ND_NODVS_BUCK_VRMON130 0x8
+#define BD718XX_3RD_NODVS_BUCK_VRMON80  0x10
+#define BD718XX_3RD_NODVS_BUCK_VRMON130 0x20
+#define BD718XX_4TH_NODVS_BUCK_VRMON80  0x40
+#define BD718XX_4TH_NODVS_BUCK_VRMON130 0x80
+#define BD718XX_LDO1_VRMON80            0x1
+#define BD718XX_LDO2_VRMON80            0x2
+#define BD718XX_LDO3_VRMON80            0x4
+#define BD718XX_LDO4_VRMON80            0x8
+#define BD718XX_LDO5_VRMON80            0x10
+#define BD718XX_LDO6_VRMON80            0x20
+
+/* BD71837 specific voltage monitoring masks */
+#define BD71837_BUCK3_VRMON80           0x10
+#define BD71837_BUCK3_VRMON130          0x20
+#define BD71837_BUCK4_VRMON80           0x40
+#define BD71837_BUCK4_VRMON130          0x80
+#define BD71837_LDO7_VRMON80            0x40
+
 /* BD71837_REG_IRQ bits */
 #define IRQ_SWRST		0x40
 #define IRQ_PWRON_S		0x20
-- 
2.14.3

