Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA532C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68B2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfBRLYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:24:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730621AbfBRLXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:23:34 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4BCEDBDAA62540E854B;
        Mon, 18 Feb 2019 19:23:26 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 19:23:20 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Pengcheng Li <lpc.li@hisilicon.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH v2 05/10] phy: Add usb phy support for hi3660 Soc of Hisilicon
Date:   Mon, 18 Feb 2019 19:23:05 +0800
Message-ID: <20190218112310.17860-6-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190218112310.17860-1-chenyu56@huawei.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver handles usb phy power on and shutdown for hi3660 Soc of
Hisilicon.

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Pengcheng Li <lpc.li@hisilicon.com>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jiancheng Xue <xuejiancheng@hisilicon.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
v1:
* Remove unused code and add comment for time delay as suggested by
Kishon Vijay Abraham I.
v2:
* Fix license declaration.
* Remove redundant parens.
* Remove unused member variables in struct hi3660_priv.
---
---
 MAINTAINERS                             |   8 ++
 drivers/phy/hisilicon/Kconfig           |  10 ++
 drivers/phy/hisilicon/Makefile          |   1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c | 232 ++++++++++++++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..8dc289faa2c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15790,6 +15790,14 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
 
+USB IP DRIVER FOR HISILICON KIRIN
+M:	Yu Chen <chenyu56@huawei.com>
+M:	Binghui Wang <wangbinghui@hisilicon.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
+F:	drivers/phy/hisilicon/phy-hi3660-usb3.c
+
 USB ISP116X DRIVER
 M:	Olav Kongas <ok@artecdesign.ee>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index b40ee54a1a50..3c142f08987c 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -12,6 +12,16 @@ config PHY_HI6220_USB
 
 	  To compile this driver as a module, choose M here.
 
+config PHY_HI3660_USB
+	tristate "hi3660 USB PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HISILICON HI3660 USB PHY.
+
+	  To compile this driver as a module, choose M here.
+
 config PHY_HISTB_COMBPHY
 	tristate "HiSilicon STB SoCs COMBPHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
index f662a4fe18d8..75ba64e2faf8 100644
--- a/drivers/phy/hisilicon/Makefile
+++ b/drivers/phy/hisilicon/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
+obj-$(CONFIG_PHY_HI3660_USB)		+= phy-hi3660-usb3.o
 obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
 obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
diff --git a/drivers/phy/hisilicon/phy-hi3660-usb3.c b/drivers/phy/hisilicon/phy-hi3660-usb3.c
new file mode 100644
index 000000000000..97184e6f0d41
--- /dev/null
+++ b/drivers/phy/hisilicon/phy-hi3660-usb3.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Phy provider for USB 3.0 controller on HiSilicon 3660 platform
+ *
+ * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
+ *		http://www.huawei.com
+ *
+ * Authors: Yu Chen <chenyu56@huawei.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define PERI_CRG_CLK_EN4			0x40
+#define PERI_CRG_CLK_DIS4			0x44
+#define GT_CLK_USB3OTG_REF			BIT(0)
+#define GT_ACLK_USB3OTG				BIT(1)
+
+#define PERI_CRG_RSTEN4				0x90
+#define PERI_CRG_RSTDIS4			0x94
+#define IP_RST_USB3OTGPHY_POR			BIT(3)
+#define IP_RST_USB3OTG				BIT(5)
+
+#define PERI_CRG_ISODIS				0x148
+#define USB_REFCLK_ISO_EN			BIT(25)
+
+#define PCTRL_PERI_CTRL3			0x10
+#define PCTRL_PERI_CTRL3_MSK_START		16
+#define USB_TCXO_EN				BIT(1)
+
+#define PCTRL_PERI_CTRL24			0x64
+#define SC_CLK_USB3PHY_3MUX1_SEL		BIT(25)
+
+#define USBOTG3_CTRL0				0x00
+#define SC_USB3PHY_ABB_GT_EN			BIT(15)
+
+#define USBOTG3_CTRL2				0x08
+#define USBOTG3CTRL2_POWERDOWN_HSP		BIT(0)
+#define USBOTG3CTRL2_POWERDOWN_SSP		BIT(1)
+
+#define USBOTG3_CTRL3				0x0C
+#define USBOTG3_CTRL3_VBUSVLDEXT		BIT(6)
+#define USBOTG3_CTRL3_VBUSVLDEXTSEL		BIT(5)
+
+#define USBOTG3_CTRL4				0x10
+
+#define USBOTG3_CTRL7				0x1c
+#define REF_SSP_EN				BIT(16)
+
+#define HI3660_USB_DEFAULT_PHY_PARAM		0x1c466e3
+
+struct hi3660_priv {
+	struct device *dev;
+	struct regmap *peri_crg;
+	struct regmap *pctrl;
+	struct regmap *otg_bc;
+	u32 eye_diagram_param;
+};
+
+static int hi3660_phy_init(struct phy *phy)
+{
+	struct hi3660_priv *priv = phy_get_drvdata(phy);
+	u32 val, mask;
+	int ret;
+
+	/* usb refclk iso disable */
+	ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS, USB_REFCLK_ISO_EN);
+	if (ret)
+		goto out;
+
+	/* enable usb_tcxo_en */
+	val = USB_TCXO_EN | (USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
+	ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3, val);
+	if (ret)
+		goto out;
+
+	/* assert phy */
+	val = IP_RST_USB3OTGPHY_POR | IP_RST_USB3OTG;
+	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTEN4, val);
+	if (ret)
+		goto out;
+
+	/* enable phy ref clk */
+	val = SC_USB3PHY_ABB_GT_EN;
+	mask = val;
+	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL0, mask, val);
+	if (ret)
+		goto out;
+
+	val = REF_SSP_EN;
+	mask = val;
+	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL7, mask, val);
+	if (ret)
+		goto out;
+
+	/* exit from IDDQ mode */
+	mask = USBOTG3CTRL2_POWERDOWN_HSP | USBOTG3CTRL2_POWERDOWN_SSP;
+	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL2, mask, 0);
+	if (ret)
+		goto out;
+
+	/* delay for exit from IDDQ mode */
+	usleep_range(100, 100);
+
+	/* deassert phy */
+	val = IP_RST_USB3OTGPHY_POR | IP_RST_USB3OTG;
+	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTDIS4, val);
+	if (ret)
+		goto out;
+
+	/* delay for phy deasserted */
+	usleep_range(10000, 15000);
+
+	/* fake vbus valid signal */
+	val = USBOTG3_CTRL3_VBUSVLDEXT | USBOTG3_CTRL3_VBUSVLDEXTSEL;
+	mask = val;
+	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL3, mask, val);
+	if (ret)
+		goto out;
+
+	/* delay for vbus valid */
+	usleep_range(100, 100);
+
+	ret = regmap_write(priv->otg_bc, USBOTG3_CTRL4,
+			priv->eye_diagram_param);
+	if (ret)
+		goto out;
+
+	return 0;
+out:
+	dev_err(priv->dev, "failed to init phy ret: %d\n", ret);
+	return ret;
+}
+
+static int hi3660_phy_exit(struct phy *phy)
+{
+	struct hi3660_priv *priv = phy_get_drvdata(phy);
+	u32 val;
+	int ret;
+
+	/* assert phy */
+	val = IP_RST_USB3OTGPHY_POR;
+	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTEN4, val);
+	if (ret)
+		goto out;
+
+	/* disable usb_tcxo_en */
+	val = USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START;
+	ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3, val);
+	if (ret)
+		goto out;
+
+	return 0;
+out:
+	dev_err(priv->dev, "failed to exit phy ret: %d\n", ret);
+	return ret;
+}
+
+static struct phy_ops hi3660_phy_ops = {
+	.init		= hi3660_phy_init,
+	.exit		= hi3660_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int hi3660_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct phy *phy;
+	struct hi3660_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->peri_crg = syscon_regmap_lookup_by_phandle(dev->of_node,
+					"hisilicon,pericrg-syscon");
+	if (IS_ERR(priv->peri_crg)) {
+		dev_err(dev, "no hisilicon,pericrg-syscon\n");
+		return PTR_ERR(priv->peri_crg);
+	}
+
+	priv->pctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
+					"hisilicon,pctrl-syscon");
+	if (IS_ERR(priv->pctrl)) {
+		dev_err(dev, "no hisilicon,pctrl-syscon\n");
+		return PTR_ERR(priv->pctrl);
+	}
+
+	priv->otg_bc = syscon_regmap_lookup_by_phandle(dev->of_node,
+					"hisilicon,usb3-otg-bc-syscon");
+	if (IS_ERR(priv->otg_bc)) {
+		dev_err(dev, "no hisilicon,usb3-otg-bc-syscon\n");
+		return PTR_ERR(priv->otg_bc);
+	}
+
+	if (of_property_read_u32(dev->of_node, "hisilicon,eye-diagram-param",
+		&(priv->eye_diagram_param)))
+		priv->eye_diagram_param = HI3660_USB_DEFAULT_PHY_PARAM;
+
+	phy = devm_phy_create(dev, NULL, &hi3660_phy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy_set_drvdata(phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id hi3660_phy_of_match[] = {
+	{.compatible = "hisilicon,hi3660-usb-phy",},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi3660_phy_of_match);
+
+static struct platform_driver hi3660_phy_driver = {
+	.probe	= hi3660_phy_probe,
+	.driver = {
+		.name	= "hi3660-usb-phy",
+		.of_match_table	= hi3660_phy_of_match,
+	}
+};
+module_platform_driver(hi3660_phy_driver);
+
+MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hilisicon Hi3660 USB3 PHY Driver");
-- 
2.15.0-rc2

