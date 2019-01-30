Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A36C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C082020989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfA3KMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:12:47 -0500
Received: from foss.arm.com ([217.140.101.70]:51476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfA3KMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:12:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C83F5A78;
        Wed, 30 Jan 2019 02:12:45 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58073F71E;
        Wed, 30 Jan 2019 02:12:42 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:12:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Message-ID: <20190130101236.GA27201@e107155-lin>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
 <1548794301-30483-4-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548794301-30483-4-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:38:21PM -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add ZynqMP PM driver. PM driver provides power management
> support for ZynqMP.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/soc/xilinx/Kconfig        |  11 +++
>  drivers/soc/xilinx/Makefile       |   1 +
>  drivers/soc/xilinx/zynqmp_power.c | 178 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 drivers/soc/xilinx/zynqmp_power.c
> 
> diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
> index 687c8f3..5025e0e 100644
> --- a/drivers/soc/xilinx/Kconfig
> +++ b/drivers/soc/xilinx/Kconfig
> @@ -17,4 +17,15 @@ config XILINX_VCU
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called xlnx_vcu.
>  
> +config ZYNQMP_POWER
> +	bool "Enable Xilinx Zynq MPSoC Power Management driver"
> +	depends on PM && ARCH_ZYNQMP
> +	default y
> +	help
> +	  Say yes to enable power management support for ZyqnMP SoC.
> +	  This driver uses firmware driver as an interface for power
> +	  management request to firmware. It registers isr to handle
> +	  power management callbacks from firmware.
> +	  If in doubt, say N.
> +
>  endmenu
> diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
> index dee8fd5..428b9db 100644
> --- a/drivers/soc/xilinx/Makefile
> +++ b/drivers/soc/xilinx/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
> +obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> new file mode 100644
> index 0000000..771cb59
> --- /dev/null
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Zynq MPSoC Power Management
> + *
> + *  Copyright (C) 2014-2018 Xilinx, Inc.
> + *
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajan.vaja@xilinx.com>
> + */
> +
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/suspend.h>
> +
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +enum pm_suspend_mode {
> +	PM_SUSPEND_MODE_FIRST = 0,
> +	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
> +	PM_SUSPEND_MODE_POWER_OFF,
> +};
> +
> +#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
> +
> +static const char *const suspend_modes[] = {
> +	[PM_SUSPEND_MODE_STD] = "standard",
> +	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
> +};
> +
> +static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
> +
> +enum pm_api_cb_id {
> +	PM_INIT_SUSPEND_CB = 30,
> +	PM_ACKNOWLEDGE_CB,
> +	PM_NOTIFY_CB,
> +};
> +
> +static void zynqmp_pm_get_callback_data(u32 *buf)
> +{
> +	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> +}
> +
> +static irqreturn_t zynqmp_pm_isr(int irq, void *data)
> +{
> +	u32 payload[CB_PAYLOAD_SIZE];
> +
> +	zynqmp_pm_get_callback_data(payload);
> +
> +	/* First element is callback API ID, others are callback arguments */
> +	if (payload[0] == PM_INIT_SUSPEND_CB) {
> +		switch (payload[1]) {
> +		case SUSPEND_SYSTEM_SHUTDOWN:
> +			orderly_poweroff(true);
> +			break;
> +		case SUSPEND_POWER_REQUEST:
> +			pm_suspend(PM_SUSPEND_MEM);
> +			break;
> +		default:
> +			pr_err("%s Unsupported InitSuspendCb reason "
> +				"code %d\n", __func__, payload[1]);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t suspend_mode_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	char *s = buf;
> +	int md;
> +
> +	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
> +		if (suspend_modes[md]) {
> +			if (md == suspend_mode)
> +				s += sprintf(s, "[%s] ", suspend_modes[md]);
> +			else
> +				s += sprintf(s, "%s ", suspend_modes[md]);
> +		}
> +
> +	/* Convert last space to newline */
> +	if (s != buf)
> +		*(s - 1) = '\n';
> +	return (s - buf);
> +}
> +
> +static ssize_t suspend_mode_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	int md, ret = -EINVAL;
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->set_suspend_mode)
> +		return ret;
> +
> +	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
> +		if (suspend_modes[md] &&
> +		    sysfs_streq(suspend_modes[md], buf)) {
> +			ret = 0;
> +			break;
> +		}
> +
> +	if (!ret && md != suspend_mode) {
> +		ret = eemi_ops->set_suspend_mode(md);
> +		if (likely(!ret))
> +			suspend_mode = md;
> +	}
> +
> +	return ret ? ret : count;
> +}
> +
> +static DEVICE_ATTR_RW(suspend_mode);
> +
> +static int zynqmp_pm_probe(struct platform_device *pdev)
> +{
> +	int ret, irq;
> +	u32 pm_api_version;
> +
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
> +		return -ENXIO;
> +
> +	eemi_ops->init_finalize();
> +	eemi_ops->get_api_version(&pm_api_version);
> +
> +	/* Check PM API version number */
> +	if (pm_api_version < ZYNQMP_PM_VERSION)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return -ENXIO;
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, zynqmp_pm_isr,
> +					IRQF_NO_SUSPEND | IRQF_ONESHOT,
> +					dev_name(&pdev->dev), &pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed "
> +			"with %d\n", irq, ret);
> +		return ret;
> +	}
> +
> +	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);

NACK, if this is for system suspend/reset ? You can just use exiting
sysfs, no need to create Xilinx specific new ones. Moreover you need to
use PSCI to make sure higher ELs can do orderly suspend/shutdown.

--
Regards,
Sudeep
