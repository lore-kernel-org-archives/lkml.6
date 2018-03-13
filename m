Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeCMQmq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:42:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59850 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752892AbeCMQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:42 -0400
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
Subject: [PATCH v1 5/8] dmaengine: stm32-dma: fix max items per transfer
Date: Tue, 13 Mar 2018 17:42:04 +0100
Message-ID: <1520959327-25760-6-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having 0 in item counter register is valid and stands for a "No or Ended
transfer". Therefore valid transfer starts from @+0 to @+0xFFFE leading to
unaligned scatter gather at boundary. Thus it's safer to round down this
value on its FIFO size (16 Bytes).

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 0685961..f9d3c84 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -38,10 +38,6 @@
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
-#define STM32_DMA_MASKI			(STM32_DMA_TCI \
-					 | STM32_DMA_TEI \
-					 | STM32_DMA_DMEI \
-					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -117,6 +113,13 @@
 #define STM32_DMA_FIFO_THRESHOLD_FULL			0x03
 
 #define STM32_DMA_MAX_DATA_ITEMS	0xffff
+/*
+ * Valid transfer starts from @0 to @0xFFFE leading to unaligned scatter
+ * gather at boundary. Thus it's safer to round down this value on FIFO
+ * size (16 Bytes)
+ */
+#define STM32_DMA_ALIGNED_MAX_DATA_ITEMS	\
+	ALIGN_DOWN(STM32_DMA_MAX_DATA_ITEMS, 16)
 #define STM32_DMA_MAX_CHANNELS		0x08
 #define STM32_DMA_MAX_REQUEST_ID	0x08
 #define STM32_DMA_MAX_DATA_PARAM	0x03
@@ -864,7 +867,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		desc->sg_req[i].len = sg_dma_len(sg);
 
 		nb_data_items = desc->sg_req[i].len / buswidth;
-		if (nb_data_items > STM32_DMA_MAX_DATA_ITEMS) {
+		if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
 			dev_err(chan2dev(chan), "nb items not supported\n");
 			goto err;
 		}
@@ -930,7 +933,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 		return NULL;
 
 	nb_data_items = period_len / buswidth;
-	if (nb_data_items > STM32_DMA_MAX_DATA_ITEMS) {
+	if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
 		dev_err(chan2dev(chan), "number of items not supported\n");
 		return NULL;
 	}
@@ -980,7 +983,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	u32 num_sgs, best_burst, dma_burst, threshold;
 	int i;
 
-	num_sgs = DIV_ROUND_UP(len, STM32_DMA_MAX_DATA_ITEMS);
+	num_sgs = DIV_ROUND_UP(len, STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
 	desc = stm32_dma_alloc_desc(num_sgs);
 	if (!desc)
 		return NULL;
@@ -989,7 +992,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 
 	for (offset = 0, i = 0; offset < len; offset += xfer_count, i++) {
 		xfer_count = min_t(size_t, len - offset,
-				   STM32_DMA_MAX_DATA_ITEMS);
+				   STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
 
 		/* Compute best burst size */
 		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-- 
2.7.4
