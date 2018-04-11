Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753771AbeDKNZk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:25:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41135 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753628AbeDKNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:25:25 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 6/6] i2c: i2c-stm32f7: Implement I2C release mechanism
Date: Wed, 11 Apr 2018 15:24:58 +0200
Message-ID: <1523453098-3758-7-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feature prevents I2C lock-ups. Mechanism resets I2C state machine
and releases SCL/SDA signals but preserves I2C registers.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
    v2:
       * Don't use i2c engine recovery mechanism since driver
         procedure only recover master and not the slave.
    v3:
       * s/recovery/release/ throughout the patch. Recovery is really
         something else
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 63ea71c..0f87449 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -718,6 +718,20 @@ static void stm32f7_i2c_smbus_reload(struct stm32f7_i2c_dev *i2c_dev)
 	writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
 }
 
+static int stm32f7_i2c_release_bus(struct i2c_adapter *i2c_adap)
+{
+	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
+
+	dev_info(i2c_dev->dev, "Trying to recover bus\n");
+
+	stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1,
+			     STM32F7_I2C_CR1_PE);
+
+	stm32f7_i2c_hw_config(i2c_dev);
+
+	return 0;
+}
+
 static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
 {
 	u32 status;
@@ -727,12 +741,18 @@ static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
 					 status,
 					 !(status & STM32F7_I2C_ISR_BUSY),
 					 10, 1000);
+	if (!ret)
+		return 0;
+
+	dev_info(i2c_dev->dev, "bus busy\n");
+
+	ret = stm32f7_i2c_release_bus(&i2c_dev->adap);
 	if (ret) {
-		dev_dbg(i2c_dev->dev, "bus busy\n");
-		ret = -EBUSY;
+		dev_err(i2c_dev->dev, "Failed to recover the bus (%d)\n", ret);
+		return ret;
 	}
 
-	return ret;
+	return -EBUSY;
 }
 
 static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
@@ -1474,6 +1494,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
 	if (status & STM32F7_I2C_ISR_BERR) {
 		dev_err(dev, "<%s>: Bus error\n", __func__);
 		writel_relaxed(STM32F7_I2C_ICR_BERRCF, base + STM32F7_I2C_ICR);
+		stm32f7_i2c_release_bus(&i2c_dev->adap);
 		f7_msg->result = -EIO;
 	}
 
-- 
2.7.4
