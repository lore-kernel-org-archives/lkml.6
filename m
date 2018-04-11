Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753661AbeDKNZZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:25:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41536 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753364AbeDKNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:25:23 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 4/6] i2c: i2c-stm32: Add generic DMA API
Date: Wed, 11 Apr 2018 15:24:56 +0200
Message-ID: <1523453098-3758-5-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a generic DMA API to implement DMA support for i2c-stm32fx
drivers

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
    v2:
    v3:
---
---
 drivers/i2c/busses/i2c-stm32.c | 153 +++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-stm32.h |  37 ++++++++++
 2 files changed, 190 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-stm32.c

diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
new file mode 100644
index 0000000..d75fbcb
--- /dev/null
+++ b/drivers/i2c/busses/i2c-stm32.c
@@ -0,0 +1,153 @@
+/*
+ * i2c-stm32.c
+ *
+ * Copyright (C) M'boumba Cedric Madianga 2017
+ * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include "i2c-stm32.h"
+
+/* Functions for DMA support */
+struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
+					    dma_addr_t phy_addr,
+					    u32 txdr_offset,
+					    u32 rxdr_offset)
+{
+	struct stm32_i2c_dma *dma;
+	struct dma_slave_config dma_sconfig;
+	int ret;
+
+	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return NULL;
+
+	/* Request and configure I2C TX dma channel */
+	dma->chan_tx = dma_request_slave_channel(dev, "tx");
+	if (!dma->chan_tx) {
+		dev_dbg(dev, "can't request DMA tx channel\n");
+		ret = -EINVAL;
+		goto fail_al;
+	}
+
+	memset(&dma_sconfig, 0, sizeof(dma_sconfig));
+	dma_sconfig.dst_addr = phy_addr + txdr_offset;
+	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_maxburst = 1;
+	dma_sconfig.direction = DMA_MEM_TO_DEV;
+	ret = dmaengine_slave_config(dma->chan_tx, &dma_sconfig);
+	if (ret < 0) {
+		dev_err(dev, "can't configure tx channel\n");
+		goto fail_tx;
+	}
+
+	/* Request and configure I2C RX dma channel */
+	dma->chan_rx = dma_request_slave_channel(dev, "rx");
+	if (!dma->chan_rx) {
+		dev_err(dev, "can't request DMA rx channel\n");
+		ret = -EINVAL;
+		goto fail_tx;
+	}
+
+	memset(&dma_sconfig, 0, sizeof(dma_sconfig));
+	dma_sconfig.src_addr = phy_addr + rxdr_offset;
+	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.src_maxburst = 1;
+	dma_sconfig.direction = DMA_DEV_TO_MEM;
+	ret = dmaengine_slave_config(dma->chan_rx, &dma_sconfig);
+	if (ret < 0) {
+		dev_err(dev, "can't configure rx channel\n");
+		goto fail_rx;
+	}
+
+	init_completion(&dma->dma_complete);
+
+	dev_info(dev, "using %s (tx) and %s (rx) for DMA transfers\n",
+		 dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
+
+	return dma;
+
+fail_rx:
+	dma_release_channel(dma->chan_rx);
+fail_tx:
+	dma_release_channel(dma->chan_tx);
+fail_al:
+	devm_kfree(dev, dma);
+	dev_info(dev, "can't use DMA\n");
+
+	return NULL;
+}
+
+void stm32_i2c_dma_free(struct stm32_i2c_dma *dma)
+{
+	dma->dma_buf = 0;
+	dma->dma_len = 0;
+
+	dma_release_channel(dma->chan_tx);
+	dma->chan_tx = NULL;
+
+	dma_release_channel(dma->chan_rx);
+	dma->chan_rx = NULL;
+
+	dma->chan_using = NULL;
+}
+
+int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
+			    bool rd_wr, u32 len, u8 *buf,
+			    dma_async_tx_callback callback,
+			    void *dma_async_param)
+{
+	struct dma_async_tx_descriptor *txdesc;
+	struct device *chan_dev;
+	int ret;
+
+	if (rd_wr) {
+		dma->chan_using = dma->chan_rx;
+		dma->dma_transfer_dir = DMA_DEV_TO_MEM;
+		dma->dma_data_dir = DMA_FROM_DEVICE;
+	} else {
+		dma->chan_using = dma->chan_tx;
+		dma->dma_transfer_dir = DMA_MEM_TO_DEV;
+		dma->dma_data_dir = DMA_TO_DEVICE;
+	}
+
+	dma->dma_len = len;
+	chan_dev = dma->chan_using->device->dev;
+
+	dma->dma_buf = dma_map_single(chan_dev, buf, dma->dma_len,
+				      dma->dma_data_dir);
+	if (dma_mapping_error(chan_dev, dma->dma_buf)) {
+		dev_err(dev, "DMA mapping failed\n");
+		return -EINVAL;
+	}
+
+	txdesc = dmaengine_prep_slave_single(dma->chan_using, dma->dma_buf,
+					     dma->dma_len,
+					     dma->dma_transfer_dir,
+					     DMA_PREP_INTERRUPT);
+	if (!txdesc) {
+		dev_err(dev, "Not able to get desc for DMA xfer\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	reinit_completion(&dma->dma_complete);
+
+	txdesc->callback = callback;
+	txdesc->callback_param = dma_async_param;
+	ret = dma_submit_error(dmaengine_submit(txdesc));
+	if (ret < 0) {
+		dev_err(dev, "DMA submit failed\n");
+		goto err;
+	}
+
+	dma_async_issue_pending(dma->chan_using);
+
+	return 0;
+
+err:
+	dma_unmap_single(chan_dev, dma->dma_buf, dma->dma_len,
+			 dma->dma_data_dir);
+	return ret;
+}
diff --git a/drivers/i2c/busses/i2c-stm32.h b/drivers/i2c/busses/i2c-stm32.h
index d4f9cef..868755f 100644
--- a/drivers/i2c/busses/i2c-stm32.h
+++ b/drivers/i2c/busses/i2c-stm32.h
@@ -11,6 +11,10 @@
 #ifndef _I2C_STM32_H
 #define _I2C_STM32_H
 
+#include <linux/dma-direction.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+
 enum stm32_i2c_speed {
 	STM32_I2C_SPEED_STANDARD, /* 100 kHz */
 	STM32_I2C_SPEED_FAST, /* 400 kHz */
@@ -18,4 +22,37 @@ enum stm32_i2c_speed {
 	STM32_I2C_SPEED_END,
 };
 
+/**
+ * struct stm32_i2c_dma - DMA specific data
+ * @chan_tx: dma channel for TX transfer
+ * @chan_rx: dma channel for RX transfer
+ * @chan_using: dma channel used for the current transfer (TX or RX)
+ * @dma_buf: dma buffer
+ * @dma_len: dma buffer len
+ * @dma_transfer_dir: dma transfer direction indicator
+ * @dma_data_dir: dma transfer mode indicator
+ * @dma_complete: dma transfer completion
+ */
+struct stm32_i2c_dma {
+	struct dma_chan *chan_tx;
+	struct dma_chan *chan_rx;
+	struct dma_chan *chan_using;
+	dma_addr_t dma_buf;
+	unsigned int dma_len;
+	enum dma_transfer_direction dma_transfer_dir;
+	enum dma_data_direction dma_data_dir;
+	struct completion dma_complete;
+};
+
+struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
+					    dma_addr_t phy_addr,
+					    u32 txdr_offset, u32 rxdr_offset);
+
+void stm32_i2c_dma_free(struct stm32_i2c_dma *dma);
+
+int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
+			    bool rd_wr, u32 len, u8 *buf,
+			    dma_async_tx_callback callback,
+			    void *dma_async_param);
+
 #endif /* _I2C_STM32_H */
-- 
2.7.4
