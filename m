Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753835AbeDKN0E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:26:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41607 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753798AbeDKN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:26:01 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 1/6] i2c: i2c-stm32f7: Add 10-bit address support
Date: Wed, 11 Apr 2018 15:24:53 +0200
Message-ID: <1523453098-3758-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for 10-bit device address for STM32F7 I2C

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
 drivers/i2c/busses/i2c-stm32f7.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index f273e28..ae0d15c 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -65,7 +65,12 @@
 #define STM32F7_I2C_CR2_NACK			BIT(15)
 #define STM32F7_I2C_CR2_STOP			BIT(14)
 #define STM32F7_I2C_CR2_START			BIT(13)
+#define STM32F7_I2C_CR2_HEAD10R			BIT(12)
+#define STM32F7_I2C_CR2_ADD10			BIT(11)
 #define STM32F7_I2C_CR2_RD_WRN			BIT(10)
+#define STM32F7_I2C_CR2_SADD10_MASK		GENMASK(9, 0)
+#define STM32F7_I2C_CR2_SADD10(n)		(((n) & \
+						STM32F7_I2C_CR2_SADD10_MASK))
 #define STM32F7_I2C_CR2_SADD7_MASK		GENMASK(7, 1)
 #define STM32F7_I2C_CR2_SADD7(n)		(((n) & 0x7f) << 1)
 
@@ -176,14 +181,14 @@ struct stm32f7_i2c_timings {
 
 /**
  * struct stm32f7_i2c_msg - client specific data
- * @addr: 8-bit slave addr, including r/w bit
+ * @addr: 8-bit or 10-bit slave addr, including r/w bit
  * @count: number of bytes to be transferred
  * @buf: data buffer
  * @result: result of the transfer
  * @stop: last I2C msg to be sent, i.e. STOP to be generated
  */
 struct stm32f7_i2c_msg {
-	u8 addr;
+	u16 addr;
 	u32 count;
 	u8 *buf;
 	int result;
@@ -629,8 +634,15 @@ static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 		cr2 |= STM32F7_I2C_CR2_RD_WRN;
 
 	/* Set slave address */
-	cr2 &= ~STM32F7_I2C_CR2_SADD7_MASK;
-	cr2 |= STM32F7_I2C_CR2_SADD7(f7_msg->addr);
+	cr2 &= ~(STM32F7_I2C_CR2_HEAD10R | STM32F7_I2C_CR2_ADD10);
+	if (msg->flags & I2C_M_TEN) {
+		cr2 &= ~STM32F7_I2C_CR2_SADD10_MASK;
+		cr2 |= STM32F7_I2C_CR2_SADD10(f7_msg->addr);
+		cr2 |= STM32F7_I2C_CR2_ADD10;
+	} else {
+		cr2 &= ~STM32F7_I2C_CR2_SADD7_MASK;
+		cr2 |= STM32F7_I2C_CR2_SADD7(f7_msg->addr);
+	}
 
 	/* Set nb bytes to transfer and reload if needed */
 	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK | STM32F7_I2C_CR2_RELOAD);
@@ -798,7 +810,7 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
 }
 
 static struct i2c_algorithm stm32f7_i2c_algo = {
-- 
2.7.4
