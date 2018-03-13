Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeCMQo7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:44:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53391 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933452AbeCMQmt (ORCPT
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
Subject: [PATCH v1 6/8] dmaengine: stm32-dma: properly mask irq bits
Date: Tue, 13 Mar 2018 17:42:05 +0100
Message-ID: <1520959327-25760-7-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single register of the controller holds the information for four dma
channels.
The functions stm32_dma_irq_status() don't mask the relevant bits after
the shift, thus adjacent channel's status is also reported in the returned
value.
Fixed by masking the value before returning it.

Similarly, the function stm32_dma_irq_clear() don't mask the input value
before shifting it, thus an incorrect input value could disable the
interrupts of adjacent channels.
Fixed by masking the input value before using it.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index f9d3c84..a11cbee 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -38,6 +38,10 @@
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
+#define STM32_DMA_MASKI			(STM32_DMA_TCI \
+					 | STM32_DMA_TEI \
+					 | STM32_DMA_DMEI \
+					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -404,7 +408,7 @@ static u32 stm32_dma_irq_status(struct stm32_dma_chan *chan)
 
 	flags = dma_isr >> (((chan->id & 2) << 3) | ((chan->id & 1) * 6));
 
-	return flags;
+	return flags & STM32_DMA_MASKI;
 }
 
 static void stm32_dma_irq_clear(struct stm32_dma_chan *chan, u32 flags)
@@ -419,6 +423,7 @@ static void stm32_dma_irq_clear(struct stm32_dma_chan *chan, u32 flags)
 	 * If (ch % 4) is 2 or 3, left shift the mask by 16 bits.
 	 * If (ch % 4) is 1 or 3, additionally left shift the mask by 6 bits.
 	 */
+	flags &= STM32_DMA_MASKI;
 	dma_ifcr = flags << (((chan->id & 2) << 3) | ((chan->id & 1) * 6));
 
 	if (chan->id & 4)
-- 
2.7.4
