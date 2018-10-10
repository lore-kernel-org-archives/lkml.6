Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729FFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E82087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V58OYLY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8E82087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJJWGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:06:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38480 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJJWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:06:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so6039798wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rpuf2JMk8Gc53Xi6a8ncf+1FKfUDYBS+2j+fVX+wSuo=;
        b=V58OYLY/u11ihxM1xYlDt3dGwnRrT1eRLj24LQ+qUnvBjxYuNBms6b7l/CEeYfgJ2h
         YW1o+oN67i7fpZnDyq3a1DUlLsphxUlhISiJ3nWyX2gH6uJVF1GN2IYQziukG2SAgO4g
         7FLpiczNU5I3sqDP+dA+TIQ4G56kqf5kM+YpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rpuf2JMk8Gc53Xi6a8ncf+1FKfUDYBS+2j+fVX+wSuo=;
        b=mQnhMZF2lYKv9hrmlwIkiNsGgNQV2z8MaA284x7cj+caq0yUouLkKU8rdQ4ZqRCXc/
         //dpvXavDoA5K4AHtLKvG7Uv70fDoAUwAUoRdwQ7pyTFMIhLp17cj2HtwkWUdECIfPaA
         tA6dG5SmM2yfIe1/UsVdWcDJ5+8QEVmYPQ6ZHdEgNg4Ss6hku9Z5f73Wb/1RXudPcvSW
         Q8p+juJK3DGDhzga4f3hQTJKL7bTOJSglNy7Axm4rgqQjx/9roiKkeM99Mt37n6Mdykz
         HM9e4lV4FvUfD7/sqmyOniJ9EBRXOFRWDD2YYb5aHajpHBLDE1m2mQzZpFHKf2+Z8aC7
         6VEg==
X-Gm-Message-State: ABuFfogdPL2mAG+fDc4B+NBEyTkE6CzR2PG61Oosbbizj/URCABS2IB2
        VU6sN+RrXDwE/PJdJuf1Ad5MJA==
X-Google-Smtp-Source: ACcGV62fAqofyW2nhw9yN9mhAGxgealG6H0HehlIz7znPWbVFuT91oTDy0dPybfBx4BCHY40FgVLGw==
X-Received: by 2002:a1c:adce:: with SMTP id w197-v6mr1234248wme.11.1539182657650;
        Wed, 10 Oct 2018 07:44:17 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 195-v6sm23284351wmx.21.2018.10.10.07.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 07:44:16 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] iommu: arm-smmu: handle client iommu translation fault handlers
Date:   Wed, 10 Oct 2018 17:44:07 +0300
Message-Id: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call iommu client translation fault handler(s).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 066f4c8daf4e..02a8aab0cc59 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 			    fsr, iova, fsynr, cfg->cbndx);
 
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
+
+	report_iommu_fault(domain, smmu->dev, iova, 0);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

