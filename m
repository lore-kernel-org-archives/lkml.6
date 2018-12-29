Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE90C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14620815
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeL2Hlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:41:51 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:22808 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727486AbeL2Hlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:41:50 -0500
X-UUID: 5accc0bd9b19423d81e2e6553ed22b6d-20181229
X-UUID: 5accc0bd9b19423d81e2e6553ed22b6d-20181229
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 52716412; Sat, 29 Dec 2018 15:41:24 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 29 Dec
 2018 15:41:22 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Dec 2018 15:41:21 +0800
Message-ID: <1546069281.32173.186.camel@mhfsdcap03>
Subject: Re: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
Date:   Sat, 29 Dec 2018 15:41:21 +0800
In-Reply-To: <1545577992-4013-6-git-send-email-pawell@cadence.com>
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
         <1545577992-4013-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
On Sun, 2018-12-23 at 15:13 +0000, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver
> to linux kernel.

<...>

> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> new file mode 100644
> index 000000000000..e93179c45ece
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS PCI Glue driver
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +
> +struct cdns3_wrap {
> +	struct platform_device *plat_dev;
> +	struct pci_dev *hg_dev;
> +	struct resource dev_res[4];
> +};
> +
> +struct cdns3_wrap wrap;
> +
> +#define RES_IRQ_ID		0
> +#define RES_HOST_ID		1
> +#define RES_DEV_ID		2
> +#define RES_DRD_ID		3
> +
> +#define PCI_BAR_HOST		0
> +#define PCI_BAR_DEV		2
> +#define PCI_BAR_OTG		4
> +
> +#define PCI_DEV_FN_HOST_DEVICE	0
> +#define PCI_DEV_FN_OTG		1
> +
> +#define PCI_DRIVER_NAME		"cdns3-pci-usbss"
> +#define PLAT_DRIVER_NAME	"cdns-usb3"
> +
> +#define CDNS_VENDOR_ID 0x17cd
> +#define CDNS_DEVICE_ID 0x0100
> +
> +/**
> + * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
> + * @pdev: platform device object
> + * @id: pci device id
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_pci_probe(struct pci_dev *pdev,
> +			   const struct pci_device_id *id)
> +{
> +	struct platform_device_info plat_info;
> +	struct cdns3_wrap *wrap;
> +	struct resource *res;
> +	int err;
> +
> +	/*
> +	 * for GADGET/HOST PCI (devfn) function number is 0,
> +	 * for OTG PCI (devfn) function number is 1
> +	 */
> +	if (!id || pdev->devfn != PCI_DEV_FN_HOST_DEVICE)
> +		return -EINVAL;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
> +		return err;
> +	}
> +
> +	pci_set_master(pdev);
> +	wrap = devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
> +	if (!wrap) {
> +		dev_err(&pdev->dev, "Failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
> +	memset(wrap->dev_res, 0x00,
> +	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
> +	dev_dbg(&pdev->dev, "Initialize Device resources\n");
> +	res = wrap->dev_res;
> +
> +	res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
> +	res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
> +	res[RES_DEV_ID].name = "cdns3-dev-regs";
> +	res[RES_DEV_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
> +		&res[RES_DEV_ID].start);
> +
> +	res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].name = "cdns3-xhci-regs";
> +	res[RES_HOST_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
> +		&res[RES_HOST_ID].start);
> +
> +	res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].name = "cdns3-otg";
> +	res[RES_DRD_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
> +		&res[RES_DRD_ID].start);
> +
> +	/* Interrupt common for both device and XHCI */
> +	wrap->dev_res[RES_IRQ_ID].start = pdev->irq;
> +	wrap->dev_res[RES_IRQ_ID].name = "cdns3-irq";
> +	wrap->dev_res[RES_IRQ_ID].flags = IORESOURCE_IRQ;
> +
> +	/* set up platform device info */
> +	memset(&plat_info, 0, sizeof(plat_info));
> +	plat_info.parent = &pdev->dev;
> +	plat_info.fwnode = pdev->dev.fwnode;
> +	plat_info.name = PLAT_DRIVER_NAME;
> +	plat_info.id = pdev->devfn;
> +	plat_info.res = wrap->dev_res;
> +	plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
> +	plat_info.dma_mask = pdev->dma_mask;
> +
> +	/* register platform device */
> +	wrap->plat_dev = platform_device_register_full(&plat_info);
> +	if (IS_ERR(wrap->plat_dev)) {
> +		err = PTR_ERR(wrap->plat_dev);
> +		return err;
> +	}
return PTR_ERR(wrap->plat_dev);

> +
> +	pci_set_drvdata(pdev, wrap);
> +
> +	return err;
> +}
> +
> +void cdns3_pci_remove(struct pci_dev *pdev)
> +{
> +	struct cdns3_wrap *wrap = (struct cdns3_wrap *)pci_get_drvdata(pdev);
> +
> +	platform_device_unregister(wrap->plat_dev);
> +}
> +
> +static const struct pci_device_id cdns3_pci_ids[] = {
> +	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
> +	{ 0, }
> +};
> +
> +static struct pci_driver cdns3_pci_driver = {
> +	.name = PCI_DRIVER_NAME,
> +	.id_table = cdns3_pci_ids,
> +	.probe = cdns3_pci_probe,
> +	.remove = cdns3_pci_remove,
> +};
> +
> +module_pci_driver(cdns3_pci_driver);
> +MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
> +
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
> +
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> new file mode 100644
> index 000000000000..d274586aca36
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Author: Peter Chen <peter.chen@nxp.com>
> + *         Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "host-export.h"
> +#include "gadget-export.h"
> +#include "drd.h"
> +#include "debug.h"
> +
> +static inline
> +struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> +{
> +	WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> +	return cdns->roles[cdns->role];
> +}
> +
> +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
remove inline
> +{
> +	int ret;
> +
> +	if (WARN_ON(role >= CDNS3_ROLE_END))
> +		return 0;
> +
> +	if (!cdns->roles[role])
> +		return -ENXIO;
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_ACTIVE)
> +		return 0;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->role = role;
> +	ret = cdns->roles[role]->start(cdns);
> +	if (!ret)
> +		cdns->roles[role]->state = CDNS3_ROLE_STATE_ACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +	return ret;
> +}
> +
> +void cdns3_role_stop(struct cdns3 *cdns)
> +{
> +	enum cdns3_roles role = cdns->role;
> +
> +	if (role >= CDNS3_ROLE_END) {
> +		WARN_ON(role > CDNS3_ROLE_END);
> +		return;
> +	}
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
> +		return;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->roles[role]->stop(cdns);
> +	cdns->roles[role]->state = CDNS3_ROLE_STATE_INACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +}
> +
> +/*
> + * cdns->role gets from cdns3_get_initial_role, and this API tells role at the
> + * runtime.
> + * If both roles are supported, the role is selected based on vbus/id.
> + * It could be read from OTG register or external connector.
> + * If only single role is supported, only one role structure
> + * is allocated, cdns->roles[CDNS3_ROLE_HOST] or cdns->roles[CDNS3_ROLE_GADGET].
> + */
> +static enum cdns3_roles cdns3_get_initial_role(struct cdns3 *cdns)
> +{
> +	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> +		if (cdns3_is_host(cdns))
> +			return CDNS3_ROLE_HOST;
> +		if (cdns3_is_device(cdns))
> +			return CDNS3_ROLE_GADGET;
> +	}
> +	return cdns->roles[CDNS3_ROLE_HOST]
> +		? CDNS3_ROLE_HOST
> +		: CDNS3_ROLE_GADGET;
> +}
> +
> +static void cdns3_exit_roles(struct cdns3 *cdns)
> +{
> +	cdns3_role_stop(cdns);
> +	cdns3_drd_exit(cdns);
> +}
> +
> +/**
> + * cdns3_core_init_role - initialize role of operation
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_core_init_role(struct cdns3 *cdns)
> +{
> +	struct device *dev = cdns->dev;
> +	enum usb_dr_mode best_dr_mode;
> +	enum usb_dr_mode dr_mode;
> +	int ret = 0;
> +
> +	dr_mode = usb_get_dr_mode(dev);
> +	cdns->role = CDNS3_ROLE_END;
> +
> +	/*
> +	 * If driver can't read mode by means of usb_get_dr_mdoe function then
> +	 * chooses mode according with Kernel configuration. This setting
> +	 * can be restricted later depending on strap pin configuration.
> +	 */
> +	if (dr_mode == USB_DR_MODE_UNKNOWN) {
> +		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
> +		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			dr_mode = USB_DR_MODE_OTG;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +			dr_mode = USB_DR_MODE_HOST;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	best_dr_mode = USB_DR_MODE_OTG;
> +
> +	if (dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = cdns->dr_mode;
> +	} else if (cdns->dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = dr_mode;
> +	} else if (cdns->dr_mode != dr_mode) {
> +		dev_err(dev, "Incorrect DRD configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	dr_mode = best_dr_mode;
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> +		ret = cdns3_host_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Host initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		ret = cdns3_gadget_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Device initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	cdns->desired_dr_mode = dr_mode;
> +	cdns->dr_mode = dr_mode;
> +	/*
> +	 * dr_mode could be change so DRD must update controller
> +	 * configuration
> +	 */
> +	ret = cdns3_drd_update_mode(cdns);
Do you need check ret value? if not, no need assign it
> +
> +	cdns->role = cdns3_get_initial_role(cdns);
> +
> +	ret = cdns3_role_start(cdns, cdns->role);
> +	if (ret) {
> +		dev_err(dev, "can't start %s role\n",
> +			cdns3_get_current_role_driver(cdns)->name);
> +		goto err;
> +	}
> +
> +	return ret;
> +err:
> +	cdns3_exit_roles(cdns);
> +	return ret;
> +}
> +
> +/**
> + * cdsn3_get_real_role - get real role of controller based on hardware settings.
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns role
> + */
> +enum cdns3_roles cdsn3_get_real_role(struct cdns3 *cdns)
> +{
> +	enum cdns3_roles role = CDNS3_ROLE_END;
> +
> +	if (cdns->current_dr_mode == USB_DR_MODE_OTG) {
> +		if (cdns3_get_id(cdns))
> +			role = CDNS3_ROLE_GADGET;
> +		else
> +			role = CDNS3_ROLE_HOST;
> +	} else {
> +		if (cdns3_is_host(cdns))
> +			role = CDNS3_ROLE_HOST;
> +		if (cdns3_is_device(cdns))
> +			role = CDNS3_ROLE_GADGET;
> +	}
> +
> +	return role;
> +}
> +
> +/**
> + * cdns3_role_switch - work queue handler for role switch
> + *
> + * @work: work queue item structure
> + *
> + * Handles below events:
> + * - Role switch for dual-role devices
> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
> + */
> +static void cdns3_role_switch(struct work_struct *work)
> +{
> +	enum cdns3_roles role = CDNS3_ROLE_END;
> +	struct cdns3_role_driver *role_drv;
> +	enum cdns3_roles current_role;
> +	struct cdns3 *cdns;
> +	int ret = 0;
> +
> +	cdns = container_of(work, struct cdns3, role_switch_wq);
> +
> +	/* During switching cdns->role can be different then role */
> +	role = cdsn3_get_real_role(cdns);
> +
> +	role_drv = cdns3_get_current_role_driver(cdns);
> +
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	/* Disable current role. This state can be forced from user space. */
> +	if (cdns->debug_disable && role_drv->state == CDNS3_ROLE_STATE_ACTIVE) {
> +		cdns3_role_stop(cdns);
> +		goto exit;
> +	}
> +
> +	/* Do nothing if nothing changed */
> +	if (cdns->role == role && role_drv->state == CDNS3_ROLE_STATE_ACTIVE)
> +		goto exit;
> +
> +	cdns3_role_stop(cdns);
> +
> +	role = cdsn3_get_real_role(cdns);
> +
> +	current_role = cdns->role;
> +	dev_dbg(cdns->dev, "Switching role");
> +
> +	ret = cdns3_role_start(cdns, role);
> +
remove blank line
> +	if (ret) {
> +		/* Back to current role */
> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> +			role, current_role);
> +		cdns3_role_start(cdns, current_role);
> +	}
> +exit:
> +	pm_runtime_put_sync(cdns->dev);
> +}
> +
> +/**
> + * cdns3_probe - probe for cdns3 core device
> + * @pdev: Pointer to cdns3 core platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource	*res;
> +	struct cdns3 *cdns;
> +	void __iomem *regs;
> +	int ret;
> +
> +	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> +	if (!cdns)
> +		return -ENOMEM;
> +
> +	cdns->dev = dev;
> +
> +	platform_set_drvdata(pdev, cdns);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(dev, "missing IRQ\n");
> +		return -ENODEV;
> +	}
> +	cdns->irq = res->start;
> +
> +	cdns->xhci_res[0] = *res;
> +
> +	/*
> +	 * Request memory region
> +	 * region-0: xHCI
> +	 * region-1: Peripheral
> +	 * region-2: OTG registers
> +	 */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cdns->xhci_res[1] = *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +	cdns->dev_regs	= regs;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	cdns->otg_res = *res;
It'll make the DTS clearer if add reg-names
> +
> +	mutex_init(&cdns->mutex);
> +
> +	cdns->phy = devm_phy_get(dev, "cdns3,usbphy");
Try to use devm_phy_optional_get()?
> +	if (IS_ERR(cdns->phy)) {
> +		ret = PTR_ERR(cdns->phy);
> +		if (ret == -ENODEV) {
> +			cdns->phy = NULL;
> +		} else if (ret == -EPROBE_DEFER) {
> +			return ret;
> +		} else {
> +			dev_err(dev, "no phy found\n");
> +			goto err0;
> +		}
> +	}
> +
> +	phy_init(cdns->phy);
> +
> +	INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> +
> +	ret = cdns3_drd_init(cdns);
> +	if (ret)
> +		goto err1;
> +
> +	ret = cdns3_core_init_role(cdns);
> +	if (ret)
> +		goto err1;
> +
> +	cdns3_debugfs_init(cdns);
> +	device_set_wakeup_capable(dev, true);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/*
> +	 * The controller needs less time between bus and controller suspend,
> +	 * and we also needs a small delay to avoid frequently entering low
> +	 * power mode.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, 20);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_use_autosuspend(dev);
> +	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> +
> +	return 0;
> +
> +err1:
> +	phy_exit(cdns->phy);
> +err0:
> +	return ret;
> +}
> +
> +/**
> + * cdns3_remove - unbind drd driver and clean up
> + * @pdev: Pointer to Linux platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_remove(struct platform_device *pdev)
> +{
> +	struct cdns3 *cdns = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	cdns3_debugfs_exit(cdns);
> +	cdns3_exit_roles(cdns);
> +	phy_exit(cdns->phy);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cdns3_match[] = {
> +	{ .compatible = "cdns,usb3-1.0.0" },
> +	{ .compatible = "cdns,usb3-1.0.1" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> +#endif
> +
> +static struct platform_driver cdns3_driver = {
> +	.probe		= cdns3_probe,
> +	.remove		= cdns3_remove,
> +	.driver		= {
> +		.name	= "cdns-usb3",
> +		.of_match_table	= of_match_ptr(of_cdns3_match),
> +	},
> +};
> +
> +module_platform_driver(cdns3_driver);
> +
> +MODULE_ALIAS("platform:cdns3");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> new file mode 100644
> index 000000000000..fb4b39206158
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Header File.
> + *
> + * Copyright (C) 2017-2018 NXP
> + * Copyright (C) 2018 Cadence.
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *          Pawel Laszczak <pawell@cadence.com>
> + */
> +#include <linux/usb/otg.h>
> +
> +#ifndef __LINUX_CDNS3_CORE_H
> +#define __LINUX_CDNS3_CORE_H
> +
> +struct cdns3;
> +enum cdns3_roles {
> +	CDNS3_ROLE_HOST = 0,
> +	CDNS3_ROLE_GADGET,
> +	CDNS3_ROLE_END,
> +};
> +
> +/**
> + * struct cdns3_role_driver - host/gadget role driver
> + * @start: start this role
> + * @stop: stop this role
> + * @suspend: suspend callback for this role
> + * @resume: resume callback for this role
> + * @irq: irq handler for this role
> + * @name: role name string (host/gadget)
> + * @state: current state
> + */
> +struct cdns3_role_driver {
> +	int (*start)(struct cdns3 *cdns);
> +	void (*stop)(struct cdns3 *cdns);
> +	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> +	int (*resume)(struct cdns3 *cdns, bool hibernated);
> +	const char *name;
> +#define CDNS3_ROLE_STATE_INACTIVE	0
> +#define CDNS3_ROLE_STATE_ACTIVE		1
> +	int state;
> +};
> +
> +#define CDNS3_XHCI_RESOURCES_NUM	2
> +/**
> + * struct cdns3 - Representation of Cadence USB3 DRD controller.
> + * @dev: pointer to Cadence device struct
> + * @xhci_regs: pointer to base of xhci registers
> + * @xhci_res: the resource for xhci
> + * @dev_regs: pointer to base of dev registers
> + * @otg_regs: pointer to base of otg registers
> + * @irq: irq number for controller
> + * @roles: array of supported roles for this controller
> + * @role: current role
> + * @host_dev: the child host device pointer for cdns3 core
> + * @gadget_dev: the child gadget device pointer for cdns3 core
> + * @usb: phy for this controller
> + * @role_switch_wq: work queue item for role switch
> + * @in_lpm: the controller in low power mode
> + * @wakeup_int: the wakeup interrupt
> + * @mutex: the mutex for concurrent code at driver
> + * @dr_mode: supported mode of operation it can be only Host, only Device
> + *           or OTG mode that allow to switch between Device and Host mode.
> + *           This field based on firmware setting, kernel configuration
> + *           and hardware configuration.
> + * @current_dr_mode: current mode of operation when in dual-role mode
> + * @desired_dr_mode: desired mode of operation when in dual-role mode.
> + *           This value can be changed during runtime.
> + *           Available options depends on  dr_mode:
> + *           dr_mode                 |  desired_dr_mode and current_dr_mode
> + *           ----------------------------------------------------------------
> + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
> + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_HOST
> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_PERIPHERAL
> + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG
> + *
> + *           Desired_dr_role can be changed by means of debugfs.
> + * @root: debugfs root folder pointer
> + * @debug_disable:
> + */
> +struct cdns3 {
> +	struct device			*dev;
> +	void __iomem			*xhci_regs;
> +	struct resource			xhci_res[CDNS3_XHCI_RESOURCES_NUM];
> +	struct cdns3_usb_regs __iomem	*dev_regs;
> +
> +	struct resource			otg_res;
> +	struct cdns3_otg_legacy_regs	*otg_v0_regs;
> +	struct cdns3_otg_regs		*otg_v1_regs;
> +	struct cdns3_otg_common_regs	*otg_regs;
> +#define CDNS3_CONTROLLER_V0	0
> +#define CDNS3_CONTROLLER_V1	1
> +	u32				version;
> +
> +	int				irq;
> +	struct cdns3_role_driver	*roles[CDNS3_ROLE_END];
> +	enum cdns3_roles		role;
> +	struct platform_device		*host_dev;
> +	struct cdns3_device		*gadget_dev;
> +	struct phy			*phy;
> +	struct work_struct		role_switch_wq;
> +	int				in_lpm:1;
> +	int				wakeup_int:1;
> +	/* mutext used in workqueue*/
> +	struct mutex			mutex;
> +	enum usb_dr_mode		dr_mode;
> +	enum usb_dr_mode		current_dr_mode;
> +	enum usb_dr_mode		desired_dr_mode;
> +	struct dentry			*root;
> +	int				debug_disable:1;
> +};
> +
> +void cdns3_role_stop(struct cdns3 *cdns);
> +
> +#endif /* __LINUX_CDNS3_CORE_H */
> diff --git a/drivers/usb/cdns3/debug.h b/drivers/usb/cdns3/debug.h
> new file mode 100644
> index 000000000000..94f9ef15f899
> --- /dev/null
> +++ b/drivers/usb/cdns3/debug.h
> @@ -0,0 +1,166 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver.
> + * Debug header file.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +#ifndef __LINUX_CDNS3_DEBUG
> +#define __LINUX_CDNS3_DEBUG
> +
> +#include "core.h"
> +
> +static inline char *cdns3_decode_usb_irq(char *str,
> +					 enum usb_device_speed speed,
> +
too many sentences as inline function
> 					 u32 usb_ists)
> +{
> +	int ret;
> +
> +	ret = sprintf(str, "IRQ %08x = ", usb_ists);
> +
> +	if (usb_ists & (USB_ISTS_CON2I | USB_ISTS_CONI)) {
> +		ret += sprintf(str + ret, "Connection %s\n",
> +			       usb_speed_string(speed));
> +	}
> +	if (usb_ists & USB_ISTS_CON2I || usb_ists & USB_ISTS_CONI)
> +		ret += sprintf(str + ret, "Disconnection ");
> +	if (usb_ists & USB_ISTS_L2ENTI)
> +		ret += sprintf(str + ret, "suspended ");
> +
> +	if (usb_ists & USB_ISTS_L2EXTI)
> +		ret += sprintf(str + ret, "L2 exit ");
> +	if (usb_ists & USB_ISTS_U3EXTI)
> +		ret += sprintf(str + ret, "U3 exit ");
> +	if (usb_ists & USB_ISTS_UWRESI)
> +		ret += sprintf(str + ret, "Warm Reset ");
> +	if (usb_ists & USB_ISTS_UHRESI)
> +		ret += sprintf(str + ret, "Hot Reset ");
> +	if (usb_ists & USB_ISTS_U2RESI)
> +		ret += sprintf(str + ret, "Reset");
> +
> +	return str;
> +}
> +
> +static inline  char *cdns3_decode_ep_irq(char *str,
> +					 u32 ep_sts,
> +					 const char *ep_name)
ditto
> +{
> +	int ret;
> +
> +	ret = sprintf(str, "IRQ for %s: %08x ", ep_name, ep_sts);
> +
> +	if (ep_sts & EP_STS_SETUP)
> +		ret += sprintf(str + ret, "SETUP ");
> +	if (ep_sts & EP_STS_IOC)
> +		ret += sprintf(str + ret, "IOC ");
> +	if (ep_sts & EP_STS_ISP)
> +		ret += sprintf(str + ret, "ISP ");
> +	if (ep_sts & EP_STS_DESCMIS)
> +		ret += sprintf(str + ret, "DESCMIS ");
> +	if (ep_sts & EP_STS_STREAMR)
> +		ret += sprintf(str + ret, "STREAMR ");
> +	if (ep_sts & EP_STS_MD_EXIT)
> +		ret += sprintf(str + ret, "MD_EXIT ");
> +	if (ep_sts & EP_STS_TRBERR)
> +		ret += sprintf(str + ret, "TRBERR ");
> +	if (ep_sts & EP_STS_NRDY)
> +		ret += sprintf(str + ret, "NRDY ");
> +	if (ep_sts & EP_STS_PRIME)
> +		ret += sprintf(str + ret, "PRIME ");
> +	if (ep_sts & EP_STS_SIDERR)
> +		ret += sprintf(str + ret, "SIDERRT ");
> +	if (ep_sts & EP_STS_OUTSMM)
> +		ret += sprintf(str + ret, "OUTSMM ");
> +	if (ep_sts & EP_STS_ISOERR)
> +		ret += sprintf(str + ret, "ISOERR ");
> +	if (ep_sts & EP_STS_IOT)
> +		ret += sprintf(str + ret, "IOT ");
> +
> +	return str;
> +}
> +
> +static inline char *cdns3_decode_epx_irq(char *str,
> +					 char *ep_name,
> +					 u32 ep_sts)
> +{
> +	return cdns3_decode_ep_irq(str, ep_sts, ep_name);
> +}
> +
> +static inline char *cdns3_decode_ep0_irq(char *str,
> +					 int dir,
> +					 u32 ep_sts)
> +{
> +	return cdns3_decode_ep_irq(str, ep_sts,
> +				   dir ? "ep0IN" : "ep0OUT");
> +}
> +
> +/**
> + * Debug a transfer ring.
> + *
> + * Prints out all TRBs in the endpoint ring, even those after the Link TRB.
> + *.
> + */
> +static inline char *cdns3_dbg_ring(struct cdns3_endpoint *priv_ep,
> +				   struct cdns3_trb *ring, char *str)
ditto
> +{
> +	dma_addr_t addr = priv_ep->trb_pool_dma;
> +	struct cdns3_trb *trb;
> +	int trb_per_sector;
> +	int ret = 0;
> +	int i;
> +
> +	trb_per_sector = GET_TRBS_PER_SEGMENT(priv_ep->type);
> +
> +	trb = &priv_ep->trb_pool[priv_ep->dequeue];
> +	ret += sprintf(str + ret, "\n\t\tRing contents for %s:", priv_ep->name);
> +
> +	ret += sprintf(str + ret,
> +		       "\n\t\tRing deq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		       priv_ep->dequeue, trb,
> +		       (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +	trb = &priv_ep->trb_pool[priv_ep->enqueue];
> +	ret += sprintf(str + ret,
> +		       "\t\tRing enq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		       priv_ep->enqueue, trb,
> +		       (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +	ret += sprintf(str + ret,
> +		       "\t\tfree trbs: %d, CCS=%d, PCS=%d\n",
> +		       priv_ep->free_trbs, priv_ep->ccs, priv_ep->pcs);
> +
> +	if (trb_per_sector > TRBS_PER_SEGMENT)
> +		trb_per_sector = TRBS_PER_SEGMENT;
> +
> +	if (trb_per_sector > TRBS_PER_SEGMENT) {
> +		sprintf(str + ret, "\t\tTo big transfer ring %d\n",
> +			trb_per_sector);
> +		return str;
> +	}
> +
> +	for (i = 0; i < trb_per_sector; ++i) {
> +		trb = &ring[i];
> +		ret += sprintf(str + ret,
> +			"\t\t@%pad %08x %08x %08x\n", &addr,
> +			le32_to_cpu(trb->buffer),
> +			le32_to_cpu(trb->length),
> +			le32_to_cpu(trb->control));
> +		addr += sizeof(*trb);
> +	}
> +
> +	return str;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +#else
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +{  }
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +{  }
> +#endif
> +
> +#endif /*__LINUX_CDNS3_DEBUG*/
> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
> new file mode 100644
> index 000000000000..d7919f5c1d90
> --- /dev/null
> +++ b/drivers/usb/cdns3/debugfs.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Controller DebugFS filer.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/uaccess.h>
> +
> +#include "core.h"
> +#include "gadget.h"
> +#include "drd.h"
> +
> +static int cdns3_mode_show(struct seq_file *s, void *unused)
> +{
> +	struct cdns3 *cdns = s->private;
> +
> +	switch (cdns->current_dr_mode) {
> +	case USB_DR_MODE_HOST:
> +		seq_puts(s, "host\n");
> +		break;
> +	case USB_DR_MODE_PERIPHERAL:
> +		seq_puts(s, "device\n");
> +		break;
> +	case USB_DR_MODE_OTG:
> +		seq_puts(s, "otg\n");
> +		break;
> +	default:
> +		seq_puts(s, "UNKNOWN mode\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns3_mode_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, cdns3_mode_show, inode->i_private);
> +}
> +
> +static ssize_t cdns3_mode_write(struct file *file,
> +				const char __user *ubuf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct seq_file	 *s = file->private_data;
> +	struct cdns3 *cdns = s->private;
> +	u32 mode = USB_DR_MODE_UNKNOWN;
> +	char buf[32];
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (!strncmp(buf, "host", 4)) {
> +		if (cdns->dr_mode == USB_DR_MODE_HOST ||
> +		    cdns->dr_mode == USB_DR_MODE_OTG) {
> +			mode = USB_DR_MODE_HOST;
> +		}
> +	}
> +
> +	if (!strncmp(buf, "device", 6))
> +		if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL ||
> +		    cdns->dr_mode == USB_DR_MODE_OTG)
> +			mode = USB_DR_MODE_PERIPHERAL;
> +
> +	if (!strncmp(buf, "otg", 3) && cdns->dr_mode == USB_DR_MODE_OTG)
> +		mode = USB_DR_MODE_OTG;
> +
> +	if (mode == USB_DR_MODE_UNKNOWN) {
> +		dev_err(cdns->dev, "Failed: incorrect mode setting\n");
> +		return -EFAULT;
> +	}
> +
> +	if (cdns->current_dr_mode != mode) {
> +		cdns->desired_dr_mode = mode;
> +		cdns->debug_disable = 0;
> +		cdns3_role_stop(cdns);
> +		cdns3_drd_update_mode(cdns);
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations cdns3_mode_fops = {
> +	.open			= cdns3_mode_open,
> +	.write			= cdns3_mode_write,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +static int cdns3_disable_show(struct seq_file *s, void *unused)
> +{
> +	struct cdns3 *cdns = s->private;
> +
> +	if (!cdns->debug_disable)
> +		seq_puts(s, "0\n");
> +	else
> +		seq_puts(s, "1\n");
> +
> +	return 0;
> +}
> +
> +static ssize_t cdns3_disable_write(struct file *file,
> +				   const char __user *ubuf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct seq_file	 *s = file->private_data;
> +	struct cdns3 *cdns = s->private;
> +	int disable;
> +	char buf[32];
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (!strncmp(buf, "1", 1) || !strncmp(buf, "yes", 3)) {
> +		disable = 1;
> +	} else if (!strncmp(buf, "0", 1) || !strncmp(buf, "no", 2)) {
> +		disable = 0;
> +	} else {
> +		dev_err(cdns->dev, "Failed: incorrect disable setting\n");
> +		return -EFAULT;
> +	}
> +
There is common API kstrtobool()?

> +	if (disable != cdns->debug_disable) {
> +		cdns->debug_disable = disable;
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +	}
> +
> +	return count;
> +}
> +
> +static int cdns3_disable_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, cdns3_disable_show, inode->i_private);
> +}
> +
> +static const struct file_operations cdns3_disable_fops = {
> +	.open			= cdns3_disable_open,
> +	.write			= cdns3_disable_write,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +void cdns3_debugfs_init(struct cdns3 *cdns)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir(dev_name(cdns->dev), NULL);
> +	cdns->root = root;
> +	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
> +	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +		debugfs_create_file("mode", 0644, root, cdns,
> +				    &cdns3_mode_fops);
> +
> +	debugfs_create_file("disable", 0644, root, cdns,
> +			    &cdns3_disable_fops);
> +}
> +
> +void cdns3_debugfs_exit(struct cdns3 *cdns)
> +{
> +	debugfs_remove_recursive(cdns->root);
> +}
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> new file mode 100644
> index 000000000000..b0c32302eb0b
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/usb/otg.h>
> +
> +#include "gadget.h"
> +#include "drd.h"
> +#include "core.h"
> +
> +static int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on);
> +static int cdns3_drd_switch_host(struct cdns3 *cdns, int on);
> +
> +/**
> + * cdns3_set_mode - change mode of OTG Core
> + * @cdns: pointer to context structure
> + * @mode: selected mode from cdns_role
> + */
> +void cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
> +{
> +	u32 reg;
> +
> +	cdns->current_dr_mode = mode;
> +
> +	switch (mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		dev_info(cdns->dev, "Set controller to Gadget mode\n");
> +		cdns3_drd_switch_gadget(cdns, 1);
> +		break;
> +	case USB_DR_MODE_HOST:
> +		dev_info(cdns->dev, "Set controller to Host mode\n");
> +		cdns3_drd_switch_host(cdns, 1);
> +		break;
> +	case USB_DR_MODE_OTG:
> +		dev_info(cdns->dev, "Set controller to OTG mode\n");
> +		if (cdns->version == CDNS3_CONTROLLER_V1) {
> +			reg = readl(&cdns->otg_v1_regs->override);
> +			reg |= OVERRIDE_IDPULLUP;
> +			writel(reg, &cdns->otg_v1_regs->override);
> +		} else {
> +			reg = readl(&cdns->otg_v0_regs->ctrl1);
> +			reg |= OVERRIDE_IDPULLUP_V0;
> +			writel(reg, &cdns->otg_v0_regs->ctrl1);
> +		}
> +
> +		/*
> +		 * Hardware specification says: "ID_VALUE must be valid within
> +		 * 50ms after idpullup is set to '1" so driver must wait
> +		 * 50ms before reading this pin.
> +		 */
> +		usleep_range(50000, 60000);
> +		break;
> +	default:
> +		cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
> +		return;
> +	}
> +}
> +
> +int cdns3_get_id(struct cdns3 *cdns)
> +{
> +	int id;
> +
> +	id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
> +	return  1 ; //id;
return fixed value ?
> +}
> +
> +int cdns3_is_host(struct cdns3 *cdns)
> +{
> +	if (cdns->current_dr_mode == USB_DR_MODE_HOST)
> +		return 1;
> +	else if (!cdns3_get_id(cdns))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +

> +
> +/**
> + * cdns3_init_otg_mode - initialize drd controller
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
void function
> + */
> +static void cdns3_init_otg_mode(struct cdns3 *cdns)
> +{
> +	cdns3_otg_disable_irq(cdns);
> +	/* clear all interrupts */
> +	writel(~0, &cdns->otg_regs->ivect);
> +
> +	cdns3_set_mode(cdns, USB_DR_MODE_OTG);
> +
> +	if (cdns3_is_host(cdns))
> +		cdns3_drd_switch_host(cdns, 1);
> +	else
> +		cdns3_drd_switch_gadget(cdns, 1);
> +
> +	cdns3_otg_enable_irq(cdns);
> +}
> +
> +/**
> + * cdns3_drd_update_mode - initialize mode of operation
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_drd_update_mode(struct cdns3 *cdns)
> +{
> +	int ret = 0;
> +
> +	if (cdns->desired_dr_mode == cdns->current_dr_mode)
> +		return ret;
> +
> +	cdns3_drd_switch_gadget(cdns, 0);
> +	cdns3_drd_switch_host(cdns, 0);
> +
> +	switch (cdns->desired_dr_mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
> +		break;
> +	case USB_DR_MODE_HOST:
> +		cdns3_set_mode(cdns, USB_DR_MODE_HOST);
> +		break;
> +	case USB_DR_MODE_OTG:
> +		cdns3_init_otg_mode(cdns);
> +		break;
> +	default:
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
> +			cdns->dr_mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
no need define local variable @ret
> +}
> +
> +/**
> + * cdns3_drd_irq - interrupt handler for OTG events
> + *
> + * @irq: irq number for cdns3 core device
> + * @data: structure of cdns3
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE
> + */
> +static irqreturn_t cdns3_drd_irq(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +	struct cdns3 *cdns = data;
> +	u32 reg;
> +
> +	if (cdns->dr_mode != USB_DR_MODE_OTG)
> +		return ret;
> +
> +	reg = readl(&cdns->otg_regs->ivect);
> +
> +	if (!reg)
> +		return ret;
> +
> +	if (reg & OTGIEN_ID_CHANGE_INT) {
> +		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
> +			cdns3_get_id(cdns));
> +
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +
do you need to clear interrupts status here?
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	writel(~0, &cdns->otg_regs->ivect);
> +	return ret;
> +}
> +
> +int cdns3_drd_init(struct cdns3 *cdns)
> +{
> +	void __iomem *regs;
> +	int ret = 0;
> +	u32 state;
> +
> +	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	/* Detection of DRD version. Controller has been released
> +	 * in two versions. Both are similar, but they have same changes
> +	 * in register maps.
> +	 * The first register in old version is command register and it's read
> +	 * only, so driver should read 0 from it. On the other hand, in v1
> +	 * the first register contains device ID number which is not set to 0.
> +	 * Driver uses this fact to detect the proper version of
> +	 * controller.
> +	 */
> +	cdns->otg_v0_regs = regs;
> +	if (!readl(&cdns->otg_v0_regs->cmd)) {
> +		cdns->version  = CDNS3_CONTROLLER_V0;
> +		cdns->otg_v1_regs = NULL;
> +		cdns->otg_regs = regs;
> +		dev_info(cdns->dev, "DRD version v0 (%08x)\n",
> +			 readl(&cdns->otg_v0_regs->version));
> +	} else {
> +		cdns->otg_v0_regs = NULL;
> +		cdns->otg_v1_regs = regs;
> +		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
> +		cdns->version  = CDNS3_CONTROLLER_V1;
> +		dev_info(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
> +			 readl(&cdns->otg_v1_regs->did),
> +			 readl(&cdns->otg_v1_regs->rid));
> +	}
> +
> +	state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
> +
> +	/* Update dr_mode according to STRAP configuration. */
> +	cdns->dr_mode = USB_DR_MODE_OTG;
> +	if (state == OTGSTS_STRAP_HOST) {
> +		dev_info(cdns->dev, "Controller strapped to HOST\n");
> +		cdns->dr_mode = USB_DR_MODE_HOST;
> +	} else if (state == OTGSTS_STRAP_GADGET) {
> +		dev_info(cdns->dev, "Controller strapped to PERIPHERAL\n");
> +		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	cdns->desired_dr_mode = cdns->dr_mode;
> +	cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +
> +	ret = devm_request_threaded_irq(cdns->dev, cdns->irq, cdns3_drd_irq,
> +					NULL, IRQF_SHARED,
> +					dev_name(cdns->dev), cdns);
> +
> +	if (ret)
> +		return ret;
> +
> +	state = readl(&cdns->otg_regs->sts);
> +	if (OTGSTS_OTG_NRDY(state) != 0) {
> +		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = cdns3_drd_update_mode(cdns);
> +
> +	return ret;
return cdns3_drd_update_mode();
> +}
> +
> +int cdns3_drd_exit(struct cdns3 *cdns)
> +{
> +	return cdns3_drd_switch_host(cdns, 0);
> +}


<...>

> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> new file mode 100644
> index 000000000000..89cf1cde1555
> --- /dev/null
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -0,0 +1,896 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *	    Peter Chen <peter.chen@nxp.com>
> + */
> +
> +#include <linux/usb/composite.h>
> +
> +#include "gadget.h"
> +#include "trace.h"
> +
> +static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
> +	.bLength = USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType = USB_DT_ENDPOINT,
> +	.bmAttributes =	USB_ENDPOINT_XFER_CONTROL,
> +};
> +
<...>
> +
> +
> +#endif /* __LINUX_CDNS3_GADGET_EXPORT */
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> new file mode 100644
> index 000000000000..0d95eb00be37
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -0,0 +1,2102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *	    Peter Chen <peter.chen@nxp.com>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/usb/gadget.h>
> +
<...>

> +/**
> + * cdns3_next_request - returns next request from list
> + * @list: list containing requests
> + *
> + * Returns request or NULL if no requests in list
> + */
> +struct usb_request *cdns3_next_request(struct list_head *list)
> +{
> +	if (list_empty(list))
> +		return NULL;
No need check it, if list is empty, list_first_entry_or_null() will
return NULL
> +	return list_first_entry_or_null(list, struct usb_request, list);
> +}
> +
> +/**
> + * cdns3_next_priv_request - returns next request from list
> + * @list: list containing requests
> + *
> + * Returns request or NULL if no requests in list
> + */
> +struct cdns3_request *cdns3_next_priv_request(struct list_head *list)
> +{
> +	if (list_empty(list))
> +		return NULL;
ditto
> +	return list_first_entry_or_null(list, struct cdns3_request, list);
> +}
> +

<...>



