Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE37DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D1820684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D1820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeI1PA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:00:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44737 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbeI1PA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:00:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8S8XuUF001372;
        Fri, 28 Sep 2018 10:37:10 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mncmev279-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 10:37:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 69F4831;
        Fri, 28 Sep 2018 08:37:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E7FF2632;
        Fri, 28 Sep 2018 08:37:09 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 28 Sep 2018 10:37:07
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 5/7] dmaengine: stm32-mdma: Add DMA/MDMA chaining support
Date:   Fri, 28 Sep 2018 10:36:32 +0200
Message-ID: <1538123794-17085-6-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
References: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

This patch adds support for M2M transfer triggered by STM32 DMA in order to
transfer data from/to SRAM to/from DDR.

Normally, this mode should not be needed as transferring data from/to DDR
is supported by the STM32 DMA.
However, the STM32 DMA don't have the ability to generate burst transfer
on the DDR as it only embeds only a 4-word FIFO although the minimal burst
length on the DDR is 8 words.
Due to this constraint, the STM32 DMA transfers data from/to DDR in a
single way and could lead to pollute the DDR.
To avoid this, we have to use SRAM for all transfers where STM32 DMA is
involved.

So, we need to add an intermediate M2M transfer handled by the MDMA, which
has the ability to generate burst transfer on the DDR, to copy data
from/to SRAM to/from DDR as described below:
For M2D: DDR --> MDMA --> SRAM --> DMA  --> IP
For D2M: IP  --> DMA  --> SRAM --> MDMA --> DDR

This intermediate transfer is triggered by the STM32 DMA when his transfer
complete flag is set. In that way, we are able to build a DMA/MDMA
chaining transfer completely handled by HW.

This patch clearly adds support for M2M transfer triggered by HW.
This mode is not really available in dmaengine framework as normally M2M
transfers are triggered by SW.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-mdma.c | 131 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 06dd172..6b6e63b 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -211,6 +211,8 @@
 #define STM32_MDMA_MAX_BURST		128
 #define STM32_MDMA_VERY_HIGH_PRIORITY	0x11
 
+#define STM32_DMA_SRAM_GRANULARITY	PAGE_SIZE
+
 enum stm32_mdma_trigger_mode {
 	STM32_MDMA_BUFFER,
 	STM32_MDMA_BLOCK,
@@ -237,6 +239,7 @@ struct stm32_mdma_chan_config {
 	u32 transfer_config;
 	u32 mask_addr;
 	u32 mask_data;
+	bool m2m_hw;
 };
 
 struct stm32_mdma_hwdesc {
@@ -262,6 +265,7 @@ struct stm32_mdma_desc {
 	u32 ccr;
 	bool cyclic;
 	u32 count;
+	enum dma_transfer_direction dir;
 	struct stm32_mdma_desc_node node[];
 };
 
@@ -577,13 +581,25 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 		dst_addr = chan->dma_config.dst_addr;
 
 		/* Set device data size */
+		if (chan_config->m2m_hw)
+			dst_addr_width =
+			stm32_mdma_get_max_width(dst_addr, buf_len,
+						 STM32_MDMA_MAX_BUF_LEN);
+
 		dst_bus_width = stm32_mdma_get_width(chan, dst_addr_width);
 		if (dst_bus_width < 0)
 			return dst_bus_width;
 		ctcr &= ~STM32_MDMA_CTCR_DSIZE_MASK;
 		ctcr |= STM32_MDMA_CTCR_DSIZE(dst_bus_width);
+		if (chan_config->m2m_hw) {
+			ctcr &= ~STM32_MDMA_CTCR_DINCOS_MASK;
+			ctcr |= STM32_MDMA_CTCR_DINCOS(dst_bus_width);
+		}
 
 		/* Set device burst value */
+		if (chan_config->m2m_hw)
+			dst_maxburst = STM32_MDMA_MAX_BUF_LEN / dst_addr_width;
+
 		dst_best_burst = stm32_mdma_get_best_burst(buf_len, tlen,
 							   dst_maxburst,
 							   dst_addr_width);
@@ -626,13 +642,25 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 		src_addr = chan->dma_config.src_addr;
 
 		/* Set device data size */
+		if (chan_config->m2m_hw)
+			src_addr_width =
+			stm32_mdma_get_max_width(src_addr, buf_len,
+						 STM32_MDMA_MAX_BUF_LEN);
+
 		src_bus_width = stm32_mdma_get_width(chan, src_addr_width);
 		if (src_bus_width < 0)
 			return src_bus_width;
 		ctcr &= ~STM32_MDMA_CTCR_SSIZE_MASK;
 		ctcr |= STM32_MDMA_CTCR_SSIZE(src_bus_width);
+		if (chan_config->m2m_hw) {
+			ctcr &= ~STM32_MDMA_CTCR_SINCOS_MASK;
+			ctcr |= STM32_MDMA_CTCR_SINCOS(src_bus_width);
+		}
 
 		/* Set device burst value */
+		if (chan_config->m2m_hw)
+			src_maxburst = STM32_MDMA_MAX_BUF_LEN / src_addr_width;
+
 		src_best_burst = stm32_mdma_get_best_burst(buf_len, tlen,
 							   src_maxburst,
 							   src_addr_width);
@@ -740,6 +768,7 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct dma_slave_config *dma_config = &chan->dma_config;
+	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct scatterlist *sg;
 	dma_addr_t src_addr, dst_addr;
 	u32 ccr, ctcr, ctbr;
@@ -762,6 +791,8 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 		} else {
 			src_addr = dma_config->src_addr;
 			dst_addr = sg_dma_address(sg);
+			if (chan_config->m2m_hw)
+				src_addr += ((i & 1) ? sg_dma_len(sg) : 0);
 			ret = stm32_mdma_set_xfer_param(chan, direction, &ccr,
 							&ctcr, &ctbr, dst_addr,
 							sg_dma_len(sg));
@@ -780,8 +811,6 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 	/* Enable interrupts */
 	ccr &= ~STM32_MDMA_CCR_IRQ_MASK;
 	ccr |= STM32_MDMA_CCR_TEIE | STM32_MDMA_CCR_CTCIE;
-	if (sg_len > 1)
-		ccr |= STM32_MDMA_CCR_BTIE;
 	desc->ccr = ccr;
 
 	return 0;
@@ -793,7 +822,9 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
 			 unsigned long flags, void *context)
 {
 	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
+	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct stm32_mdma_desc *desc;
+	struct stm32_mdma_hwdesc *hwdesc;
 	int i, ret;
 
 	/*
@@ -815,6 +846,20 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
 	if (ret < 0)
 		goto xfer_setup_err;
 
+	/*
+	 * In case of M2M HW transfer triggered by STM32 DMA, we do not have to
+	 * clear the transfer complete flag by hardware in order to let the
+	 * CPU rearm the DMA with the next sg element and update some data in
+	 * dmaengine framework
+	 */
+	if (chan_config->m2m_hw && direction == DMA_MEM_TO_DEV) {
+		for (i = 0; i < sg_len; i++) {
+			hwdesc = desc->node[i].hwdesc;
+			hwdesc->cmar = 0;
+			hwdesc->cmdr = 0;
+		}
+	}
+
 	desc->cyclic = false;
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
@@ -836,9 +881,10 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
 	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct dma_slave_config *dma_config = &chan->dma_config;
+	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct stm32_mdma_desc *desc;
 	dma_addr_t src_addr, dst_addr;
-	u32 ccr, ctcr, ctbr, count;
+	u32 ccr, ctcr, ctbr, count, offset;
 	int i, ret;
 
 	/*
@@ -892,12 +938,29 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
 	desc->ccr = ccr;
 
 	/* Configure hwdesc list */
+	offset =  ALIGN(period_len, STM32_DMA_SRAM_GRANULARITY);
 	for (i = 0; i < count; i++) {
 		if (direction == DMA_MEM_TO_DEV) {
+			/*
+			 * When the DMA is configured in double buffer mode,
+			 * the MDMA has to use 2 destination buffers to be
+			 * compliant with this mode.
+			 */
+			if (chan_config->m2m_hw && count > 1 && i % 2)
+				dst_addr = dma_config->dst_addr + offset;
+			else
+				dst_addr = dma_config->dst_addr;
 			src_addr = buf_addr + i * period_len;
-			dst_addr = dma_config->dst_addr;
 		} else {
-			src_addr = dma_config->src_addr;
+			/*
+			 * When the DMA is configured in double buffer mode,
+			 * the MDMA has to use 2 destination buffers to be
+			 * compliant with this mode.
+			 */
+			if (chan_config->m2m_hw && count > 1 && i % 2)
+				src_addr = dma_config->src_addr + offset;
+			else
+				src_addr = dma_config->src_addr;
 			dst_addr = buf_addr + i * period_len;
 		}
 
@@ -907,6 +970,7 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
 	}
 
 	desc->cyclic = true;
+	desc->dir = direction;
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 
@@ -1287,14 +1351,28 @@ static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct stm32_mdma_hwdesc *hwdesc = desc->node[0].hwdesc;
-	u32 cbndtr, residue, modulo, burst_size;
+	u32 residue = 0;
+	u32 modulo, burst_size;
+	dma_addr_t next_clar;
+	u32 cbndtr;
 	int i;
 
-	residue = 0;
-	for (i = curr_hwdesc + 1; i < desc->count; i++) {
+	/*
+	 * Get the residue of pending descriptors
+	 */
+	/* Get the next hw descriptor to process from current transfer */
+	next_clar = stm32_mdma_read(dmadev, STM32_MDMA_CLAR(chan->id));
+	for (i = desc->count - 1; i >= 0; i--) {
 		hwdesc = desc->node[i].hwdesc;
+
+		if (hwdesc->clar == next_clar)
+			break;/* Current transfer found, stop cumulating */
+
+		/* Cumulate residue of unprocessed hw descriptors */
 		residue += STM32_MDMA_CBNDTR_BNDT(hwdesc->cbndtr);
 	}
+
+	/* Read & cumulate the residue of the current transfer */
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
 	residue += cbndtr & STM32_MDMA_CBNDTR_BNDT_MASK;
 
@@ -1314,24 +1392,39 @@ static enum dma_status stm32_mdma_tx_status(struct dma_chan *c,
 					    struct dma_tx_state *state)
 {
 	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
+	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct virt_dma_desc *vdesc;
 	enum dma_status status;
 	unsigned long flags;
 	u32 residue = 0;
 
 	status = dma_cookie_status(c, cookie, state);
-	if ((status == DMA_COMPLETE) || (!state))
+	if (status == DMA_COMPLETE || !state)
 		return status;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
 	vdesc = vchan_find_desc(&chan->vchan, cookie);
-	if (chan->desc && cookie == chan->desc->vdesc.tx.cookie)
-		residue = stm32_mdma_desc_residue(chan, chan->desc,
-						  chan->curr_hwdesc);
-	else if (vdesc)
+	if (chan->desc && cookie == chan->desc->vdesc.tx.cookie) {
+		/*
+		 * In case of M2D transfer triggered by STM32 DMA, the MDMA has
+		 * always one period in advance in cyclic mode. So, we have to
+		 * add 1 period of data to return the good residue to the
+		 * client
+		 */
+		if (chan_config->m2m_hw && chan->desc->dir == DMA_MEM_TO_DEV &&
+		    chan->curr_hwdesc > 1)
+			residue =
+				stm32_mdma_desc_residue(chan, chan->desc,
+							chan->curr_hwdesc - 1);
+		else
+			residue = stm32_mdma_desc_residue(chan, chan->desc,
+							  chan->curr_hwdesc);
+	} else if (vdesc) {
 		residue = stm32_mdma_desc_residue(chan,
 						  to_stm32_mdma_desc(vdesc), 0);
+	}
+
 	dma_set_residue(state, residue);
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
@@ -1498,7 +1591,7 @@ static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 	struct dma_chan *c;
 	struct stm32_mdma_chan_config config;
 
-	if (dma_spec->args_count < 5) {
+	if (dma_spec->args_count < 6) {
 		dev_err(mdma2dev(dmadev), "Bad number of args\n");
 		return NULL;
 	}
@@ -1508,6 +1601,7 @@ static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 	config.transfer_config = dma_spec->args[2];
 	config.mask_addr = dma_spec->args[3];
 	config.mask_data = dma_spec->args[4];
+	config.m2m_hw = dma_spec->args[5];
 
 	if (config.request >= dmadev->nr_requests) {
 		dev_err(mdma2dev(dmadev), "Bad request line\n");
@@ -1646,19 +1740,20 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	dmadev->irq = platform_get_irq(pdev, 0);
 	if (dmadev->irq < 0) {
 		dev_err(&pdev->dev, "failed to get IRQ\n");
-		return dmadev->irq;
+		ret = dmadev->irq;
+		goto clk_free;
 	}
 
 	ret = devm_request_irq(&pdev->dev, dmadev->irq, stm32_mdma_irq_handler,
 			       0, dev_name(&pdev->dev), dmadev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		return ret;
+		goto clk_free;
 	}
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto clk_free;
 
 	ret = of_dma_controller_register(of_node, stm32_mdma_of_xlate, dmadev);
 	if (ret < 0) {
@@ -1675,6 +1770,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 
 err_unregister:
 	dma_async_device_unregister(dd);
+clk_free:
+	clk_disable_unprepare(dmadev->clk);
 
 	return ret;
 }
-- 
2.7.4

