Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933694AbeCMQno (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:43:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59871 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933466AbeCMQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:54 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 3/8] dmaengine: stm32-dma: Improve memory burst management
Date: Tue, 13 Mar 2018 17:42:02 +0100
Message-ID: <1520959327-25760-4-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves memory burst capability using best burst size
according to transferred buffer size from/to memory.

>From now on, memory burst is not necessarily same as with peripheral
burst one and fifo threshold is directly managed by this driver in order
to fit with computed memory burst.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 204 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 175 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 4099948..a7edd6d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) M'boumba Cedric Madianga 2015
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
+ *         Pierre-Yves Mordret <pierre-yves.mordret@st.com>
  *
  * License terms:  GNU General Public License (GPL), version 2
  */
@@ -114,6 +115,8 @@
 #define STM32_DMA_MAX_CHANNELS		0x08
 #define STM32_DMA_MAX_REQUEST_ID	0x08
 #define STM32_DMA_MAX_DATA_PARAM	0x03
+#define STM32_DMA_FIFO_SIZE		16	/* FIFO is 16 bytes */
+#define STM32_DMA_MIN_BURST		4
 #define STM32_DMA_MAX_BURST		16
 
 /* DMA Features */
@@ -183,6 +186,8 @@ struct stm32_dma_chan {
 	struct dma_slave_config	dma_sconfig;
 	struct stm32_dma_chan_reg chan_reg;
 	u32 threshold;
+	u32 mem_burst;
+	u32 mem_width;
 };
 
 struct stm32_dma_device {
@@ -247,6 +252,85 @@ static int stm32_dma_get_width(struct stm32_dma_chan *chan,
 	}
 }
 
+static enum dma_slave_buswidth stm32_dma_get_max_width(u32 buf_len,
+						       u32 threshold)
+{
+	enum dma_slave_buswidth max_width;
+
+	if (threshold == STM32_DMA_FIFO_THRESHOLD_FULL)
+		max_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	else
+		max_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	while ((buf_len < max_width  || buf_len % max_width) &&
+	       max_width > DMA_SLAVE_BUSWIDTH_1_BYTE)
+		max_width = max_width >> 1;
+
+	return max_width;
+}
+
+static bool stm32_dma_fifo_threshold_is_allowed(u32 burst, u32 threshold,
+						enum dma_slave_buswidth width)
+{
+	u32 remaining;
+
+	if (width != DMA_SLAVE_BUSWIDTH_UNDEFINED) {
+		if (burst != 0) {
+			/*
+			 * If number of beats fit in several whole bursts
+			 * this configuration is allowed.
+			 */
+			remaining = ((STM32_DMA_FIFO_SIZE / width) *
+				     (threshold + 1) / 4) % burst;
+
+			if (remaining == 0)
+				return true;
+		} else {
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool stm32_dma_is_burst_possible(u32 buf_len, u32 threshold)
+{
+	switch (threshold) {
+	case STM32_DMA_FIFO_THRESHOLD_FULL:
+		if (buf_len >= STM32_DMA_MAX_BURST)
+			return true;
+		else
+			return false;
+	case STM32_DMA_FIFO_THRESHOLD_HALFFULL:
+		if (buf_len >= STM32_DMA_MAX_BURST / 2)
+			return true;
+		else
+			return false;
+	default:
+		return false;
+	}
+}
+
+static u32 stm32_dma_get_best_burst(u32 buf_len, u32 max_burst, u32 threshold,
+				    enum dma_slave_buswidth width)
+{
+	u32 best_burst = max_burst;
+
+	if (best_burst == 1 || !stm32_dma_is_burst_possible(buf_len, threshold))
+		return 0;
+
+	while ((buf_len < best_burst * width && best_burst > 1) ||
+	       !stm32_dma_fifo_threshold_is_allowed(best_burst, threshold,
+						    width)) {
+		if (best_burst > STM32_DMA_MIN_BURST)
+			best_burst = best_burst >> 1;
+		else
+			best_burst = 0;
+	}
+
+	return best_burst;
+}
+
 static int stm32_dma_get_burst(struct stm32_dma_chan *chan, u32 maxburst)
 {
 	switch (maxburst) {
@@ -266,12 +350,12 @@ static int stm32_dma_get_burst(struct stm32_dma_chan *chan, u32 maxburst)
 }
 
 static void stm32_dma_set_fifo_config(struct stm32_dma_chan *chan,
-				      u32 src_maxburst, u32 dst_maxburst)
+				      u32 src_burst, u32 dst_burst)
 {
 	chan->chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_MASK;
 	chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_DMEIE;
 
-	if ((!src_maxburst) && (!dst_maxburst)) {
+	if (!src_burst && !dst_burst) {
 		/* Using direct mode */
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_DMEIE;
 	} else {
@@ -584,37 +668,52 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 
 static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 				    enum dma_transfer_direction direction,
-				    enum dma_slave_buswidth *buswidth)
+				    enum dma_slave_buswidth *buswidth,
+				    u32 buf_len)
 {
 	enum dma_slave_buswidth src_addr_width, dst_addr_width;
 	int src_bus_width, dst_bus_width;
 	int src_burst_size, dst_burst_size;
-	u32 src_maxburst, dst_maxburst;
-	u32 dma_scr = 0;
+	u32 src_maxburst, dst_maxburst, src_best_burst, dst_best_burst;
+	u32 dma_scr, threshold;
 
 	src_addr_width = chan->dma_sconfig.src_addr_width;
 	dst_addr_width = chan->dma_sconfig.dst_addr_width;
 	src_maxburst = chan->dma_sconfig.src_maxburst;
 	dst_maxburst = chan->dma_sconfig.dst_maxburst;
+	threshold = chan->threshold;
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
+		/* Set device data size */
 		dst_bus_width = stm32_dma_get_width(chan, dst_addr_width);
 		if (dst_bus_width < 0)
 			return dst_bus_width;
 
-		dst_burst_size = stm32_dma_get_burst(chan, dst_maxburst);
+		/* Set device burst size */
+		dst_best_burst = stm32_dma_get_best_burst(buf_len,
+							  dst_maxburst,
+							  threshold,
+							  dst_addr_width);
+
+		dst_burst_size = stm32_dma_get_burst(chan, dst_best_burst);
 		if (dst_burst_size < 0)
 			return dst_burst_size;
 
-		if (!src_addr_width)
-			src_addr_width = dst_addr_width;
-
+		/* Set memory data size */
+		src_addr_width = stm32_dma_get_max_width(buf_len, threshold);
+		chan->mem_width = src_addr_width;
 		src_bus_width = stm32_dma_get_width(chan, src_addr_width);
 		if (src_bus_width < 0)
 			return src_bus_width;
 
-		src_burst_size = stm32_dma_get_burst(chan, src_maxburst);
+		/* Set memory burst size */
+		src_maxburst = STM32_DMA_MAX_BURST;
+		src_best_burst = stm32_dma_get_best_burst(buf_len,
+							  src_maxburst,
+							  threshold,
+							  src_addr_width);
+		src_burst_size = stm32_dma_get_burst(chan, src_best_burst);
 		if (src_burst_size < 0)
 			return src_burst_size;
 
@@ -624,27 +723,46 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 			STM32_DMA_SCR_PBURST(dst_burst_size) |
 			STM32_DMA_SCR_MBURST(src_burst_size);
 
+		/* Set FIFO threshold */
+		chan->chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_FTH_MASK;
+		chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(threshold);
+
+		/* Set peripheral address */
 		chan->chan_reg.dma_spar = chan->dma_sconfig.dst_addr;
 		*buswidth = dst_addr_width;
 		break;
 
 	case DMA_DEV_TO_MEM:
+		/* Set device data size */
 		src_bus_width = stm32_dma_get_width(chan, src_addr_width);
 		if (src_bus_width < 0)
 			return src_bus_width;
 
-		src_burst_size = stm32_dma_get_burst(chan, src_maxburst);
+		/* Set device burst size */
+		src_best_burst = stm32_dma_get_best_burst(buf_len,
+							  src_maxburst,
+							  threshold,
+							  src_addr_width);
+		chan->mem_burst = src_best_burst;
+		src_burst_size = stm32_dma_get_burst(chan, src_best_burst);
 		if (src_burst_size < 0)
 			return src_burst_size;
 
-		if (!dst_addr_width)
-			dst_addr_width = src_addr_width;
-
+		/* Set memory data size */
+		dst_addr_width = stm32_dma_get_max_width(buf_len, threshold);
+		chan->mem_width = dst_addr_width;
 		dst_bus_width = stm32_dma_get_width(chan, dst_addr_width);
 		if (dst_bus_width < 0)
 			return dst_bus_width;
 
-		dst_burst_size = stm32_dma_get_burst(chan, dst_maxburst);
+		/* Set memory burst size */
+		dst_maxburst = STM32_DMA_MAX_BURST;
+		dst_best_burst = stm32_dma_get_best_burst(buf_len,
+							  dst_maxburst,
+							  threshold,
+							  dst_addr_width);
+		chan->mem_burst = dst_best_burst;
+		dst_burst_size = stm32_dma_get_burst(chan, dst_best_burst);
 		if (dst_burst_size < 0)
 			return dst_burst_size;
 
@@ -654,6 +772,11 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 			STM32_DMA_SCR_PBURST(src_burst_size) |
 			STM32_DMA_SCR_MBURST(dst_burst_size);
 
+		/* Set FIFO threshold */
+		chan->chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_FTH_MASK;
+		chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(threshold);
+
+		/* Set peripheral address */
 		chan->chan_reg.dma_spar = chan->dma_sconfig.src_addr;
 		*buswidth = chan->dma_sconfig.src_addr_width;
 		break;
@@ -663,8 +786,9 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		return -EINVAL;
 	}
 
-	stm32_dma_set_fifo_config(chan, src_maxburst, dst_maxburst);
+	stm32_dma_set_fifo_config(chan, src_best_burst, dst_best_burst);
 
+	/* Set DMA control register */
 	chan->chan_reg.dma_scr &= ~(STM32_DMA_SCR_DIR_MASK |
 			STM32_DMA_SCR_PSIZE_MASK | STM32_DMA_SCR_MSIZE_MASK |
 			STM32_DMA_SCR_PBURST_MASK | STM32_DMA_SCR_MBURST_MASK);
@@ -704,10 +828,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 	if (!desc)
 		return NULL;
 
-	ret = stm32_dma_set_xfer_param(chan, direction, &buswidth);
-	if (ret < 0)
-		goto err;
-
 	/* Set peripheral flow controller */
 	if (chan->dma_sconfig.device_fc)
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_PFCTRL;
@@ -715,6 +835,11 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_PFCTRL;
 
 	for_each_sg(sgl, sg, sg_len, i) {
+		ret = stm32_dma_set_xfer_param(chan, direction, &buswidth,
+					       sg_dma_len(sg));
+		if (ret < 0)
+			goto err;
+
 		desc->sg_req[i].len = sg_dma_len(sg);
 
 		nb_data_items = desc->sg_req[i].len / buswidth;
@@ -779,7 +904,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 		return NULL;
 	}
 
-	ret = stm32_dma_set_xfer_param(chan, direction, &buswidth);
+	ret = stm32_dma_set_xfer_param(chan, direction, &buswidth, period_len);
 	if (ret < 0)
 		return NULL;
 
@@ -828,9 +953,10 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	dma_addr_t src, size_t len, unsigned long flags)
 {
 	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
-	u32 num_sgs;
+	enum dma_slave_buswidth max_width;
 	struct stm32_dma_desc *desc;
 	size_t xfer_count, offset;
+	u32 num_sgs, best_burst, dma_burst, threshold;
 	int i;
 
 	num_sgs = DIV_ROUND_UP(len, STM32_DMA_MAX_DATA_ITEMS);
@@ -838,25 +964,34 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	if (!desc)
 		return NULL;
 
+	threshold = chan->threshold;
+
 	for (offset = 0, i = 0; offset < len; offset += xfer_count, i++) {
 		xfer_count = min_t(size_t, len - offset,
 				   STM32_DMA_MAX_DATA_ITEMS);
 
-		desc->sg_req[i].len = xfer_count;
+		/* Compute best burst size */
+		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		best_burst = stm32_dma_get_best_burst(len, STM32_DMA_MAX_BURST,
+						      threshold, max_width);
+		dma_burst = stm32_dma_get_burst(chan, best_burst);
 
 		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
 		desc->sg_req[i].chan_reg.dma_scr =
 			STM32_DMA_SCR_DIR(STM32_DMA_MEM_TO_MEM) |
+			STM32_DMA_SCR_PBURST(dma_burst) |
+			STM32_DMA_SCR_MBURST(dma_burst) |
 			STM32_DMA_SCR_MINC |
 			STM32_DMA_SCR_PINC |
 			STM32_DMA_SCR_TCIE |
 			STM32_DMA_SCR_TEIE;
-		desc->sg_req[i].chan_reg.dma_sfcr = STM32_DMA_SFCR_DMDIS |
-			STM32_DMA_SFCR_FTH(STM32_DMA_FIFO_THRESHOLD_FULL) |
-			STM32_DMA_SFCR_FEIE;
+		desc->sg_req[i].chan_reg.dma_sfcr |= STM32_DMA_SFCR_MASK;
+		desc->sg_req[i].chan_reg.dma_sfcr |=
+			STM32_DMA_SFCR_FTH(threshold);
 		desc->sg_req[i].chan_reg.dma_spar = src + offset;
 		desc->sg_req[i].chan_reg.dma_sm0ar = dest + offset;
 		desc->sg_req[i].chan_reg.dma_sndtr = xfer_count;
+		desc->sg_req[i].len = xfer_count;
 	}
 
 	desc->num_sgs = num_sgs;
@@ -881,6 +1016,7 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 				     struct stm32_dma_desc *desc,
 				     u32 next_sg)
 {
+	u32 modulo, burst_size;
 	u32 residue = 0;
 	int i;
 
@@ -888,8 +1024,10 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 	 * In cyclic mode, for the last period, residue = remaining bytes from
 	 * NDTR
 	 */
-	if (chan->desc->cyclic && next_sg == 0)
-		return stm32_dma_get_remaining_bytes(chan);
+	if (chan->desc->cyclic && next_sg == 0) {
+		residue = stm32_dma_get_remaining_bytes(chan);
+		goto end;
+	}
 
 	/*
 	 * For all other periods in cyclic mode, and in sg mode,
@@ -900,6 +1038,15 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 		residue += desc->sg_req[i].len;
 	residue += stm32_dma_get_remaining_bytes(chan);
 
+end:
+	if (!chan->mem_burst)
+		return residue;
+
+	burst_size = chan->mem_burst * chan->mem_width;
+	modulo = residue % burst_size;
+	if (modulo)
+		residue = residue - modulo + burst_size;
+
 	return residue;
 }
 
@@ -989,7 +1136,6 @@ static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 	chan->chan_reg.dma_scr |= STM32_DMA_SCR_TEIE | STM32_DMA_SCR_TCIE;
 
 	chan->threshold = STM32_DMA_THRESHOLD_FTR_GET(cfg->features);
-	chan->chan_reg.dma_sfcr = STM32_DMA_SFCR_FTH(chan->threshold);
 }
 
 static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
-- 
2.7.4
