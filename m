Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELs0uAOUWIaCsNE0/St1apcIw8FfgANs0a/P2elOPSV1+ye24o6swdjmJXUpvKJzuqp0DDMG
ARC-Seal: i=1; a=rsa-sha256; t=1521802834; cv=none;
        d=google.com; s=arc-20160816;
        b=MUxn7j5f+winCmBu2olinF2Pijo51N7a92kB632M3mM/gffNCL5nTAS8TFQbXEIoCC
         GUGNabpInLPA7a+Lt3E21wg85KuEZDZKUH2kcZ9KcoeZCSxlFMqfcTOm9L/28Lr4ppOm
         zyAIM+vrMAmZSqe6jDdmSm4sPAHQQCcEAGvQ+7/vuJssXbq7KoOI9/8n2Bq91utpV4Sy
         tvrO3SP4AZkISbasFvYCS6EPwViLG4ZDZKaZHWC21GpIO3urepp8tcpNEZM9c2Mf1Dd6
         nVDQ3rne3ikN15awvfNtR2AxNpE9ZcQgQ99nZVrkHgYRWzwFGumbRMlVKV90Qi/s9xMK
         MTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ejG7u/xFM2zgpsgeaqXC0cUXojSx80+cy9RsyCeo+98=;
        b=x22z50sgFapceV2Y+zAnBPGKwnh2/l6yNf0AVLt2KiihbL2zDMirMDKMcjSWTduVPA
         2+uZe4zY+IkmHXpBHBbQQT2cOTME4z7YRUVVT0/JD94xj9HkT40yW4eJJgQY1Sn41y9E
         IU4XCQy1IjyyPt5dMF60MjHze+Q0msYCAwwWzmTJ9EzFMCEU1Z4rEp0GJbgIwM5NvJbl
         hrIhAGiTxKMpyP/mws6kht7Yi131+Z3+VU5md6hUgjsAZ3sEN1Xvq74Gex1zmgcJH1fe
         z3rBp5ZQoyZ9NWbpKE3rYjcEiF6nGcBMmx5Nqe3swYjROK0Lq+GPxm8/tPF84UWvL+PM
         IgJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 01/11] i2c: Export of_i2c_get_board_info()
Date: Fri, 23 Mar 2018 12:00:10 +0100
Message-Id: <20180323110020.19080-2-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180323110020.19080-1-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725929783088275?=
X-GMAIL-MSGID: =?utf-8?q?1595725929783088275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Brezillon <boris.brezillon@free-electrons.com>

I3C busses have to know about all I2C devices connected on the I3C bus
to properly initialize the I3C master, and I2C frames can't be sent on
the bus until this initialization is done.

We can't let the I2C core parse the DT and instantiate I2C devices as
part of its i2c_add_adapter() procedure because, when done this way,
I2C devices are directly registered to the device-model and might be
attached to drivers which could in turn start sending frames on the bus,
which won't work since, as said above, the bus is not yet initialized.

Export of_i2c_register_device() in order to let the I3C core parse the
I2C device nodes by itself and initialize the bus.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes in v2:
- fix memset() call
- rebase on v4.15-rc1
---
 drivers/i2c/i2c-core-base.c |  2 +-
 drivers/i2c/i2c-core-of.c   | 66 ++++++++++++++++++++++++++-------------------
 include/linux/i2c.h         | 10 +++++++
 3 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5a00bf443d06..e57715f5064c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -736,7 +736,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.parent = &client->adapter->dev;
 	client->dev.bus = &i2c_bus_type;
 	client->dev.type = &i2c_client_type;
-	client->dev.of_node = info->of_node;
+	client->dev.of_node = of_node_get(info->of_node);
 	client->dev.fwnode = info->fwnode;
 
 	i2c_dev_set_name(adap, client, info);
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 8d474bb1dc15..7470bc418a3b 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -22,56 +22,66 @@
 
 #include "i2c-core.h"
 
-static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
-						 struct device_node *node)
+int of_i2c_get_board_info(struct device *dev, struct device_node *node,
+			  struct i2c_board_info *info)
 {
-	struct i2c_client *result;
-	struct i2c_board_info info = {};
-	struct dev_archdata dev_ad = {};
-	const __be32 *addr_be;
 	u32 addr;
-	int len;
+	int ret;
 
-	dev_dbg(&adap->dev, "of_i2c: register %pOF\n", node);
+	memset(info, 0, sizeof(*info));
 
-	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
-		dev_err(&adap->dev, "of_i2c: modalias failure on %pOF\n",
-			node);
-		return ERR_PTR(-EINVAL);
+	if (of_modalias_node(node, info->type, sizeof(info->type)) < 0) {
+		dev_err(dev, "of_i2c: modalias failure on %pOF\n", node);
+		return -EINVAL;
 	}
 
-	addr_be = of_get_property(node, "reg", &len);
-	if (!addr_be || (len < sizeof(*addr_be))) {
-		dev_err(&adap->dev, "of_i2c: invalid reg on %pOF\n", node);
-		return ERR_PTR(-EINVAL);
+	ret = of_property_read_u32(node, "reg", &addr);
+	if (ret) {
+		dev_err(dev, "of_i2c: invalid reg on %pOF\n", node);
+		return ret;
 	}
 
-	addr = be32_to_cpup(addr_be);
 	if (addr & I2C_TEN_BIT_ADDRESS) {
 		addr &= ~I2C_TEN_BIT_ADDRESS;
-		info.flags |= I2C_CLIENT_TEN;
+		info->flags |= I2C_CLIENT_TEN;
 	}
 
 	if (addr & I2C_OWN_SLAVE_ADDRESS) {
 		addr &= ~I2C_OWN_SLAVE_ADDRESS;
-		info.flags |= I2C_CLIENT_SLAVE;
+		info->flags |= I2C_CLIENT_SLAVE;
 	}
 
-	if (i2c_check_addr_validity(addr, info.flags)) {
-		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %pOF\n",
-			addr, node);
-		return ERR_PTR(-EINVAL);
+	ret = i2c_check_addr_validity(addr, info->flags);
+	if (ret) {
+		dev_err(dev, "of_i2c: invalid addr=%x on %pOF\n", addr, node);
+		return ret;
 	}
 
-	info.addr = addr;
-	info.of_node = of_node_get(node);
-	info.archdata = &dev_ad;
+	info->addr = addr;
+	info->of_node = node;
 
 	if (of_property_read_bool(node, "host-notify"))
-		info.flags |= I2C_CLIENT_HOST_NOTIFY;
+		info->flags |= I2C_CLIENT_HOST_NOTIFY;
 
 	if (of_get_property(node, "wakeup-source", NULL))
-		info.flags |= I2C_CLIENT_WAKE;
+		info->flags |= I2C_CLIENT_WAKE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_i2c_get_board_info);
+
+static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
+						 struct device_node *node)
+{
+	struct i2c_client *result;
+	struct i2c_board_info info;
+	int ret;
+
+	dev_dbg(&adap->dev, "of_i2c: register %pOF\n", node);
+
+	ret = of_i2c_get_board_info(&adap->dev, node, &info);
+	if (ret)
+		return ERR_PTR(ret);
 
 	result = i2c_new_device(adap, &info);
 	if (result == NULL) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 419a38e7c315..3e38c10748e3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -873,6 +873,9 @@ extern const struct of_device_id
 *i2c_of_match_device(const struct of_device_id *matches,
 		     struct i2c_client *client);
 
+int of_i2c_get_board_info(struct device *dev, struct device_node *node,
+			  struct i2c_board_info *info);
+
 #else
 
 static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
@@ -897,6 +900,13 @@ static inline const struct of_device_id
 	return NULL;
 }
 
+static inline int of_i2c_get_board_info(struct device *dev,
+					struct device_node *node,
+					struct i2c_board_info *info)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_OF */
 
 #if IS_ENABLED(CONFIG_ACPI)
-- 
2.14.1
