Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A958ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/Jo+vXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DE82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeGRICD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:02:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46235 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbeGRICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:02:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so3515186wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VD2olbd9oQC1RGmU9iprACti8KCCG3wIJjoyBgZ3IoM=;
        b=M/Jo+vXV92GYMmp5IIJxWZp+PRsISVnNpXChlCaibp28Aj1WOgJc8ctyjRUcPy3qfy
         cSzhNz2CADP5c2t0MD6Iu1UWRNQIosmYqZnCdQWS4NBzRbV8cnsQjilvW/Vry1CwdHMY
         EIGhDWO2GSxqxyyj/UYxbngSBIs2Jz4Ccuxo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VD2olbd9oQC1RGmU9iprACti8KCCG3wIJjoyBgZ3IoM=;
        b=BBeEaSyoN8+BW2DclaHqXV2onujfnNIoYrWoJfbo0V3T4yyVAlTfZJuUOEy0KD5I5O
         gXLV6I9WP8EPN8flgt77iKUmUk5ANS68eqwr70EnqsGj0MGOUSNuIeyH0HaHS78BfrWF
         J+JXJ7MFYVNxNc8T6v4hniB4sRuDKxmzvxxwEahMfHKFvrA8FDEKewHeEJiELVuWfawJ
         UFtnC3+yiAzXEG5BA+3imkbMKqI9NpzT9vdnTIMoWV04J9WBPZPiOAQBLFo091xSqY9s
         xsZNDFaIvvKCzrBnDfUQ/bWYmKhGFz6fhY4Tk10hGhFJcHLrdAVL9I/tj4+Z9YC/HGlC
         WRLg==
X-Gm-Message-State: AOUpUlGuf8QZHET/O1TD4FVkaNQUOrZhd4urTIgc53AGc1kireu/qWWT
        py3fyLvdBN7QlSDOT56nNz8oCySubX0=
X-Google-Smtp-Source: AAOMgpeoosvEdDK/0hL2fG5UBaJ6DTm9yufOyAnMEr5qP7LZZi45zpJuguEwKeB6y76H4Kt3zGsPIg==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr3270446wrg.62.1531898734754;
        Wed, 18 Jul 2018 00:25:34 -0700 (PDT)
Received: from localhost ([49.248.170.255])
        by smtp.gmail.com with ESMTPSA id q11-v6sm7220033wrp.58.2018.07.18.00.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 00:25:34 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 2/3] thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
Date:   Wed, 18 Jul 2018 12:55:02 +0530
Message-Id: <4dd9f01c2b5d6988c5329062c25ae61747b42a32.1531898088.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resources() automatically requests resources (so that the I/O
region shows up in /proc/iomem) and devm_ wrappers do better error handling
and unmapping of the I/O region when needed.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 25e7f24..6207d8d 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -127,13 +127,11 @@ static const struct regmap_config tsens_config = {
 int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *base;
+	struct resource *res;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
 	if (!op)
 		return -EINVAL;
-	base = of_iomap(tmdev->dev->of_node, 0);
-	if (!base)
-		return -EINVAL;
 
 	/* The driver only uses the TM register address space for now */
 	if (op->num_resources > 1) {
@@ -143,11 +141,14 @@ int __init init_common(struct tsens_device *tmdev)
 		tmdev->tm_offset = 0x1000;
 	}
 
+	res = platform_get_resource(op, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&op->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
 	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
-	if (IS_ERR(tmdev->map)) {
-		iounmap(base);
+	if (IS_ERR(tmdev->map))
 		return PTR_ERR(tmdev->map);
-	}
 
 	return 0;
 }
-- 
2.7.4

