Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CC0C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE2120657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE2120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJ2XTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:19:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:3462 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbeJ2XTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:19:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 07:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="103459274"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 29 Oct 2018 07:30:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Oct 2018 16:30:40 +0200
Date:   Mon, 29 Oct 2018 16:30:40 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH 07/10] hikey960: Support usb functionality of Hikey960
Message-ID: <20181029143040.GB14534@kuha.fi.intel.com>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-8-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027095820.40056-8-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 27, 2018 at 05:58:17PM +0800, Yu Chen wrote:
> This driver handles usb hub power on and typeC port event of HiKey960 board:
> 1)DP&DM switching between usb hub and typeC port base on typeC port
> state

By "hub" do you mean you have some kind of an integrated USB hub on
your SoC?

> 2)Control power of usb hub on Hikey960
> 3)Control vbus of typeC port
> 4)Handle typeC port event to switch data role

Is your role switch a discrete component, or something part of the SoC?

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  drivers/misc/Kconfig          |   7 +
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/hisi_hikey_usb.c | 319 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 327 insertions(+)
>  create mode 100644 drivers/misc/hisi_hikey_usb.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3726eacdf65d..8e04fc87b685 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -513,6 +513,13 @@ config MISC_RTSX
>  	tristate
>  	default MISC_RTSX_PCI || MISC_RTSX_USB
>  
> +config HISI_HIKEY_USB
> +	tristate "USB functionality of HiSilicon Hikey Platform"
> +	depends on GPIOLIB
> +	default n
> +	help
> +	  If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index af22bbc3d00c..387dd302815c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> +obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
> new file mode 100644
> index 000000000000..4965719c99ae
> --- /dev/null
> +++ b/drivers/misc/hisi_hikey_usb.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hisi_hikey_usb.c
> + *
> + * Copyright (c) Hisilicon Tech. Co., Ltd. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/usb/role.h>
> +
> +#define DEVICE_DRIVER_NAME "hisi_hikey_usb"
> +
> +#define HUB_VBUS_POWER_ON 1
> +#define HUB_VBUS_POWER_OFF 0
> +#define USB_SWITCH_TO_HUB 1
> +#define USB_SWITCH_TO_TYPEC 0
> +
> +#define INVALID_GPIO_VALUE (-1)
> +
> +struct hisi_hikey_usb {
> +	int otg_switch_gpio;
> +	int typec_vbus_gpio;
> +	int typec_vbus_enable_val;
> +	int hub_vbus_gpio;

I think you should use struct gpio_desc and gpiod_*() API with the
gpios.

> +	struct extcon_dev *edev;
> +	struct usb_role_switch *role_sw;
> +};
> +
> +static const unsigned int usb_extcon_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_NONE,
> +};
> +
> +static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
> +{
> +	int gpio = hisi_hikey_usb->hub_vbus_gpio;
> +
> +	if (gpio_is_valid(gpio))
> +		gpio_set_value(gpio, value);
> +}
> +
> +static void usb_switch_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
> +		int switch_to)
> +{
> +	int gpio = hisi_hikey_usb->otg_switch_gpio;
> +	const char *switch_to_str = (switch_to == USB_SWITCH_TO_HUB) ?
> +		"hub" : "typec";
> +
> +	if (!gpio_is_valid(gpio)) {
> +		pr_err("%s: otg_switch_gpio is err\n", __func__);
> +		return;
> +	}
> +
> +	if (gpio_get_value(gpio) == switch_to) {
> +		pr_info("%s: already switch to %s\n", __func__, switch_to_str);

That kind of prints are really just noise.

> +		return;
> +	}
> +
> +	gpio_direction_output(gpio, switch_to);
> +	pr_info("%s: switch to %s\n", __func__, switch_to_str);

That is also just noise.

> +}
> +
> +static void usb_typec_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
> +		int value)
> +{
> +	int gpio = hisi_hikey_usb->typec_vbus_gpio;
> +
> +	if (!gpio_is_valid(gpio)) {
> +		pr_err("%s: typec power gpio is err\n", __func__);
> +		return;
> +	}
> +
> +	if (gpio_get_value(gpio) == value) {
> +		pr_info("%s: typec power no change\n", __func__);

Ditto.

> +		return;
> +	}
> +
> +	gpio_direction_output(gpio, value);
> +	pr_info("%s: set typec vbus gpio to %d\n", __func__, value);

Ditto.

> +}
> +
> +static int extcon_hisi_pd_set_role(struct device *dev, enum usb_role role)
> +{
> +	struct hisi_hikey_usb *hisi_hikey_usb = dev_get_drvdata(dev);
> +
> +	dev_info(dev, "%s:set usb role to %d\n", __func__, role);
> +	switch (role) {
> +	case USB_ROLE_NONE:
> +		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_HUB);
> +		usb_typec_power_ctrl(hisi_hikey_usb,
> +				!hisi_hikey_usb->typec_vbus_enable_val);
> +		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_ON);
> +		extcon_set_state_sync(hisi_hikey_usb->edev, EXTCON_USB, false);
> +		extcon_set_state_sync(hisi_hikey_usb->edev, EXTCON_USB_HOST,
> +				true);
> +		break;
> +	case USB_ROLE_HOST:
> +		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
> +		usb_typec_power_ctrl(hisi_hikey_usb,
> +				hisi_hikey_usb->typec_vbus_enable_val);
> +		extcon_set_state_sync(hisi_hikey_usb->edev, EXTCON_USB, false);
> +		extcon_set_state_sync(hisi_hikey_usb->edev, EXTCON_USB_HOST,
> +				true);
> +		break;
> +	case USB_ROLE_DEVICE:
> +		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
> +		usb_typec_power_ctrl(hisi_hikey_usb,
> +				hisi_hikey_usb->typec_vbus_enable_val);
> +		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
> +		extcon_set_state_sync(hisi_hikey_usb->edev, EXTCON_USB_HOST,
> +				false);
> +		extcon_set_state_sync(hisi_hikey_usb->edev, EXTCON_USB, true);
> +		break;
> +	}

If I understood the above correctly, you are controlling the VBUS
based on the data role, right?

With USB Type-C connectors the power and data roles are separate, so
you should not be doing that.

But since you are controlling the VBUS with a single GPIO, wouldn't it
be easier to just give the Type-C port controller device that GPIO
resources and let the Type-C drivers take care of it? You could add a
"set_vbus" callback to struct tcpci_data and take care of the GPIO in
tcpci_rt1711h.c, or alternatively, just handle it in tcpci.c.

> +	return 0;
> +}
> +
> +static enum usb_role extcon_hisi_pd_get_role(struct device *dev)
> +{
> +	struct hisi_hikey_usb *hisi_hikey_usb = dev_get_drvdata(dev);
> +
> +	return usb_role_switch_get_role(hisi_hikey_usb->role_sw);
> +}
> +
> +static const struct usb_role_switch_desc sw_desc = {
> +	.set = extcon_hisi_pd_set_role,
> +	.get = extcon_hisi_pd_get_role,
> +	.allow_userspace_control = true,
> +};
> +
> +static int hisi_hikey_usb_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *root = dev->of_node;
> +	struct hisi_hikey_usb *hisi_hikey_usb;
> +	int ret;
> +
> +	hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
> +	if (!hisi_hikey_usb)
> +		return -ENOMEM;
> +
> +	dev_set_name(dev, "hisi_hikey_usb");
> +
> +	hisi_hikey_usb->hub_vbus_gpio = INVALID_GPIO_VALUE;
> +	hisi_hikey_usb->otg_switch_gpio = INVALID_GPIO_VALUE;
> +	hisi_hikey_usb->typec_vbus_gpio = INVALID_GPIO_VALUE;
> +
> +	hisi_hikey_usb->hub_vbus_gpio = of_get_named_gpio(root,
> +			"hub_vdd33_en_gpio", 0);
> +	if (!gpio_is_valid(hisi_hikey_usb->hub_vbus_gpio)) {
> +		pr_err("%s: hub_vbus_gpio is err\n", __func__);
> +		return hisi_hikey_usb->hub_vbus_gpio;
> +	}
> +
> +	ret = gpio_request(hisi_hikey_usb->hub_vbus_gpio, "hub_vbus_int_gpio");
> +	if (ret) {
> +		pr_err("%s: request hub_vbus_gpio err\n", __func__);
> +		hisi_hikey_usb->hub_vbus_gpio = INVALID_GPIO_VALUE;
> +		return ret;
> +	}
> +
> +	ret = gpio_direction_output(hisi_hikey_usb->hub_vbus_gpio,
> +			HUB_VBUS_POWER_ON);
> +	if (ret) {
> +		pr_err("%s: power on hub vbus err\n", __func__);
> +		goto free_gpio1;
> +	}
> +
> +	hisi_hikey_usb->typec_vbus_gpio = of_get_named_gpio(root,
> +		"typc_vbus_int_gpio,typec-gpios", 0);
> +	if (!gpio_is_valid(hisi_hikey_usb->typec_vbus_gpio)) {
> +		pr_err("%s: typec_vbus_gpio is err\n", __func__);
> +		ret = hisi_hikey_usb->typec_vbus_gpio;
> +		goto free_gpio1;
> +	}
> +
> +	ret = gpio_request(hisi_hikey_usb->typec_vbus_gpio,
> +			"typc_vbus_int_gpio");
> +	if (ret) {
> +		pr_err("%s: request typec_vbus_gpio err\n", __func__);
> +		hisi_hikey_usb->typec_vbus_gpio = INVALID_GPIO_VALUE;
> +		goto free_gpio1;
> +	}
> +
> +	ret = of_property_read_u32(root, "typc_vbus_enable_val",
> +				   &hisi_hikey_usb->typec_vbus_enable_val);
> +	if (ret) {
> +		pr_err("%s: typc_vbus_enable_val can't get\n", __func__);
> +		goto free_gpio2;
> +	}
> +
> +	hisi_hikey_usb->typec_vbus_enable_val =
> +		!!hisi_hikey_usb->typec_vbus_enable_val;
> +
> +	ret = gpio_direction_output(hisi_hikey_usb->typec_vbus_gpio,
> +				    hisi_hikey_usb->typec_vbus_enable_val);
> +	if (ret) {
> +		pr_err("%s: power on typec vbus err", __func__);
> +		goto free_gpio2;
> +	}
> +
> +	if (of_device_is_compatible(root, "hisilicon,hikey960_usb")) {

Instead of that kind of checks, isn't it enough to just use optional
gpios?

> +		hisi_hikey_usb->otg_switch_gpio = of_get_named_gpio(root,
> +				"otg_gpio", 0);
> +		if (!gpio_is_valid(hisi_hikey_usb->otg_switch_gpio)) {
> +			pr_info("%s: otg_switch_gpio is err\n", __func__);
> +			goto free_gpio2;
> +		}
> +
> +		ret = gpio_request(hisi_hikey_usb->otg_switch_gpio,
> +				"otg_switch_gpio");
> +		if (ret) {
> +			hisi_hikey_usb->otg_switch_gpio = INVALID_GPIO_VALUE;
> +			pr_err("%s: request typec_vbus_gpio err\n", __func__);
> +			goto free_gpio2;
> +		}
> +	}
> +
> +	hisi_hikey_usb->edev = devm_extcon_dev_allocate(dev, usb_extcon_cable);
> +	if (IS_ERR(hisi_hikey_usb->edev)) {
> +		dev_err(dev, "failed to allocate extcon device\n");
> +		goto free_gpio2;
> +	}
> +
> +	ret = devm_extcon_dev_register(dev, hisi_hikey_usb->edev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register extcon device\n");
> +		goto free_gpio2;
> +	}
> +	extcon_set_state(hisi_hikey_usb->edev, EXTCON_USB_HOST, true);

Is the primary purpose for this extcon device to satisfy the DRD code
in dwc3 driver?

> +	hisi_hikey_usb->role_sw = usb_role_switch_register(dev, &sw_desc);
> +	if (IS_ERR(hisi_hikey_usb->role_sw))
> +		goto free_gpio2;

It looks a bit clumsy to me to register both the extcon device and the
mux device, but I'm guessing you need to get a notification in dwc3
driver when the role changes, right? Perhaps we should simply add
notification chain to the role mux structure. That could potentially
allow this kind of code to be organized a bit better.

> +	platform_set_drvdata(pdev, hisi_hikey_usb);
> +
> +	return 0;
> +
> +free_gpio2:
> +	if (gpio_is_valid(hisi_hikey_usb->typec_vbus_gpio)) {
> +		gpio_free(hisi_hikey_usb->typec_vbus_gpio);
> +		hisi_hikey_usb->typec_vbus_gpio = INVALID_GPIO_VALUE;
> +	}
> +
> +free_gpio1:
> +	if (gpio_is_valid(hisi_hikey_usb->hub_vbus_gpio)) {
> +		gpio_free(hisi_hikey_usb->hub_vbus_gpio);
> +		hisi_hikey_usb->hub_vbus_gpio = INVALID_GPIO_VALUE;
> +	}
> +
> +	return ret;
> +}
> +
> +static int  hisi_hikey_usb_remove(struct platform_device *pdev)
> +{
> +	struct hisi_hikey_usb *hisi_hikey_usb = platform_get_drvdata(pdev);
> +
> +	if (gpio_is_valid(hisi_hikey_usb->otg_switch_gpio)) {
> +		gpio_free(hisi_hikey_usb->otg_switch_gpio);
> +		hisi_hikey_usb->otg_switch_gpio = INVALID_GPIO_VALUE;
> +	}
> +
> +	if (gpio_is_valid(hisi_hikey_usb->typec_vbus_gpio)) {
> +		gpio_free(hisi_hikey_usb->typec_vbus_gpio);
> +		hisi_hikey_usb->typec_vbus_gpio = INVALID_GPIO_VALUE;
> +	}
> +
> +	if (gpio_is_valid(hisi_hikey_usb->hub_vbus_gpio)) {
> +		gpio_free(hisi_hikey_usb->hub_vbus_gpio);
> +		hisi_hikey_usb->hub_vbus_gpio = INVALID_GPIO_VALUE;
> +	}
> +
> +	usb_role_switch_unregister(hisi_hikey_usb->role_sw);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id id_table_hisi_hikey_usb[] = {
> +	{.compatible = "hisilicon,gpio_hubv1"},
> +	{.compatible = "hisilicon,hikey960_usb"},
> +	{}
> +};
> +
> +static struct platform_driver  hisi_hikey_usb_driver = {
> +	.probe = hisi_hikey_usb_probe,
> +	.remove = hisi_hikey_usb_remove,
> +	.driver = {
> +		.name = DEVICE_DRIVER_NAME,
> +		.of_match_table = of_match_ptr(id_table_hisi_hikey_usb),
> +
> +	},
> +};
> +
> +module_platform_driver(hisi_hikey_usb_driver);
> +
> +MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
> +MODULE_DESCRIPTION("Driver Support for USB functionality of Hikey");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.15.0-rc2

I think you have too many things integrated into this one driver. IMO
it would at least be better to just let the Type-C port driver take
care of VBUS like I mentioned above. I'm also wondering if it would
make sense to handle the role switch and the "hub" in their own
drivers, but I don't know enough about your platform at this point to
say for sure.


br,

-- 
heikki
