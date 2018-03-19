Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbeCSLlG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:41:06 -0400
Received: from hub01.inventec.com ([61.220.76.161]:22121 "EHLO
        mail.inventec.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755299AbeCSLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:41:04 -0400
X-Google-Smtp-Source: AG47ELtmsdEttnw0KumG7GdIKXzYPf4h71FMzP4ZwMEXEat8qlOHeDp/2kS7v5jY6q3IogAZ3rTVyw==
From: Ken Chen <chen.kenyy@inventec.com>
To: <linux@roeck-us.net>, <wsa@the-dreams.de>, <peda@axentia.se>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ken Chen <chen.kenyy@inventec.com>, <joel@jms.id.au>
Subject: [PATCH linux dev-4.16] drivers: i2c: master arbiter: create driver
Date: Mon, 19 Mar 2018 19:38:08 +0800
Message-ID: <20180319113808.23485-1-chen.kenyy@inventec.com>
X-Mailer: git-send-email 2.9.3
X-DNSRBL: 
X-MAIL: IEC1-MSE-FE1.inventec.com w2JBZKkK057711
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial PCA9641 2 chennel I2C bus master arbiter
with separate implementation. It has probe issue
and difference device hehavior between PCA9541
and PCA9641 in original PCA9641 patch.

Signed-off-by: Ken Chen <chen.kenyy@inventec.com>
---
 drivers/i2c/muxes/Kconfig           |   9 +
 drivers/i2c/muxes/Makefile          |   1 +
 drivers/i2c/muxes/i2c-mux-pca9641.c | 360 ++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 drivers/i2c/muxes/i2c-mux-pca9641.c

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 52a4a92..f9c51b8 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -73,6 +73,15 @@ config I2C_MUX_PCA954x
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-pca954x.
 
+config I2C_MUX_PCA9641
+	tristate "NXP PCA9641 I2C Master demultiplexer"
+	help
+	  If you say yes here you get support for the NXP PCA9641
+	  I2C Master demultiplexer with an arbiter function.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mux-pca9641.
+
 config I2C_MUX_PINCTRL
 	tristate "pinctrl-based I2C multiplexer"
 	depends on PINCTRL
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 6d9d865..a229a1a 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_I2C_MUX_LTC4306)	+= i2c-mux-ltc4306.o
 obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
 obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
+obj-$(CONFIG_I2C_MUX_PCA9641)	+= i2c-mux-pca9641.o
 obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
 obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
 
diff --git a/drivers/i2c/muxes/i2c-mux-pca9641.c b/drivers/i2c/muxes/i2c-mux-pca9641.c
new file mode 100644
index 0000000..bcf45c8
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-mux-pca9641.c
@@ -0,0 +1,360 @@
+/*
+ * I2C demultiplexer driver for PCA9641 bus master demultiplexer
+ *
+ * Copyright (c) 2010 Ericsson AB.
+ *
+ * Author: Ken Chen <chen.kenyy@inventec.com>
+ *
+ * Derived from:
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+
+#include <linux/i2c/pca954x.h>
+
+/*
+ * The PCA9641 is two I2C bus masters demultiplexer. It supports two I2C masters
+ * connected to a single slave bus.
+ *
+ * It is designed for high reliability dual master I2C bus applications where
+ * correct system operation is required, even when two I2C master issue their
+ * commands at the same time. The arbiter will select a winner and let it work
+ * uninterrupted, and the losing master will take control of the I2C bus after
+ * the winnter has finished. The arbiter also allows for queued requests where
+ * a master requests the downstream bus while the other master has control.
+ *
+ */
+
+#define PCA9641_ID		0x01
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
+#define busoff(x, y)	(!((x) & PCA9641_CTL_LOCK_GRANT) && \
+			!((y) & PCA9641_STS_OTHER_LOCK))
+#define other_lock(x)	((x) & PCA9641_STS_OTHER_LOCK)
+#define lock_grant(x)	((x) & PCA9641_CTL_LOCK_GRANT)
+
+/* arbitration timeouts, in jiffies */
+#define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
+#define ARB2_TIMEOUT	(HZ / 4)	/* 250 ms until acquisition failure */
+
+/* arbitration retry delays, in us */
+#define SELECT_DELAY_SHORT	50
+#define SELECT_DELAY_LONG	1000
+
+struct pca9641 {
+	struct i2c_client *client;
+	unsigned long select_timeout;
+	unsigned long arb_timeout;
+};
+
+static const struct i2c_device_id pca9641_id[] = {
+	{"pca9641", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pca9641_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pca9641_of_match[] = {
+	{ .compatible = "nxp,pca9641" },
+	{}
+};
+#endif
+
+/*
+ * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
+ * as they will try to lock the adapter a second time.
+ */
+static int pca9641_reg_write(struct i2c_client *client, u8 command, u8 val)
+{
+	struct i2c_adapter *adap = client->adapter;
+	int ret;
+
+	if (adap->algo->master_xfer) {
+		struct i2c_msg msg;
+		char buf[2];
+
+		msg.addr = client->addr;
+		msg.flags = 0;
+		msg.len = 2;
+		buf[0] = command;
+		buf[1] = val;
+		msg.buf = buf;
+		ret = __i2c_transfer(adap, &msg, 1);
+	} else {
+		union i2c_smbus_data data;
+
+		data.byte = val;
+		ret = adap->algo->smbus_xfer(adap, client->addr,
+					     client->flags,
+					     I2C_SMBUS_WRITE,
+					     command,
+					     I2C_SMBUS_BYTE_DATA, &data);
+	}
+
+	return ret;
+}
+
+/*
+ * Read from chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
+ * as they will try to lock adapter a second time.
+ */
+static int pca9641_reg_read(struct i2c_client *client, u8 command)
+{
+	struct i2c_adapter *adap = client->adapter;
+	int ret;
+	u8 val;
+
+	if (adap->algo->master_xfer) {
+		struct i2c_msg msg[2] = {
+			{
+				.addr = client->addr,
+				.flags = 0,
+				.len = 1,
+				.buf = &command
+			},
+			{
+				.addr = client->addr,
+				.flags = I2C_M_RD,
+				.len = 1,
+				.buf = &val
+			}
+		};
+		ret = __i2c_transfer(adap, msg, 2);
+		if (ret == 2)
+			ret = val;
+		else if (ret >= 0)
+			ret = -EIO;
+	} else {
+		union i2c_smbus_data data;
+
+		ret = adap->algo->smbus_xfer(adap, client->addr,
+					     client->flags,
+					     I2C_SMBUS_READ,
+					     command,
+					     I2C_SMBUS_BYTE_DATA, &data);
+		if (!ret)
+			ret = data.byte;
+	}
+	return ret;
+}
+
+/*
+ * Arbitration management functions
+ */
+static void pca9641_release_bus(struct i2c_client *client)
+{
+	pca9641_reg_write(client, PCA9641_CONTROL, 0);
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
+	struct pca9641 *data = i2c_mux_priv(muxc);
+	int reg_ctl, reg_sts;
+
+	reg_ctl = pca9641_reg_read(client, PCA9641_CONTROL);
+	if (reg_ctl < 0)
+		return reg_ctl;
+	reg_sts = pca9641_reg_read(client, PCA9641_STATUS);
+
+	if (busoff(reg_ctl, reg_sts)) {
+		/*
+		 * Bus is off. Request ownership or turn it on unless
+		 * other master requested ownership.
+		 */
+		reg_ctl |= PCA9641_CTL_LOCK_REQ;
+		pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
+		reg_ctl = pca9641_reg_read(client, PCA9641_CONTROL);
+
+		if (lock_grant(reg_ctl)) {
+			/*
+			 * Other master did not request ownership,
+			 * or arbitration timeout expired. Take the bus.
+			 */
+			reg_ctl |= PCA9641_CTL_BUS_CONNECT \
+					| PCA9641_CTL_LOCK_REQ;
+			pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
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
+		pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
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
+		pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
+	}
+	return 0;
+}
+
+static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct pca9641 *data = i2c_mux_priv(muxc);
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
+	struct pca9641 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+
+	pca9641_release_bus(client);
+	return 0;
+}
+
+/*
+ * I2C init/probing/exit functions
+ */
+static int pca9641_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adap = client->adapter;
+	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct i2c_mux_core *muxc;
+	struct pca9641 *data;
+	int force;
+	int ret;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	/*
+	 * I2C accesses are unprotected here.
+	 * We have to lock the adapter before releasing the bus.
+	 */
+	i2c_lock_adapter(adap);
+	pca9641_release_bus(client);
+	i2c_unlock_adapter(adap);
+
+	/* Create mux adapter */
+
+	force = 0;
+	if (pdata)
+		force = pdata->modes[0].adap_id;
+	muxc = i2c_mux_alloc(adap, &client->dev, 8, sizeof(*data),
+			     I2C_MUX_ARBITRATOR,
+			     pca9641_select_chan, pca9641_release_chan);
+	if (!muxc)
+		return -ENOMEM;
+
+	data = i2c_mux_priv(muxc);
+	data->client = client;
+
+	i2c_set_clientdata(client, muxc);
+
+
+	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
+	if (ret) {
+		dev_err(&client->dev, "failed to register master demultiplexer\n");
+		return ret;
+	}
+
+	dev_info(&client->dev, "registered master demultiplexer for I2C %s\n",
+		 client->name);
+
+	return 0;
+}
+
+static int pca9641_remove(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+
+	i2c_mux_del_adapters(muxc);
+	return 0;
+}
+
+static struct i2c_driver pca9641_driver = {
+	.driver = {
+		   .name = "pca9641",
+		   .of_match_table = of_match_ptr(pca9641_of_match),
+		   },
+	.probe = pca9641_probe,
+	.remove = pca9641_remove,
+	.id_table = pca9641_id,
+};
+
+module_i2c_driver(pca9641_driver);
+
+MODULE_AUTHOR("Ken Chen <chen.kenyy@inventec.com>");
+MODULE_DESCRIPTION("PCA9641 I2C master demultiplexer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
