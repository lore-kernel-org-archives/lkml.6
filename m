Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02422C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F47217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3KhXxkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfAVNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:21:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34780 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfAVNVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:21:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so11087279pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aThP/Y0UG/Bg6pZXhNtucLsiLRzzJRNdslnI1cWQFgk=;
        b=L3KhXxkKfjsH+L/BnnSqvkjQnyke/EFblv6Xj9LR5HpaDYCG2SW+L1rZPux21lQZOy
         6QlGOs3Fk+PCVOn136Z1R+D+jrRAPLWxAxVmDq5npItzATHgmUGDTEYJ19DG8oRODYc7
         elvbX1t+aPoMNLPjK3juuGj4wpVIYB0zb/f+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aThP/Y0UG/Bg6pZXhNtucLsiLRzzJRNdslnI1cWQFgk=;
        b=N4RpROWaQP97RBuQMRifsiW479Jblj6pPcQUccWXdZQwB50wqjSecb+kPVI+EYMNXP
         ZkjFtp3Fc57jTs850gFqe9UxoZhPPMM2U2THzaaEQ6MuLNr/EzE/hL9m1f+Mr/uJSXO/
         jYalB5Gg3w5o8JEYM7Hwh8mYdNKfNYrO4AmSwD3+WYWJ72iINkdRpe60CnX/xHKHdtcb
         ILOiUzF51xtTwV5WEW746VW7EWBHytUBdgjMbNS3T8+iggT89tc8obaZw/AZLLx3sylv
         5uLt2CqgsseCcim+66uCRFnNTbl6AZU3tYkShsOYRq3hKJ7y5VSubsniHbBt8F0+1Ydf
         TlCg==
X-Gm-Message-State: AJcUukfznQjpims74CwmMjtsC6k1d0sFLqwSwBNGFH4rg31gAbrk+HFt
        eu2KSGDSox4NNjwK+FY364JiGA==
X-Google-Smtp-Source: ALg8bN7IMe1xG7oWLmt59zeewvS276awFJgI0jA50yMh6opTTidFaX//dX+l9hYA9ckDUMNYQQUSgg==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr34406112pfa.76.1548163307648;
        Tue, 22 Jan 2019 05:21:47 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l185sm21609574pfl.54.2019.01.22.05.21.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 05:21:46 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     arnd@arndb.de, olof@lixom.net, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/3] dmaengine: sprd: Add new DMA engine translation function
Date:   Tue, 22 Jan 2019 21:20:52 +0800
Message-Id: <529bc30b34a14bf7849fc852c7cbff34dee47aaa.1548158832.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new DMA engine translation function to get the hardware slave id
of the corresponding DMA engine channel. Meanwhile we do not need
to set default slave id in sprd_dma_alloc_chan_resources(), remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   49 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e2f0167..7d180bb 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -204,9 +204,9 @@ struct sprd_dma_dev {
 	struct sprd_dma_chn	channels[0];
 };
 
-static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param);
-static struct of_dma_filter_info sprd_dma_info = {
-	.filter_fn = sprd_dma_filter_fn,
+struct sprd_dma_filter_param {
+	u32 chn_id;
+	u32 slave_id;
 };
 
 static inline struct sprd_dma_chn *to_sprd_dma_chan(struct dma_chan *c)
@@ -580,15 +580,7 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 
 static int sprd_dma_alloc_chan_resources(struct dma_chan *chan)
 {
-	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
-	int ret;
-
-	ret = pm_runtime_get_sync(chan->device->dev);
-	if (ret < 0)
-		return ret;
-
-	schan->dev_id = SPRD_DMA_SOFTWARE_UID;
-	return 0;
+	return pm_runtime_get_sync(chan->device->dev);
 }
 
 static void sprd_dma_free_chan_resources(struct dma_chan *chan)
@@ -1022,12 +1014,31 @@ static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
-	u32 req = *(u32 *)param;
+	struct sprd_dma_filter_param *sparam = param;
 
-	if (req < sdev->total_chns)
-		return req == schan->chn_num + 1;
-	else
-		return false;
+	if (sparam->chn_id < sdev->total_chns &&
+	    sparam->chn_id == schan->chn_num + 1) {
+		schan->dev_id = sparam->slave_id;
+		return true;
+	}
+
+	return false;
+}
+
+static struct dma_chan *sprd_dma_xlate(struct of_phandle_args *dma_spec,
+				       struct of_dma *ofdma)
+{
+	struct sprd_dma_dev *sdev = ofdma->of_dma_data;
+	dma_cap_mask_t mask = sdev->dma_dev.cap_mask;
+	struct sprd_dma_filter_param param;
+
+	if (dma_spec->args_count != 2)
+		return NULL;
+
+	param.chn_id = dma_spec->args[0];
+	param.slave_id = dma_spec->args[1];
+
+	return dma_request_channel(mask, sprd_dma_filter_fn, &param);
 }
 
 static int sprd_dma_probe(struct platform_device *pdev)
@@ -1133,9 +1144,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 		goto err_register;
 	}
 
-	sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
-	ret = of_dma_controller_register(np, of_dma_simple_xlate,
-					 &sprd_dma_info);
+	ret = of_dma_controller_register(np, sprd_dma_xlate, sdev);
 	if (ret)
 		goto err_of_register;
 
-- 
1.7.9.5

