Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeCMQm7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:42:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22736 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933454AbeCMQmt (ORCPT
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
Subject: [PATCH v1 2/8] dmaengine: stm32-dma: threshold manages with bitfield feature
Date: Tue, 13 Mar 2018 17:42:01 +0100
Message-ID: <1520959327-25760-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From now on, DMA bitfield is to manage DMA FIFO Threshold.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 786fc8f..4099948 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -116,6 +116,10 @@
 #define STM32_DMA_MAX_DATA_PARAM	0x03
 #define STM32_DMA_MAX_BURST		16
 
+/* DMA Features */
+#define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
+#define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
+
 enum stm32_dma_width {
 	STM32_DMA_BYTE,
 	STM32_DMA_HALF_WORD,
@@ -129,11 +133,18 @@ enum stm32_dma_burst_size {
 	STM32_DMA_BURST_INCR16,
 };
 
+/**
+ * struct stm32_dma_cfg - STM32 DMA custom configuration
+ * @channel_id: channel ID
+ * @request_line: DMA request
+ * @stream_config: 32bit mask specifying the DMA channel configuration
+ * @features: 32bit mask specifying the DMA Feature list
+ */
 struct stm32_dma_cfg {
 	u32 channel_id;
 	u32 request_line;
 	u32 stream_config;
-	u32 threshold;
+	u32 features;
 };
 
 struct stm32_dma_chan_reg {
@@ -171,6 +182,7 @@ struct stm32_dma_chan {
 	u32 next_sg;
 	struct dma_slave_config	dma_sconfig;
 	struct stm32_dma_chan_reg chan_reg;
+	u32 threshold;
 };
 
 struct stm32_dma_device {
@@ -976,7 +988,8 @@ static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 	/* Enable Interrupts  */
 	chan->chan_reg.dma_scr |= STM32_DMA_SCR_TEIE | STM32_DMA_SCR_TCIE;
 
-	chan->chan_reg.dma_sfcr = cfg->threshold & STM32_DMA_SFCR_FTH_MASK;
+	chan->threshold = STM32_DMA_THRESHOLD_FTR_GET(cfg->features);
+	chan->chan_reg.dma_sfcr = STM32_DMA_SFCR_FTH(chan->threshold);
 }
 
 static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
@@ -996,7 +1009,7 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 	cfg.channel_id = dma_spec->args[0];
 	cfg.request_line = dma_spec->args[1];
 	cfg.stream_config = dma_spec->args[2];
-	cfg.threshold = dma_spec->args[3];
+	cfg.features = dma_spec->args[3];
 
 	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
 	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
-- 
2.7.4
