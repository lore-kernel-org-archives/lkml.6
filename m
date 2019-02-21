Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8F2214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWXXDDAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfBUFfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:35:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42874 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUFfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:35:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so13177255pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=I+lwgjMPx4qaNrrdmqhxKjqvoWmsUeMIRo3rHXe/pVU=;
        b=yWXXDDAu70UKxZqDRXkfkvj8zkHJjsSWLqih2dV2eqrb9t4B6Nfo6+4SmzO9yqX8gE
         ejGKc4UoajokSgrctdkTsydBargA/EXcYhOo1d6Cq/qr7neYJ9Ml3rfkgucHkMOSxAqn
         kcurzbVHgQNmRXY/LkmX+LKyEdWiHR7MqaO3FEPOWlnAUkG6VX4S8Tt853p2Wq8LckEF
         klDrJapFdcLfP35Ksoyv4N/wvQHSMiwxt1bKllkUe97xZGO/THEf5XlD3+3/sBeADxhx
         3UCCdHfXVvuRN4fPBUkTfg8nskfBxPpN7Y7VzWKABHMdPJ9npekq7BBq6QRTDsS/dowy
         FMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=I+lwgjMPx4qaNrrdmqhxKjqvoWmsUeMIRo3rHXe/pVU=;
        b=LX+WrTFV9OdTRJjHBKAJgXtWkyRCzZ0BusmDIyaerSEWmiNQ487C6PvsCpL6GFHQUx
         RlSMgRKVMj2O753LC+m2G3x3qaferes8ZeV+w2od3xjac8PqCeJ2h5QmPg52HIF0qQEM
         WkaSIUgL7l6nClDWp0QTqEKwgniKa2jw/II5k3OuV7jSqeCZonE46cA3pOt2B20EgE/A
         jN54Rz4Khpa509zUv0QSTBRBPVFUaI8+pvf9yI04dFeOXaslhpUXCWpWXAvcbRRzgdpJ
         bocF33mXObGkwZB0un6VUL91ABTpi6vk+aEthKz1yOS56zJwUMb3d3xAZNvQLWTON96c
         v9sg==
X-Gm-Message-State: AHQUAuZnWRF0z6ExIj28uQrifiwyf+l1gEJ9D3UGRmt7GA+FrT/7EON+
        Wm2kGSdNmAjdmP7nd5D2VTk1Ig==
X-Google-Smtp-Source: AHgI3IYxTaTyO21PUP1m+aWr1/zyddwSRtgfr165WFwpvMwxC8pjOvYghKA4jtw4kitRZoG0N4HNaQ==
X-Received: by 2002:a65:6553:: with SMTP id a19mr33145199pgw.267.1550727313507;
        Wed, 20 Feb 2019 21:35:13 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l10sm35001421pfc.90.2019.02.20.21.35.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 21:35:12 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        arnd@arndb.de
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        eric.long@unisoc.com, broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 2/2] dmaengine: sprd: Change channel id to slave id for DMA cell specifier
Date:   Thu, 21 Feb 2019 13:34:41 +0800
Message-Id: <c37545bd4e98f2811ee3589baae9378349bdb0a6.1550719757.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
References: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
In-Reply-To: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
References: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will describe the slave id in DMA cell specifier instead of DMA channel
id, thus we should save the slave id from DMA engine translation function,
and remove the channel id validation.

Meanwhile we do not need set default slave id in sprd_dma_alloc_chan_resources(),
remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Remove channel id from DT.
---
 drivers/dma/sprd-dma.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e2f0167..48431e2 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
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
@@ -1021,13 +1013,10 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
 static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
-	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
-	u32 req = *(u32 *)param;
+	u32 slave_id = *(u32 *)param;
 
-	if (req < sdev->total_chns)
-		return req == schan->chn_num + 1;
-	else
-		return false;
+	schan->dev_id = slave_id;
+	return true;
 }
 
 static int sprd_dma_probe(struct platform_device *pdev)
-- 
1.7.9.5

