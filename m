Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED476C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6316221748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6316221748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbeI1PBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:01:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44805 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbeI1PBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:01:33 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8S8XfBr000939;
        Fri, 28 Sep 2018 10:37:04 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mncmev26w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 10:37:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC7EA31;
        Fri, 28 Sep 2018 08:37:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E7EA2631;
        Fri, 28 Sep 2018 08:37:03 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 28 Sep 2018 10:37:01
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
Subject: [PATCH v2 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining support
Date:   Fri, 28 Sep 2018 10:36:31 +0200
Message-ID: <1538123794-17085-5-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
References: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of DMA/MDMA chaining support.
It introduces an intermediate transfer between peripherals and STM32 DMA.
This intermediate transfer is triggered by SW for single M2D transfer and
by STM32 DMA IP for all other modes (sg, cyclic) and direction (D2M).

A generic SRAM allocator is used for this intermediate buffer
Each DMA channel will be able to define its SRAM needs to achieve chaining
feature : (2 ^ order) * PAGE_SIZE.
For cyclic, SRAM buffer is derived from period length (rounded on
PAGE_SIZE).

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 879 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 772 insertions(+), 107 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 379e8d5..1571f2f 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -15,11 +15,14 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/genalloc.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
@@ -118,6 +121,7 @@
 #define STM32_DMA_FIFO_THRESHOLD_FULL			0x03
 
 #define STM32_DMA_MAX_DATA_ITEMS	0xffff
+#define STM32_DMA_SRAM_GRANULARITY	PAGE_SIZE
 /*
  * Valid transfer starts from @0 to @0xFFFE leading to unaligned scatter
  * gather at boundary. Thus it's safer to round down this value on FIFO
@@ -135,6 +139,12 @@
 /* DMA Features */
 #define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
 #define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
+#define STM32_DMA_MDMA_CHAIN_FTR_MASK	BIT(2)
+#define STM32_DMA_MDMA_CHAIN_FTR_GET(n)	(((n) & STM32_DMA_MDMA_CHAIN_FTR_MASK) \
+					 >> 2)
+#define STM32_DMA_MDMA_SRAM_SIZE_MASK	GENMASK(4, 3)
+#define STM32_DMA_MDMA_SRAM_SIZE_GET(n)	(((n) & STM32_DMA_MDMA_SRAM_SIZE_MASK) \
+					 >> 3)
 
 enum stm32_dma_width {
 	STM32_DMA_BYTE,
@@ -176,15 +186,31 @@ struct stm32_dma_chan_reg {
 	u32 dma_sfcr;
 };
 
+struct stm32_dma_mdma_desc {
+	struct sg_table sgt;
+	struct dma_async_tx_descriptor *desc;
+};
+
+struct stm32_dma_mdma {
+	struct dma_chan *chan;
+	enum dma_transfer_direction dir;
+	dma_addr_t sram_buf;
+	u32 sram_period;
+	u32 num_sgs;
+};
+
 struct stm32_dma_sg_req {
-	u32 len;
+	struct scatterlist stm32_sgl_req;
 	struct stm32_dma_chan_reg chan_reg;
+	struct stm32_dma_mdma_desc m_desc;
 };
 
 struct stm32_dma_desc {
 	struct virt_dma_desc vdesc;
 	bool cyclic;
 	u32 num_sgs;
+	dma_addr_t dma_buf;
+	void *dma_buf_cpu;
 	struct stm32_dma_sg_req sg_req[];
 };
 
@@ -201,6 +227,10 @@ struct stm32_dma_chan {
 	u32 threshold;
 	u32 mem_burst;
 	u32 mem_width;
+	struct stm32_dma_mdma mchan;
+	u32 use_mdma;
+	u32 sram_size;
+	u32 residue_after_drain;
 };
 
 struct stm32_dma_device {
@@ -210,6 +240,7 @@ struct stm32_dma_device {
 	struct reset_control *rst;
 	bool mem2mem;
 	struct stm32_dma_chan chan[STM32_DMA_MAX_CHANNELS];
+	struct gen_pool *sram_pool;
 };
 
 static struct stm32_dma_device *stm32_dma_get_dev(struct stm32_dma_chan *chan)
@@ -497,11 +528,15 @@ static void stm32_dma_stop(struct stm32_dma_chan *chan)
 static int stm32_dma_terminate_all(struct dma_chan *c)
 {
 	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+	struct stm32_dma_mdma *mchan = &chan->mchan;
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
+	if (chan->use_mdma)
+		dmaengine_terminate_async(mchan->chan);
+
 	if (chan->busy) {
 		stm32_dma_stop(chan);
 		chan->desc = NULL;
@@ -514,9 +549,96 @@ static int stm32_dma_terminate_all(struct dma_chan *c)
 	return 0;
 }
 
+static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
+{
+	u32 dma_scr, width, ndtr;
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+
+	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
+	width = STM32_DMA_SCR_PSIZE_GET(dma_scr);
+	ndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
+
+	return ndtr << width;
+}
+
+static int stm32_dma_mdma_drain(struct stm32_dma_chan *chan)
+{
+	struct stm32_dma_mdma *mchan = &chan->mchan;
+	struct stm32_dma_sg_req *sg_req;
+	struct dma_device *ddev = mchan->chan->device;
+	struct dma_async_tx_descriptor *desc = NULL;
+	enum dma_status status;
+	dma_addr_t src_buf, dst_buf;
+	u32 mdma_residue, mdma_wrote, dma_to_write, len;
+	struct dma_tx_state state;
+	int ret;
+
+	/* DMA/MDMA chain: drain remaining data in SRAM */
+
+	/* Get the residue on MDMA side */
+	status = dmaengine_tx_status(mchan->chan, mchan->chan->cookie, &state);
+	if (status == DMA_COMPLETE)
+		return status;
+
+	mdma_residue = state.residue;
+	sg_req = &chan->desc->sg_req[chan->next_sg - 1];
+	len = sg_dma_len(&sg_req->stm32_sgl_req);
+
+	/*
+	 * Total = mdma blocks * sram_period + rest (< sram_period)
+	 * so mdma blocks * sram_period = len - mdma residue - rest
+	 */
+	mdma_wrote = len - mdma_residue - (len % mchan->sram_period);
+
+	/* Remaining data stuck in SRAM */
+	dma_to_write = mchan->sram_period - stm32_dma_get_remaining_bytes(chan);
+	if (dma_to_write > 0) {
+		/* Stop DMA current operation */
+		stm32_dma_disable_chan(chan);
+
+		/* Terminate current MDMA to initiate a new one */
+		dmaengine_terminate_all(mchan->chan);
+
+		/* Double buffer management */
+		src_buf = mchan->sram_buf +
+			  ((mdma_wrote / mchan->sram_period) & 0x1) *
+			  mchan->sram_period;
+		dst_buf = sg_dma_address(&sg_req->stm32_sgl_req) + mdma_wrote;
+
+		desc = ddev->device_prep_dma_memcpy(mchan->chan,
+						    dst_buf, src_buf,
+						    dma_to_write,
+						    DMA_PREP_INTERRUPT);
+		if (!desc)
+			return -EINVAL;
+
+		ret = dma_submit_error(dmaengine_submit(desc));
+		if (ret < 0)
+			return ret;
+
+		status = dma_wait_for_async_tx(desc);
+		if (status != DMA_COMPLETE) {
+			dev_err(chan2dev(chan), "flush() dma_wait_for_async_tx error\n");
+			dmaengine_terminate_async(mchan->chan);
+			return -EBUSY;
+		}
+
+		/* We need to store residue for tx_status() */
+		chan->residue_after_drain = len - (mdma_wrote + dma_to_write);
+	}
+
+	return 0;
+}
+
 static void stm32_dma_synchronize(struct dma_chan *c)
 {
 	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+	struct stm32_dma_mdma *mchan = &chan->mchan;
+
+	if (chan->desc && chan->use_mdma && mchan->dir == DMA_DEV_TO_MEM)
+		if (stm32_dma_mdma_drain(chan))
+			dev_err(chan2dev(chan), "%s: can't drain DMA\n",
+				__func__);
 
 	vchan_synchronize(&chan->vchan);
 }
@@ -539,62 +661,232 @@ static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
 	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
 }
 
-static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan);
-
-static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
+static int stm32_dma_dummy_memcpy_xfer(struct stm32_dma_chan *chan)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
-	struct virt_dma_desc *vdesc;
+	struct dma_device *ddev = &dmadev->ddev;
+	struct stm32_dma_chan_reg reg;
+	u8 src_buf, dst_buf;
+	dma_addr_t dma_src_buf, dma_dst_buf;
+	u32 ndtr, status;
+	int len, ret;
+
+	ret = 0;
+	src_buf = 0;
+	len = 1;
+
+	dma_src_buf = dma_map_single(ddev->dev, &src_buf, len, DMA_TO_DEVICE);
+	ret = dma_mapping_error(ddev->dev, dma_src_buf);
+	if (ret < 0) {
+		dev_err(chan2dev(chan), "Source buffer map failed\n");
+		return ret;
+	}
+
+	dma_dst_buf = dma_map_single(ddev->dev, &dst_buf, len, DMA_FROM_DEVICE);
+	ret = dma_mapping_error(ddev->dev, dma_dst_buf);
+	if (ret < 0) {
+		dev_err(chan2dev(chan), "Destination buffer map failed\n");
+		dma_unmap_single(ddev->dev, dma_src_buf, len, DMA_TO_DEVICE);
+		return ret;
+	}
+
+	reg.dma_scr =	STM32_DMA_SCR_DIR(STM32_DMA_MEM_TO_MEM) |
+			STM32_DMA_SCR_PBURST(STM32_DMA_BURST_SINGLE) |
+			STM32_DMA_SCR_MBURST(STM32_DMA_BURST_SINGLE) |
+			STM32_DMA_SCR_MINC |
+			STM32_DMA_SCR_PINC |
+			STM32_DMA_SCR_TEIE;
+	reg.dma_spar = dma_src_buf;
+	reg.dma_sm0ar = dma_dst_buf;
+	reg.dma_sfcr = STM32_DMA_SFCR_MASK |
+		STM32_DMA_SFCR_FTH(STM32_DMA_FIFO_THRESHOLD_FULL);
+	reg.dma_sm1ar = dma_dst_buf;
+	reg.dma_sndtr = 1;
+
+	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg.dma_scr);
+	stm32_dma_write(dmadev, STM32_DMA_SPAR(chan->id), reg.dma_spar);
+	stm32_dma_write(dmadev, STM32_DMA_SM0AR(chan->id), reg.dma_sm0ar);
+	stm32_dma_write(dmadev, STM32_DMA_SFCR(chan->id), reg.dma_sfcr);
+	stm32_dma_write(dmadev, STM32_DMA_SM1AR(chan->id), reg.dma_sm1ar);
+	stm32_dma_write(dmadev, STM32_DMA_SNDTR(chan->id), reg.dma_sndtr);
+
+	/* Clear interrupt status if it is there */
+	status = stm32_dma_irq_status(chan);
+	if (status)
+		stm32_dma_irq_clear(chan, status);
+
+	stm32_dma_dump_reg(chan);
+
+	chan->busy = true;
+	/* Start DMA */
+	reg.dma_scr |= STM32_DMA_SCR_EN;
+	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg.dma_scr);
+
+	ret = readl_relaxed_poll_timeout_atomic(dmadev->base +
+						STM32_DMA_SNDTR(chan->id),
+						ndtr, !ndtr, 10, 1000);
+	if (ret) {
+		dev_err(chan2dev(chan), "%s: timeout!\n", __func__);
+		ret = -EBUSY;
+	}
+
+	chan->busy = false;
+
+	ret = stm32_dma_disable_chan(chan);
+	status = stm32_dma_irq_status(chan);
+	if (status)
+		stm32_dma_irq_clear(chan, status);
+
+	dma_unmap_single(ddev->dev, dma_src_buf, len, DMA_TO_DEVICE);
+	dma_unmap_single(ddev->dev, dma_dst_buf, len, DMA_FROM_DEVICE);
+
+	return ret;
+}
+
+static int stm32_dma_mdma_flush_remaining(struct stm32_dma_chan *chan)
+{
+	struct stm32_dma_mdma *mchan = &chan->mchan;
 	struct stm32_dma_sg_req *sg_req;
-	struct stm32_dma_chan_reg *reg;
-	u32 status;
+	struct dma_device *ddev = mchan->chan->device;
+	struct dma_async_tx_descriptor *desc = NULL;
+	enum dma_status status;
+	dma_addr_t src_buf, dst_buf;
+	u32 residue, remain, len;
 	int ret;
 
-	ret = stm32_dma_disable_chan(chan);
-	if (ret < 0)
-		return;
+	sg_req = &chan->desc->sg_req[chan->next_sg - 1];
 
-	if (!chan->desc) {
-		vdesc = vchan_next_desc(&chan->vchan);
-		if (!vdesc)
-			return;
+	residue = stm32_dma_get_remaining_bytes(chan);
+	len = sg_dma_len(&sg_req->stm32_sgl_req);
+	remain = len % mchan->sram_period;
 
-		chan->desc = to_stm32_dma_desc(vdesc);
-		chan->next_sg = 0;
+	if (residue > 0 && len > mchan->sram_period &&
+	    ((len % mchan->sram_period) != 0)) {
+		unsigned long dma_sync_wait_timeout =
+			jiffies + msecs_to_jiffies(5000);
+
+		while (residue > 0 &&
+		       residue > (mchan->sram_period - remain)) {
+			if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
+				dev_err(chan2dev(chan),
+					"%s timeout waiting for last bytes\n",
+					__func__);
+				break;
+			}
+			cpu_relax();
+			residue = stm32_dma_get_remaining_bytes(chan);
+		}
+		stm32_dma_disable_chan(chan);
+
+		src_buf = mchan->sram_buf + ((len / mchan->sram_period) & 0x1)
+			* mchan->sram_period;
+		dst_buf = sg_dma_address(&sg_req->stm32_sgl_req) + len -
+			(len % mchan->sram_period);
+
+		desc = ddev->device_prep_dma_memcpy(mchan->chan,
+						    dst_buf, src_buf,
+						    len % mchan->sram_period,
+						    DMA_PREP_INTERRUPT);
+
+		if (!desc)
+			return -EINVAL;
+
+		ret = dma_submit_error(dmaengine_submit(desc));
+		if (ret < 0)
+			return ret;
+
+		status = dma_wait_for_async_tx(desc);
+		if (status != DMA_COMPLETE) {
+			dmaengine_terminate_async(mchan->chan);
+			return -EBUSY;
+		}
 	}
 
-	if (chan->next_sg == chan->desc->num_sgs)
-		chan->next_sg = 0;
+	return 0;
+}
 
-	sg_req = &chan->desc->sg_req[chan->next_sg];
-	reg = &sg_req->chan_reg;
+static void stm32_dma_start_transfer(struct stm32_dma_chan *chan);
 
-	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
-	stm32_dma_write(dmadev, STM32_DMA_SPAR(chan->id), reg->dma_spar);
-	stm32_dma_write(dmadev, STM32_DMA_SM0AR(chan->id), reg->dma_sm0ar);
-	stm32_dma_write(dmadev, STM32_DMA_SFCR(chan->id), reg->dma_sfcr);
-	stm32_dma_write(dmadev, STM32_DMA_SM1AR(chan->id), reg->dma_sm1ar);
-	stm32_dma_write(dmadev, STM32_DMA_SNDTR(chan->id), reg->dma_sndtr);
+static void stm32_mdma_chan_complete(void *param,
+				     const struct dmaengine_result *result)
+{
+	struct stm32_dma_chan *chan = param;
 
-	chan->next_sg++;
+	chan->busy = false;
+	if (result->result == DMA_TRANS_NOERROR) {
+		if (stm32_dma_mdma_flush_remaining(chan)) {
+			dev_err(chan2dev(chan), "Can't flush DMA\n");
+			return;
+		}
 
-	/* Clear interrupt status if it is there */
-	status = stm32_dma_irq_status(chan);
-	if (status)
-		stm32_dma_irq_clear(chan, status);
+		if (chan->next_sg == chan->desc->num_sgs) {
+			list_del(&chan->desc->vdesc.node);
+			vchan_cookie_complete(&chan->desc->vdesc);
+			chan->desc = NULL;
+		}
+		stm32_dma_start_transfer(chan);
+	} else {
+		dev_err(chan2dev(chan), "MDMA transfer error: %d\n",
+			result->result);
+	}
+}
 
-	if (chan->desc->cyclic)
-		stm32_dma_configure_next_sg(chan);
+static int stm32_dma_mdma_start(struct stm32_dma_chan *chan,
+				struct stm32_dma_sg_req *sg_req)
+{
+	struct stm32_dma_mdma *mchan = &chan->mchan;
+	struct stm32_dma_mdma_desc *m_desc = &sg_req->m_desc;
+	struct dma_slave_config config;
+	int ret;
 
-	stm32_dma_dump_reg(chan);
+	/* Configure MDMA channel */
+	memset(&config, 0, sizeof(config));
+	if (mchan->dir == DMA_MEM_TO_DEV)
+		config.dst_addr = mchan->sram_buf;
+	else
+		config.src_addr = mchan->sram_buf;
 
-	/* Start DMA */
-	reg->dma_scr |= STM32_DMA_SCR_EN;
-	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
+	ret = dmaengine_slave_config(mchan->chan, &config);
+	if (ret < 0)
+		goto error;
+
+	 /* Prepare MDMA descriptor */
+	m_desc->desc = dmaengine_prep_slave_sg(mchan->chan, m_desc->sgt.sgl,
+					       m_desc->sgt.nents, mchan->dir,
+					       DMA_PREP_INTERRUPT);
+	if (!m_desc->desc) {
+		ret = -EINVAL;
+		goto error;
+	}
 
-	chan->busy = true;
+	if (mchan->dir != DMA_MEM_TO_DEV) {
+		m_desc->desc->callback_result = stm32_mdma_chan_complete;
+		m_desc->desc->callback_param = chan;
+	}
 
-	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
+	ret = dma_submit_error(dmaengine_submit(m_desc->desc));
+	if (ret < 0) {
+		dev_err(chan2dev(chan), "MDMA submit failed\n");
+		goto error;
+	}
+
+	dma_async_issue_pending(mchan->chan);
+
+	/*
+	 * In case of M2D transfer, we have to generate dummy DMA transfer to
+	 * copy 1st sg data into SRAM
+	 */
+	if (mchan->dir == DMA_MEM_TO_DEV) {
+		ret = stm32_dma_dummy_memcpy_xfer(chan);
+		if (ret < 0) {
+			dmaengine_terminate_async(mchan->chan);
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	return ret;
 }
 
 static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
@@ -626,23 +918,132 @@ static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
 	}
 }
 
-static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan)
+static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 {
-	if (chan->desc) {
-		if (chan->desc->cyclic) {
-			vchan_cyclic_callback(&chan->desc->vdesc);
-			chan->next_sg++;
-			stm32_dma_configure_next_sg(chan);
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct virt_dma_desc *vdesc;
+	struct stm32_dma_sg_req *sg_req;
+	struct stm32_dma_chan_reg *reg;
+	u32 status;
+	int ret;
+
+	ret = stm32_dma_disable_chan(chan);
+	if (ret < 0)
+		return;
+
+	if (!chan->desc) {
+		vdesc = vchan_next_desc(&chan->vchan);
+		if (!vdesc)
+			return;
+
+		chan->desc = to_stm32_dma_desc(vdesc);
+		chan->next_sg = 0;
+	} else {
+		vdesc = &chan->desc->vdesc;
+	}
+
+	if (chan->next_sg == chan->desc->num_sgs)
+		chan->next_sg = 0;
+
+	sg_req = &chan->desc->sg_req[chan->next_sg];
+	reg = &sg_req->chan_reg;
+
+	/* Clear interrupt status if it is there */
+	status = stm32_dma_irq_status(chan);
+	if (status)
+		stm32_dma_irq_clear(chan, status);
+
+	if (chan->use_mdma) {
+		if (chan->next_sg == 0) {
+			struct stm32_dma_mdma_desc *m_desc;
+
+			m_desc = &sg_req->m_desc;
+			if (chan->desc->cyclic) {
+				/*
+				 * If one callback is set, it will be called by
+				 * MDMA driver.
+				 */
+				if (vdesc->tx.callback) {
+					m_desc->desc->callback =
+						vdesc->tx.callback;
+					m_desc->desc->callback_param =
+						vdesc->tx.callback_param;
+					vdesc->tx.callback = NULL;
+					vdesc->tx.callback_param = NULL;
+				}
+			}
+		}
+
+		if (chan->mchan.dir == DMA_MEM_TO_DEV) {
+			ret = stm32_dma_dummy_memcpy_xfer(chan);
+			if (ret < 0) {
+				dmaengine_terminate_async(chan->mchan.chan);
+				chan->desc = NULL;
+				return;
+			}
 		} else {
-			chan->busy = false;
-			if (chan->next_sg == chan->desc->num_sgs) {
-				list_del(&chan->desc->vdesc.node);
-				vchan_cookie_complete(&chan->desc->vdesc);
+			reg->dma_scr &= ~STM32_DMA_SCR_TCIE;
+		}
+
+		if (!chan->desc->cyclic) {
+			/*  MDMA already started */
+			if (chan->mchan.dir != DMA_MEM_TO_DEV &&
+			    sg_dma_len(&sg_req->stm32_sgl_req) >
+			    chan->mchan.sram_period)
+				reg->dma_scr |= STM32_DMA_SCR_DBM;
+			ret = stm32_dma_mdma_start(chan, sg_req);
+			if (ret < 0) {
 				chan->desc = NULL;
+				return;
 			}
-			stm32_dma_start_transfer(chan);
 		}
 	}
+
+	chan->next_sg++;
+
+	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
+	stm32_dma_write(dmadev, STM32_DMA_SPAR(chan->id), reg->dma_spar);
+	stm32_dma_write(dmadev, STM32_DMA_SM0AR(chan->id), reg->dma_sm0ar);
+	stm32_dma_write(dmadev, STM32_DMA_SFCR(chan->id), reg->dma_sfcr);
+	stm32_dma_write(dmadev, STM32_DMA_SM1AR(chan->id), reg->dma_sm1ar);
+	stm32_dma_write(dmadev, STM32_DMA_SNDTR(chan->id), reg->dma_sndtr);
+
+	if (chan->desc->cyclic)
+		stm32_dma_configure_next_sg(chan);
+
+	stm32_dma_dump_reg(chan);
+
+	/* Start DMA */
+	chan->busy = true;
+	reg->dma_scr |= STM32_DMA_SCR_EN;
+	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
+
+	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
+}
+
+static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan)
+{
+	if (!chan->desc)
+		return;
+
+	if (chan->desc->cyclic) {
+		vchan_cyclic_callback(&chan->desc->vdesc);
+		if (chan->use_mdma)
+			return;
+		chan->next_sg++;
+		stm32_dma_configure_next_sg(chan);
+	} else {
+		chan->busy = false;
+		if (chan->use_mdma && chan->mchan.dir != DMA_MEM_TO_DEV)
+			return;
+		if (chan->next_sg == chan->desc->num_sgs) {
+			list_del(&chan->desc->vdesc.node);
+			vchan_cookie_complete(&chan->desc->vdesc);
+			chan->desc = NULL;
+		}
+
+		stm32_dma_start_transfer(chan);
+	}
 }
 
 static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
@@ -695,7 +1096,6 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
 		dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
 		stm32_dma_start_transfer(chan);
-
 	}
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
@@ -836,16 +1236,128 @@ static void stm32_dma_clear_reg(struct stm32_dma_chan_reg *regs)
 	memset(regs, 0, sizeof(struct stm32_dma_chan_reg));
 }
 
+static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
+					struct scatterlist *sgl, u32 sg_len,
+					struct stm32_dma_desc *desc)
+{
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct scatterlist *sg, *m_sg;
+	dma_addr_t dma_buf;
+	u32 len, num_sgs, sram_period;
+	int i, j, ret;
+
+	desc->dma_buf_cpu = gen_pool_dma_alloc(dmadev->sram_pool,
+					       chan->sram_size,
+					       &desc->dma_buf);
+	if (!desc->dma_buf_cpu)
+		return -ENOMEM;
+
+	sram_period = chan->sram_size / 2;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		struct stm32_dma_mdma_desc *m_desc = &desc->sg_req[i].m_desc;
+
+		len = sg_dma_len(sg);
+		desc->sg_req[i].stm32_sgl_req = *sg;
+		num_sgs = 1;
+
+		if (chan->mchan.dir == DMA_MEM_TO_DEV) {
+			if (len > chan->sram_size) {
+				dev_err(chan2dev(chan),
+					"max buf size = %d bytes\n",
+					chan->sram_size);
+				goto free_alloc;
+			}
+		} else {
+			/*
+			 * Build new sg for MDMA transfer
+			 * Scatter DMA Req into several SDRAM transfer
+			 */
+			if (len > sram_period)
+				num_sgs = len / sram_period;
+		}
+
+		ret = sg_alloc_table(&m_desc->sgt, num_sgs, GFP_ATOMIC);
+		if (ret) {
+			dev_err(chan2dev(chan), "MDMA sg table alloc failed\n");
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		dma_buf = sg_dma_address(sg);
+		for_each_sg(m_desc->sgt.sgl, m_sg, num_sgs, j) {
+			size_t bytes = min_t(size_t, len, sram_period);
+
+			sg_dma_address(m_sg) = dma_buf;
+			sg_dma_len(m_sg) = bytes;
+			dma_buf += bytes;
+			len -= bytes;
+		}
+	}
+
+	chan->mchan.sram_buf = desc->dma_buf;
+	chan->mchan.sram_period = sram_period;
+	chan->mchan.num_sgs = num_sgs;
+
+	return 0;
+
+err:
+	for (j = 0; j < i; j++)
+		sg_free_table(&desc->sg_req[j].m_desc.sgt);
+free_alloc:
+	gen_pool_free(dmadev->sram_pool, (unsigned long)desc->dma_buf_cpu,
+		      chan->sram_size);
+	return ret;
+}
+
+static int stm32_dma_setup_sg_requests(struct stm32_dma_chan *chan,
+				       struct scatterlist *sgl,
+				       unsigned int sg_len,
+				       enum dma_transfer_direction direction,
+				       struct stm32_dma_desc *desc)
+{
+	struct scatterlist *sg;
+	u32 nb_data_items;
+	int i, ret;
+	enum dma_slave_buswidth buswidth;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		ret = stm32_dma_set_xfer_param(chan, direction, &buswidth,
+					       sg_dma_len(sg));
+		if (ret < 0)
+			return ret;
+
+		nb_data_items = sg_dma_len(sg) / buswidth;
+		if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
+			dev_err(chan2dev(chan), "nb items not supported\n");
+			return -EINVAL;
+		}
+
+		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
+		desc->sg_req[i].chan_reg.dma_scr = chan->chan_reg.dma_scr;
+		desc->sg_req[i].chan_reg.dma_sfcr = chan->chan_reg.dma_sfcr;
+		desc->sg_req[i].chan_reg.dma_spar = chan->chan_reg.dma_spar;
+		desc->sg_req[i].chan_reg.dma_sm0ar = sg_dma_address(sg);
+		desc->sg_req[i].chan_reg.dma_sm1ar = sg_dma_address(sg);
+		if (chan->use_mdma)
+			desc->sg_req[i].chan_reg.dma_sm1ar +=
+				chan->mchan.sram_period;
+		desc->sg_req[i].chan_reg.dma_sndtr = nb_data_items;
+	}
+
+	desc->num_sgs = sg_len;
+
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 	struct dma_chan *c, struct scatterlist *sgl,
 	u32 sg_len, enum dma_transfer_direction direction,
 	unsigned long flags, void *context)
 {
 	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+
 	struct stm32_dma_desc *desc;
-	struct scatterlist *sg;
-	enum dma_slave_buswidth buswidth;
-	u32 nb_data_items;
 	int i, ret;
 
 	if (!chan->config_init) {
@@ -868,48 +1380,141 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 	else
 		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_PFCTRL;
 
-	for_each_sg(sgl, sg, sg_len, i) {
-		ret = stm32_dma_set_xfer_param(chan, direction, &buswidth,
-					       sg_dma_len(sg));
-		if (ret < 0)
-			goto err;
-
-		desc->sg_req[i].len = sg_dma_len(sg);
+	if (chan->use_mdma) {
+		struct sg_table new_sgt;
+		struct scatterlist *s, *_sgl;
 
-		nb_data_items = desc->sg_req[i].len / buswidth;
-		if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
-			dev_err(chan2dev(chan), "nb items not supported\n");
-			goto err;
+		chan->mchan.dir = direction;
+		ret = stm32_dma_mdma_prep_slave_sg(chan, sgl, sg_len, desc);
+		if (ret < 0)
+			return NULL;
+
+		ret = sg_alloc_table(&new_sgt, sg_len, GFP_ATOMIC);
+		if (ret)
+			dev_err(chan2dev(chan), "DMA sg table alloc failed\n");
+
+		for_each_sg(new_sgt.sgl, s, sg_len, i) {
+			_sgl = sgl;
+			sg_dma_len(s) =
+				min(sg_dma_len(_sgl), chan->mchan.sram_period);
+			s->dma_address = chan->mchan.sram_buf;
+			_sgl = sg_next(_sgl);
 		}
 
-		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
-		desc->sg_req[i].chan_reg.dma_scr = chan->chan_reg.dma_scr;
-		desc->sg_req[i].chan_reg.dma_sfcr = chan->chan_reg.dma_sfcr;
-		desc->sg_req[i].chan_reg.dma_spar = chan->chan_reg.dma_spar;
-		desc->sg_req[i].chan_reg.dma_sm0ar = sg_dma_address(sg);
-		desc->sg_req[i].chan_reg.dma_sm1ar = sg_dma_address(sg);
-		desc->sg_req[i].chan_reg.dma_sndtr = nb_data_items;
+		ret = stm32_dma_setup_sg_requests(chan, new_sgt.sgl, sg_len,
+						  direction, desc);
+		sg_free_table(&new_sgt);
+		if (ret < 0)
+			goto err;
+	} else {
+		/* Prepare a normal DMA transfer */
+		ret = stm32_dma_setup_sg_requests(chan, sgl, sg_len, direction,
+						  desc);
+		if (ret < 0)
+			goto err;
 	}
 
-	desc->num_sgs = sg_len;
 	desc->cyclic = false;
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
-
 err:
+	if (chan->use_mdma) {
+		struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+
+		for (i = 0; i < sg_len; i++)
+			sg_free_table(&desc->sg_req[i].m_desc.sgt);
+
+		gen_pool_free(dmadev->sram_pool,
+			      (unsigned long)desc->dma_buf_cpu,
+			      chan->sram_size);
+	}
 	kfree(desc);
+
 	return NULL;
 }
 
+static int stm32_dma_mdma_prep_dma_cyclic(struct stm32_dma_chan *chan,
+					  dma_addr_t buf_addr, size_t buf_len,
+					  size_t period_len,
+					  struct stm32_dma_desc *desc)
+{
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct stm32_dma_mdma *mchan = &chan->mchan;
+	struct stm32_dma_mdma_desc *m_desc = &desc->sg_req[0].m_desc;
+	struct dma_slave_config config;
+	dma_addr_t mem;
+	int ret;
+
+	chan->sram_size = ALIGN(period_len, STM32_DMA_SRAM_GRANULARITY);
+	desc->dma_buf_cpu = gen_pool_dma_alloc(dmadev->sram_pool,
+					       2 * chan->sram_size,
+					       &desc->dma_buf);
+	if (!desc->dma_buf_cpu)
+		return -ENOMEM;
+
+	memset(&config, 0, sizeof(config));
+	mem = buf_addr;
+
+	/* Configure MDMA channel */
+	if (chan->mchan.dir == DMA_MEM_TO_DEV)
+		config.dst_addr = desc->dma_buf;
+	else
+		config.src_addr = desc->dma_buf;
+	ret = dmaengine_slave_config(mchan->chan, &config);
+	if (ret < 0)
+		goto err;
+
+	/* Prepare MDMA descriptor */
+	m_desc->desc = dmaengine_prep_dma_cyclic(mchan->chan, buf_addr, buf_len,
+						 period_len, chan->mchan.dir,
+						 DMA_PREP_INTERRUPT);
+
+	if (!m_desc->desc) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = dma_submit_error(dmaengine_submit(m_desc->desc));
+	if (ret < 0) {
+		dev_err(chan2dev(chan), "MDMA submit failed\n");
+		goto err;
+	}
+
+	dma_async_issue_pending(mchan->chan);
+
+	/*
+	 * In case of M2D transfer, we have to generate dummy DMA transfer to
+	 * copy 1 period of data into SRAM
+	 */
+	if (chan->mchan.dir == DMA_MEM_TO_DEV) {
+		ret = stm32_dma_dummy_memcpy_xfer(chan);
+		if (ret < 0) {
+			dev_err(chan2dev(chan),
+				"stm32_dma_dummy_memcpy_xfer failed\n");
+			dmaengine_terminate_async(mchan->chan);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	gen_pool_free(dmadev->sram_pool,
+		      (unsigned long)desc->dma_buf_cpu,
+		      chan->sram_size);
+	return ret;
+}
+
 static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
 	unsigned long flags)
 {
 	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+	struct stm32_dma_chan_reg *chan_reg = &chan->chan_reg;
 	struct stm32_dma_desc *desc;
 	enum dma_slave_buswidth buswidth;
 	u32 num_periods, nb_data_items;
+	dma_addr_t dma_buf = 0;
 	int i, ret;
 
 	if (!buf_len || !period_len) {
@@ -957,28 +1562,49 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 	/* Clear periph ctrl if client set it */
 	chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_PFCTRL;
 
-	num_periods = buf_len / period_len;
+	if (chan->use_mdma)
+		num_periods = 1;
+	else
+		num_periods = buf_len / period_len;
 
 	desc = stm32_dma_alloc_desc(num_periods);
 	if (!desc)
 		return NULL;
 
-	for (i = 0; i < num_periods; i++) {
-		desc->sg_req[i].len = period_len;
+	desc->num_sgs = num_periods;
+	desc->cyclic = true;
 
+	if (chan->use_mdma) {
+		chan->mchan.dir = direction;
+
+		ret = stm32_dma_mdma_prep_dma_cyclic(chan, buf_addr, buf_len,
+						     period_len, desc);
+		if (ret < 0)
+			return NULL;
+		dma_buf = desc->dma_buf;
+	} else {
+		dma_buf = buf_addr;
+	}
+
+	for (i = 0; i < num_periods; i++) {
+		sg_dma_len(&desc->sg_req[i].stm32_sgl_req) = period_len;
+		sg_dma_address(&desc->sg_req[i].stm32_sgl_req) = dma_buf;
 		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
-		desc->sg_req[i].chan_reg.dma_scr = chan->chan_reg.dma_scr;
-		desc->sg_req[i].chan_reg.dma_sfcr = chan->chan_reg.dma_sfcr;
-		desc->sg_req[i].chan_reg.dma_spar = chan->chan_reg.dma_spar;
-		desc->sg_req[i].chan_reg.dma_sm0ar = buf_addr;
-		desc->sg_req[i].chan_reg.dma_sm1ar = buf_addr;
+		desc->sg_req[i].chan_reg.dma_scr = chan_reg->dma_scr;
+		desc->sg_req[i].chan_reg.dma_sfcr = chan_reg->dma_sfcr;
+		desc->sg_req[i].chan_reg.dma_spar = chan_reg->dma_spar;
+		if (chan->use_mdma) {
+			desc->sg_req[i].chan_reg.dma_sm0ar = desc->dma_buf;
+			desc->sg_req[i].chan_reg.dma_sm1ar = desc->dma_buf +
+				chan->sram_size;
+		} else {
+			desc->sg_req[i].chan_reg.dma_sm0ar = dma_buf;
+			desc->sg_req[i].chan_reg.dma_sm1ar = dma_buf;
+			dma_buf += period_len;
+		}
 		desc->sg_req[i].chan_reg.dma_sndtr = nb_data_items;
-		buf_addr += period_len;
 	}
 
-	desc->num_sgs = num_periods;
-	desc->cyclic = true;
-
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
@@ -1019,13 +1645,13 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 			STM32_DMA_SCR_PINC |
 			STM32_DMA_SCR_TCIE |
 			STM32_DMA_SCR_TEIE;
-		desc->sg_req[i].chan_reg.dma_sfcr |= STM32_DMA_SFCR_MASK;
+		desc->sg_req[i].chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_MASK;
 		desc->sg_req[i].chan_reg.dma_sfcr |=
 			STM32_DMA_SFCR_FTH(threshold);
 		desc->sg_req[i].chan_reg.dma_spar = src + offset;
 		desc->sg_req[i].chan_reg.dma_sm0ar = dest + offset;
 		desc->sg_req[i].chan_reg.dma_sndtr = xfer_count;
-		desc->sg_req[i].len = xfer_count;
+		sg_dma_len(&desc->sg_req[i].stm32_sgl_req) = xfer_count;
 	}
 
 	desc->num_sgs = num_sgs;
@@ -1034,18 +1660,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
-static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
-{
-	u32 dma_scr, width, ndtr;
-	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
-
-	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
-	width = STM32_DMA_SCR_PSIZE_GET(dma_scr);
-	ndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
-
-	return ndtr << width;
-}
-
 static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 				     struct stm32_dma_desc *desc,
 				     u32 next_sg)
@@ -1054,6 +1668,10 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 	u32 residue = 0;
 	int i;
 
+	/* Drain case */
+	if (chan->residue_after_drain)
+		return chan->residue_after_drain;
+
 	/*
 	 * In cyclic mode, for the last period, residue = remaining bytes from
 	 * NDTR
@@ -1069,7 +1687,7 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 	 * transferred
 	 */
 	for (i = next_sg; i < desc->num_sgs; i++)
-		residue += desc->sg_req[i].len;
+		residue += sg_dma_len(&desc->sg_req[i].stm32_sgl_req);
 	residue += stm32_dma_get_remaining_bytes(chan);
 
 end:
@@ -1089,11 +1707,23 @@ static enum dma_status stm32_dma_tx_status(struct dma_chan *c,
 					   struct dma_tx_state *state)
 {
 	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+	struct stm32_dma_mdma *mchan = &chan->mchan;
 	struct virt_dma_desc *vdesc;
 	enum dma_status status;
 	unsigned long flags;
 	u32 residue = 0;
 
+	/*
+	 * When DMA/MDMA chain is used, we return the status of MDMA in cyclic
+	 * mode and for D2M transfer in sg mode in order to return the correct
+	 * residue if any
+	 */
+	if (chan->desc && chan->use_mdma &&
+	    (mchan->dir != DMA_MEM_TO_DEV || chan->desc->cyclic) &&
+	    !chan->residue_after_drain)
+		return dmaengine_tx_status(mchan->chan, mchan->chan->cookie,
+					   state);
+
 	status = dma_cookie_status(c, cookie, state);
 	if (status == DMA_COMPLETE || !state)
 		return status;
@@ -1155,21 +1785,34 @@ static void stm32_dma_free_chan_resources(struct dma_chan *c)
 
 static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
 {
-	kfree(container_of(vdesc, struct stm32_dma_desc, vdesc));
+	struct stm32_dma_desc *desc = to_stm32_dma_desc(vdesc);
+	struct stm32_dma_chan *chan = to_stm32_dma_chan(vdesc->tx.chan);
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	int i;
+
+	if (chan->use_mdma) {
+		for (i = 0; i < desc->num_sgs; i++)
+			sg_free_table(&desc->sg_req[i].m_desc.sgt);
+
+		gen_pool_free(dmadev->sram_pool,
+			      (unsigned long)desc->dma_buf_cpu,
+			      chan->sram_size);
+	}
+
+	kfree(desc);
 }
 
 static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 				 struct stm32_dma_cfg *cfg)
 {
 	stm32_dma_clear_reg(&chan->chan_reg);
-
 	chan->chan_reg.dma_scr = cfg->stream_config & STM32_DMA_SCR_CFG_MASK;
 	chan->chan_reg.dma_scr |= STM32_DMA_SCR_REQ(cfg->request_line);
-
-	/* Enable Interrupts  */
 	chan->chan_reg.dma_scr |= STM32_DMA_SCR_TEIE | STM32_DMA_SCR_TCIE;
-
 	chan->threshold = STM32_DMA_THRESHOLD_FTR_GET(cfg->features);
+	chan->use_mdma = STM32_DMA_MDMA_CHAIN_FTR_GET(cfg->features);
+	chan->sram_size = (1 << STM32_DMA_MDMA_SRAM_SIZE_GET(cfg->features)) *
+		STM32_DMA_SRAM_GRANULARITY;
 }
 
 static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
@@ -1207,6 +1850,9 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 
 	stm32_dma_set_config(chan, &cfg);
 
+	if (!dmadev->sram_pool || !chan->mchan.chan)
+		chan->use_mdma = 0;
+
 	return c;
 }
 
@@ -1219,10 +1865,12 @@ MODULE_DEVICE_TABLE(of, stm32_dma_of_match);
 static int stm32_dma_probe(struct platform_device *pdev)
 {
 	struct stm32_dma_chan *chan;
+	struct stm32_dma_mdma *mchan;
 	struct stm32_dma_device *dmadev;
 	struct dma_device *dd;
 	const struct of_device_id *match;
 	struct resource *res;
+	char name[4];
 	int i, ret;
 
 	match = of_match_device(stm32_dma_of_match, &pdev->dev);
@@ -1258,6 +1906,13 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		reset_control_deassert(dmadev->rst);
 	}
 
+	dmadev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
+	if (!dmadev->sram_pool)
+		dev_info(&pdev->dev, "no dma pool: can't use MDMA: %d\n", ret);
+	else
+		dev_dbg(&pdev->dev, "SRAM pool: %zu KiB\n",
+			gen_pool_size(dmadev->sram_pool) / 1024);
+
 	dma_cap_set(DMA_SLAVE, dd->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dd->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dd->cap_mask);
@@ -1293,6 +1948,16 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		chan->id = i;
 		chan->vchan.desc_free = stm32_dma_desc_free;
 		vchan_init(&chan->vchan, dd);
+
+		mchan = &chan->mchan;
+		if (dmadev->sram_pool) {
+			snprintf(name, sizeof(name), "ch%d", chan->id);
+			mchan->chan = dma_request_slave_channel(dd->dev, name);
+			if (!mchan->chan)
+				dev_info(&pdev->dev,
+					 "can't request MDMA chan for %s\n",
+					 name);
+		}
 	}
 
 	ret = dma_async_device_register(dd);
@@ -1350,4 +2015,4 @@ static int __init stm32_dma_init(void)
 {
 	return platform_driver_probe(&stm32_dma_driver, stm32_dma_probe);
 }
-subsys_initcall(stm32_dma_init);
+device_initcall(stm32_dma_init);
-- 
2.7.4

