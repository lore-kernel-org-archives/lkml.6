Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeCZJCD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:02:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46655 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeCZJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:02:02 -0400
Message-ID: <1522054917.5851.2.camel@pengutronix.de>
Subject: Re: [RFC 2/2] reset: reset-zynqmp: Adding support for Xilinx zynqmp
 reset controller.
From: Philipp Zabel <p.zabel@pengutronix.de>
To: chinnikishore369@gmail.com, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Nava kishore Manne <navam@xilinx.com>
Date: Mon, 26 Mar 2018 11:01:57 +0200
In-Reply-To: <20180324191100.18363-2-chinnikishore369@gmail.com>
References: <20180324191100.18363-1-chinnikishore369@gmail.com>
         <20180324191100.18363-2-chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2018-03-25 at 00:41 +0530, chinnikishore369@gmail.com wrote:
> From: Nava kishore Manne <navam@xilinx.com>
> 
> Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> The zynqmp reset-controller has the ability to reset lines
> connected to different blocks and peripheral in the Soc.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>

Thank you for the patch, this driver looks mostly fine to me.
I just have a few nitpicks below:

> ---
>   drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-zynqmp.c | 106 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 drivers/reset/reset-zynqmp.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 132c24f5ddb5..4e1a94acf83f 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -20,4 +20,5 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> +obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
> 
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> new file mode 100644
> index 000000000000..c8510fa93ad9
> --- /dev/null
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -0,0 +1,106 @@
[...]
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +
> +#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
> +#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
> +
> +static const struct zynqmp_eemi_ops *eemi_ops;

This seems to depend on some other patches for the EEMI API support.
Could you point them out to me? I'd just like to see whether the
ZYNQMP_PM_RESET_* defines agree with the zynqmp-reset.txt DT docs.

> +struct zynqmp_reset {
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
> +				unsigned long id)

This is not a hard requirement, but it would be nice if you could align
with the open parentheses such that checkpatch.pl --strict doesn't warn.
Same for the others below.

> +{
> +	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
> +						PM_RESET_ACTION_ASSERT);
> +}
> +
> +static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
> +						PM_RESET_ACTION_RELEASE);
> +}
> +
> +static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	int val;
> +
> +	eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);

Can reset_get_status return an error? If so, please propagate it.

> +	return val;
> +}
> +
> +static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
> +						PM_RESET_ACTION_PULSE);
> +}
> +
> +static struct reset_control_ops zynqmp_reset_ops = {
> +	.reset = zynqmp_reset_reset,
> +	.assert = zynqmp_reset_assert,
> +	.deassert = zynqmp_reset_deassert,
> +	.status = zynqmp_reset_status,
> +};
> +
> +static int zynqmp_reset_probe(struct platform_device *pdev)
> +{
> +	struct zynqmp_reset *zynqmp_reset;
> +	int ret;
> +
> +	zynqmp_reset = devm_kzalloc(&pdev->dev,
> +				sizeof(*zynqmp_reset), GFP_KERNEL);
> +	if (!zynqmp_reset)
> +		return -ENOMEM;
> +
> +	eemi_ops = zynqmp_pm_get_eemi_ops();

Not sure if this can ever happen, but if there are two xlnx,zynqmp-reset 
in the DT by accident, the probing the second would presumably return an
error here, thereby overwriting eemi_ops for the first one.
Perhaps it is safer to either use a local variable and only assign on
success, or better: move eemi_ops into the zynqmp_reset structure.

> +	if (!eemi_ops)
> +		return -ENXIO;
> +
> +	platform_set_drvdata(pdev, zynqmp_reset);
> +
> +	zynqmp_reset->rcdev.ops = &zynqmp_reset_ops;
> +	zynqmp_reset->rcdev.owner = THIS_MODULE;
> +	zynqmp_reset->rcdev.of_node = pdev->dev.of_node;
> +	zynqmp_reset->rcdev.of_reset_n_cells = 1;

This line is not needed. If of_xlate is not set, the core will use
of_reset_simple_xlate and set of_reset_n_cells to 1.

> +	zynqmp_reset->rcdev.nr_resets = ZYNQMP_NR_RESETS;
> +
> +	ret = reset_controller_register(&zynqmp_reset->rcdev);
> +	if (!ret)
> +		dev_info(&pdev->dev, "Xilinx zynqmp reset driver probed\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id zynqmp_reset_dt_ids[] = {
> +	{ .compatible = "xlnx,zynqmp-reset", },
> +	{ },
> +};
> +
> +static struct platform_driver zynqmp_reset_driver = {
> +	.probe	= zynqmp_reset_probe,
> +	.driver = {
> +		.name		= KBUILD_MODNAME,
> +		.of_match_table	= zynqmp_reset_dt_ids,
> +	},
> +};
> +
> +static int __init zynqmp_reset_init(void)
> +{
> +	return platform_driver_register(&zynqmp_reset_driver);
> +}
> +
> +arch_initcall(zynqmp_reset_init);

regards
Philipp
