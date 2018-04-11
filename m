Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753756AbeDKOpZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:45:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49283 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753473AbeDKOpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:45:04 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 2/2] dmaengine: stm32-mdma: Fix incomplete Hw descriptors allocator
Date: Wed, 11 Apr 2018 16:44:39 +0200
Message-ID: <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only 1 Hw Descriptor is allocated. Loop over required Hw descriptor for
proper allocation.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
    v2:
       * Fix kbuild warning format: /0x%08x/%pad/
---
---
 drivers/dma/stm32-mdma.c | 90 ++++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index fbcffa2..3a477bc 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -252,13 +252,17 @@ struct stm32_mdma_hwdesc {
 	u32 cmdr;
 } __aligned(64);
 
+struct stm32_mdma_desc_node {
+	struct stm32_mdma_hwdesc *hwdesc;
+	dma_addr_t hwdesc_phys;
+};
+
 struct stm32_mdma_desc {
 	struct virt_dma_desc vdesc;
 	u32 ccr;
-	struct stm32_mdma_hwdesc *hwdesc;
-	dma_addr_t hwdesc_phys;
 	bool cyclic;
 	u32 count;
+	struct stm32_mdma_desc_node node[];
 };
 
 struct stm32_mdma_chan {
@@ -344,30 +348,43 @@ static struct stm32_mdma_desc *stm32_mdma_alloc_desc(
 		struct stm32_mdma_chan *chan, u32 count)
 {
 	struct stm32_mdma_desc *desc;
+	int i;
 
-	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	desc = kzalloc(sizeof(*desc) +
+		       sizeof(struct stm32_mdma_desc_node) * count, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->hwdesc = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT,
-				      &desc->hwdesc_phys);
-	if (!desc->hwdesc) {
-		dev_err(chan2dev(chan), "Failed to allocate descriptor\n");
-		kfree(desc);
-		return NULL;
+	for (i = 0; i < count; i++) {
+		desc->node[i].hwdesc =
+			dma_pool_alloc(chan->desc_pool, GFP_NOWAIT,
+				       &desc->node[i].hwdesc_phys);
+		if (!desc->node[i].hwdesc)
+			goto err;
 	}
 
 	desc->count = count;
 
 	return desc;
+
+err:
+	dev_err(chan2dev(chan), "Failed to allocate descriptor\n");
+	while (--i >= 0)
+		dma_pool_free(chan->desc_pool, desc->node[i].hwdesc,
+			      desc->node[i].hwdesc_phys);
+	kfree(desc);
+	return NULL;
 }
 
 static void stm32_mdma_desc_free(struct virt_dma_desc *vdesc)
 {
 	struct stm32_mdma_desc *desc = to_stm32_mdma_desc(vdesc);
 	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(vdesc->tx.chan);
+	int i;
 
-	dma_pool_free(chan->desc_pool, desc->hwdesc, desc->hwdesc_phys);
+	for (i = 0; i < desc->count; i++)
+		dma_pool_free(chan->desc_pool, desc->node[i].hwdesc,
+			      desc->node[i].hwdesc_phys);
 	kfree(desc);
 }
 
@@ -669,18 +686,18 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 }
 
 static void stm32_mdma_dump_hwdesc(struct stm32_mdma_chan *chan,
-				   struct stm32_mdma_hwdesc *hwdesc)
+				   struct stm32_mdma_desc_node *node)
 {
-	dev_dbg(chan2dev(chan), "hwdesc:  0x%p\n", hwdesc);
-	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", hwdesc->ctcr);
-	dev_dbg(chan2dev(chan), "CBNDTR:  0x%08x\n", hwdesc->cbndtr);
-	dev_dbg(chan2dev(chan), "CSAR:    0x%08x\n", hwdesc->csar);
-	dev_dbg(chan2dev(chan), "CDAR:    0x%08x\n", hwdesc->cdar);
-	dev_dbg(chan2dev(chan), "CBRUR:   0x%08x\n", hwdesc->cbrur);
-	dev_dbg(chan2dev(chan), "CLAR:    0x%08x\n", hwdesc->clar);
-	dev_dbg(chan2dev(chan), "CTBR:    0x%08x\n", hwdesc->ctbr);
-	dev_dbg(chan2dev(chan), "CMAR:    0x%08x\n", hwdesc->cmar);
-	dev_dbg(chan2dev(chan), "CMDR:    0x%08x\n\n", hwdesc->cmdr);
+	dev_dbg(chan2dev(chan), "hwdesc:  %pad\n", &node->hwdesc_phys);
+	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);
+	dev_dbg(chan2dev(chan), "CBNDTR:  0x%08x\n", node->hwdesc->cbndtr);
+	dev_dbg(chan2dev(chan), "CSAR:    0x%08x\n", node->hwdesc->csar);
+	dev_dbg(chan2dev(chan), "CDAR:    0x%08x\n", node->hwdesc->cdar);
+	dev_dbg(chan2dev(chan), "CBRUR:   0x%08x\n", node->hwdesc->cbrur);
+	dev_dbg(chan2dev(chan), "CLAR:    0x%08x\n", node->hwdesc->clar);
+	dev_dbg(chan2dev(chan), "CTBR:    0x%08x\n", node->hwdesc->ctbr);
+	dev_dbg(chan2dev(chan), "CMAR:    0x%08x\n", node->hwdesc->cmar);
+	dev_dbg(chan2dev(chan), "CMDR:    0x%08x\n\n", node->hwdesc->cmdr);
 }
 
 static void stm32_mdma_setup_hwdesc(struct stm32_mdma_chan *chan,
@@ -694,7 +711,7 @@ static void stm32_mdma_setup_hwdesc(struct stm32_mdma_chan *chan,
 	struct stm32_mdma_hwdesc *hwdesc;
 	u32 next = count + 1;
 
-	hwdesc = &desc->hwdesc[count];
+	hwdesc = desc->node[count].hwdesc;
 	hwdesc->ctcr = ctcr;
 	hwdesc->cbndtr &= ~(STM32_MDMA_CBNDTR_BRC_MK |
 			STM32_MDMA_CBNDTR_BRDUM |
@@ -704,19 +721,20 @@ static void stm32_mdma_setup_hwdesc(struct stm32_mdma_chan *chan,
 	hwdesc->csar = src_addr;
 	hwdesc->cdar = dst_addr;
 	hwdesc->cbrur = 0;
-	hwdesc->clar = desc->hwdesc_phys + next * sizeof(*hwdesc);
 	hwdesc->ctbr = ctbr;
 	hwdesc->cmar = config->mask_addr;
 	hwdesc->cmdr = config->mask_data;
 
 	if (is_last) {
 		if (is_cyclic)
-			hwdesc->clar = desc->hwdesc_phys;
+			hwdesc->clar = desc->node[0].hwdesc_phys;
 		else
 			hwdesc->clar = 0;
+	} else {
+		hwdesc->clar = desc->node[next].hwdesc_phys;
 	}
 
-	stm32_mdma_dump_hwdesc(chan, hwdesc);
+	stm32_mdma_dump_hwdesc(chan, &desc->node[count]);
 }
 
 static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
@@ -780,7 +798,7 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
 {
 	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
 	struct stm32_mdma_desc *desc;
-	int ret;
+	int i, ret;
 
 	/*
 	 * Once DMA is in setup cyclic mode the channel we cannot assign this
@@ -806,7 +824,9 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 
 xfer_setup_err:
-	dma_pool_free(chan->desc_pool, &desc->hwdesc, desc->hwdesc_phys);
+	for (i = 0; i < desc->count; i++)
+		dma_pool_free(chan->desc_pool, desc->node[i].hwdesc,
+			      desc->node[i].hwdesc_phys);
 	kfree(desc);
 	return NULL;
 }
@@ -895,7 +915,9 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 
 xfer_setup_err:
-	dma_pool_free(chan->desc_pool, &desc->hwdesc, desc->hwdesc_phys);
+	for (i = 0; i < desc->count; i++)
+		dma_pool_free(chan->desc_pool, desc->node[i].hwdesc,
+			      desc->node[i].hwdesc_phys);
 	kfree(desc);
 	return NULL;
 }
@@ -1009,7 +1031,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 			ctcr |= STM32_MDMA_CTCR_PKE;
 
 		/* Prepare hardware descriptor */
-		hwdesc = desc->hwdesc;
+		hwdesc = desc->node[0].hwdesc;
 		hwdesc->ctcr = ctcr;
 		hwdesc->cbndtr = cbndtr;
 		hwdesc->csar = src;
@@ -1020,7 +1042,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 		hwdesc->cmar = 0;
 		hwdesc->cmdr = 0;
 
-		stm32_mdma_dump_hwdesc(chan, hwdesc);
+		stm32_mdma_dump_hwdesc(chan, &desc->node[0]);
 	} else {
 		/* Setup a LLI transfer */
 		ctcr |= STM32_MDMA_CTCR_TRGM(STM32_MDMA_LINKED_LIST) |
@@ -1120,7 +1142,7 @@ static void stm32_mdma_start_transfer(struct stm32_mdma_chan *chan)
 	}
 
 	chan->desc = to_stm32_mdma_desc(vdesc);
-	hwdesc = chan->desc->hwdesc;
+	hwdesc = chan->desc->node[0].hwdesc;
 	chan->curr_hwdesc = 0;
 
 	stm32_mdma_write(dmadev, STM32_MDMA_CCR(id), chan->desc->ccr);
@@ -1198,7 +1220,7 @@ static int stm32_mdma_resume(struct dma_chan *c)
 	unsigned long flags;
 	u32 status, reg;
 
-	hwdesc = &chan->desc->hwdesc[chan->curr_hwdesc];
+	hwdesc = chan->desc->node[chan->curr_hwdesc].hwdesc;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
@@ -1268,13 +1290,13 @@ static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
 				      u32 curr_hwdesc)
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
+	struct stm32_mdma_hwdesc *hwdesc = desc->node[0].hwdesc;
 	u32 cbndtr, residue, modulo, burst_size;
 	int i;
 
 	residue = 0;
 	for (i = curr_hwdesc + 1; i < desc->count; i++) {
-		struct stm32_mdma_hwdesc *hwdesc = &desc->hwdesc[i];
-
+		hwdesc = desc->node[i].hwdesc;
 		residue += STM32_MDMA_CBNDTR_BNDT(hwdesc->cbndtr);
 	}
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
-- 
2.7.4
