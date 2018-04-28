Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933411AbeD1Aee (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:34:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39799 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933259AbeD1Acx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:53 -0400
X-Google-Smtp-Source: AB8JxZpRG+KwdzJCjOW0bpe8OlIZ2RbzrqwBw3hJNUye+dRdlD88rvpaw3kZHA/tMRzJOknUUSsVbQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [RFC net-next 4/5] net: phy: Add support for IEEE standard test modes
Date: Fri, 27 Apr 2018 17:32:34 -0700
Message-Id: <20180428003237.1536-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 100BaseT2 and 1000BaseT standard test modes as
defined by the IEEE 802.3-2012-Section two and three. We provide a set
of helper functions for PHY drivers to either punt entirely onto
genphy_* functions or if they desire, build additional tests on top of
the standard ones available.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/Kconfig     |   6 ++
 drivers/net/phy/Makefile    |   4 +-
 drivers/net/phy/phy-tests.c | 159 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h         |  22 ++++++
 4 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/phy-tests.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index edb8b9ab827f..ef3f2f1ae990 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -200,6 +200,12 @@ config LED_TRIGGER_PHY
 		<Speed in megabits>Mbps OR <Speed in gigabits>Gbps OR link
 		for any speed known to the PHY.
 
+config CONFIG_PHYLIB_TEST_MODES
+	bool "Support for test modes"
+	---help---
+	  Selecting this option will allow the PHY library to support
+	  test modes: electrical, cable diagnostics, pattern generator etc.
+
 
 comment "MII PHY device drivers"
 
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 701ca0b8717e..e9905432e164 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux PHY drivers and MDIO bus drivers
 
-libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o
+libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
+				   phy-tests.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
@@ -18,6 +19,7 @@ obj-$(CONFIG_MDIO_DEVICE)	+= mdio-bus.o
 endif
 libphy-$(CONFIG_SWPHY)		+= swphy.o
 libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
+libphy-$(CONFIG_PHYLIB_TEST_MODES)	+= phy-tests.o
 
 obj-$(CONFIG_PHYLINK)		+= phylink.o
 obj-$(CONFIG_PHYLIB)		+= libphy.o
diff --git a/drivers/net/phy/phy-tests.c b/drivers/net/phy/phy-tests.c
new file mode 100644
index 000000000000..5709d7821925
--- /dev/null
+++ b/drivers/net/phy/phy-tests.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* PHY library common test modes
+ */
+#include <linux/export.h>
+#include <linux/phy.h>
+
+/* genphy_get_test - Get PHY test specific data
+ * @phydev: the PHY device instance
+ * @test: the desired test mode
+ * @data: test specific data (none)
+ */
+int genphy_get_test(struct phy_device *phydev, struct ethtool_phy_test *test,
+		    u8 *data)
+{
+	if (test->mode >= PHY_STD_TEST_MODE_MAX)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(genphy_get_test);
+
+/* genphy_set_test - Make a PHY enter one of the standard IEEE defined
+ * test modes
+ * @phydev: the PHY device instance
+ * @test: the desired test mode
+ * @data: test specific data (none)
+ *
+ * This function makes the designated @phydev enter the desired standard
+ * 100BaseT2 or 1000BaseT test mode as defined in IEEE 802.3-2012 section TWO
+ * and THREE under 32.6.1.2.1 and 40.6.1.1.2 respectively
+ */
+int genphy_set_test(struct phy_device *phydev,
+		    struct ethtool_phy_test *test, const u8 *data)
+{
+	u16 shift, base, bmcr = 0;
+	int ret;
+
+	/* Exit test mode */
+	if (test->mode == PHY_STD_TEST_MODE_NORMAL) {
+		ret = phy_read(phydev, MII_CTRL1000);
+		if (ret < 0)
+			return ret;
+
+		ret &= ~GENMASK(15, 13);
+
+		return phy_write(phydev, MII_CTRL1000, ret);
+	}
+
+	switch (test->mode) {
+	case PHY_STD_TEST_MODE_100BASET2_1:
+	case PHY_STD_TEST_MODE_100BASET2_2:
+	case PHY_STD_TEST_MODE_100BASET2_3:
+		if (!(phydev->supported & PHY_100BT_FEATURES))
+			return -EOPNOTSUPP;
+
+		shift = 14;
+		base = test->mode - PHY_STD_TEST_MODE_NORMAL;
+		bmcr = BMCR_SPEED100;
+		break;
+
+	case PHY_STD_TEST_MODE_1000BASET_1:
+	case PHY_STD_TEST_MODE_1000BASET_2:
+	case PHY_STD_TEST_MODE_1000BASET_3:
+	case PHY_STD_TEST_MODE_1000BASET_4:
+		if (!(phydev->supported & PHY_1000BT_FEATURES))
+			return -EOPNOTSUPP;
+
+		shift = 13;
+		base = test->mode - PHY_STD_TEST_MODE_100BASET2_MAX;
+		bmcr = BMCR_SPEED1000;
+		break;
+
+	default:
+		/* Let an upper driver deal with additional modes it may
+		 * support
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	/* Force speed and duplex */
+	ret = phy_write(phydev, MII_BMCR, bmcr | BMCR_FULLDPLX);
+	if (ret < 0)
+		return ret;
+
+	/* Set the desired test mode bit */
+	return phy_write(phydev, MII_CTRL1000, (test->mode + base) << shift);
+}
+EXPORT_SYMBOL_GPL(genphy_set_test);
+
+static const char *const phy_std_test_mode_str[] = {
+	"normal",
+	"100baseT2-tx-waveform",
+	"100baseT2-tx-jitter",
+	"100baseT2-tx-idle",
+	"1000baseT-tx-waveform",
+	"1000baseT-tx-jitter-master",
+	"1000baseT-tx-jitter-slave",
+	"1000BaseT-tx-distorsion"
+};
+
+/* genphy_get_test_count - Get PHY test count
+ * @phydev: the PHY device instance
+ *
+ * Returns the number of supported test modes for this PHY
+ */
+int genphy_get_test_count(struct phy_device *phydev)
+{
+	return ARRAY_SIZE(phy_std_test_mode_str);
+}
+EXPORT_SYMBOL_GPL(genphy_get_test_count);
+
+/* genphy_get_test_len - Return the amount of test specific data given
+ * a specific test mode
+ * @phydev: the PHY device instance
+ * @mode: the desired test mode
+ */
+int genphy_get_test_len(struct phy_device *phydev, u32 mode)
+{
+	switch (mode) {
+	case PHY_STD_TEST_MODE_NORMAL:
+	case PHY_STD_TEST_MODE_100BASET2_1:
+	case PHY_STD_TEST_MODE_100BASET2_2:
+	case PHY_STD_TEST_MODE_100BASET2_3:
+	case PHY_STD_TEST_MODE_1000BASET_1:
+	case PHY_STD_TEST_MODE_1000BASET_2:
+	case PHY_STD_TEST_MODE_1000BASET_3:
+	case PHY_STD_TEST_MODE_1000BASET_4:
+		/* no test specific data */
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(genphy_get_test_len);
+
+/* genphy_get_test_strings - Obtain the PHY device supported test modes
+ * text representations
+ * @phydev: the PHY device instance
+ * @data: buffer to store strings
+ */
+void genphy_get_test_strings(struct phy_device *phydev, u8 *data)
+{
+	unsigned int i;
+
+	if (!(phydev->supported & PHY_100BT_FEATURES))
+		return;
+
+	for (i = 0; i < PHY_STD_TEST_MODE_100BASET2_MAX; i++)
+		strlcpy(data + i * ETH_GSTRING_LEN,
+			phy_std_test_mode_str[i], ETH_GSTRING_LEN);
+
+	if (!(phydev->supported & PHY_1000BT_FEATURES))
+		return;
+
+	for (; i < PHY_STD_TEST_MODE_MAX; i++)
+		strlcpy(data + i * ETH_GSTRING_LEN,
+			phy_std_test_mode_str[i], ETH_GSTRING_LEN);
+}
+EXPORT_SYMBOL_GPL(genphy_get_test_strings);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 449afde7ca7c..7155187cf268 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -165,6 +165,20 @@ static inline const char *phy_modes(phy_interface_t interface)
 	}
 }
 
+enum phy_std_test_mode {
+	/* Normal operation - disables test mode */
+	PHY_STD_TEST_MODE_NORMAL = 0,
+	PHY_STD_TEST_MODE_100BASET2_1,
+	PHY_STD_TEST_MODE_100BASET2_2,
+	PHY_STD_TEST_MODE_100BASET2_3,
+	PHY_STD_TEST_MODE_100BASET2_MAX = PHY_STD_TEST_MODE_100BASET2_3,
+	PHY_STD_TEST_MODE_1000BASET_1,
+	PHY_STD_TEST_MODE_1000BASET_2,
+	PHY_STD_TEST_MODE_1000BASET_3,
+	PHY_STD_TEST_MODE_1000BASET_4,
+	PHY_STD_TEST_MODE_MAX,
+	/* PHY drivers can implement their own test modes after that value */
+};
 
 #define PHY_INIT_TIMEOUT	100000
 #define PHY_STATE_TIME		1
@@ -997,6 +1011,14 @@ int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 				 u16 regnum, u16 val);
 
+int genphy_get_test(struct phy_device *phydev, struct ethtool_phy_test *t,
+		    u8 *data);
+int genphy_set_test(struct phy_device *phydev, struct ethtool_phy_test *t,
+		    const u8 *data);
+int genphy_get_test_count(struct phy_device *phydev);
+void genphy_get_test_strings(struct phy_device *phydev, u8 *data);
+int genphy_get_test_len(struct phy_device *phydev, u32 mode);
+
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
-- 
2.14.1
