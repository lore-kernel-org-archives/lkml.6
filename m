Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4573C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924EB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Njalyeho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfAOKde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:33:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46299 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfAOKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:33:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so1080275ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gfsjcoK5+n5u8rdyVSCIiowp3BqnWBKCmYbY+r0pFqo=;
        b=NjalyehonmSD9f1XkR4NT52PJKvEiK+haOiYekDryzxm6wrHaHgYPGssUgy5RnbI+c
         7E2jxPO/HlDbaNi8KYCw6/fEqL8aI7xmSFTo2CuSv0zZEg/RnPuiTfhPB05xN2TzxVwI
         2+8U/2UEm/wbrBLy/cAYfcY9EC/97mPdi/ibU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gfsjcoK5+n5u8rdyVSCIiowp3BqnWBKCmYbY+r0pFqo=;
        b=Y2FqEW3hCZcvxJX9tXUCLu1Svya5dgR0o/4PGseOTbNB5r45LXRUHa/SYpYPQ5Fd0G
         UkNfkGp9Ti1wV7Wn5AL3zATqgIqR3IAyFVtB6uSRTAyGRdHTtG2OtuoA+jlD3Mu+BUWB
         P8vNWA0sFduln/Wm4NRPpVfYMXxjPISz0V1/azYJI2Nt7UGAlL3h0rMpwUeRn3b4+/KJ
         pjI2uOZzatD0jyNeItXHffGQOq8NtS+0clpzO2pM/jEzPUKa6yD3b2xon8FpOwhSynlU
         H5qzXk/5iTqIwzB03vRx68Rwah16fpNtQgyYwrVRUw+BdqhPxtrnzWSI6ztKuIwj3jv8
         lqzg==
X-Gm-Message-State: AJcUukfrDvxVKSiAUxv4wlKWqgDba2Fp9gkXlZxpohz5q7I0hJeOspAb
        1OpUX+/BRhrEuCsydz8Vh3z0gQ==
X-Google-Smtp-Source: ALg8bN4OopI8AkedXthOvA9gAZJmqUIZOMaddwqcZBZBl4IMX905n3P7WxheBQ6/XrO/3TCt+bi5Qw==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr3323046plx.231.1547548411565;
        Tue, 15 Jan 2019 02:33:31 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d13sm5073957pfd.58.2019.01.15.02.33.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 02:33:30 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com,
        orsonzhai@gmail.com
Subject: [PATCH 4/4] power: supply: sc27xx: Fix capacity saving function
Date:   Tue, 15 Jan 2019 18:32:37 +0800
Message-Id: <30327406bfd6aa0559e48b766c87c6845fe059af.1547544142.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

We found sometimes we can not get the saving capacity to initialize the
battery capacity, the reason is the user area registers are put on power
always-on region, so we need delay some time to wait until values are
updated successfully.

Moreover we also should clear the USER_AREA_CLEAR register after setting
the USER_AREA_SET register, otherwise we can not save the values in the
USER_AREA_SET register.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   64 +++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index ea1349f..24895cc 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -171,10 +171,37 @@ static int sc27xx_fgu_save_boot_mode(struct sc27xx_fgu_data *data,
 	if (ret)
 		return ret;
 
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_SET,
+				 SC27XX_FGU_MODE_AREA_MASK,
+				 boot_mode << SC27XX_FGU_MODE_AREA_SHIFT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	/*
+	 * According to the datasheet, we should set the USER_AREA_CLEAR to 0 to
+	 * make the user area data available, otherwise we can not save the user
+	 * area data.
+	 */
 	return regmap_update_bits(data->regmap,
-				  data->base + SC27XX_FGU_USER_AREA_SET,
-				  SC27XX_FGU_MODE_AREA_MASK,
-				  boot_mode << SC27XX_FGU_MODE_AREA_SHIFT);
+				  data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				  SC27XX_FGU_MODE_AREA_MASK, 0);
 }
 
 static int sc27xx_fgu_save_last_cap(struct sc27xx_fgu_data *data, int cap)
@@ -188,9 +215,36 @@ static int sc27xx_fgu_save_last_cap(struct sc27xx_fgu_data *data, int cap)
 	if (ret)
 		return ret;
 
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_SET,
+				 SC27XX_FGU_CAP_AREA_MASK, cap);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	/*
+	 * According to the datasheet, we should set the USER_AREA_CLEAR to 0 to
+	 * make the user area data available, otherwise we can not save the user
+	 * area data.
+	 */
 	return regmap_update_bits(data->regmap,
-				  data->base + SC27XX_FGU_USER_AREA_SET,
-				  SC27XX_FGU_CAP_AREA_MASK, cap);
+				  data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				  SC27XX_FGU_CAP_AREA_MASK, 0);
 }
 
 static int sc27xx_fgu_read_last_cap(struct sc27xx_fgu_data *data, int *cap)
-- 
1.7.9.5

