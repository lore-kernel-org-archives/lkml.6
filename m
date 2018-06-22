Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156CBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D2423EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNs0NXN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D2423EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754389AbeFVILK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:11:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34293 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeFVIKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:10:12 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so2640767pgr.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mKiddEQWBDsjx6NRHIvvE6IftcVqW5H+YgW4bj7RSJU=;
        b=HNs0NXN6Ng8OmwqRMgMlx0l9e1Zs/10ib/zbBHfhdtugYJKZbbRvtwggReBmZy4GI+
         6Wr5O7tW+/nmqjILFWA7yFLcna+4Wuf1/RkUZS2mFFZ1J+jK/vOiXpziNMCvjOnf43he
         nVdA8RSqQIG7nGptRsZE9nHYxi6Aqilcqlb5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mKiddEQWBDsjx6NRHIvvE6IftcVqW5H+YgW4bj7RSJU=;
        b=tm7fW08K32IcR6mq4UC2z6kl4zmEvKKKb7JtAQl1Pce4wdTrC5M50yPesCXEFTaBRm
         gGBtGcwDS9FrPmA2ctbXm7B0Yk/L/UZJa+SZx6+8Zv3Ubp3EHsbQ8K23viFQlvDxi1ME
         7d0bJl5Y9qe+vPDbqvOUTADC3BnnjOtaPFXeOSrBhrvc/E4Sie8gF15Zdzu3bFd520fi
         3QcuplPkzYLCYR4evsaXngqCbe6U0wYSeVkRDpOYIQUfg8oxPesifTOfkJ8ZBOPnnmD+
         bOwiJWjTYlK0Yj6Kj5nynMpS3PyNumf9ntkG4D4T0ZSR9PvsPrqfR3wt00vGDgfYJEtu
         PJIQ==
X-Gm-Message-State: APt69E3RQGG9zy98XMc+tz1WT7kIC4Ax86tYA7e4LlHEYkm7y3xmr8MD
        9Hb8dL5lr/DlzAnN6RTIsLgOJw==
X-Google-Smtp-Source: ADUXVKIapS8nx3nv/SbfC8OrdVS9i1n3JBuQMfeo+wT3Ak2L2ATBhVa37PkVaUEKkFt2QlBc2Wqs7w==
X-Received: by 2002:a62:e117:: with SMTP id q23-v6mr645775pfh.75.1529655011469;
        Fri, 22 Jun 2018 01:10:11 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.10.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:10:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] spi: sprd: Replace of_hwspin_lock_get_id() with of_hwspin_lock_get_id_byname()
Date:   Fri, 22 Jun 2018 16:09:04 +0800
Message-Id: <c08a834989a8ffa841c457129d13b7a11361ec51.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the hwlock core has supplied new function to get a specific hwlock id
by one hwlock name, which is more clear for users. So change to use
of_hwspin_lock_get_id_byname().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 6fc50cf..d8d5e2f 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -459,7 +459,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	sadi->slave_pbase = res->start + ADI_SLAVE_OFFSET;
 	sadi->ctlr = ctlr;
 	sadi->dev = &pdev->dev;
-	ret = of_hwspin_lock_get_id(np, 0);
+	ret = of_hwspin_lock_get_id_byname(np, "adi");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not get the hardware spinlock\n");
 		goto put_ctlr;
-- 
1.7.9.5

