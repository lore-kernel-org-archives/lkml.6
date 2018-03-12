Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCLKyp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:54:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42975 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751312AbeCLKym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:54:42 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery mechanism
Date: Mon, 12 Mar 2018 11:53:43 +0100
Message-ID: <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_06:,,
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
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 69a2e5e..3808bc9 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -718,6 +718,20 @@ static void stm32f7_i2c_smbus_reload(struct stm32f7_i2c_dev *i2c_dev)
 	writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
 }
 
+static int stm32f7_i2c_recover_bus(struct i2c_adapter *i2c_adap)
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
+	ret = i2c_recover_bus(&i2c_dev->adap);
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
@@ -1476,6 +1496,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
 	if (status & STM32F7_I2C_ISR_BERR) {
 		dev_err(dev, "<%s>: Bus error\n", __func__);
 		writel_relaxed(STM32F7_I2C_ICR_BERRCF, base + STM32F7_I2C_ICR);
+		i2c_recover_bus(&i2c_dev->adap);
 		f7_msg->result = -EIO;
 	}
 
@@ -1760,6 +1781,10 @@ static struct i2c_algorithm stm32f7_i2c_algo = {
 	.unreg_slave = stm32f7_i2c_unreg_slave,
 };
 
+static struct i2c_bus_recovery_info stm32f7_i2c_recovery_info = {
+	.recover_bus = stm32f7_i2c_recover_bus,
+};
+
 static int stm32f7_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1879,6 +1904,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	adap->algo = &stm32f7_i2c_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
+	adap->bus_recovery_info = &stm32f7_i2c_recovery_info;
 
 	init_completion(&i2c_dev->complete);
 
-- 
2.7.4
