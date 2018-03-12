Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeCLKyN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:54:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11351 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750967AbeCLKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:54:11 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND PATCH v1 1/6] i2c: i2c-stm32f7: Add 10-bit address support
Date: Mon, 12 Mar 2018 11:53:38 +0100
Message-ID: <1520852023-27083-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_06:,,
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
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index fdad107..8e56df0 100644
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
