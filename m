Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1DA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxSRrtci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfAJReY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44112 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfAJReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so5091319pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GvaGd5Qa7PcuxUq/r8GFXFG1FEuIWEy4GqPFolG9iUI=;
        b=jxSRrtciAFsvPrLOdNPhoVjarHW2x/2/ieNzhzFow+FU0K8BMwZLOe2a4Smu9h1k0R
         PKW4LIHA2T7w2pM2l3KXg2pwa3HsvR+0UOWMXVWL33Ev0NGPfMeEWNyUEwjuxpLdOihY
         joAfF444bcis6IgH48l+ZKHNIc3ECmaj1WIeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GvaGd5Qa7PcuxUq/r8GFXFG1FEuIWEy4GqPFolG9iUI=;
        b=TIG3KzKWicoaaG7XyEiQjweRU1zGH+PM0Pp5SCryVRb7mDb8BlsVWaTQ5Rc7L+XK/q
         y6v5NvMnsUdh35dCS700KuPnScFfbdqedUqsBaxyJAmBsO35vzFowCY9erqQtYJUT5TA
         v10VmuOzJNnUMl6k3GbVI7SSUkMSMacBc798Q/pgZlc8UKS1ItC7clDpBteVo+RKl/qS
         tWbb6/MOX4g0O//dawR7/3QNpWC82IxFCUMgcUzDWu4Bp47oOazjyTja+x+yciQc/GOH
         Qy3dsjhhyZK3kIaBmrnZNk5cETAG8Yzg8j1CJilHJCJaeaOIjyITVljDvcL9vuL/x5hC
         IcpA==
X-Gm-Message-State: AJcUukdU9weGjuiP81j7rxi31CdMCsdeCPeh5KjjrB6yBdBu56aS6Iu0
        fqoF96HTGnUGgnJRJrn5C7SkW369Nom1UA==
X-Google-Smtp-Source: ALg8bN4hH6OpNpCbHKtQeZyVFIwzVI9NPTlgoq4ItvQtEK7rYgtlbysusiurz+Jp1hkGwNWFvLMIbw==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr4506117pge.437.1547141660281;
        Thu, 10 Jan 2019 09:34:20 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:19 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Tanglei Han <hantanglei@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/8 v3] dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
Date:   Thu, 10 Jan 2019 09:34:07 -0800
Message-Id: <1547141652-8660-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

On the hi3660 hardware there are two (at least) DMA controllers,
the DMA-P (Peripherial DMA) and the DMA-A (Audio DMA). The
two blocks are similar, but have some slight differences. This
resulted in the vendor implementing two separate drivers, which
after review, they have been able to condense and re-use the
existing k3dma driver.

Thus, this patch adds support for the new "hisi-pcm-asp-dma-1.0"
compatible string in the binding.

One difference with the DMA-A controller, is that it does not
need to initialize a clock. So we skip this by adding and using
soc data flags.

After above this driver will support both k3 and hisi_asp dma
hardware.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
[jstultz: Reworked to use of_match_data, commit msg improvements]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Reworked to use of_match_data
v3:
* Further rework of the commit message
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

