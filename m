Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFCCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55D21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPJpGAYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfADU5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:57:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40261 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfADU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so17914229plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7PoOlpFQPsMjakXihA1LLc08Bpkr7q8xCpQ3M2g6csg=;
        b=OPJpGAYSmyme1wm2pNRYFlKfBrH/jBcgmLWLGhlShFq2CZVk/aZ0HTjiA7Iypf850I
         gc7dnajTLdoDGRTBkKLJEwILJOw+SCY9T52VBqurC7UPLYSytV2WZveFs3LzUwlANFCd
         0Sx+eOlBCvjbduggdL8tnvgQ1P+s5k68N2NPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7PoOlpFQPsMjakXihA1LLc08Bpkr7q8xCpQ3M2g6csg=;
        b=WMfaxXgbh1gCer7y1/4id+/a9c03hprIP2ZjzRhQDhVDHIeEFdbY0S9jIL75yLjMpO
         U3YN6XCT7lKiQPd1xLZBazcGXahVefJe6fqZWfuUhMgKuloRfCkxYy5c9vpgO0q9N1B8
         FINDmJSrSDrh7yOAIiA99akKcSKzqWVoVw+9akQoHtztpgWMCja1FiMD8aceYXxEhMsg
         Wqhrt+PRUIFuB/7PZcP0xhEO6HyJ0XVSKmgL9aqYGaq73iZ0xnCkp26lWo2M4PZ2MM6k
         Lx9M2Gdvpt2dMDLOVWrWLoHW3zxkVR5bJCrq2r6+zX/BOIwePJE2J4K/353J2jznbOxl
         33SA==
X-Gm-Message-State: AJcUukdMpDsUTfLExgD5mkwCKzyfi/efFcmOXfD8UvfvYyKGV/sfvtOB
        XI5Ndfu7bolIKgm+ZyYoPlxG8L7S4nCauw==
X-Google-Smtp-Source: ALg8bN4bfl6pWNWbydF8wvNL7jKqslDcpZM8jK1Ofpx3+3pmhd1ZTgbsOyuKDh2o74j2jLYtZvtsTQ==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32mr52616262plj.318.1546635397174;
        Fri, 04 Jan 2019 12:56:37 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:36 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, Tanglei Han <hantanglei@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/8 v2] dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
Date:   Fri,  4 Jan 2019 12:56:23 -0800
Message-Id: <1546635388-13795-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

There is an new "hisi-pcm-asp-dma-1.0" device added in
"arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
So we have to add a matching id in the driver file:
 .compatible = "hisilicon,hisi-pcm-asp-dma-1.0"

And also hisi-pcm-asp dma device needs no setting to the clock.
So we skip this by adding and using soc data flags.

After above this driver will support both k3 and hisi_asp dma hardware.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
[jstultz: Reworked to use of_match_data]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Reworked to use of_match_data
---
 drivers/dma/k3dma.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fdec2b6..df61406 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -116,6 +116,13 @@ struct k3_dma_dev {
 	unsigned int		irq;
 };
 
+
+#define K3_FLAG_NOCLK  (1<<0)
+struct k3dma_soc_data {
+	unsigned long flags;
+};
+
+
 #define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
 
 static int k3_dma_config_write(struct dma_chan *chan,
@@ -790,8 +797,21 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
 	return 0;
 }
 
+static const struct k3dma_soc_data k3_v1_dma_data = {
+	.flags = 0,
+};
+
+static const struct k3dma_soc_data asp_v1_dma_data = {
+	.flags = K3_FLAG_NOCLK,
+};
+
 static const struct of_device_id k3_pdma_dt_ids[] = {
-	{ .compatible = "hisilicon,k3-dma-1.0", },
+	{ .compatible = "hisilicon,k3-dma-1.0",
+	  .data = &k3_v1_dma_data
+	},
+	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0",
+	  .data = &asp_v1_dma_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
@@ -810,6 +830,7 @@ static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 
 static int k3_dma_probe(struct platform_device *op)
 {
+	const struct k3dma_soc_data *soc_data;
 	struct k3_dma_dev *d;
 	const struct of_device_id *of_id;
 	struct resource *iores;
@@ -823,6 +844,10 @@ static int k3_dma_probe(struct platform_device *op)
 	if (!d)
 		return -ENOMEM;
 
+	soc_data = device_get_match_data(&op->dev);
+	if (!soc_data)
+		return -EINVAL;
+
 	d->base = devm_ioremap_resource(&op->dev, iores);
 	if (IS_ERR(d->base))
 		return PTR_ERR(d->base);
@@ -835,10 +860,12 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-requests", &d->dma_requests);
 	}
 
-	d->clk = devm_clk_get(&op->dev, NULL);
-	if (IS_ERR(d->clk)) {
-		dev_err(&op->dev, "no dma clk\n");
-		return PTR_ERR(d->clk);
+	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
+		d->clk = devm_clk_get(&op->dev, NULL);
+		if (IS_ERR(d->clk)) {
+			dev_err(&op->dev, "no dma clk\n");
+			return PTR_ERR(d->clk);
+		}
 	}
 
 	irq = platform_get_irq(op, 0);
-- 
2.7.4

