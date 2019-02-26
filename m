Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7E8217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Gnib2xJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfBZFwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:52:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37086 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZFwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:52:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so5668199pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=u4l7XvHuAb6oka6W2zo4DesmSmwZylCH/DbIE2GBwTo=;
        b=Gnib2xJ9/9l3BcgCTUh76Jqq+HxxO+8oPAeleBoNasXEPNKmxIcP57ME6ayZSFlodX
         m8Kc++QcQXAGZQ0i31OOl0dASq0yevyXBe6P5CogUzIEC0CSO3yxf3T31Yh/q1MGhY1P
         CqA70xHzJY599M7R6EHYePJ+fMdHvP+J2XZBpy2Plaly6kWS0a47mEEHkcTq2Q2EAv8t
         S69YWRW+cCwpcEa+fyjtUfhwrOUl5u+Dk6UpoQhc9bDLFSC5tN/LeNl4ohwH0xoOe1Wh
         KK1S9ETd634P/SV+7FwUgUpZ9faH0ch0qfrbvgw5p3vXCndDq5YiejB5n+GXLZwWIELp
         4Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u4l7XvHuAb6oka6W2zo4DesmSmwZylCH/DbIE2GBwTo=;
        b=GOnPYT2079+iACQNtlXqdljYt8iG8SB6FyMAW5unfxOuXP8f5TDGo29Ke8792IBJZG
         BysIEPd9OEe4ZvTbMuaMAvOvxnym3mLIsqqN+9IsW//aNp264EFaf7fnOYKiv9iDCdqa
         OhIfj2lUzV2NZA9vABFjufYQzRgD8yo/D3yhxTfxwIOMhX8+w1OVC4NsLFMB/z2Om/B9
         YM7nM1fiX/WK6g14FT0dnM8GbLCm6SJABQq0TmkVJD644VA0WLoo228FUqyYkEN44GT8
         cK577eqC4HIWLxMj6VwnxH/SrWlY2jrgwWOj8m6C5XaWWhRkvQjvjSjPbUocV+wJ46fG
         Aj2w==
X-Gm-Message-State: AHQUAuZn6KzO0w7v+fMz1pndytJ5AFiy/VzdZ+uwFR8+SYve35FGtG8/
        vkKVB1lyHUKH40gUigDzyOEwWA==
X-Google-Smtp-Source: AHgI3IZ+p+Jheh260li07abhhkDrKkTXJSGS0rcVAiNjSud/7V2F8w7NnnHptGpodWKOOVwUsxrPfA==
X-Received: by 2002:a62:4ec5:: with SMTP id c188mr24515974pfb.230.1551160361665;
        Mon, 25 Feb 2019 21:52:41 -0800 (PST)
Received: from localhost.localdomain (36-239-237-193.dynamic-ip.hinet.net. [36.239.237.193])
        by smtp.gmail.com with ESMTPSA id l79sm25061506pfb.102.2019.02.25.21.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:52:41 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: cpcap: Remove unused vsel_shift from struct cpcap_regulator
Date:   Tue, 26 Feb 2019 13:52:29 +0800
Message-Id: <20190226055230.25482-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses regulator_get/set_voltage_sel_regmap so it does not use
vsel_shift. Actually, vsel_shift can be calculated by vsel_mask setting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/cpcap-regulator.c | 102 ++++++++++++++--------------
 1 file changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index 2131457937b7..c15ced1b5968 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -100,12 +100,11 @@ struct cpcap_regulator {
 	struct regulator_desc rdesc;
 	const u16 assign_reg;
 	const u16 assign_mask;
-	const u16 vsel_shift;
 };
 
 #define CPCAP_REG(_ID, reg, assignment_reg, assignment_mask, val_tbl,	\
-		mode_mask, volt_mask, volt_shft,			\
-		mode_val, off_val, volt_trans_time) {			\
+		mode_mask, volt_mask, mode_val, off_val,		\
+		volt_trans_time) {					\
 	.rdesc = {							\
 		.name = #_ID,						\
 		.of_match = of_match_ptr(#_ID),				\
@@ -127,7 +126,6 @@ struct cpcap_regulator {
 	},								\
 	.assign_reg = (assignment_reg),					\
 	.assign_mask = (assignment_mask),				\
-	.vsel_shift = (volt_shft),					\
 }
 
 struct cpcap_ddata {
@@ -339,152 +337,152 @@ static const unsigned int vaudio_val_tbl[] = { 0, 2775000, };
 static struct cpcap_regulator omap4_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW2_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW4_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
-		  0x28, 0, 0, 0x20 | CPCAP_REG_OFF_MODE_SEC, 0, 0),
+		  0x28, 0, 0x20 | CPCAP_REG_OFF_MODE_SEC, 0, 0),
 	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
-		  0x87, 0x30, 4, 0x3, 0, 420),
+		  0x87, 0x30, 0x3, 0, 420),
 	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
-		  0x47, 0x10, 4, 0x43, 0x41, 350),
+		  0x47, 0x10, 0x43, 0x41, 350),
 	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
-		  0x87, 0x30, 4, 0x3, 0, 420),
+		  0x87, 0x30, 0x3, 0, 420),
 	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
-		  0x87, 0x30, 4, 0x82, 0, 420),
+		  0x87, 0x30, 0x82, 0, 420),
 	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
-		  0x80, 0xf, 0, 0x80, 0, 420),
+		  0x80, 0xf, 0x80, 0, 420),
 	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
-		  0x17, 0, 0, 0, 0x12, 0),
+		  0x17, 0, 0, 0x12, 0),
 	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
-		  0x87, 0x38, 3, 0x82, 0, 420),
+		  0x87, 0x38, 0x82, 0, 420),
 	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
-		  0x43, 0x18, 3, 0x2, 0, 420),
+		  0x43, 0x18, 0x2, 0, 420),
 	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
-		  0xac, 0x2, 1, 0x4, 0, 10),
+		  0xac, 0x2, 0x4, 0, 10),
 	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
-		  0x23, 0x8, 3, 0, 0, 10),
+		  0x23, 0x8, 0, 0, 10),
 	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
-		  0x23, 0x8, 3, 0, 0, 420),
+		  0x23, 0x8, 0, 0, 420),
 	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
-		  0x47, 0x10, 4, 0, 0, 420),
+		  0x47, 0x10, 0, 0, 420),
 	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
-		  0x20c, 0xc0, 6, 0x20c, 0, 420),
+		  0x20c, 0xc0, 0x20c, 0, 420),
 	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsim_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 420),
+		  0x23, 0x8, 0x3, 0, 420),
 	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsimcard_val_tbl,
-		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
+		  0x1e80, 0x8, 0x1e00, 0, 420),
 	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
-		  0x1, 0xc, 2, 0x1, 0, 500),
+		  0x1, 0xc, 0x1, 0, 500),
 	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
-		  0x11c, 0x40, 6, 0xc, 0, 0),
+		  0x11c, 0x40, 0xc, 0, 0),
 	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
 		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
-		  0x16, 0x1, 0, 0x4, 0, 0),
+		  0x16, 0x1, 0x4, 0, 0),
 	{ /* sentinel */ },
 };
 
 static struct cpcap_regulator xoom_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
-		  0xf00, 0x7f, 0, 0x800, 0, 120),
+		  0xf00, 0x7f, 0x800, 0, 120),
 	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
-		  0xf00, 0x7f, 0, 0x900, 0, 100),
+		  0xf00, 0x7f, 0x900, 0, 100),
 	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
-		  0x2a, 0, 0, 0x22, 0, 0),
+		  0x2a, 0, 0x22, 0, 0),
 	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
-		  0x87, 0x30, 4, 0x7, 0, 420),
+		  0x87, 0x30, 0x7, 0, 420),
 	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
-		  0x47, 0x10, 4, 0x7, 0, 350),
+		  0x47, 0x10, 0x7, 0, 350),
 	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
-		  0x87, 0x30, 4, 0x3, 0, 420),
+		  0x87, 0x30, 0x3, 0, 420),
 	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
-		  0x87, 0x30, 4, 0x5, 0, 420),
+		  0x87, 0x30, 0x5, 0, 420),
 	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
-		  0x80, 0xf, 0, 0x80, 0, 420),
+		  0x80, 0xf, 0x80, 0, 420),
 	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
-		  0x17, 0, 0, 0x2, 0, 0),
+		  0x17, 0, 0x2, 0, 0),
 	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
-		  0x87, 0x38, 3, 0x2, 0, 420),
+		  0x87, 0x38, 0x2, 0, 420),
 	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
-		  0x43, 0x18, 3, 0x1, 0, 420),
+		  0x43, 0x18, 0x1, 0, 420),
 	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
-		  0xac, 0x2, 1, 0xc, 0, 10),
+		  0xac, 0x2, 0xc, 0, 10),
 	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 10),
+		  0x23, 0x8, 0x3, 0, 10),
 	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 420),
+		  0x23, 0x8, 0x3, 0, 420),
 	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
-		  0x47, 0x10, 4, 0x5, 0, 420),
+		  0x47, 0x10, 0x5, 0, 420),
 	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
-		  0x20c, 0xc0, 6, 0x8, 0, 420),
+		  0x20c, 0xc0, 0x8, 0, 420),
 	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsim_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 420),
+		  0x23, 0x8, 0x3, 0, 420),
 	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsimcard_val_tbl,
-		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
+		  0x1e80, 0x8, 0x1e00, 0, 420),
 	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
-		  0x1, 0xc, 2, 0, 0x1, 500),
+		  0x1, 0xc, 0, 0x1, 500),
 	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
-		  0x11c, 0x40, 6, 0xc, 0, 0),
+		  0x11c, 0x40, 0xc, 0, 0),
 	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
 		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
-		  0x16, 0x1, 0, 0x4, 0, 0),
+		  0x16, 0x1, 0x4, 0, 0),
 	{ /* sentinel */ },
 };
 
-- 
2.17.1

