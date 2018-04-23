Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeDWGnQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:43:16 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:36360 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbeDWGm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:42:57 -0400
Subject: Re: [PATCH] phy: Add a driver for the ATH79 USB phy
To: Alban Bedel <albeu@free.fr>
References: <1521931120-31118-1-git-send-email-albeu@free.fr>
CC: <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8052c841-0950-9f03-c21e-0395db198969@ti.com>
Date: Mon, 23 Apr 2018 12:12:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1521931120-31118-1-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday 25 March 2018 04:08 AM, Alban Bedel wrote:
> The ATH79 USB phy is very simple, it only have a reset. On some SoC a
> second reset is used to force the phy in suspend mode regardless of the
> USB controller status.
> 
> This driver is added to the qualcom directory as atheros is now part
> of qualcom and newer SoC of this familly are marketed under the
> qualcom name.

merged, thanks!

-Kishon

> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  MAINTAINERS                          |   8 +++
>  drivers/phy/qualcomm/Kconfig         |  11 +++-
>  drivers/phy/qualcomm/Makefile        |   1 +
>  drivers/phy/qualcomm/phy-ath79-usb.c | 108 +++++++++++++++++++++++++++++++++++
>  4 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/phy/qualcomm/phy-ath79-usb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73c0cda..ce5ecd6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2294,6 +2294,14 @@ S:	Maintained
>  F:	drivers/gpio/gpio-ath79.c
>  F:	Documentation/devicetree/bindings/gpio/gpio-ath79.txt
>  
> +ATHEROS 71XX/9XXX USB PHY DRIVER
> +M:	Alban Bedel <albeu@free.fr>
> +W:	https://github.com/AlbanBedel/linux
> +T:	git git://github.com/AlbanBedel/linux
> +S:	Maintained
> +F:	drivers/phy/qualcomm/phy-ath79-usb.c
> +F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
> +
>  ATHEROS ATH GENERIC UTILITIES
>  M:	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>  L:	linux-wireless@vger.kernel.org
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 7bfa64b..632a0e7 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -1,6 +1,15 @@
>  #
> -# Phy drivers for Qualcomm platforms
> +# Phy drivers for Qualcomm and Atheros platforms
>  #
> +config PHY_ATH79_USB
> +	tristate "Atheros AR71XX/9XXX USB PHY driver"
> +	depends on OF && (ATH79 || COMPILE_TEST)
> +	default y if USB_EHCI_HCD_PLATFORM || USB_OHCI_HCD_PLATFORM
> +	select RESET_CONTROLLER
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the USB PHY on Atheros AR71XX/9XXX SoCs.
> +
>  config PHY_QCOM_APQ8064_SATA
>  	tristate "Qualcomm APQ8064 SATA SerDes/PHY driver"
>  	depends on ARCH_QCOM
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index 9abb789..deb831f4 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PHY_ATH79_USB)		+= phy-ath79-usb.o
>  obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
>  obj-$(CONFIG_PHY_QCOM_QMP)		+= phy-qcom-qmp.o
> diff --git a/drivers/phy/qualcomm/phy-ath79-usb.c b/drivers/phy/qualcomm/phy-ath79-usb.c
> new file mode 100644
> index 0000000..6fd6e07
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-ath79-usb.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Atheros AR71XX/9XXX USB PHY driver
> + *
> + * Copyright (C) 2015-2018 Alban Bedel <albeu@free.fr>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/reset.h>
> +
> +struct ath79_usb_phy {
> +	struct reset_control *reset;
> +	/* The suspend override logic is inverted, hence the no prefix
> +	 * to make the code a bit easier to understand.
> +	 */
> +	struct reset_control *no_suspend_override;
> +};
> +
> +static int ath79_usb_phy_power_on(struct phy *phy)
> +{
> +	struct ath79_usb_phy *priv = phy_get_drvdata(phy);
> +	int err = 0;
> +
> +	if (priv->no_suspend_override) {
> +		err = reset_control_assert(priv->no_suspend_override);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = reset_control_deassert(priv->reset);
> +	if (err && priv->no_suspend_override)
> +		reset_control_assert(priv->no_suspend_override);
> +
> +	return err;
> +}
> +
> +static int ath79_usb_phy_power_off(struct phy *phy)
> +{
> +	struct ath79_usb_phy *priv = phy_get_drvdata(phy);
> +	int err = 0;
> +
> +	err = reset_control_assert(priv->reset);
> +	if (err)
> +		return err;
> +
> +	if (priv->no_suspend_override) {
> +		err = reset_control_deassert(priv->no_suspend_override);
> +		if (err)
> +			reset_control_deassert(priv->reset);
> +	}
> +
> +	return err;
> +}
> +
> +static const struct phy_ops ath79_usb_phy_ops = {
> +	.power_on	= ath79_usb_phy_power_on,
> +	.power_off	= ath79_usb_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int ath79_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct ath79_usb_phy *priv;
> +	struct phy *phy;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->reset = devm_reset_control_get(&pdev->dev, "usb-phy");
> +	if (IS_ERR(priv->reset))
> +		return PTR_ERR(priv->reset);
> +
> +	priv->no_suspend_override = devm_reset_control_get_optional(
> +		&pdev->dev, "usb-suspend-override");
> +	if (IS_ERR(priv->no_suspend_override))
> +		return PTR_ERR(priv->no_suspend_override);
> +
> +	phy = devm_phy_create(&pdev->dev, NULL, &ath79_usb_phy_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, priv);
> +
> +	return PTR_ERR_OR_ZERO(devm_of_phy_provider_register(
> +				&pdev->dev, of_phy_simple_xlate));
> +}
> +
> +static const struct of_device_id ath79_usb_phy_of_match[] = {
> +	{ .compatible = "qca,ar7100-usb-phy" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ath79_usb_phy_of_match);
> +
> +static struct platform_driver ath79_usb_phy_driver = {
> +	.probe	= ath79_usb_phy_probe,
> +	.driver = {
> +		.of_match_table	= ath79_usb_phy_of_match,
> +		.name		= "ath79-usb-phy",
> +	}
> +};
> +module_platform_driver(ath79_usb_phy_driver);
> +
> +MODULE_DESCRIPTION("ATH79 USB PHY driver");
> +MODULE_AUTHOR("Alban Bedel <albeu@free.fr>");
> +MODULE_LICENSE("GPL");
> 
