Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F9217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbfBSCuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:50:25 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:23395 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725801AbfBSCuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:50:24 -0500
X-UUID: 2878306887ac4fe6b3135b99dc669019-20190219
X-UUID: 2878306887ac4fe6b3135b99dc669019-20190219
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 922748648; Tue, 19 Feb 2019 10:50:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 10:50:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 10:50:15 +0800
Message-ID: <1550544615.2210.27.camel@mhfsdcap03>
Subject: Re: [PATCH v2 08/10] hikey960: Support usb functionality of Hikey960
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Yu Chen <chenyu56@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <liuyu712@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Tue, 19 Feb 2019 10:50:15 +0800
In-Reply-To: <20190218112310.17860-9-chenyu56@huawei.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
         <20190218112310.17860-9-chenyu56@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, 2019-02-18 at 19:23 +0800, Yu Chen wrote:
> This driver handles usb hub power on and typeC port event of HiKey960 board:
> 1)DP&DM switching between usb hub and typeC port base on typeC port
> state
> 2)Control power of usb hub on Hikey960
> 3)Control vbus of typeC port
> 
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> 
> ---
> v1:
> * Using gpiod API with the gpios.
> * Removing registering usb role switch.
> * Registering usb role switch notifier.
> v2:
> * Fix license declaration.
> * Add configuration of  gpio direction.
> * Remove some log print.
> ---
> ---
>  drivers/misc/Kconfig          |   6 ++
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/hisi_hikey_usb.c | 181 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 drivers/misc/hisi_hikey_usb.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f417b06e11c5..8d8b717759e2 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -521,6 +521,12 @@ config PVPANIC
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
>  
> +config HISI_HIKEY_USB
> +	tristate "USB functionality of HiSilicon Hikey Platform"
> +	depends on OF && GPIOLIB
> +	help
> +	  If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e39ccbbc1b3a..dc8892b13a1a 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-y				+= cardreader/
>  obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
> +obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
> new file mode 100644
> index 000000000000..70013f8e76f0
> --- /dev/null
> +++ b/drivers/misc/hisi_hikey_usb.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for usb functionality of Hikey series boards
> + * based on Hisilicon Kirin Soc.
> + *
> + * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
> + *		http://www.huawei.com
> + *
> + * Authors: Yu Chen <chenyu56@huawei.com>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/usb/role.h>
> +
> +#define DEVICE_DRIVER_NAME "hisi_hikey_usb"
> +
> +#define HUB_VBUS_POWER_ON 1
> +#define HUB_VBUS_POWER_OFF 0
> +#define USB_SWITCH_TO_HUB 1
> +#define USB_SWITCH_TO_TYPEC 0
> +
> +struct hisi_hikey_usb {
> +	struct gpio_desc *otg_switch;
> +	struct gpio_desc *typec_vbus;
> +	struct gpio_desc *hub_vbus;
> +	int typec_vbus_enable_val;
> +
> +	struct usb_role_switch *role_sw;
> +	struct notifier_block nb;
> +};
> +
> +static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
> +{
> +	gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
> +}
> +
> +static void usb_switch_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
> +		int switch_to)
> +{
> +	gpiod_set_value_cansleep(hisi_hikey_usb->otg_switch, switch_to);
> +}
> +
> +static void usb_typec_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
> +		int value)
> +{
> +	gpiod_set_value_cansleep(hisi_hikey_usb->typec_vbus, value);
> +}
> +
> +static int hisi_hikey_role_switch(struct notifier_block *nb,
> +			unsigned long state, void *data)
> +{
> +	struct hisi_hikey_usb *hisi_hikey_usb;
> +
> +	hisi_hikey_usb = container_of(nb, struct hisi_hikey_usb, nb);
> +
> +	switch (state) {
> +	case USB_ROLE_NONE:
> +		usb_typec_power_ctrl(hisi_hikey_usb,
> +				!hisi_hikey_usb->typec_vbus_enable_val);
> +		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_HUB);
> +		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_ON);
> +		break;
> +	case USB_ROLE_HOST:
> +		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
> +		usb_typec_power_ctrl(hisi_hikey_usb,
> +				hisi_hikey_usb->typec_vbus_enable_val);
> +		break;
> +	case USB_ROLE_DEVICE:
> +		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
> +		usb_typec_power_ctrl(hisi_hikey_usb,
> +				!hisi_hikey_usb->typec_vbus_enable_val);
> +		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
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
> +	hisi_hikey_usb->nb.notifier_call = hisi_hikey_role_switch;
> +
> +	ret = of_property_read_u32(root, "typec-vbus-enable-val",
> +				   &hisi_hikey_usb->typec_vbus_enable_val);
> +	if (ret)
> +		hisi_hikey_usb->typec_vbus_enable_val = 1;
> +
> +	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
> +			hisi_hikey_usb->typec_vbus_enable_val ?
> +			GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
> +	if (!hisi_hikey_usb->typec_vbus)
> +		return -ENOENT;
> +	else if (IS_ERR(hisi_hikey_usb->typec_vbus))
> +		return PTR_ERR(hisi_hikey_usb->typec_vbus);
> +
> +	gpiod_direction_output(hisi_hikey_usb->typec_vbus,
> +			!hisi_hikey_usb->typec_vbus_enable_val);
maybe a simple way if use fixed regulator?

> +
> +	hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch", GPIOD_IN);
> +	if (!hisi_hikey_usb->otg_switch)
> +		return -ENOENT;
> +	else if (IS_ERR(hisi_hikey_usb->otg_switch))
> +		return PTR_ERR(hisi_hikey_usb->otg_switch);
> +
> +	gpiod_direction_output(hisi_hikey_usb->otg_switch, USB_SWITCH_TO_HUB);
> +
> +	/* hub-vdd33-en is optional */
> +	hisi_hikey_usb->hub_vbus = devm_gpiod_get(dev, "hub-vdd33-en",
> +			GPIOD_OUT_LOW);
> +	if (IS_ERR(hisi_hikey_usb->hub_vbus))
> +		return PTR_ERR(hisi_hikey_usb->hub_vbus);
> +
> +	gpiod_direction_output(hisi_hikey_usb->hub_vbus, HUB_VBUS_POWER_ON);
ditto
> +
> +	hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
> +	if (!hisi_hikey_usb->role_sw)
> +		return -EPROBE_DEFER;
> +	else if (IS_ERR(hisi_hikey_usb->role_sw))
> +		return PTR_ERR(hisi_hikey_usb->role_sw);
> +
> +	ret = usb_role_switch_register_notifier(hisi_hikey_usb->role_sw,
> +			&hisi_hikey_usb->nb);
> +	if (ret) {
> +		usb_role_switch_put(hisi_hikey_usb->role_sw);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, hisi_hikey_usb);
> +
> +	return 0;
> +}
> +
> +static int  hisi_hikey_usb_remove(struct platform_device *pdev)
> +{
> +	struct hisi_hikey_usb *hisi_hikey_usb = platform_get_drvdata(pdev);
> +
> +	usb_role_switch_unregister_notifier(hisi_hikey_usb->role_sw,
> +			&hisi_hikey_usb->nb);
> +
> +	usb_role_switch_put(hisi_hikey_usb->role_sw);
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
> +static struct platform_driver hisi_hikey_usb_driver = {
> +	.probe = hisi_hikey_usb_probe,
> +	.remove = hisi_hikey_usb_remove,
> +	.driver = {
> +		.name = DEVICE_DRIVER_NAME,
> +		.of_match_table = id_table_hisi_hikey_usb,
> +	},
> +};
> +
> +module_platform_driver(hisi_hikey_usb_driver);
> +
> +MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
> +MODULE_DESCRIPTION("Driver Support for USB functionality of Hikey");
> +MODULE_LICENSE("GPL v2");


