Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933625AbeCMQm5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:42:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58761 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933464AbeCMQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:49 -0400
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
Subject: [PATCH v1 4/8] dmaengine: stm32-dma: fix DMA IRQ status handling
Date: Tue, 13 Mar 2018 17:42:03 +0100
Message-ID: <1520959327-25760-5-git-send-email-pierre-yves.mordret@st.com>
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

Update the way Transfer Complete and Half Transfer Complete status are
acknowledge. Even if HTI is not enabled its status is shown when reading
registers, driver has to clear it gently and not raise an error.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index a7edd6d..0685961 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -34,9 +34,14 @@
 #define STM32_DMA_LIFCR			0x0008 /* DMA Low Int Flag Clear Reg */
 #define STM32_DMA_HIFCR			0x000c /* DMA High Int Flag Clear Reg */
 #define STM32_DMA_TCI			BIT(5) /* Transfer Complete Interrupt */
+#define STM32_DMA_HTI			BIT(4) /* Half Transfer Interrupt */
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
+#define STM32_DMA_MASKI			(STM32_DMA_TCI \
+					 | STM32_DMA_TEI \
+					 | STM32_DMA_DMEI \
+					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -637,13 +642,29 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	status = stm32_dma_irq_status(chan);
 	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
 
-	if ((status & STM32_DMA_TCI) && (scr & STM32_DMA_SCR_TCIE)) {
+	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
-		stm32_dma_handle_chan_done(chan);
-
-	} else {
+		if (scr & STM32_DMA_SCR_TCIE)
+			stm32_dma_handle_chan_done(chan);
+		status &= ~STM32_DMA_TCI;
+	}
+	if (status & STM32_DMA_HTI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_HTI);
+		status &= ~STM32_DMA_HTI;
+	}
+	if (status & STM32_DMA_FEI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_FEI);
+		status &= ~STM32_DMA_FEI;
+		if (!(scr & STM32_DMA_SCR_EN))
+			dev_err(chan2dev(chan), "FIFO Error\n");
+		else
+			dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+	}
+	if (status) {
 		stm32_dma_irq_clear(chan, status);
 		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
+		if (!(scr & STM32_DMA_SCR_EN))
+			dev_err(chan2dev(chan), "chan disabled by HW\n");
 	}
 
 	spin_unlock(&chan->vchan.lock);
-- 
2.7.4
