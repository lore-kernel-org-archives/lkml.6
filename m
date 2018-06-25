Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4E6C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C547256BB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb/iRY/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C547256BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755097AbeFYJ2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:28:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38225 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeFYJ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:27:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so9136151wmf.3;
        Mon, 25 Jun 2018 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQWm49q+VQG4QldyEA43MFoYJbGcwmhy3rCvnd6Er4o=;
        b=jb/iRY/m0mDJmcTe5cb1vunHUmnQwrbVn3p3M7Eiv6pPBguIm2jj5630vmR76AKErv
         KxVuMFMUFnL/UAap9jDiU1UQuhCeVv/5UOVt11Qjl4ssNwsu3elHuIhhidweP3wXpbjJ
         0pKx3OdziQ0ilEW74muANQX6OA/PLv5cv4WkiFfOBlR8RYct7vYO/LW8xvXnIK4zwiCg
         C5y0pnVEz3Bt3bBoO9qFQdho7XnGBd5LjCSHCC+psuzhqOyVx58+/QbmgfFaBJMcDOsw
         vk98e1oOFrjpdnDaIg3KdtrfdzdvhT8dMFk6H0GjqZboONJ4bczrA6rUkeMaheendLDk
         5EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQWm49q+VQG4QldyEA43MFoYJbGcwmhy3rCvnd6Er4o=;
        b=a6VENrnIYwDnwDouDv6Imu8pEdrXkwEarzaR2TGIe+hSq1vfd6t3sj3LDfkGF/Kfhw
         uQxYw44wnBhTxgYadBpx6PoNUyxKjVHGH92KFT23odw5H6LAWZ7njTkg36xEOUbbmhb8
         QV+V8dQufxD+IhJ80noOdy1L1w+8SZhEq+vEu45LN1/f5ExdiFsq4oFMbP+OG5hGN8Ah
         n5XC6MNxGanSyFLHrqV7IgcfHKwjN3lH2Eu0Ca6s4wxZk0PFejyGLy0wkkh4xEZl1a9w
         PK76m95Vd3+p3GJnpuX8fh3wnuIc/Uw3lmSecAiH8471naJSlWH80yp2FU8wjNjX6rCu
         OChg==
X-Gm-Message-State: APt69E2C0bEG+hYFfmHRY+3FZJXdssq7wzfxRUqGmDMDknDe/BzaCT95
        igxcCfEzyUM2PQqqijTHjPw=
X-Google-Smtp-Source: AAOMgpcd2BRxORtSgLoZGjn6ICIR9iItU1bVT9eS4g7vFGG/MqyMpRobaYk+ispRb8syM3rTQt7DjA==
X-Received: by 2002:a1c:8d15:: with SMTP id p21-v6mr310217wmd.145.1529918871920;
        Mon, 25 Jun 2018 02:27:51 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id v2-v6sm15638779wrm.84.2018.06.25.02.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:27:51 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v3 4/5] dmaengine: xilinx_dma: autodetect whether the HW supports scatter-gather
Date:   Mon, 25 Jun 2018 11:27:23 +0200
Message-Id: <20180625092724.22164-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625092724.22164-1-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXIDMA and CDMA HW can be either direct-access or scatter-gather
version. These are SW incompatible.

The driver can handle both version: a DT property was used to
tell the driver whether to assume the HW is is scatter-gather mode.

This patch makes the driver to autodetect this information. The DT
property is not required anymore.

No changes for VDMA.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
	- autodetect only in !VDMA case
Changes in v3:
	- cc DT maintainers/ML
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 7f0ab904b749..43fcc71ff287 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -86,6 +86,7 @@
 #define XILINX_DMA_DMASR_DMA_DEC_ERR		BIT(6)
 #define XILINX_DMA_DMASR_DMA_SLAVE_ERR		BIT(5)
 #define XILINX_DMA_DMASR_DMA_INT_ERR		BIT(4)
+#define XILINX_DMA_DMASR_SG_MASK		BIT(3)
 #define XILINX_DMA_DMASR_IDLE			BIT(1)
 #define XILINX_DMA_DMASR_HALTED		BIT(0)
 #define XILINX_DMA_DMASR_DELAY_MASK		GENMASK(31, 24)
@@ -406,7 +407,6 @@ struct xilinx_dma_config {
  * @dev: Device Structure
  * @common: DMA device structure
  * @chan: Driver specific DMA channel
- * @has_sg: Specifies whether Scatter-Gather is present or not
  * @mcdma: Specifies whether Multi-Channel is present or not
  * @flush_on_fsync: Flush on frame sync
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
@@ -426,7 +426,6 @@ struct xilinx_dma_device {
 	struct device *dev;
 	struct dma_device common;
 	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
-	bool has_sg;
 	bool mcdma;
 	u32 flush_on_fsync;
 	bool ext_addr;
@@ -2393,7 +2392,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	chan->dev = xdev->dev;
 	chan->xdev = xdev;
-	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
 	chan->ext_addr = xdev->ext_addr;
 	/* This variable ensures that descriptors are not
@@ -2486,6 +2484,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->stop_transfer = xilinx_dma_stop_transfer;
 	}
 
+	/* check if SG is enabled (only for AXIDMA and CDMA) */
+	if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
+		if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
+		    XILINX_DMA_DMASR_SG_MASK)
+			chan->has_sg = true;
+		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
+			chan->has_sg ? "enabled" : "disabled");
+	}
+
 	/* Initialize the tasklet */
 	tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
 			(unsigned long)chan);
@@ -2624,7 +2631,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
2.17.1

