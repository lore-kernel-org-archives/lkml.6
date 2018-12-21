Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17960C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8036218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QsylXiGH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="khSjI9ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbeLUMAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:00:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeLUMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:00:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3EA53608C5; Fri, 21 Dec 2018 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393615;
        bh=N9QFwoPHVle1Kh8jGl00bfT1oRAjbz2Q7x3QbyVcRpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsylXiGHUwGl+VBnVHWpKMWWtTuQYtU7CuZP+eLEbeYUfSu1pDbfjKiowmoVZIeOx
         sgomyqWNK/TAH1PI6FN6nICAJ4lCCM+MsyDBoJR9+NGSycixTnKe8ce6y9XIrpBUUA
         MSonJIE41BCK0buef9nLQ8e2eQs/CNM6LvjnlCqY=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 955C6608D4;
        Fri, 21 Dec 2018 12:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393614;
        bh=N9QFwoPHVle1Kh8jGl00bfT1oRAjbz2Q7x3QbyVcRpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khSjI9ciVdkNM23AQxT7fMjArIzEmanrz9hPUUEtBK3WDuDCQjFWzjvgVt09jHEzT
         xeRsWQDVKubaJoTD9XNLwXqTDi1qZ2FGPsmmwSX+toEAFAmbyJFnH0ng5fI+3ccL2y
         HBhSca1t2nBu6haKYTWdX5AT94eXh8RkyrDzYN1Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 955C6608D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 1/5] drivers: qcom: rpmh-rsc: Add regmap for RSC controller
Date:   Fri, 21 Dec 2018 17:29:42 +0530
Message-Id: <20181221115946.10095-2-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RSC controller has dedicated control registers to
send next wakeup timer vale to PDC. The timer value
needs to be programmed by sleep driver client. So add
regmap for the controller.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 75bd9a83aef0..269fd0866647 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -61,6 +62,13 @@
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+static const struct regmap_config rsc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
 static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
 	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
@@ -534,6 +542,7 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	struct tcs_group *tcs;
 	struct resource *res;
 	void __iomem *base;
+	struct regmap *regmap;
 	char drv_id[10] = {0};
 
 	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
@@ -542,6 +551,11 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					&rsc_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
 	if (ret)
 		return ret;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

