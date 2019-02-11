Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A912C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3B02081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895676;
	bh=471p3E0aVKn+D59PmlE8kZS00zNQFH7ptb7h0xFTbj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ETt0Cw6pQaN8Ql8U5Ajp0yUaQQxhw4WhFOBZeBIK9JTaY5apscY8GmWaFvdkJ/s0X
	 FALcb2AMoSZOcNzVadYNEJyCzIbCZOH/m3tIKrGpBlxDF6Co0cHZpYaPvf/vXDLTKH
	 sOanBAp1L1/R2hpzq1TklXuRm8yKFQh3B348qxEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfBKOef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:34:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730867AbfBKOeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1EF2081B;
        Mon, 11 Feb 2019 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895671;
        bh=471p3E0aVKn+D59PmlE8kZS00zNQFH7ptb7h0xFTbj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PB6dfXuj2HQmZIXeIw0w15v5Juc8x+DiXSn3FJsJ4u2CqOANzai19kqRSRTpwkN05
         pu17ybx00am5McQBTCCSbs4X/DJ6cb/AZtXSYDqXNbWiV/5OWKWsS6kTkoeCRV9RtQ
         Fgf/gNmJ5jjEhTVqi3DTeTQDczrZPSnZLLXuToKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 276/352] thermal: tsens: qcom: do not create duplicate regmap debugfs entries
Date:   Mon, 11 Feb 2019 15:18:23 +0100
Message-Id: <20190211141904.535641198@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4ab248b3b10a58e379e2d32333fff99ea5ca256c ]

Regmap would use device name to create debugfs entries. If the device
has multiple regmaps it is recommended to use name field in regmap_config.
Fix this by providing name to the regmap configs correctly.

Without this patch we would see below error on DB820c.

qcom-tsens 4a9000.thermal-sensor: Failed to create 4a9000.thermal-sensor
debugfs directory

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/tsens-common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 3be4be2e0465..78652cac7f3d 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -114,6 +114,14 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 }
 
 static const struct regmap_config tsens_config = {
+	.name		= "tm",
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+static const struct regmap_config tsens_srot_config = {
+	.name		= "srot",
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
@@ -139,8 +147,8 @@ int __init init_common(struct tsens_device *tmdev)
 		if (IS_ERR(srot_base))
 			return PTR_ERR(srot_base);
 
-		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
-							srot_base, &tsens_config);
+		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
+							&tsens_srot_config);
 		if (IS_ERR(tmdev->srot_map))
 			return PTR_ERR(tmdev->srot_map);
 
-- 
2.19.1



