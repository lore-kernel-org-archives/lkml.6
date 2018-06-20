Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A067C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B00208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzoWc6a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B00208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeFTIkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:40:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55058 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeFTIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so4537917wmf.4;
        Wed, 20 Jun 2018 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ikExev5A2WQ5EKd5UIu+P7INa93GJEaKn/9DOv1483o=;
        b=KzoWc6a7h5Jb5tzWNiZq1K+e6B7e3bVrCKlMx/3W7V6zpu9k+b3mzrxfJv1Ml36c4W
         8IfWFBpPVU9yu+Jyzb8hOczcS+UpskHvsms+4lz28wdH2HPZ14Qw9bQaKJXkG1sLNwZs
         57cjD4MnyEKE3N7Wz+80uIynE7FquLSVBeJVhcNmWA1nEsiEZTIoyb5LTWqG+aTxKY3m
         D9YJxUwJic4oo+TZV57d+tPzfKpl2UScPMvxClmelsMJOj+yi0EpAWR5edCJWkbcYszp
         vFd//RuaS3rr0vtxOXXDFdNjFsTVhDOTNGK3jhT+P/H/RXR5S9w/OusHCL1QnF/dOXbU
         ymKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ikExev5A2WQ5EKd5UIu+P7INa93GJEaKn/9DOv1483o=;
        b=d3xdYo2oCSez/+2oc0TUgparrEbGPT93zWkZKvCgRtyHmVlehjyz9OwQnMtm5tCNAo
         T+yIp0vWYTvQ82fgJ/wh5P5vDzaqWFuFdAHDl4Xm8fC+ba5AYZsjLh1dpqrl1EeSG2N/
         CNnXWX90FN2vYDjH5PsyTDpS+QZjgS7R+qo6/q9JdpsS1qQ0JLlhzhO0md5YwxA6BhnV
         Wcf2Js9tBYe+ZbPHnFzB/05a1Z3GKGLLm26chkjwb9OFTD6BlQRtG7SEEETWuyZdhxsN
         R10i9cKhCzwKhFjoAJPr/zztejv2OeUR3EktTCQtyPMDRpttfYonFfgReT3PttgB0jq/
         3caw==
X-Gm-Message-State: APt69E2B6/6XVsVA3xLoQAOlOr/VZNjjGfz6kWnMu1WU2aUdaMdAQ1WZ
        H/j7Wn0n0wskI+YA9K2k6o0=
X-Google-Smtp-Source: ADUXVKKtdiA7CcW5m0L3q/TjLdTh9yUiLpEg+2TXSfP7WuY+DCKQ8VYMl8h4nQ0uBXXJcOycJSA7Qg==
X-Received: by 2002:a1c:ee06:: with SMTP id m6-v6mr990881wmh.70.1529483832329;
        Wed, 20 Jun 2018 01:37:12 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id f24-v6sm1615933wmc.0.2018.06.20.01.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:37:11 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 4/6] dmaengine: xilinx_dma: fix hardcoded maximum transfer length may be wrong
Date:   Wed, 20 Jun 2018 10:36:51 +0200
Message-Id: <20180620083653.17010-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum transfer length is currently hardcoded in the driver, but
it depends by how the soft-IP is actually configured.

This seems to affect also max possible length for SG transfers.

This patch introduce a new DT property in order to operate with proper
maximum transfer length.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cf12f7147f07..bdbc8ba9092a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -439,6 +439,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	int max_transfer;
 };
 
 /* Macros */
@@ -1806,8 +1807,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * the next chuck start address is aligned
 			 */
 			copy = sg_dma_len(sg) - sg_used;
-			if (copy > XILINX_DMA_MAX_TRANS_LEN)
-				copy = XILINX_DMA_MAX_TRANS_LEN &
+			if (copy > chan->xdev->max_transfer)
+				copy = chan->xdev->max_transfer &
 					chan->copy_mask;
 
 			hw = &segment->hw;
@@ -1914,8 +1915,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * the next chuck start address is aligned
 			 */
 			copy = period_len - sg_used;
-			if (copy > XILINX_DMA_MAX_TRANS_LEN)
-				copy = XILINX_DMA_MAX_TRANS_LEN &
+			if (copy > chan->xdev->max_transfer)
+				copy = chan->xdev->max_transfer &
 					chan->copy_mask;
 
 			hw = &segment->hw;
@@ -2594,7 +2595,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct resource *io;
-	u32 num_frames, addr_width;
+	u32 num_frames, addr_width, lenreg_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -2625,9 +2626,18 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
+		err = of_property_read_u32(node, "xlnx,lengthregwidth",
+					&lenreg_width);
+		if (err < 0) {
+			dev_err(xdev->dev,
+				"missing xlnx,lengthregwidth property\n");
+			return err;
+		}
+		xdev->max_transfer = GENMASK(lenreg_width - 1, 0);
+	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
-- 
2.17.1

