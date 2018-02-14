Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967095AbeBNKFw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:05:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10517 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967016AbeBNKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:05:45 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>,
        <alexandre.torgue@st.com>
CC: <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [RESEND PATCH v2 4/8] mfd: stm32-timers: add support for dmas
Date: Wed, 14 Feb 2018 11:04:35 +0100
Message-ID: <1518602679-3064-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 Timers can support up to 7 DMA requests:
- 4 channels, update, compare and trigger.
Optionally request part, or all DMAs from stm32-timers MFD core.

Also add routine to implement burst reads using DMA from timer registers.
This is exported. So, it can be used by child drivers, PWM capture
for instance (but not limited to).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
Changes in v2:
- Abstract DMA handling from child driver: move it to MFD core
- Add comments on optional dma support
---
 drivers/mfd/stm32-timers.c       | 215 ++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h |  27 +++++
 2 files changed, 238 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index a6675a4..2cdad2c 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -6,16 +6,166 @@
  * License terms:  GNU General Public License (GPL), version 2
  */
 
+#include <linux/bitfield.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/reset.h>
 
+#define STM32_TIMERS_MAX_REGISTERS	0x3fc
+
+struct stm32_timers_priv {
+	struct device *dev;
+	struct completion completion;
+	phys_addr_t phys_base;		/* timers physical addr for dma */
+	struct mutex lock;		/* protect dma access */
+	struct dma_chan *dma_chan;	/* dma channel in use */
+	struct dma_chan *dmas[STM32_TIMERS_MAX_DMAS];
+	struct stm32_timers ddata;
+};
+
+static struct stm32_timers_priv *to_stm32_timers_priv(struct stm32_timers *d)
+{
+	return container_of(d, struct stm32_timers_priv, ddata);
+}
+
+/* DIER register DMA enable bits */
+static const u32 stm32_timers_dier_dmaen[STM32_TIMERS_MAX_DMAS] = {
+	TIM_DIER_CC1DE, TIM_DIER_CC2DE, TIM_DIER_CC3DE, TIM_DIER_CC4DE,
+	TIM_DIER_UIE, TIM_DIER_TDE, TIM_DIER_COMDE
+};
+
+static void stm32_timers_dma_done(void *p)
+{
+	struct stm32_timers_priv *priv = p;
+	struct dma_chan *dma_chan = priv->dma_chan;
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(dma_chan, dma_chan->cookie, &state);
+	if (status == DMA_COMPLETE)
+		complete(&priv->completion);
+}
+
+/**
+ * stm32_timers_dma_burst_read - Read from timers registers using DMA.
+ *
+ * Read from STM32 timers registers using DMA on a single event.
+ * @ddata: reference to stm32_timers
+ * @buf: dma'able destination buffer
+ * @id: stm32_timers_dmas event identifier (ch[1..4], up, trig or com)
+ * @reg: registers start offset for DMA to read from (like CCRx for capture)
+ * @num_reg: number of registers to read upon each dma request, starting @reg.
+ * @bursts: number of bursts to read (e.g. like two for pwm period capture)
+ * @tmo_ms: timeout (milliseconds)
+ */
+int stm32_timers_dma_burst_read(struct stm32_timers *ddata, u32 *buf,
+				enum stm32_timers_dmas id, u32 reg,
+				unsigned int num_reg, unsigned int bursts,
+				unsigned long tmo_ms)
+{
+	struct stm32_timers_priv *priv = to_stm32_timers_priv(ddata);
+	unsigned long timeout = msecs_to_jiffies(tmo_ms);
+	struct regmap *regmap = priv->ddata.regmap;
+	size_t len = num_reg * bursts * sizeof(u32);
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config config;
+	dma_cookie_t cookie;
+	dma_addr_t dma_buf;
+	u32 dbl, dba;
+	long err;
+	int ret;
+
+	/* sanity check */
+	if (id < STM32_TIMERS_DMA_CH1 || id >= STM32_TIMERS_MAX_DMAS)
+		return -EINVAL;
+
+	if (!num_reg || !bursts || reg > STM32_TIMERS_MAX_REGISTERS ||
+	    (reg + num_reg * sizeof(u32)) > STM32_TIMERS_MAX_REGISTERS)
+		return -EINVAL;
+
+	if (!priv->dmas[id])
+		return -ENODEV;
+	mutex_lock(&priv->lock);
+	priv->dma_chan = priv->dmas[id];
+
+	dma_buf = dma_map_single(priv->dev, buf, len, DMA_FROM_DEVICE);
+	ret = dma_mapping_error(priv->dev, dma_buf);
+	if (ret)
+		goto unlock;
+
+	/* Prepare DMA read from timer registers, using DMA burst mode */
+	memset(&config, 0, sizeof(config));
+	config.src_addr = (dma_addr_t)priv->phys_base + TIM_DMAR;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ret = dmaengine_slave_config(priv->dma_chan, &config);
+	if (ret)
+		goto unmap;
+
+	desc = dmaengine_prep_slave_single(priv->dma_chan, dma_buf, len,
+					   DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		ret = -EBUSY;
+		goto unmap;
+	}
+
+	desc->callback = stm32_timers_dma_done;
+	desc->callback_param = priv;
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret)
+		goto dma_term;
+
+	reinit_completion(&priv->completion);
+	dma_async_issue_pending(priv->dma_chan);
+
+	/* Setup and enable timer DMA burst mode */
+	dbl = FIELD_PREP(TIM_DCR_DBL, bursts - 1);
+	dba = FIELD_PREP(TIM_DCR_DBA, reg >> 2);
+	ret = regmap_write(regmap, TIM_DCR, dbl | dba);
+	if (ret)
+		goto dma_term;
+
+	/* Clear pending flags before enabling DMA request */
+	ret = regmap_write(regmap, TIM_SR, 0);
+	if (ret)
+		goto dcr_clr;
+
+	ret = regmap_update_bits(regmap, TIM_DIER, stm32_timers_dier_dmaen[id],
+				 stm32_timers_dier_dmaen[id]);
+	if (ret)
+		goto dcr_clr;
+
+	err = wait_for_completion_interruptible_timeout(&priv->completion,
+							timeout);
+	if (err == 0)
+		ret = -ETIMEDOUT;
+	else if (err < 0)
+		ret = err;
+
+	regmap_update_bits(regmap, TIM_DIER, stm32_timers_dier_dmaen[id], 0);
+	regmap_write(regmap, TIM_SR, 0);
+dcr_clr:
+	regmap_write(regmap, TIM_DCR, 0);
+dma_term:
+	dmaengine_terminate_all(priv->dma_chan);
+unmap:
+	dma_unmap_single(priv->dev, dma_buf, len, DMA_FROM_DEVICE);
+unlock:
+	priv->dma_chan = NULL;
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_timers_dma_burst_read);
+
 static const struct regmap_config stm32_timers_regmap_cfg = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = sizeof(u32),
-	.max_register = 0x3fc,
+	.max_register = STM32_TIMERS_MAX_REGISTERS,
 };
 
 static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
@@ -29,21 +179,55 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
 	regmap_write(ddata->regmap, TIM_ARR, 0x0);
 }
 
+static void stm32_timers_dma_probe(struct device *dev,
+				   struct stm32_timers_priv *priv)
+{
+	int i;
+	char name[4];
+	struct dma_chan **dmas = priv->dmas;
+
+	/* Optional DMA support: get valid dma channel(s) or NULL */
+	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
+		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
+		dmas[i] = dma_request_slave_channel(dev, name);
+	}
+	dmas[STM32_TIMERS_DMA_UP] = dma_request_slave_channel(dev, "up");
+	dmas[STM32_TIMERS_DMA_TRIG] = dma_request_slave_channel(dev, "trig");
+	dmas[STM32_TIMERS_DMA_COM] = dma_request_slave_channel(dev, "com");
+}
+
+static void stm32_timers_dma_remove(struct device *dev,
+				    struct stm32_timers_priv *priv)
+{
+	int i;
+
+	for (i = STM32_TIMERS_DMA_CH1; i < STM32_TIMERS_MAX_DMAS; i++)
+		if (priv->dmas[i])
+			dma_release_channel(priv->dmas[i]);
+}
+
 static int stm32_timers_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct stm32_timers_priv *priv;
 	struct stm32_timers *ddata;
 	struct resource *res;
 	void __iomem *mmio;
+	int ret;
 
-	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
+	ddata = &priv->ddata;
+	init_completion(&priv->completion);
+	mutex_init(&priv->lock);
+	priv->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mmio = devm_ioremap_resource(dev, res);
 	if (IS_ERR(mmio))
 		return PTR_ERR(mmio);
+	priv->phys_base = res->start;
 
 	ddata->regmap = devm_regmap_init_mmio_clk(dev, "int", mmio,
 						  &stm32_timers_regmap_cfg);
@@ -56,9 +240,31 @@ static int stm32_timers_probe(struct platform_device *pdev)
 
 	stm32_timers_get_arr_size(ddata);
 
+	stm32_timers_dma_probe(dev, priv);
+
 	platform_set_drvdata(pdev, ddata);
 
-	return devm_of_platform_populate(&pdev->dev);
+	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+	if (ret)
+		goto dma_remove;
+
+	return 0;
+
+dma_remove:
+	stm32_timers_dma_remove(dev, priv);
+
+	return ret;
+}
+
+static int stm32_timers_remove(struct platform_device *pdev)
+{
+	struct stm32_timers *ddata = platform_get_drvdata(pdev);
+	struct stm32_timers_priv *priv = to_stm32_timers_priv(ddata);
+
+	of_platform_depopulate(&pdev->dev);
+	stm32_timers_dma_remove(&pdev->dev, priv);
+
+	return 0;
 }
 
 static const struct of_device_id stm32_timers_of_match[] = {
@@ -69,6 +275,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
 
 static struct platform_driver stm32_timers_driver = {
 	.probe = stm32_timers_probe,
+	.remove = stm32_timers_remove,
 	.driver	= {
 		.name = "stm32-timers",
 		.of_match_table = stm32_timers_of_match,
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index ce7346e..5fd2d6b 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -29,6 +29,8 @@
 #define TIM_CCR3	0x3C	/* Capt/Comp Register 3    */
 #define TIM_CCR4	0x40	/* Capt/Comp Register 4    */
 #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
+#define TIM_DCR		0x48	/* DMA control register    */
+#define TIM_DMAR	0x4C	/* DMA register for transfer */
 
 #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
 #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
@@ -38,6 +40,13 @@
 #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
 #define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
 #define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
+#define TIM_DIER_UDE	BIT(8)  /* Update DMA request Enable */
+#define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
+#define TIM_DIER_CC2DE	BIT(10) /* CC2 DMA request Enable  */
+#define TIM_DIER_CC3DE	BIT(11) /* CC3 DMA request Enable  */
+#define TIM_DIER_CC4DE	BIT(12) /* CC4 DMA request Enable  */
+#define TIM_DIER_COMDE	BIT(13) /* COM DMA request Enable  */
+#define TIM_DIER_TDE	BIT(14) /* Trigger DMA request Enable */
 #define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
 #define TIM_EGR_UG	BIT(0)	/* Update Generation       */
 #define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
@@ -58,6 +67,8 @@
 #define TIM_BDTR_BK2F	(BIT(20) | BIT(21) | BIT(22) | BIT(23))
 #define TIM_BDTR_BK2E	BIT(24) /* Break 2 input enable	   */
 #define TIM_BDTR_BK2P	BIT(25) /* Break 2 input polarity  */
+#define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
+#define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
 
 #define MAX_TIM_PSC		0xFFFF
 #define TIM_CR2_MMS_SHIFT	4
@@ -67,9 +78,25 @@
 #define TIM_BDTR_BKF_SHIFT	16
 #define TIM_BDTR_BK2F_SHIFT	20
 
+enum stm32_timers_dmas {
+	STM32_TIMERS_DMA_CH1,
+	STM32_TIMERS_DMA_CH2,
+	STM32_TIMERS_DMA_CH3,
+	STM32_TIMERS_DMA_CH4,
+	STM32_TIMERS_DMA_UP,
+	STM32_TIMERS_DMA_TRIG,
+	STM32_TIMERS_DMA_COM,
+	STM32_TIMERS_MAX_DMAS,
+};
+
 struct stm32_timers {
 	struct clk *clk;
 	struct regmap *regmap;
 	u32 max_arr;
 };
+
+int stm32_timers_dma_burst_read(struct stm32_timers *ddata, u32 *buf,
+				enum stm32_timers_dmas id, u32 reg,
+				unsigned int num_reg, unsigned int bursts,
+				unsigned long tmo_ms);
 #endif
-- 
1.9.1
