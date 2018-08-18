Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDBD2198E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CeyqkzHl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cYcYW7sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDBD2198E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeHRDOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:14:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeHRDOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:14:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF38B624C0; Sat, 18 Aug 2018 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534550925;
        bh=yNyN9CtZNJbAKE+N6+F9qkLKoMCdJe26xlVBad6kwY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeyqkzHlR00d8k0XszgHwLY79qPC7LeFngf+8SGiY362vlk7ggWLMf4EPwe2Gh8UB
         Ks9UVRZnuDWUNHQe5Ven7kZ6OYos/cA4a8wJLNqlK0914S3iYkdQCEI0K29wRO/QyK
         rcgDYLJRWZvN9aiRYJfbAZyGbSb7LDVLgplA/tqM=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3260B6249E;
        Sat, 18 Aug 2018 00:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534550924;
        bh=yNyN9CtZNJbAKE+N6+F9qkLKoMCdJe26xlVBad6kwY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYcYW7sMbLO2RikoJQfHlUX1g5G/Sx2IP1wL0+eqhPhGcQxV94YFMJX9IdrOupSTf
         jPV8bVpMnc/i4/dT4CgaR2EikbLhpFcC9Chc0fHSL5zsobGlFGtDeAwRv4ShxaTwR/
         xx8bwZw1Tr8jrGGhe6n4MVS53tVxznfDrkWtSmdA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3260B6249E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de,
        evgreen@chromium.org
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v2 1/4] drivers: soc: Add broadcast base for Last Level Cache Controller (LLCC)
Date:   Fri, 17 Aug 2018 17:08:32 -0700
Message-Id: <1534550915-18230-2-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, boradcast base is set to end of the LLCC banks, which may
not be correct always. As the number of banks may vary for each chipset
and the broadcast base could be at a different address as well. This info
depends on the chipset, so get the broadcast base info from the device
tree (DT). Add broadcast base in LLCC driver and use this for broadcast
writes.

Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 drivers/soc/qcom/llcc-slice.c      | 55 +++++++++++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |  4 +--
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index fcaad1a..a63640d 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -105,22 +105,24 @@ static int llcc_update_act_ctrl(u32 sid,
 	u32 slice_status;
 	int ret;
 
-	act_ctrl_reg = drv_data->bcast_off + LLCC_TRP_ACT_CTRLn(sid);
-	status_reg = drv_data->bcast_off + LLCC_TRP_STATUSn(sid);
+	act_ctrl_reg = LLCC_TRP_ACT_CTRLn(sid);
+	status_reg = LLCC_TRP_STATUSn(sid);
 
 	/* Set the ACTIVE trigger */
 	act_ctrl_reg_val |= ACT_CTRL_ACT_TRIG;
-	ret = regmap_write(drv_data->regmap, act_ctrl_reg, act_ctrl_reg_val);
+	ret = regmap_write(drv_data->bcast_regmap, act_ctrl_reg,
+				act_ctrl_reg_val);
 	if (ret)
 		return ret;
 
 	/* Clear the ACTIVE trigger */
 	act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
-	ret = regmap_write(drv_data->regmap, act_ctrl_reg, act_ctrl_reg_val);
+	ret = regmap_write(drv_data->bcast_regmap, act_ctrl_reg,
+				act_ctrl_reg_val);
 	if (ret)
 		return ret;
 
-	ret = regmap_read_poll_timeout(drv_data->regmap, status_reg,
+	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
 	return ret;
@@ -225,16 +227,13 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
 	int ret;
 	const struct llcc_slice_config *llcc_table;
 	struct llcc_slice_desc desc;
-	u32 bcast_off = drv_data->bcast_off;
 
 	sz = drv_data->cfg_size;
 	llcc_table = drv_data->cfg;
 
 	for (i = 0; i < sz; i++) {
-		attr1_cfg = bcast_off +
-				LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
-		attr0_cfg = bcast_off +
-				LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
+		attr1_cfg = LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
+		attr0_cfg = LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
 
 		attr1_val = llcc_table[i].cache_mode;
 		attr1_val |= llcc_table[i].probe_target_ways <<
@@ -259,10 +258,12 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
 		attr0_val = llcc_table[i].res_ways & ATTR0_RES_WAYS_MASK;
 		attr0_val |= llcc_table[i].bonus_ways << ATTR0_BONUS_WAYS_SHIFT;
 
-		ret = regmap_write(drv_data->regmap, attr1_cfg, attr1_val);
+		ret = regmap_write(drv_data->bcast_regmap, attr1_cfg,
+					attr1_val);
 		if (ret)
 			return ret;
-		ret = regmap_write(drv_data->regmap, attr0_cfg, attr0_val);
+		ret = regmap_write(drv_data->bcast_regmap, attr0_cfg,
+					attr0_val);
 		if (ret)
 			return ret;
 		if (llcc_table[i].activate_on_init) {
@@ -278,24 +279,36 @@ int qcom_llcc_probe(struct platform_device *pdev,
 {
 	u32 num_banks;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
-	void __iomem *base;
+	struct resource *llcc_banks_res, *llcc_bcast_res;
+	void __iomem *llcc_banks_base, *llcc_bcast_base;
 	int ret, i;
 
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	llcc_banks_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+							"llcc_base");
+	llcc_banks_base = devm_ioremap_resource(&pdev->dev, llcc_banks_res);
+	if (IS_ERR(llcc_banks_base))
+		return PTR_ERR(llcc_banks_base);
 
-	drv_data->regmap = devm_regmap_init_mmio(dev, base,
-					&llcc_regmap_config);
+	drv_data->regmap = devm_regmap_init_mmio(dev, llcc_banks_base,
+						&llcc_regmap_config);
 	if (IS_ERR(drv_data->regmap))
 		return PTR_ERR(drv_data->regmap);
 
+	llcc_bcast_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+							"llcc_broadcast_base");
+	llcc_bcast_base = devm_ioremap_resource(&pdev->dev, llcc_bcast_res);
+	if (IS_ERR(llcc_bcast_base))
+		return PTR_ERR(llcc_bcast_base);
+
+	drv_data->bcast_regmap = devm_regmap_init_mmio(dev, llcc_bcast_base,
+							&llcc_regmap_config);
+	if (IS_ERR(drv_data->bcast_regmap))
+		return PTR_ERR(drv_data->bcast_regmap);
+
 	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
 						&num_banks);
 	if (ret)
@@ -317,8 +330,6 @@ int qcom_llcc_probe(struct platform_device *pdev,
 	for (i = 0; i < num_banks; i++)
 		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
 
-	drv_data->bcast_off = num_banks * BANK_OFFSET_STRIDE;
-
 	drv_data->bitmap = devm_kcalloc(dev,
 	BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
 						GFP_KERNEL);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 7e3b9c6..c681e79 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -70,22 +70,22 @@ struct llcc_slice_config {
 /**
  * llcc_drv_data - Data associated with the llcc driver
  * @regmap: regmap associated with the llcc device
+ * @bcast_regmap: regmap associated with llcc broadcast offset
  * @cfg: pointer to the data structure for slice configuration
  * @lock: mutex associated with each slice
  * @cfg_size: size of the config data table
  * @max_slices: max slices as read from device tree
- * @bcast_off: Offset of the broadcast bank
  * @num_banks: Number of llcc banks
  * @bitmap: Bit map to track the active slice ids
  * @offsets: Pointer to the bank offsets array
  */
 struct llcc_drv_data {
 	struct regmap *regmap;
+	struct regmap *bcast_regmap;
 	const struct llcc_slice_config *cfg;
 	struct mutex lock;
 	u32 cfg_size;
 	u32 max_slices;
-	u32 bcast_off;
 	u32 num_banks;
 	unsigned long *bitmap;
 	u32 *offsets;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

