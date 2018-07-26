Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BBEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790CF20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fhi4Ct/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790CF20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeGZLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:49:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36503 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbeGZLt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:49:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so1201193wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7pdKkXszJl0Y74TWXh6gdA8KIIImBRTHTJ1Z9RN0dvg=;
        b=Fhi4Ct/bj4yBxlkbsu/bgpQOl38iLOTF6THsInYunPXq3OR8wghp/qpuILwTIc/7ls
         usASnw3IVoVeBZvGIfqRJLAc6KRMJULsxnKne8r9HGPv6PvX5gib4c8KhjQ8uDGMFqIF
         XMmk78yAf6eBbPx1OfM+Vgww16XG9Bm5jluFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7pdKkXszJl0Y74TWXh6gdA8KIIImBRTHTJ1Z9RN0dvg=;
        b=MCnBBA4DeTxmOfUVH4kuY7fPuB0y8Q6Kvnbt5zNe/xdmcevlA6kjMX4CSRKnPMlWjJ
         /i83QeKgbHM/qPzLBO6lh2PZb+SwHk9De9qCKcEA/lfMTZ1AsrGQmYJlycwOLGQuckhB
         f0yAjH6bvDrDrQaFzrwUL1lwt+/uXwUZwmWbiypcqqiDkvT0ZSx+ryOkJoTdAizhPBsb
         diacSG9o5xFUh7ObwMqNRkazgxDNaZDOG587L8nyHtstq030aLRFPi5FD6JiU4J7Hyk8
         eeRF6FdIKTNA64gpQEL+qb6j7xJJi51CJn6m9+M+mkjSsaa/I/0ydjp17QBg+GMgWHmw
         l7qA==
X-Gm-Message-State: AOUpUlENMZZGUUpivUoG3di/hvLkJAEmPopOspFQqwHPd2yMoCmHCEAT
        /shWQiI1cqP0FV8jyQS0XTxouoh3R94=
X-Google-Smtp-Source: AAOMgpf0xMjlSxZene1uZ8E1PEOaAydk+2kAI+x7mnHgUpvHTxRBxEKH5gT+ApiiGP0FCPRVniipDA==
X-Received: by 2002:a5d:6841:: with SMTP id o1-v6mr1124857wrw.159.1532601222160;
        Thu, 26 Jul 2018 03:33:42 -0700 (PDT)
Received: from localhost ([49.248.197.57])
        by smtp.gmail.com with ESMTPSA id b6-v6sm1520458wru.66.2018.07.26.03.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 03:33:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/3] thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
Date:   Thu, 26 Jul 2018 16:03:09 +0530
Message-Id: <a737a9decfee231ad065304077755267fa5466d7.1532600791.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resources() automatically requests resources (so that the I/O
region shows up in /proc/iomem) and devm_ wrappers do better error handling
and unmapping of the I/O region when needed.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 25e7f247b027..6207d8d92351 100644
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
2.17.GIT

