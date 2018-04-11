Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeDKN0K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:26:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41613 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753393AbeDKN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:26:07 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 5/6] i2c: i2c-stm32f7: Add DMA support
Date: Wed, 11 Apr 2018 15:24:57 +0200
Message-ID: <1523453098-3758-6-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DMA support for i2c-stm32f7 driver

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
    v2:
       * fix kbuild test robot issue (format)
    v3:
       * Raise DMA usage threshold
---

fixup! i2c: i2c-stm32f7: Add DMA support
---
 drivers/i2c/busses/Makefile      |   3 +-
 drivers/i2c/busses/i2c-stm32f7.c | 214 +++++++++++++++++++++++++++++++++++----
 2 files changed, 196 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 40ab7bf..f6a8654 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -95,7 +95,8 @@ obj-$(CONFIG_I2C_SIRF)		+= i2c-sirf.o
 obj-$(CONFIG_I2C_SPRD)		+= i2c-sprd.o
 obj-$(CONFIG_I2C_ST)		+= i2c-st.o
 obj-$(CONFIG_I2C_STM32F4)	+= i2c-stm32f4.o
-obj-$(CONFIG_I2C_STM32F7)	+= i2c-stm32f7.o
+i2c-stm32f7-drv-objs := i2c-stm32f7.o i2c-stm32.o
+obj-$(CONFIG_I2C_STM32F7)	+= i2c-stm32f7-drv.o
 obj-$(CONFIG_I2C_STU300)	+= i2c-stu300.o
 obj-$(CONFIG_I2C_SUN6I_P2WI)	+= i2c-sun6i-p2wi.o
 obj-$(CONFIG_I2C_SYNQUACER)	+= i2c-synquacer.o
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 0b81b5d..63ea71c 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -47,6 +47,8 @@
 /* STM32F7 I2C control 1 */
 #define STM32F7_I2C_CR1_PECEN			BIT(23)
 #define STM32F7_I2C_CR1_SBC			BIT(16)
+#define STM32F7_I2C_CR1_RXDMAEN			BIT(15)
+#define STM32F7_I2C_CR1_TXDMAEN			BIT(14)
 #define STM32F7_I2C_CR1_ANFOFF			BIT(12)
 #define STM32F7_I2C_CR1_ERRIE			BIT(7)
 #define STM32F7_I2C_CR1_TCIE			BIT(6)
@@ -142,6 +144,7 @@
 #define STM32F7_I2C_TIMINGR_SCLL(n)		((n) & 0xff)
 
 #define STM32F7_I2C_MAX_LEN			0xff
+#define STM32F7_I2C_DMA_LEN_MIN			0x16
 #define STM32F7_I2C_MAX_SLAVE			0x2
 
 #define STM32F7_I2C_DNF_DEFAULT			0
@@ -270,6 +273,8 @@ struct stm32f7_i2c_msg {
  * @slave_dir: transfer direction for the current slave device
  * @master_mode: boolean to know in which mode the I2C is running (master or
  * slave)
+ * @dma: dma data
+ * @use_dma: boolean to know if dma is used in the current transfer
  */
 struct stm32f7_i2c_dev {
 	struct i2c_adapter adap;
@@ -288,6 +293,8 @@ struct stm32f7_i2c_dev {
 	struct i2c_client *slave_running;
 	u32 slave_dir;
 	bool master_mode;
+	struct stm32_i2c_dma *dma;
+	bool use_dma;
 };
 
 /**
@@ -599,6 +606,25 @@ static int stm32f7_i2c_setup_timing(struct stm32f7_i2c_dev *i2c_dev,
 	return 0;
 }
 
+static void stm32f7_i2c_disable_dma_req(struct stm32f7_i2c_dev *i2c_dev)
+{
+	void __iomem *base = i2c_dev->base;
+	u32 mask = STM32F7_I2C_CR1_RXDMAEN | STM32F7_I2C_CR1_TXDMAEN;
+
+	stm32f7_i2c_clr_bits(base + STM32F7_I2C_CR1, mask);
+}
+
+static void stm32f7_i2c_dma_callback(void *arg)
+{
+	struct stm32f7_i2c_dev *i2c_dev = (struct stm32f7_i2c_dev *)arg;
+	struct stm32_i2c_dma *dma = i2c_dev->dma;
+	struct device *dev = dma->chan_using->device->dev;
+
+	stm32f7_i2c_disable_dma_req(i2c_dev);
+	dma_unmap_single(dev, dma->dma_buf, dma->dma_len, dma->dma_data_dir);
+	complete(&dma->dma_complete);
+}
+
 static void stm32f7_i2c_hw_config(struct stm32f7_i2c_dev *i2c_dev)
 {
 	struct stm32f7_i2c_timings *t = &i2c_dev->timing;
@@ -653,6 +679,9 @@ static void stm32f7_i2c_reload(struct stm32f7_i2c_dev *i2c_dev)
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
 	u32 cr2;
 
+	if (i2c_dev->use_dma)
+		f7_msg->count -= STM32F7_I2C_MAX_LEN;
+
 	cr2 = readl_relaxed(i2c_dev->base + STM32F7_I2C_CR2);
 
 	cr2 &= ~STM32F7_I2C_CR2_NBYTES_MASK;
@@ -712,6 +741,7 @@ static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
 	void __iomem *base = i2c_dev->base;
 	u32 cr1, cr2;
+	int ret;
 
 	f7_msg->addr = msg->addr;
 	f7_msg->buf = msg->buf;
@@ -753,14 +783,35 @@ static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	cr1 |= STM32F7_I2C_CR1_ERRIE | STM32F7_I2C_CR1_TCIE |
 		STM32F7_I2C_CR1_STOPIE | STM32F7_I2C_CR1_NACKIE;
 
-	/* Clear TX/RX interrupt */
-	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE);
+	/* Clear DMA req and TX/RX interrupt */
+	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE |
+			STM32F7_I2C_CR1_RXDMAEN | STM32F7_I2C_CR1_TXDMAEN);
+
+	/* Configure DMA or enable RX/TX interrupt */
+	i2c_dev->use_dma = false;
+	if (i2c_dev->dma && f7_msg->count >= STM32F7_I2C_DMA_LEN_MIN) {
+		ret = stm32_i2c_prep_dma_xfer(i2c_dev->dev, i2c_dev->dma,
+					      msg->flags & I2C_M_RD,
+					      f7_msg->count, f7_msg->buf,
+					      stm32f7_i2c_dma_callback,
+					      i2c_dev);
+		if (!ret)
+			i2c_dev->use_dma = true;
+		else
+			dev_warn(i2c_dev->dev, "can't use DMA\n");
+	}
 
-	/* Enable RX/TX interrupt according to msg direction */
-	if (msg->flags & I2C_M_RD)
-		cr1 |= STM32F7_I2C_CR1_RXIE;
-	else
-		cr1 |= STM32F7_I2C_CR1_TXIE;
+	if (!i2c_dev->use_dma) {
+		if (msg->flags & I2C_M_RD)
+			cr1 |= STM32F7_I2C_CR1_RXIE;
+		else
+			cr1 |= STM32F7_I2C_CR1_TXIE;
+	} else {
+		if (msg->flags & I2C_M_RD)
+			cr1 |= STM32F7_I2C_CR1_RXDMAEN;
+		else
+			cr1 |= STM32F7_I2C_CR1_TXDMAEN;
+	}
 
 	/* Configure Start/Repeated Start */
 	cr2 |= STM32F7_I2C_CR2_START;
@@ -780,7 +831,7 @@ static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	struct device *dev = i2c_dev->dev;
 	void __iomem *base = i2c_dev->base;
 	u32 cr1, cr2;
-	int i;
+	int i, ret;
 
 	f7_msg->result = 0;
 	reinit_completion(&i2c_dev->complete);
@@ -895,14 +946,35 @@ static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	cr1 |= STM32F7_I2C_CR1_ERRIE | STM32F7_I2C_CR1_TCIE |
 		STM32F7_I2C_CR1_STOPIE | STM32F7_I2C_CR1_NACKIE;
 
-	/* Clear TX/RX interrupt */
-	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE);
+	/* Clear DMA req and TX/RX interrupt */
+	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE |
+			STM32F7_I2C_CR1_RXDMAEN | STM32F7_I2C_CR1_TXDMAEN);
+
+	/* Configure DMA or enable RX/TX interrupt */
+	i2c_dev->use_dma = false;
+	if (i2c_dev->dma && f7_msg->count >= STM32F7_I2C_DMA_LEN_MIN) {
+		ret = stm32_i2c_prep_dma_xfer(i2c_dev->dev, i2c_dev->dma,
+					      cr2 & STM32F7_I2C_CR2_RD_WRN,
+					      f7_msg->count, f7_msg->buf,
+					      stm32f7_i2c_dma_callback,
+					      i2c_dev);
+		if (!ret)
+			i2c_dev->use_dma = true;
+		else
+			dev_warn(i2c_dev->dev, "can't use DMA\n");
+	}
 
-	/* Enable RX/TX interrupt according to msg direction */
-	if (cr2 & STM32F7_I2C_CR2_RD_WRN)
-		cr1 |= STM32F7_I2C_CR1_RXIE;
-	else
-		cr1 |= STM32F7_I2C_CR1_TXIE;
+	if (!i2c_dev->use_dma) {
+		if (cr2 & STM32F7_I2C_CR2_RD_WRN)
+			cr1 |= STM32F7_I2C_CR1_RXIE;
+		else
+			cr1 |= STM32F7_I2C_CR1_TXIE;
+	} else {
+		if (cr2 & STM32F7_I2C_CR2_RD_WRN)
+			cr1 |= STM32F7_I2C_CR1_RXDMAEN;
+		else
+			cr1 |= STM32F7_I2C_CR1_TXDMAEN;
+	}
 
 	/* Set Start bit */
 	cr2 |= STM32F7_I2C_CR2_START;
@@ -921,6 +993,7 @@ static void stm32f7_i2c_smbus_rep_start(struct stm32f7_i2c_dev *i2c_dev)
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
 	void __iomem *base = i2c_dev->base;
 	u32 cr1, cr2;
+	int ret;
 
 	cr2 = readl_relaxed(base + STM32F7_I2C_CR2);
 	cr1 = readl_relaxed(base + STM32F7_I2C_CR1);
@@ -960,6 +1033,35 @@ static void stm32f7_i2c_smbus_rep_start(struct stm32f7_i2c_dev *i2c_dev)
 	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE);
 	cr1 |= STM32F7_I2C_CR1_RXIE;
 
+	/*
+	 * Configure DMA or enable RX/TX interrupt:
+	 * For I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_BLOCK_PROC_CALL we don't use
+	 * dma as we don't know in advance how many data will be received
+	 */
+	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE |
+		 STM32F7_I2C_CR1_RXDMAEN | STM32F7_I2C_CR1_TXDMAEN);
+
+	i2c_dev->use_dma = false;
+	if (i2c_dev->dma && f7_msg->count >= STM32F7_I2C_DMA_LEN_MIN &&
+	    f7_msg->size != I2C_SMBUS_BLOCK_DATA &&
+	    f7_msg->size != I2C_SMBUS_BLOCK_PROC_CALL) {
+		ret = stm32_i2c_prep_dma_xfer(i2c_dev->dev, i2c_dev->dma,
+					      cr2 & STM32F7_I2C_CR2_RD_WRN,
+					      f7_msg->count, f7_msg->buf,
+					      stm32f7_i2c_dma_callback,
+					      i2c_dev);
+
+		if (!ret)
+			i2c_dev->use_dma = true;
+		else
+			dev_warn(i2c_dev->dev, "can't use DMA\n");
+	}
+
+	if (!i2c_dev->use_dma)
+		cr1 |= STM32F7_I2C_CR1_RXIE;
+	else
+		cr1 |= STM32F7_I2C_CR1_RXDMAEN;
+
 	/* Configure Repeated Start */
 	cr2 |= STM32F7_I2C_CR2_START;
 
@@ -1248,7 +1350,7 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
 	void __iomem *base = i2c_dev->base;
 	u32 status, mask;
-	int ret;
+	int ret = IRQ_HANDLED;
 
 	/* Check if the interrupt if for a slave device */
 	if (!i2c_dev->master_mode) {
@@ -1285,8 +1387,12 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 		/* Clear STOP flag */
 		writel_relaxed(STM32F7_I2C_ICR_STOPCF, base + STM32F7_I2C_ICR);
 
-		i2c_dev->master_mode = false;
-		complete(&i2c_dev->complete);
+		if (i2c_dev->use_dma) {
+			ret = IRQ_WAKE_THREAD;
+		} else {
+			i2c_dev->master_mode = false;
+			complete(&i2c_dev->complete);
+		}
 	}
 
 	/* Transfer complete */
@@ -1294,6 +1400,8 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 		if (f7_msg->stop) {
 			mask = STM32F7_I2C_CR2_STOP;
 			stm32f7_i2c_set_bits(base + STM32F7_I2C_CR2, mask);
+		} else if (i2c_dev->use_dma) {
+			ret = IRQ_WAKE_THREAD;
 		} else if (f7_msg->smbus) {
 			stm32f7_i2c_smbus_rep_start(i2c_dev);
 		} else {
@@ -1310,6 +1418,44 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 			stm32f7_i2c_reload(i2c_dev);
 	}
 
+	return ret;
+}
+
+static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
+{
+	struct stm32f7_i2c_dev *i2c_dev = data;
+	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	struct stm32_i2c_dma *dma = i2c_dev->dma;
+	u32 status;
+	int ret;
+
+	/*
+	 * Wait for dma transfer completion before sending next message or
+	 * notity the end of xfer to the client
+	 */
+	ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
+	if (!ret) {
+		dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
+		stm32f7_i2c_disable_dma_req(i2c_dev);
+		dmaengine_terminate_all(dma->chan_using);
+		f7_msg->result = -ETIMEDOUT;
+	}
+
+	status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
+
+	if (status & STM32F7_I2C_ISR_TC) {
+		if (f7_msg->smbus) {
+			stm32f7_i2c_smbus_rep_start(i2c_dev);
+		} else {
+			i2c_dev->msg_id++;
+			i2c_dev->msg++;
+			stm32f7_i2c_xfer_msg(i2c_dev, i2c_dev->msg);
+		}
+	} else {
+		i2c_dev->master_mode = false;
+		complete(&i2c_dev->complete);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -1319,6 +1465,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
 	void __iomem *base = i2c_dev->base;
 	struct device *dev = i2c_dev->dev;
+	struct stm32_i2c_dma *dma = i2c_dev->dma;
 	u32 mask, status;
 
 	status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
@@ -1350,6 +1497,12 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
 		mask = STM32F7_I2C_ALL_IRQ_MASK;
 	stm32f7_i2c_disable_irq(i2c_dev, mask);
 
+	/* Disable dma */
+	if (i2c_dev->use_dma) {
+		stm32f7_i2c_disable_dma_req(i2c_dev);
+		dmaengine_terminate_all(dma->chan_using);
+	}
+
 	i2c_dev->master_mode = false;
 	complete(&i2c_dev->complete);
 
@@ -1361,6 +1514,7 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 {
 	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	struct stm32_i2c_dma *dma = i2c_dev->dma;
 	unsigned long time_left;
 	int ret;
 
@@ -1388,6 +1542,8 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!time_left) {
 		dev_dbg(i2c_dev->dev, "Access to slave 0x%x timed out\n",
 			i2c_dev->msg->addr);
+		if (i2c_dev->use_dma)
+			dmaengine_terminate_all(dma->chan_using);
 		ret = -ETIMEDOUT;
 	}
 
@@ -1404,6 +1560,7 @@ static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 {
 	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(adapter);
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	struct stm32_i2c_dma *dma = i2c_dev->dma;
 	struct device *dev = i2c_dev->dev;
 	unsigned long timeout;
 	int i, ret;
@@ -1435,6 +1592,8 @@ static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 
 	if (!timeout) {
 		dev_dbg(dev, "Access to slave 0x%x timed out\n", f7_msg->addr);
+		if (i2c_dev->use_dma)
+			dmaengine_terminate_all(dma->chan_using);
 		ret = -ETIMEDOUT;
 		goto clk_free;
 	}
@@ -1608,6 +1767,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	u32 irq_error, irq_event, clk_rate, rise_time, fall_time;
 	struct i2c_adapter *adap;
 	struct reset_control *rst;
+	dma_addr_t phy_addr;
 	int ret;
 
 	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
@@ -1618,6 +1778,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	i2c_dev->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(i2c_dev->base))
 		return PTR_ERR(i2c_dev->base);
+	phy_addr = (dma_addr_t)res->start;
 
 	irq_event = irq_of_parse_and_map(np, 0);
 	if (!irq_event) {
@@ -1664,8 +1825,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 
 	i2c_dev->dev = &pdev->dev;
 
-	ret = devm_request_irq(&pdev->dev, irq_event, stm32f7_i2c_isr_event, 0,
-			       pdev->name, i2c_dev);
+	ret = devm_request_threaded_irq(&pdev->dev, irq_event,
+					stm32f7_i2c_isr_event,
+					stm32f7_i2c_isr_event_thread,
+					IRQF_ONESHOT,
+					pdev->name, i2c_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq event %i\n",
 			irq_event);
@@ -1717,6 +1881,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 
 	init_completion(&i2c_dev->complete);
 
+	/* Init DMA config if supported */
+	i2c_dev->dma = stm32_i2c_dma_request(i2c_dev->dev, phy_addr,
+					     STM32F7_I2C_TXDR,
+					     STM32F7_I2C_RXDR);
+
 	ret = i2c_add_adapter(adap);
 	if (ret)
 		goto clk_free;
@@ -1739,6 +1908,11 @@ static int stm32f7_i2c_remove(struct platform_device *pdev)
 {
 	struct stm32f7_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
+	if (i2c_dev->dma) {
+		stm32_i2c_dma_free(i2c_dev->dma);
+		i2c_dev->dma = NULL;
+	}
+
 	i2c_del_adapter(&i2c_dev->adap);
 
 	clk_unprepare(i2c_dev->clk);
-- 
2.7.4
