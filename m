Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8157FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC7220882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fV2K4fx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC7220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeKHIlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:41:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeKHIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:41:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id u10-v6so2618487pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 15:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=251q+wzxMwb9EgjyEsAosebAViYOYzyiWozPstsfYng=;
        b=fV2K4fx8qaKM1Eo4yhZfAvx1TS/LwV1RBOW2YgqcgovtU/6t158ik28R7BVDqBCg5I
         0WF62c6NByPdStb6yuYI5AMLnRD8MOUaMb2vcHcBYltt8PtrlVkch5PV+29lTgEYZ7aM
         RmKRahNlyWR9hlGGnJayqXvXfVsCA3SNY6vTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=251q+wzxMwb9EgjyEsAosebAViYOYzyiWozPstsfYng=;
        b=T60SJa5GxkSmQj+wTh9pDYmyxNiCeXXwe+2CNNj9x/pJaVPP9CZQW3yOVAmjXOIwFE
         zyD7nsOZfG3yu7F05KkEpYr4mLspbWEsqJZZUVuS7RnLqtTXtMI3TsCiFHh9zmO3NANj
         7e56Bi6Ge1En1mr2BDI3+QfzIRO9A1tbdEg+U7nBCD5UrAzuSze0EXappGbEklN+BsZx
         /V7K6E5l07uaxxtqr0SwEKQahFqcRwVH2rjRZ51FhLYM0zncsmotEdDzINV0mLxjaui1
         OLK7xHpfkg0rMdLsfXgsOJyycxWRyuCgBrsaWrWgOQy89Kfui9aPTlspc+NBXgq531bo
         +PcA==
X-Gm-Message-State: AGRZ1gLF8XDJtBeeGwgZvyEqbXsiEVS2GYRsphfSsSWNJkAiWPpaaapi
        1snjWWPZcns2iA3gm7dZcmOpmA==
X-Google-Smtp-Source: AJdET5eI9EbywTsMpdytlF4HKf9rhgtpLLpxsed1ryKtAlGfNiGkTjyKjFvpIMtVwSvuZu+yMhIJwA==
X-Received: by 2002:a62:9f98:: with SMTP id v24-v6mr2228075pfk.108.1541632139005;
        Wed, 07 Nov 2018 15:08:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1802034pfb.113.2018.11.07.15.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 15:08:58 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] coresight: etm3x: Deal with CLAIM tag before and after accessing HW
Date:   Wed,  7 Nov 2018 16:08:51 -0700
Message-Id: <1541632132-1252-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves access to the CLAIM tag so that no modification to the HW
happens before and after the CLAIM operation has been carried.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index fd5c4cca7db5..4f638d81a66a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -363,15 +363,16 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 
 	CS_UNLOCK(drvdata->base);
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		goto done;
+
 	/* Turn engine on */
 	etm_clr_pwrdwn(drvdata);
 	/* Apply power to trace registers */
 	etm_set_pwrup(drvdata);
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
-	rc = coresight_claim_device_unlocked(drvdata->base);
-	if (rc)
-		goto done;
 
 	etm_set_prog(drvdata);
 
@@ -422,12 +423,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_clr_prog(drvdata);
 
 done:
-	if (rc)
-		etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
-		drvdata->cpu, rc);
+	if (!rc)
+		dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
+			drvdata->cpu, rc);
 	return rc;
 }
 
@@ -577,9 +577,9 @@ static void etm_disable_hw(void *info)
 	for (i = 0; i < drvdata->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
+	etm_set_pwrdwn(drvdata);
 	coresight_disclaim_device_unlocked(drvdata->base);
 
-	etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
-- 
2.7.4

