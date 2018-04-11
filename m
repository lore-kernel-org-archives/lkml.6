Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeDKNZj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:25:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18431 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753630AbeDKNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:25:25 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 3/6] i2c: i2c-stm32f7: Add initial SMBus protocols support
Date: Wed, 11 Apr 2018 15:24:55 +0200
Message-ID: <1523453098-3758-4-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMBus support for I2C controller embedded in STM32F7 Soc.
All SMBus protocols are implemented except SMBus-specific protocols like
SMBus Host Notification and SMBus Alert protocols.

Implemented: SMBus Quick command, Send byte, Receive byte, Write byte/word,
read byte/word, Process call, Block write/read and Block write-block read
process call.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
    v2:
       * fix Kbuild test robot issue (Unneeded semicolon)
    v3:
       * Provide more details on what have already been implemented and
         not implemented
---

fixup! i2c: i2c-stm32f7: Add initial SMBus protocols support
---
 drivers/i2c/busses/i2c-stm32f7.c | 377 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 368 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 9bf676e..0b81b5d 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -37,6 +37,7 @@
 #define STM32F7_I2C_CR2				0x04
 #define STM32F7_I2C_OAR1			0x08
 #define STM32F7_I2C_OAR2			0x0C
+#define STM32F7_I2C_PECR			0x20
 #define STM32F7_I2C_TIMINGR			0x10
 #define STM32F7_I2C_ISR				0x18
 #define STM32F7_I2C_ICR				0x1C
@@ -44,6 +45,7 @@
 #define STM32F7_I2C_TXDR			0x28
 
 /* STM32F7 I2C control 1 */
+#define STM32F7_I2C_CR1_PECEN			BIT(23)
 #define STM32F7_I2C_CR1_SBC			BIT(16)
 #define STM32F7_I2C_CR1_ANFOFF			BIT(12)
 #define STM32F7_I2C_CR1_ERRIE			BIT(7)
@@ -67,6 +69,7 @@
 						| STM32F7_I2C_CR1_TXIE)
 
 /* STM32F7 I2C control 2 */
+#define STM32F7_I2C_CR2_PECBYTE			BIT(26)
 #define STM32F7_I2C_CR2_RELOAD			BIT(24)
 #define STM32F7_I2C_CR2_NBYTES_MASK		GENMASK(23, 16)
 #define STM32F7_I2C_CR2_NBYTES(n)		(((n) & 0xff) << 16)
@@ -111,6 +114,7 @@
 				(((n) & STM32F7_I2C_ISR_ADDCODE_MASK) >> 17)
 #define STM32F7_I2C_ISR_DIR			BIT(16)
 #define STM32F7_I2C_ISR_BUSY			BIT(15)
+#define STM32F7_I2C_ISR_PECERR			BIT(11)
 #define STM32F7_I2C_ISR_ARLO			BIT(9)
 #define STM32F7_I2C_ISR_BERR			BIT(8)
 #define STM32F7_I2C_ISR_TCR			BIT(7)
@@ -123,6 +127,7 @@
 #define STM32F7_I2C_ISR_TXE			BIT(0)
 
 /* STM32F7 I2C Interrupt Clear */
+#define STM32F7_I2C_ICR_PECCF			BIT(11)
 #define STM32F7_I2C_ICR_ARLOCF			BIT(9)
 #define STM32F7_I2C_ICR_BERRCF			BIT(8)
 #define STM32F7_I2C_ICR_STOPCF			BIT(5)
@@ -225,6 +230,14 @@ struct stm32f7_i2c_timings {
  * @buf: data buffer
  * @result: result of the transfer
  * @stop: last I2C msg to be sent, i.e. STOP to be generated
+ * @smbus: boolean to know if the I2C IP is used in SMBus mode
+ * @size: type of SMBus protocol
+ * @read_write: direction of SMBus protocol
+ * SMBus block read and SMBus block write - block read process call protocols
+ * @smbus_buff: buffer to be used for SMBus protocol transfer. It will
+ * contain a maximum of 32 bytes of data + byte command + byte count + PEC
+ * This buffer has to be 32-bit aligned to be compliant with memory address
+ * register in DMA mode.
  */
 struct stm32f7_i2c_msg {
 	u16 addr;
@@ -232,6 +245,10 @@ struct stm32f7_i2c_msg {
 	u8 *buf;
 	int result;
 	bool stop;
+	bool smbus;
+	int size;
+	char read_write;
+	u8 smbus_buf[I2C_SMBUS_BLOCK_MAX + 3] __aligned(4);
 };
 
 /**
@@ -649,6 +666,29 @@ static void stm32f7_i2c_reload(struct stm32f7_i2c_dev *i2c_dev)
 	writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
 }
 
+static void stm32f7_i2c_smbus_reload(struct stm32f7_i2c_dev *i2c_dev)
+{
+	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	u32 cr2;
+	u8 *val;
+
+	/*
+	 * For I2C_SMBUS_BLOCK_DATA && I2C_SMBUS_BLOCK_PROC_CALL, the first
+	 * data received inform us how many data will follow.
+	 */
+	stm32f7_i2c_read_rx_data(i2c_dev);
+
+	/*
+	 * Update NBYTES with the value read to continue the transfer
+	 */
+	val = f7_msg->buf - sizeof(u8);
+	f7_msg->count = *val;
+	cr2 = readl_relaxed(i2c_dev->base + STM32F7_I2C_CR2);
+	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK | STM32F7_I2C_CR2_RELOAD);
+	cr2 |= STM32F7_I2C_CR2_NBYTES(f7_msg->count);
+	writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
+}
+
 static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
 {
 	u32 status;
@@ -732,6 +772,237 @@ static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	writel_relaxed(cr2, base + STM32F7_I2C_CR2);
 }
 
+static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
+				      unsigned short flags, u8 command,
+				      union i2c_smbus_data *data)
+{
+	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	struct device *dev = i2c_dev->dev;
+	void __iomem *base = i2c_dev->base;
+	u32 cr1, cr2;
+	int i;
+
+	f7_msg->result = 0;
+	reinit_completion(&i2c_dev->complete);
+
+	cr2 = readl_relaxed(base + STM32F7_I2C_CR2);
+	cr1 = readl_relaxed(base + STM32F7_I2C_CR1);
+
+	/* Set transfer direction */
+	cr2 &= ~STM32F7_I2C_CR2_RD_WRN;
+	if (f7_msg->read_write)
+		cr2 |= STM32F7_I2C_CR2_RD_WRN;
+
+	/* Set slave address */
+	cr2 &= ~(STM32F7_I2C_CR2_ADD10 | STM32F7_I2C_CR2_SADD7_MASK);
+	cr2 |= STM32F7_I2C_CR2_SADD7(f7_msg->addr);
+
+	f7_msg->smbus_buf[0] = command;
+	switch (f7_msg->size) {
+	case I2C_SMBUS_QUICK:
+		f7_msg->stop = true;
+		f7_msg->count = 0;
+		break;
+	case I2C_SMBUS_BYTE:
+		f7_msg->stop = true;
+		f7_msg->count = 1;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		if (f7_msg->read_write) {
+			f7_msg->stop = false;
+			f7_msg->count = 1;
+			cr2 &= ~STM32F7_I2C_CR2_RD_WRN;
+		} else {
+			f7_msg->stop = true;
+			f7_msg->count = 2;
+			f7_msg->smbus_buf[1] = data->byte;
+		}
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		if (f7_msg->read_write) {
+			f7_msg->stop = false;
+			f7_msg->count = 1;
+			cr2 &= ~STM32F7_I2C_CR2_RD_WRN;
+		} else {
+			f7_msg->stop = true;
+			f7_msg->count = 3;
+			f7_msg->smbus_buf[1] = data->word & 0xff;
+			f7_msg->smbus_buf[2] = data->word >> 8;
+		}
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		if (f7_msg->read_write) {
+			f7_msg->stop = false;
+			f7_msg->count = 1;
+			cr2 &= ~STM32F7_I2C_CR2_RD_WRN;
+		} else {
+			f7_msg->stop = true;
+			if (data->block[0] > I2C_SMBUS_BLOCK_MAX ||
+			    !data->block[0]) {
+				dev_err(dev, "Invalid block write size %d\n",
+					data->block[0]);
+				return -EINVAL;
+			}
+			f7_msg->count = data->block[0] + 2;
+			for (i = 1; i < f7_msg->count; i++)
+				f7_msg->smbus_buf[i] = data->block[i - 1];
+		}
+		break;
+	case I2C_SMBUS_PROC_CALL:
+		f7_msg->stop = false;
+		f7_msg->count = 3;
+		f7_msg->smbus_buf[1] = data->word & 0xff;
+		f7_msg->smbus_buf[2] = data->word >> 8;
+		cr2 &= ~STM32F7_I2C_CR2_RD_WRN;
+		f7_msg->read_write = I2C_SMBUS_READ;
+		break;
+	case I2C_SMBUS_BLOCK_PROC_CALL:
+		f7_msg->stop = false;
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX - 1) {
+			dev_err(dev, "Invalid block write size %d\n",
+				data->block[0]);
+			return -EINVAL;
+		}
+		f7_msg->count = data->block[0] + 2;
+		for (i = 1; i < f7_msg->count; i++)
+			f7_msg->smbus_buf[i] = data->block[i - 1];
+		cr2 &= ~STM32F7_I2C_CR2_RD_WRN;
+		f7_msg->read_write = I2C_SMBUS_READ;
+		break;
+	default:
+		dev_err(dev, "Unsupported smbus protocol %d\n", f7_msg->size);
+		return -EOPNOTSUPP;
+	}
+
+	f7_msg->buf = f7_msg->smbus_buf;
+
+	/* Configure PEC */
+	if ((flags & I2C_CLIENT_PEC) && f7_msg->size != I2C_SMBUS_QUICK) {
+		cr1 |= STM32F7_I2C_CR1_PECEN;
+		cr2 |= STM32F7_I2C_CR2_PECBYTE;
+		if (!f7_msg->read_write)
+			f7_msg->count++;
+	} else {
+		cr1 &= ~STM32F7_I2C_CR1_PECEN;
+		cr2 &= ~STM32F7_I2C_CR2_PECBYTE;
+	}
+
+	/* Set number of bytes to be transferred */
+	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK | STM32F7_I2C_CR2_RELOAD);
+	cr2 |= STM32F7_I2C_CR2_NBYTES(f7_msg->count);
+
+	/* Enable NACK, STOP, error and transfer complete interrupts */
+	cr1 |= STM32F7_I2C_CR1_ERRIE | STM32F7_I2C_CR1_TCIE |
+		STM32F7_I2C_CR1_STOPIE | STM32F7_I2C_CR1_NACKIE;
+
+	/* Clear TX/RX interrupt */
+	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE);
+
+	/* Enable RX/TX interrupt according to msg direction */
+	if (cr2 & STM32F7_I2C_CR2_RD_WRN)
+		cr1 |= STM32F7_I2C_CR1_RXIE;
+	else
+		cr1 |= STM32F7_I2C_CR1_TXIE;
+
+	/* Set Start bit */
+	cr2 |= STM32F7_I2C_CR2_START;
+
+	i2c_dev->master_mode = true;
+
+	/* Write configurations registers */
+	writel_relaxed(cr1, base + STM32F7_I2C_CR1);
+	writel_relaxed(cr2, base + STM32F7_I2C_CR2);
+
+	return 0;
+}
+
+static void stm32f7_i2c_smbus_rep_start(struct stm32f7_i2c_dev *i2c_dev)
+{
+	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	void __iomem *base = i2c_dev->base;
+	u32 cr1, cr2;
+
+	cr2 = readl_relaxed(base + STM32F7_I2C_CR2);
+	cr1 = readl_relaxed(base + STM32F7_I2C_CR1);
+
+	/* Set transfer direction */
+	cr2 |= STM32F7_I2C_CR2_RD_WRN;
+
+	switch (f7_msg->size) {
+	case I2C_SMBUS_BYTE_DATA:
+		f7_msg->count = 1;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+	case I2C_SMBUS_PROC_CALL:
+		f7_msg->count = 2;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+	case I2C_SMBUS_BLOCK_PROC_CALL:
+		f7_msg->count = 1;
+		cr2 |= STM32F7_I2C_CR2_RELOAD;
+		break;
+	}
+
+	f7_msg->buf = f7_msg->smbus_buf;
+	f7_msg->stop = true;
+
+	/* Add one byte for PEC if needed */
+	if (cr1 & STM32F7_I2C_CR1_PECEN)
+		f7_msg->count++;
+
+	/* Set number of bytes to be transferred */
+	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK);
+	cr2 |= STM32F7_I2C_CR2_NBYTES(f7_msg->count);
+
+	/*
+	 * Configure RX/TX interrupt:
+	 */
+	cr1 &= ~(STM32F7_I2C_CR1_RXIE | STM32F7_I2C_CR1_TXIE);
+	cr1 |= STM32F7_I2C_CR1_RXIE;
+
+	/* Configure Repeated Start */
+	cr2 |= STM32F7_I2C_CR2_START;
+
+	/* Write configurations registers */
+	writel_relaxed(cr1, base + STM32F7_I2C_CR1);
+	writel_relaxed(cr2, base + STM32F7_I2C_CR2);
+}
+
+static int stm32f7_i2c_smbus_check_pec(struct stm32f7_i2c_dev *i2c_dev)
+{
+	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	u8 count, internal_pec, received_pec;
+
+	internal_pec = readl_relaxed(i2c_dev->base + STM32F7_I2C_PECR);
+
+	switch (f7_msg->size) {
+	case I2C_SMBUS_BYTE:
+	case I2C_SMBUS_BYTE_DATA:
+		received_pec = f7_msg->smbus_buf[1];
+		break;
+	case I2C_SMBUS_WORD_DATA:
+	case I2C_SMBUS_PROC_CALL:
+		received_pec = f7_msg->smbus_buf[2];
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+	case I2C_SMBUS_BLOCK_PROC_CALL:
+		count = f7_msg->smbus_buf[0];
+		received_pec = f7_msg->smbus_buf[count];
+		break;
+	default:
+		dev_err(i2c_dev->dev, "Unsupported smbus protocol for PEC\n");
+		return -EINVAL;
+	}
+
+	if (internal_pec != received_pec) {
+		dev_err(i2c_dev->dev, "Bad PEC 0x%02x vs. 0x%02x\n",
+			internal_pec, received_pec);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
 static bool stm32f7_i2c_is_addr_match(struct i2c_client *slave, u32 addcode)
 {
 	u32 addr;
@@ -1023,6 +1294,8 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 		if (f7_msg->stop) {
 			mask = STM32F7_I2C_CR2_STOP;
 			stm32f7_i2c_set_bits(base + STM32F7_I2C_CR2, mask);
+		} else if (f7_msg->smbus) {
+			stm32f7_i2c_smbus_rep_start(i2c_dev);
 		} else {
 			i2c_dev->msg_id++;
 			i2c_dev->msg++;
@@ -1030,13 +1303,12 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 		}
 	}
 
-	/*
-	 * Transfer Complete Reload: 255 data bytes have been transferred
-	 * We have to prepare the I2C controller to transfer the remaining
-	 * data.
-	 */
-	if (status & STM32F7_I2C_ISR_TCR)
-		stm32f7_i2c_reload(i2c_dev);
+	if (status & STM32F7_I2C_ISR_TCR) {
+		if (f7_msg->smbus)
+			stm32f7_i2c_smbus_reload(i2c_dev);
+		else
+			stm32f7_i2c_reload(i2c_dev);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1065,6 +1337,12 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
 		f7_msg->result = -EAGAIN;
 	}
 
+	if (status & STM32F7_I2C_ISR_PECERR) {
+		dev_err(dev, "<%s>: PEC error in reception\n", __func__);
+		writel_relaxed(STM32F7_I2C_ICR_PECCF, base + STM32F7_I2C_ICR);
+		f7_msg->result = -EINVAL;
+	}
+
 	/* Disable interrupts */
 	if (stm32f7_i2c_is_slave_registered(i2c_dev))
 		mask = STM32F7_I2C_XFER_IRQ_MASK;
@@ -1089,6 +1367,7 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 	i2c_dev->msg = msgs;
 	i2c_dev->msg_num = num;
 	i2c_dev->msg_id = 0;
+	f7_msg->smbus = false;
 
 	ret = clk_enable(i2c_dev->clk);
 	if (ret) {
@@ -1118,6 +1397,82 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 	return (ret < 0) ? ret : num;
 }
 
+static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+				  unsigned short flags, char read_write,
+				  u8 command, int size,
+				  union i2c_smbus_data *data)
+{
+	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(adapter);
+	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	struct device *dev = i2c_dev->dev;
+	unsigned long timeout;
+	int i, ret;
+
+	f7_msg->addr = addr;
+	f7_msg->size = size;
+	f7_msg->read_write = read_write;
+	f7_msg->smbus = true;
+
+	ret = clk_enable(i2c_dev->clk);
+	if (ret) {
+		dev_err(i2c_dev->dev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	ret = stm32f7_i2c_wait_free_bus(i2c_dev);
+	if (ret)
+		goto clk_free;
+
+	ret = stm32f7_i2c_smbus_xfer_msg(i2c_dev, flags, command, data);
+	if (ret)
+		goto clk_free;
+
+	timeout = wait_for_completion_timeout(&i2c_dev->complete,
+					      i2c_dev->adap.timeout);
+	ret = f7_msg->result;
+	if (ret)
+		goto clk_free;
+
+	if (!timeout) {
+		dev_dbg(dev, "Access to slave 0x%x timed out\n", f7_msg->addr);
+		ret = -ETIMEDOUT;
+		goto clk_free;
+	}
+
+	/* Check PEC */
+	if ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && read_write) {
+		ret = stm32f7_i2c_smbus_check_pec(i2c_dev);
+		if (ret)
+			goto clk_free;
+	}
+
+	if (read_write && size != I2C_SMBUS_QUICK) {
+		switch (size) {
+		case I2C_SMBUS_BYTE:
+		case I2C_SMBUS_BYTE_DATA:
+			data->byte = f7_msg->smbus_buf[0];
+		break;
+		case I2C_SMBUS_WORD_DATA:
+		case I2C_SMBUS_PROC_CALL:
+			data->word = f7_msg->smbus_buf[0] |
+				(f7_msg->smbus_buf[1] << 8);
+		break;
+		case I2C_SMBUS_BLOCK_DATA:
+		case I2C_SMBUS_BLOCK_PROC_CALL:
+		for (i = 0; i <= f7_msg->smbus_buf[0]; i++)
+			data->block[i] = f7_msg->smbus_buf[i];
+		break;
+		default:
+			dev_err(dev, "Unsupported smbus transaction\n");
+			ret = -EINVAL;
+		}
+	}
+
+clk_free:
+	clk_disable(i2c_dev->clk);
+	return ret;
+}
+
 static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 {
 	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(slave->adapter);
@@ -1229,12 +1584,16 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 
 static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
-		I2C_FUNC_SLAVE;
+	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SLAVE |
+		I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
+		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_PEC;
 }
 
 static struct i2c_algorithm stm32f7_i2c_algo = {
 	.master_xfer = stm32f7_i2c_xfer,
+	.smbus_xfer = stm32f7_i2c_smbus_xfer,
 	.functionality = stm32f7_i2c_func,
 	.reg_slave = stm32f7_i2c_reg_slave,
 	.unreg_slave = stm32f7_i2c_unreg_slave,
-- 
2.7.4
