Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCTGVQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:21:16 -0400
Received: from hub02.inventec.com ([218.32.67.167]:55964 "EHLO
        mail.inventec.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751416AbeCTGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:20:54 -0400
X-Google-Smtp-Source: AG47ELuP5x5YBjKjk2Z8FYEF9PvsJPN0Wj5PBDtnMEfF+CkfZN/ZxEfQQMqSZQq884x3qisYJCVOFQ==
From: Ken Chen <chen.kenyy@inventec.com>
To: <linux@roeck-us.net>, <wsa@the-dreams.de>, <peda@axentia.se>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ken Chen <chen.kenyy@inventec.com>, <joel@jms.id.au>
Subject: [PATCH linux dev-4.16 v2] i2c: muxes: pca9641: new driver
Date: Tue, 20 Mar 2018 14:19:09 +0800
Message-ID: <20180320061909.5775-1-chen.kenyy@inventec.com>
X-Mailer: git-send-email 2.9.3
X-DNSRBL: 
X-MAIL: IEC1-MSE-FE1.inventec.com w2K6GQbQ002080
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ken Chen <chen.kenyy@inventec.com>

---
v1->v2
- Merged PCA9641 code into i2c-mux-pca9541.c
- Modified title
- Add PCA9641 detect function
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 184 ++++++++++++++++++++++++++++++++++--
 1 file changed, 174 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39ada..493f947 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -1,5 +1,5 @@
 /*
- * I2C multiplexer driver for PCA9541 bus master selector
+ * I2C multiplexer driver for PCA9541/PCA9641 bus master selector
  *
  * Copyright (c) 2010 Ericsson AB.
  *
@@ -26,8 +26,8 @@
 #include <linux/slab.h>
 
 /*
- * The PCA9541 is a bus master selector. It supports two I2C masters connected
- * to a single slave bus.
+ * The PCA9541/PCA9641 is a bus master selector. It supports two I2C masters 
+ * connected to a single slave bus.
  *
  * Before each bus transaction, a master has to acquire bus ownership. After the
  * transaction is complete, bus ownership has to be released. This fits well
@@ -58,11 +58,43 @@
 #define PCA9541_ISTAT_MYTEST	(1 << 6)
 #define PCA9541_ISTAT_NMYTEST	(1 << 7)
 
+#define PCA9641_ID		0x00
+#define PCA9641_ID_MAGIC	0x38
+
+#define PCA9641_CONTROL		0x01
+#define PCA9641_STATUS		0x02
+#define PCA9641_TIME		0x03
+
+#define PCA9641_CTL_LOCK_REQ		BIT(0)
+#define PCA9641_CTL_LOCK_GRANT		BIT(1)
+#define PCA9641_CTL_BUS_CONNECT		BIT(2)
+#define PCA9641_CTL_BUS_INIT		BIT(3)
+#define PCA9641_CTL_SMBUS_SWRST		BIT(4)
+#define PCA9641_CTL_IDLE_TIMER_DIS	BIT(5)
+#define PCA9641_CTL_SMBUS_DIS		BIT(6)
+#define PCA9641_CTL_PRIORITY		BIT(7)
+
+#define PCA9641_STS_OTHER_LOCK		BIT(0)
+#define PCA9641_STS_BUS_INIT_FAIL	BIT(1)
+#define PCA9641_STS_BUS_HUNG		BIT(2)
+#define PCA9641_STS_MBOX_EMPTY		BIT(3)
+#define PCA9641_STS_MBOX_FULL		BIT(4)
+#define PCA9641_STS_TEST_INT		BIT(5)
+#define PCA9641_STS_SCL_IO		BIT(6)
+#define PCA9641_STS_SDA_IO		BIT(7)
+
+#define PCA9641_RES_TIME	0x03
+
 #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
 #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
 #define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
 #define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
 
+#define BUSOFF(x, y)	(!((x) & PCA9641_CTL_LOCK_GRANT) && \
+			!((y) & PCA9641_STS_OTHER_LOCK))
+#define other_lock(x)	((x) & PCA9641_STS_OTHER_LOCK)
+#define lock_grant(x)	((x) & PCA9641_CTL_LOCK_GRANT)
+
 /* arbitration timeouts, in jiffies */
 #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
 #define ARB2_TIMEOUT	(HZ / 4)	/* 250 ms until acquisition failure */
@@ -79,6 +111,7 @@ struct pca9541 {
 
 static const struct i2c_device_id pca9541_id[] = {
 	{"pca9541", 0},
+	{"pca9641", 1},
 	{}
 };
 
@@ -87,6 +120,7 @@ MODULE_DEVICE_TABLE(i2c, pca9541_id);
 #ifdef CONFIG_OF
 static const struct of_device_id pca9541_of_match[] = {
 	{ .compatible = "nxp,pca9541" },
+	{ .compatible = "nxp,pca9641" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pca9541_of_match);
@@ -328,6 +362,125 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
 }
 
 /*
+ * Arbitration management functions
+ */
+static void pca9641_release_bus(struct i2c_client *client)
+{
+	pca9541_reg_write(client, PCA9641_CONTROL, 0);
+}
+
+/*
+ * Channel arbitration
+ *
+ * Return values:
+ *  <0: error
+ *  0 : bus not acquired
+ *  1 : bus acquired
+ */
+static int pca9641_arbitrate(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca9541 *data = i2c_mux_priv(muxc);
+	int reg_ctl, reg_sts;
+
+	reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
+	if (reg_ctl < 0)
+		return reg_ctl;
+	reg_sts = pca9541_reg_read(client, PCA9641_STATUS);
+
+	if (BUSOFF(reg_ctl, reg_sts)) {
+		/*
+		 * Bus is off. Request ownership or turn it on unless
+		 * other master requested ownership.
+		 */
+		reg_ctl |= PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+		reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
+
+		if (lock_grant(reg_ctl)) {
+			/*
+			 * Other master did not request ownership,
+			 * or arbitration timeout expired. Take the bus.
+			 */
+			reg_ctl |= PCA9641_CTL_BUS_CONNECT
+					| PCA9641_CTL_LOCK_REQ;
+			pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+			data->select_timeout = SELECT_DELAY_SHORT;
+
+			return 1;
+		} else {
+			/*
+			 * Other master requested ownership.
+			 * Set extra long timeout to give it time to acquire it.
+			 */
+			data->select_timeout = SELECT_DELAY_LONG * 2;
+		}
+	} else if (lock_grant(reg_ctl)) {
+		/*
+		 * Bus is on, and we own it. We are done with acquisition.
+		 */
+		reg_ctl |= PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+
+		return 1;
+	} else if (other_lock(reg_sts)) {
+		/*
+		 * Other master owns the bus.
+		 * If arbitration timeout has expired, force ownership.
+		 * Otherwise request it.
+		 */
+		data->select_timeout = SELECT_DELAY_LONG;
+		reg_ctl |= PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+	}
+	return 0;
+}
+
+static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct pca9541 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+	int ret;
+	unsigned long timeout = jiffies + ARB2_TIMEOUT;
+		/* give up after this time */
+
+	data->arb_timeout = jiffies + ARB_TIMEOUT;
+		/* force bus ownership after this time */
+
+	do {
+		ret = pca9641_arbitrate(client);
+		if (ret)
+			return ret < 0 ? ret : 0;
+
+		if (data->select_timeout == SELECT_DELAY_SHORT)
+			udelay(data->select_timeout);
+		else
+			msleep(data->select_timeout / 1000);
+	} while (time_is_after_eq_jiffies(timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int pca9641_release_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct pca9541 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+
+	pca9641_release_bus(client);
+	return 0;
+}
+
+static int pca9641_detect_id(struct i2c_client *client)
+{
+	int reg;
+
+	reg = pca9541_reg_read(client, PCA9641_ID);
+	if (reg == PCA9641_ID_MAGIC)
+		return 1;
+	else
+		return 0;
+}
+/*
  * I2C init/probing/exit functions
  */
 static int pca9541_probe(struct i2c_client *client,
@@ -339,34 +492,45 @@ static int pca9541_probe(struct i2c_client *client,
 	struct pca9541 *data;
 	int force;
 	int ret;
+	int detect_id;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
+	detect_id = pca9641_detect_id(client);
 	/*
 	 * I2C accesses are unprotected here.
 	 * We have to lock the adapter before releasing the bus.
 	 */
-	i2c_lock_adapter(adap);
-	pca9541_release_bus(client);
-	i2c_unlock_adapter(adap);
-
+	if (detect_id == 0) {
+		i2c_lock_adapter(adap);
+		pca9541_release_bus(client);
+		i2c_unlock_adapter(adap);
+	} else {
+		i2c_lock_adapter(adap);
+		pca9641_release_bus(client);
+		i2c_unlock_adapter(adap);
+	}
 	/* Create mux adapter */
 
 	force = 0;
 	if (pdata)
 		force = pdata->modes[0].adap_id;
-	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
+	if (detect_id == 0) {
+		muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
 			     I2C_MUX_ARBITRATOR,
 			     pca9541_select_chan, pca9541_release_chan);
+	} else {
+		muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
+			     I2C_MUX_ARBITRATOR,
+			     pca9641_select_chan, pca9641_release_chan);
+	}
 	if (!muxc)
 		return -ENOMEM;
 
 	data = i2c_mux_priv(muxc);
 	data->client = client;
-
 	i2c_set_clientdata(client, muxc);
-
 	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
 	if (ret)
 		return ret;
-- 
2.9.3
