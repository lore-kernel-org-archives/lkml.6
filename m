Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F610C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE442084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8XdWfoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE442084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeH1RbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:31:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34388 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeH1RbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:31:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so1236053eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oeW4RqD9YtS5LZxw4vdI84WXKgqnp4V7aomxkAAem2w=;
        b=V8XdWfooyN8xVF8PULrA9GGkYKytBKytVxeDi2VHGLuUR428z8Vq3Z3xskUYiKAtcU
         fbkfZ4SpWaLrgR6kQs27ZlB8PshdntUbv4/UF9PVGB5EFxkplq7ZDOId3ZfLFOLkvz9K
         kAGBAoDreYzptRokjRHUTghLmmcBTtX3uoEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oeW4RqD9YtS5LZxw4vdI84WXKgqnp4V7aomxkAAem2w=;
        b=Ur4cHjez/nBqc9VBgDkxrd4TrIaTAuox0OGVdrz8lAJp7Y5NpXCiG05j/upmT2OxbL
         LZWBuE7njksG3y268ciMYBWanY7wQ+pmb2k8+yLpjBQj05T777S88HLshTzdFoLrq6+5
         vsrpyorMPootFiGOiUUUgJzjrPwW1cIJcQjX8n7jijVyUPfKdL8pFRl12zDRjAVSouxg
         r9CChsLomkkVE4FMJWoDXrxLiJFzgiNMwxJ9otX3Zn4r7buti6KnW/n1LCTwcWFFdmFE
         uu5+9jPmYY6R0VzugyyM+CewuUcgFOtbP/qszvtZ+qiKBsOhI/WgPi6Hq2QnC4t8a8fm
         a/Uw==
X-Gm-Message-State: APzg51DzEvleSCowH+p9wZoNsteHSU3ZeKEPwFJfztg8BeELlNiBLOHb
        YEjMhJhI/vorH0hMdCLuBtbgtdq18xw=
X-Google-Smtp-Source: ANB0VdZA0PoOIpfzEH2QePWYjPPIfIQn9Kdv7RixxbXAHyqo1DisFbUDyMYq2GDAlSkyPE89TNoN6A==
X-Received: by 2002:a50:b799:: with SMTP id h25-v6mr2501293ede.297.1535463576416;
        Tue, 28 Aug 2018 06:39:36 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id a33-v6sm648763eda.2.2018.08.28.06.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:35 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 06/11] thermal: tsens: Rename map field in order to add a second address map
Date:   Tue, 28 Aug 2018 19:08:35 +0530
Message-Id: <9dd785eb1292e80e3ac4b52e1e4da431774c2211.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSENS driver currently only uses a limited set of registers from the TM
address space. So it was ok to map just that set of registers and call it
"map".

We'd now like to map a second set: SROT registers to introduce new
functionality. Rename the "map" field to a more appropriate "tm_map".

The 8960 doesn't have a clear split between TM and SROT registers. To avoid
complicating the data structure, it will switchover to using tm_map for its
maps.

There is no functional change with this patch.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-8960.c   | 30 ++++++++++++++---------------
 drivers/thermal/qcom/tsens-common.c | 17 ++++++++--------
 drivers/thermal/qcom/tsens-v2.c     |  6 +++---
 drivers/thermal/qcom/tsens.h        |  2 +-
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 4af76de7dc2e..0f0adb302a7b 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -60,7 +60,7 @@ static int suspend_8960(struct tsens_device *tmdev)
 {
 	int ret;
 	unsigned int mask;
-	struct regmap *map = tmdev->map;
+	struct regmap *map = tmdev->tm_map;
 
 	ret = regmap_read(map, THRESHOLD_ADDR, &tmdev->ctx.threshold);
 	if (ret)
@@ -85,7 +85,7 @@ static int suspend_8960(struct tsens_device *tmdev)
 static int resume_8960(struct tsens_device *tmdev)
 {
 	int ret;
-	struct regmap *map = tmdev->map;
+	struct regmap *map = tmdev->tm_map;
 
 	ret = regmap_update_bits(map, CNTL_ADDR, SW_RST, SW_RST);
 	if (ret)
@@ -117,12 +117,12 @@ static int enable_8960(struct tsens_device *tmdev, int id)
 	int ret;
 	u32 reg, mask;
 
-	ret = regmap_read(tmdev->map, CNTL_ADDR, &reg);
+	ret = regmap_read(tmdev->tm_map, CNTL_ADDR, &reg);
 	if (ret)
 		return ret;
 
 	mask = BIT(id + SENSOR0_SHIFT);
-	ret = regmap_write(tmdev->map, CNTL_ADDR, reg | SW_RST);
+	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg | SW_RST);
 	if (ret)
 		return ret;
 
@@ -131,7 +131,7 @@ static int enable_8960(struct tsens_device *tmdev, int id)
 	else
 		reg |= mask | SLP_CLK_ENA_8660 | EN;
 
-	ret = regmap_write(tmdev->map, CNTL_ADDR, reg);
+	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg);
 	if (ret)
 		return ret;
 
@@ -148,7 +148,7 @@ static void disable_8960(struct tsens_device *tmdev)
 	mask <<= SENSOR0_SHIFT;
 	mask |= EN;
 
-	ret = regmap_read(tmdev->map, CNTL_ADDR, &reg_cntl);
+	ret = regmap_read(tmdev->tm_map, CNTL_ADDR, &reg_cntl);
 	if (ret)
 		return;
 
@@ -159,7 +159,7 @@ static void disable_8960(struct tsens_device *tmdev)
 	else
 		reg_cntl &= ~SLP_CLK_ENA_8660;
 
-	regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
+	regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
 }
 
 static int init_8960(struct tsens_device *tmdev)
@@ -167,8 +167,8 @@ static int init_8960(struct tsens_device *tmdev)
 	int ret, i;
 	u32 reg_cntl;
 
-	tmdev->map = dev_get_regmap(tmdev->dev, NULL);
-	if (!tmdev->map)
+	tmdev->tm_map = dev_get_regmap(tmdev->dev, NULL);
+	if (!tmdev->tm_map)
 		return -ENODEV;
 
 	/*
@@ -184,14 +184,14 @@ static int init_8960(struct tsens_device *tmdev)
 	}
 
 	reg_cntl = SW_RST;
-	ret = regmap_update_bits(tmdev->map, CNTL_ADDR, SW_RST, reg_cntl);
+	ret = regmap_update_bits(tmdev->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
 	if (ret)
 		return ret;
 
 	if (tmdev->num_sensors > 1) {
 		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
 		reg_cntl &= ~SW_RST;
-		ret = regmap_update_bits(tmdev->map, CONFIG_ADDR,
+		ret = regmap_update_bits(tmdev->tm_map, CONFIG_ADDR,
 					 CONFIG_MASK, CONFIG);
 	} else {
 		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
@@ -200,12 +200,12 @@ static int init_8960(struct tsens_device *tmdev)
 	}
 
 	reg_cntl |= GENMASK(tmdev->num_sensors - 1, 0) << SENSOR0_SHIFT;
-	ret = regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
+	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
 	if (ret)
 		return ret;
 
 	reg_cntl |= EN;
-	ret = regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
+	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
 	if (ret)
 		return ret;
 
@@ -252,12 +252,12 @@ static int get_temp_8960(struct tsens_device *tmdev, int id, int *temp)
 
 	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
 	do {
-		ret = regmap_read(tmdev->map, INT_STATUS_ADDR, &trdy);
+		ret = regmap_read(tmdev->tm_map, INT_STATUS_ADDR, &trdy);
 		if (ret)
 			return ret;
 		if (!(trdy & TRDY_MASK))
 			continue;
-		ret = regmap_read(tmdev->map, s->status, &code);
+		ret = regmap_read(tmdev->tm_map, s->status, &code);
 		if (ret)
 			return ret;
 		*temp = code_to_mdegC(code, s);
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 303e3fdaca98..0585084630b3 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -99,8 +99,7 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	int last_temp = 0, ret;
 
 	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
-	ret = regmap_read(tmdev->map, status_reg, &code);
-
+	ret = regmap_read(tmdev->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	last_temp = code & SN_ST_TEMP_MASK;
@@ -118,7 +117,7 @@ static const struct regmap_config tsens_config = {
 
 int __init init_common(struct tsens_device *tmdev)
 {
-	void __iomem *base;
+	void __iomem *tm_base;
 	struct resource *res;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
@@ -134,13 +133,13 @@ int __init init_common(struct tsens_device *tmdev)
 	}
 
 	res = platform_get_resource(op, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&op->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	tm_base = devm_ioremap_resource(&op->dev, res);
+	if (IS_ERR(tm_base))
+		return PTR_ERR(tm_base);
 
-	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
-	if (IS_ERR(tmdev->map))
-		return PTR_ERR(tmdev->map);
+	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base, &tsens_config);
+	if (IS_ERR(tmdev->tm_map))
+		return PTR_ERR(tmdev->tm_map);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 44da02f594ac..1bdef92e4521 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -21,7 +21,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	int ret;
 
 	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
-	ret = regmap_read(tmdev->map, status_reg, &code);
+	ret = regmap_read(tmdev->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	last_temp = code & LAST_TEMP_MASK;
@@ -29,7 +29,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 		goto done;
 
 	/* Try a second time */
-	ret = regmap_read(tmdev->map, status_reg, &code);
+	ret = regmap_read(tmdev->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	if (code & STATUS_VALID_BIT) {
@@ -40,7 +40,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	}
 
 	/* Try a third/last time */
-	ret = regmap_read(tmdev->map, status_reg, &code);
+	ret = regmap_read(tmdev->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	if (code & STATUS_VALID_BIT) {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 8207610f326a..58e98c4d3a8b 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -69,7 +69,7 @@ struct tsens_context {
 struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
-	struct regmap			*map;
+	struct regmap			*tm_map;
 	u32				tm_offset;
 	struct tsens_context		ctx;
 	const struct tsens_ops		*ops;
-- 
2.17.1

