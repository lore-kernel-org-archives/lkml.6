Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB9C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7F720843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xdxj8i/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7F720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeIAUzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:55:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42802 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeIAUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:55:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so6784364pgp.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bvY3pqS4jsXLOYqngLdOBcTmjj1spRz2QJT+oPegniQ=;
        b=Xdxj8i/m7l4l+ZgCRi2MXrgn6NgFARZiBB+qb/HOWGMYIgPgDDtSwc8LYhznxjh+5w
         x3FTsxAp0LgERnzC8Uwi/LfYYU6jPs43dBkfO/Y86ufk2qdOZZ6WqpNvtIvGFj1XN2O2
         p0FWZ+wODqni/yPy2Ecp6ivFpeGJsRzzZQVdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bvY3pqS4jsXLOYqngLdOBcTmjj1spRz2QJT+oPegniQ=;
        b=c8crMyezQwfQaasyiJ1wLi6YUQ3/F81n4o9izq19oI1Fejh2hioWMDORf3KYoKtzTI
         lLNpWhsQ/6m3cwgZnTvOJd+kxqCsRxGOpC07CqFy3lwY3Mp5vweAUBPUp58lFGXJLgCV
         ijs5NECrmPdjfEI9XTWrTVGsy0TJ3jachivQzqeJli+nAy0KyDr/K0wZXUsleXfb09Iu
         Em+QQ7YsrVRkJb7546qJg9F7I2h9Bm7gtNG2JzVMmo1Q8dSNt68TNCFUvansIRMWXFlX
         +NNY6IJVonMP8VIO04rwBw7POrSHQ19rPAMw/Ymnd6pwOayAd7OWUuGDFvZlsIa1mVk0
         wgUA==
X-Gm-Message-State: APzg51DZT0FWp2sr4afEkjOc8ZXCqvfDPBuE7GrbcXq4COXIXG6F3N4H
        Tdb8vmhSsjk8sFpcilWoJdeF
X-Google-Smtp-Source: ANB0Vdabol9fVUhfiqc+l/PS804wuKRdL7jTmK8urgaODRrnQ4WnxaUMIc96mBX1qbnp+Yw4IEW9nw==
X-Received: by 2002:aa7:8087:: with SMTP id v7-v6mr21310252pff.38.1535820179954;
        Sat, 01 Sep 2018 09:42:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:724a:4d47:6510:16:9ba1:39a3])
        by smtp.gmail.com with ESMTPSA id y7-v6sm23763595pff.181.2018.09.01.09.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 09:42:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] dmaengine: Add Slave and Cyclic mode support for Actions Semi Owl S900 SoC
Date:   Sat,  1 Sep 2018 22:12:14 +0530
Message-Id: <20180901164215.3683-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Slave and Cyclic mode support for Actions Semi Owl S900 SoC. The slave
mode supports bus width of 4 bytes common for all peripherals and 1 byte
specific for UART.

The cyclic mode supports only block mode transfer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/owl-dma.c | 273 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 266 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 7812a6338acd..7f7b3e76bcf7 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_dma.h>
 #include <linux/slab.h>
 #include "virt-dma.h"
 
@@ -165,6 +166,7 @@ struct owl_dma_lli {
 struct owl_dma_txd {
 	struct virt_dma_desc	vd;
 	struct list_head	lli_list;
+	bool			cyclic;
 };
 
 /**
@@ -191,6 +193,8 @@ struct owl_dma_vchan {
 	struct virt_dma_chan	vc;
 	struct owl_dma_pchan	*pchan;
 	struct owl_dma_txd	*txd;
+	struct dma_slave_config cfg;
+	u8			drq;
 };
 
 /**
@@ -336,9 +340,11 @@ static struct owl_dma_lli *owl_dma_alloc_lli(struct owl_dma *od)
 
 static struct owl_dma_lli *owl_dma_add_lli(struct owl_dma_txd *txd,
 					   struct owl_dma_lli *prev,
-					   struct owl_dma_lli *next)
+					   struct owl_dma_lli *next,
+					   bool is_cyclic)
 {
-	list_add_tail(&next->node, &txd->lli_list);
+	if (!is_cyclic)
+		list_add_tail(&next->node, &txd->lli_list);
 
 	if (prev) {
 		prev->hw.next_lli = next->phys;
@@ -351,7 +357,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct owl_dma_txd *txd,
 static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 				  struct owl_dma_lli *lli,
 				  dma_addr_t src, dma_addr_t dst,
-				  u32 len, enum dma_transfer_direction dir)
+				  u32 len, enum dma_transfer_direction dir,
+				  struct dma_slave_config *sconfig,
+				  bool is_cyclic)
 {
 	struct owl_dma_lli_hw *hw = &lli->hw;
 	u32 mode;
@@ -364,6 +372,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 			OWL_DMA_MODE_DT_DCU | OWL_DMA_MODE_SAM_INC |
 			OWL_DMA_MODE_DAM_INC;
 
+		break;
+	case DMA_MEM_TO_DEV:
+		mode |= OWL_DMA_MODE_TS(vchan->drq)
+			| OWL_DMA_MODE_ST_DCU | OWL_DMA_MODE_DT_DEV
+			| OWL_DMA_MODE_SAM_INC | OWL_DMA_MODE_DAM_CONST;
+
+		/* Handle bus width for UART */
+		if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_1_BYTE)
+			mode |= OWL_DMA_MODE_NDDBW_8BIT;
+
+		break;
+	case DMA_DEV_TO_MEM:
+		 mode |= OWL_DMA_MODE_TS(vchan->drq)
+			| OWL_DMA_MODE_ST_DEV | OWL_DMA_MODE_DT_DCU
+			| OWL_DMA_MODE_SAM_CONST | OWL_DMA_MODE_DAM_INC;
+
+		/* Handle bus width for UART */
+		if (sconfig->src_addr_width == DMA_SLAVE_BUSWIDTH_1_BYTE)
+			mode |= OWL_DMA_MODE_NDDBW_8BIT;
+
 		break;
 	default:
 		return -EINVAL;
@@ -381,7 +409,10 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 				 OWL_DMA_LLC_SAV_LOAD_NEXT |
 				 OWL_DMA_LLC_DAV_LOAD_NEXT);
 
-	hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
+	if (is_cyclic)
+		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
+	else
+		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
 
 	return 0;
 }
@@ -443,6 +474,16 @@ static void owl_dma_terminate_pchan(struct owl_dma *od,
 	spin_unlock_irqrestore(&od->lock, flags);
 }
 
+static void owl_dma_pause_pchan(struct owl_dma_pchan *pchan)
+{
+	pchan_writel(pchan, 1, OWL_DMAX_PAUSE);
+}
+
+static void owl_dma_resume_pchan(struct owl_dma_pchan *pchan)
+{
+	pchan_writel(pchan, 0, OWL_DMAX_PAUSE);
+}
+
 static int owl_dma_start_next_txd(struct owl_dma_vchan *vchan)
 {
 	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
@@ -464,7 +505,10 @@ static int owl_dma_start_next_txd(struct owl_dma_vchan *vchan)
 	lli = list_first_entry(&txd->lli_list,
 			       struct owl_dma_lli, node);
 
-	int_ctl = OWL_DMA_INTCTL_SUPER_BLOCK;
+	if (txd->cyclic)
+		int_ctl = OWL_DMA_INTCTL_BLOCK;
+	else
+		int_ctl = OWL_DMA_INTCTL_SUPER_BLOCK;
 
 	pchan_writel(pchan, OWL_DMAX_MODE, OWL_DMA_MODE_LME);
 	pchan_writel(pchan, OWL_DMAX_LINKLIST_CTL,
@@ -627,6 +671,54 @@ static int owl_dma_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static int owl_dma_config(struct dma_chan *chan,
+			  struct dma_slave_config *config)
+{
+	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
+
+	/* Reject definitely invalid configurations */
+	if (config->src_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES ||
+	    config->dst_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES)
+		return -EINVAL;
+
+	memcpy(&vchan->cfg, config, sizeof(struct dma_slave_config));
+
+	return 0;
+}
+
+static int owl_dma_pause(struct dma_chan *chan)
+{
+	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vchan->vc.lock, flags);
+
+	owl_dma_pause_pchan(vchan->pchan);
+
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+
+	return 0;
+}
+
+static int owl_dma_resume(struct dma_chan *chan)
+{
+	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
+	unsigned long flags;
+
+	if (!vchan->pchan && !vchan->txd)
+		return 0;
+
+	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &vchan->vc);
+
+	spin_lock_irqsave(&vchan->vc.lock, flags);
+
+	owl_dma_resume_pchan(vchan->pchan);
+
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+
+	return 0;
+}
+
 static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
 {
 	struct owl_dma_pchan *pchan;
@@ -754,13 +846,14 @@ static struct dma_async_tx_descriptor
 		bytes = min_t(size_t, (len - offset), OWL_DMA_FRAME_MAX_LENGTH);
 
 		ret = owl_dma_cfg_lli(vchan, lli, src + offset, dst + offset,
-				      bytes, DMA_MEM_TO_MEM);
+				      bytes, DMA_MEM_TO_MEM,
+				      &vchan->cfg, txd->cyclic);
 		if (ret) {
 			dev_warn(chan2dev(chan), "failed to config lli\n");
 			goto err_txd_free;
 		}
 
-		prev = owl_dma_add_lli(txd, prev, lli);
+		prev = owl_dma_add_lli(txd, prev, lli, false);
 	}
 
 	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
@@ -770,6 +863,133 @@ static struct dma_async_tx_descriptor
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor
+		*owl_dma_prep_slave_sg(struct dma_chan *chan,
+				       struct scatterlist *sgl,
+				       unsigned int sg_len,
+				       enum dma_transfer_direction dir,
+				       unsigned long flags, void *context)
+{
+	struct owl_dma *od = to_owl_dma(chan->device);
+	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
+	struct dma_slave_config *sconfig = &vchan->cfg;
+	struct owl_dma_txd *txd;
+	struct owl_dma_lli *lli, *prev = NULL;
+	struct scatterlist *sg;
+	dma_addr_t addr, src = 0, dst = 0;
+	size_t len;
+	int ret, i;
+
+	txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
+	if (!txd)
+		return NULL;
+
+	INIT_LIST_HEAD(&txd->lli_list);
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		addr = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+
+		if (len > OWL_DMA_FRAME_MAX_LENGTH) {
+			dev_err(od->dma.dev,
+				"frame length exceeds max supported length");
+			goto err_txd_free;
+		}
+
+		lli = owl_dma_alloc_lli(od);
+		if (!lli) {
+			dev_err(chan2dev(chan), "failed to allocate lli");
+			goto err_txd_free;
+		}
+
+		if (dir == DMA_MEM_TO_DEV) {
+			src = addr;
+			dst = sconfig->dst_addr;
+		} else {
+			src = sconfig->src_addr;
+			dst = addr;
+		}
+
+		ret = owl_dma_cfg_lli(vchan, lli, src, dst, len, dir, sconfig,
+				      txd->cyclic);
+		if (ret) {
+			dev_warn(chan2dev(chan), "failed to config lli");
+			goto err_txd_free;
+		}
+
+		prev = owl_dma_add_lli(txd, prev, lli, false);
+	}
+
+	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
+
+err_txd_free:
+	owl_dma_free_txd(od, txd);
+
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor
+		*owl_prep_dma_cyclic(struct dma_chan *chan,
+				     dma_addr_t buf_addr, size_t buf_len,
+				     size_t period_len,
+				     enum dma_transfer_direction dir,
+				     unsigned long flags)
+{
+	struct owl_dma *od = to_owl_dma(chan->device);
+	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
+	struct dma_slave_config *sconfig = &vchan->cfg;
+	struct owl_dma_txd *txd;
+	struct owl_dma_lli *lli, *prev = NULL, *first = NULL;
+	dma_addr_t src = 0, dst = 0;
+	unsigned int periods = buf_len / period_len;
+	int ret, i;
+
+	txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
+	if (!txd)
+		return NULL;
+
+	INIT_LIST_HEAD(&txd->lli_list);
+	txd->cyclic = true;
+
+	for (i = 0; i < periods; i++) {
+		lli = owl_dma_alloc_lli(od);
+		if (!lli) {
+			dev_warn(chan2dev(chan), "failed to allocate lli");
+			goto err_txd_free;
+		}
+
+		if (dir == DMA_MEM_TO_DEV) {
+			src = buf_addr + (period_len * i);
+			dst = sconfig->dst_addr;
+		} else if (dir == DMA_DEV_TO_MEM) {
+			src = sconfig->src_addr;
+			dst = buf_addr + (period_len * i);
+		}
+
+		ret = owl_dma_cfg_lli(vchan, lli, src, dst, period_len,
+				      dir, sconfig, txd->cyclic);
+		if (ret) {
+			dev_warn(chan2dev(chan), "failed to config lli");
+			goto err_txd_free;
+		}
+
+		if (!first)
+			first = lli;
+
+		prev = owl_dma_add_lli(txd, prev, lli, false);
+	}
+
+	/* close the cyclic list */
+	owl_dma_add_lli(txd, prev, first, true);
+
+	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
+
+err_txd_free:
+	owl_dma_free_txd(od, txd);
+
+	return NULL;
+}
+
 static void owl_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
@@ -790,6 +1010,27 @@ static inline void owl_dma_free(struct owl_dma *od)
 	}
 }
 
+static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	struct owl_dma *od = ofdma->of_dma_data;
+	struct owl_dma_vchan *vchan;
+	struct dma_chan *chan;
+	u8 drq = dma_spec->args[0];
+
+	if (drq > od->nr_vchans)
+		return NULL;
+
+	chan = dma_get_any_slave_channel(&od->dma);
+	if (!chan)
+		return NULL;
+
+	vchan = to_owl_vchan(chan);
+	vchan->drq = drq;
+
+	return chan;
+}
+
 static int owl_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -833,12 +1074,19 @@ static int owl_dma_probe(struct platform_device *pdev)
 	spin_lock_init(&od->lock);
 
 	dma_cap_set(DMA_MEMCPY, od->dma.cap_mask);
+	dma_cap_set(DMA_SLAVE, od->dma.cap_mask);
+	dma_cap_set(DMA_CYCLIC, od->dma.cap_mask);
 
 	od->dma.dev = &pdev->dev;
 	od->dma.device_free_chan_resources = owl_dma_free_chan_resources;
 	od->dma.device_tx_status = owl_dma_tx_status;
 	od->dma.device_issue_pending = owl_dma_issue_pending;
 	od->dma.device_prep_dma_memcpy = owl_dma_prep_memcpy;
+	od->dma.device_prep_slave_sg = owl_dma_prep_slave_sg;
+	od->dma.device_prep_dma_cyclic = owl_prep_dma_cyclic;
+	od->dma.device_config = owl_dma_config;
+	od->dma.device_pause = owl_dma_pause;
+	od->dma.device_resume = owl_dma_resume;
 	od->dma.device_terminate_all = owl_dma_terminate_all;
 	od->dma.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->dma.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
@@ -910,8 +1158,18 @@ static int owl_dma_probe(struct platform_device *pdev)
 		goto err_pool_free;
 	}
 
+	/* Device-tree DMA controller registration */
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 owl_dma_of_xlate, od);
+	if (ret) {
+		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
+		goto err_dma_unregister;
+	}
+
 	return 0;
 
+err_dma_unregister:
+	dma_async_device_unregister(&od->dma);
 err_pool_free:
 	clk_disable_unprepare(od->clk);
 	dma_pool_destroy(od->lli_pool);
@@ -923,6 +1181,7 @@ static int owl_dma_remove(struct platform_device *pdev)
 {
 	struct owl_dma *od = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&od->dma);
 
 	/* Mask all interrupts for this execution environment */
-- 
2.17.1

