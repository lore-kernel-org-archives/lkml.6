Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbeDZSc5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:32:57 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36413 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754208AbeDZScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:32:54 -0400
X-Google-Smtp-Source: AIpwx4/jd+AhknrNsE66k7L8b0MFWAdUf3UJJKCCMQTWxiw743yEftnWtYhxhlHofZnMuNNRr2gPDg==
MIME-Version: 1.0
References: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org> <1524524972-12014-3-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1524524972-12014-3-git-send-email-rishabhb@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 26 Apr 2018 18:32:16 +0000
X-Gmail-Original-Message-ID: <CAE=gft6h6HJgXURYP2F7aMC35iOCQRq5bTzphS4PnTp56of40A@mail.gmail.com>
Message-ID: <CAE=gft6h6HJgXURYP2F7aMC35iOCQRq5bTzphS4PnTp56of40A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drivers: soc: Add LLCC driver
To: rishabhb@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        kyan@codeaurora.org, ckadabi@codeaurora.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

On Mon, Apr 23, 2018 at 4:11 PM Rishabh Bhatnagar <rishabhb@codeaurora.org>
wrote:

> LLCC (Last Level Cache Controller) provides additional cache memory
> in the system. LLCC is partitioned into multiple slices and each
> slice gets its own priority, size, ID and other config parameters.
> LLCC driver programs these parameters for each slice. Clients that
> are assigned to use LLCC need to get information such size & ID of the
> slice they get and activate or deactivate the slice as needed. LLCC driver
> provides API for the clients to perform these operations.

> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>   drivers/soc/qcom/Kconfig           |  17 ++
>   drivers/soc/qcom/Makefile          |   2 +
>   drivers/soc/qcom/llcc-sdm845.c     | 108 +++++++++++
>   drivers/soc/qcom/llcc-slice.c      | 380
+++++++++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h | 167 ++++++++++++++++
>   5 files changed, 674 insertions(+)
>   create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>   create mode 100644 drivers/soc/qcom/llcc-slice.c
>   create mode 100644 include/linux/soc/qcom/llcc-qcom.h

...
> diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
> new file mode 100644
> index 0000000..fd2b607
> --- /dev/null
> +++ b/drivers/soc/qcom/llcc-slice.c
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/llcc-qcom.h>
> +
> +#define ACTIVATE                      0x1
> +#define DEACTIVATE                    0x2
> +#define ACT_CTRL_OPCODE_ACTIVATE      0x1
> +#define ACT_CTRL_OPCODE_DEACTIVATE    0x2
> +#define ACT_CTRL_ACT_TRIG             0x1
> +#define ACT_CTRL_OPCODE_SHIFT         0x1
> +#define ATTR1_PROBE_TARGET_WAYS_SHIFT 0x2
> +#define ATTR1_FIXED_SIZE_SHIFT        0x3
> +#define ATTR1_PRIORITY_SHIFT          0x4
> +#define ATTR1_MAX_CAP_SHIFT           0x10
> +#define ATTR0_RES_WAYS_MASK           0x00000fff
> +#define ATR0_BONUS_WAYS_MASK          0x0fff0000

This looks like it's missing a t, eg ATTR0_BONUS_WAYS_MASK.

> +#define ATTR0_BONUS_WAYS_SHIFT        0x10
> +#define LLCC_STATUS_READ_DELAY 100
> +
> +#define CACHE_LINE_SIZE_SHIFT 6
> +
> +#define LLCC_COMMON_STATUS0            0x0003000c
> +#define LLCC_LB_CNT_MASK               0xf0000000
> +#define LLCC_LB_CNT_SHIFT              28
> +
> +#define MAX_CAP_TO_BYTES(n) (n * 1024)
> +#define LLCC_TRP_ACT_CTRLn(n) (n * 0x1000)
> +#define LLCC_TRP_STATUSn(n)   (4 + n * 0x1000)
> +#define LLCC_TRP_ATTR0_CFGn(n) (0x21000 + 0x8 * n)
> +#define LLCC_TRP_ATTR1_CFGn(n) (0x21004 + 0x8 * n)
> +
> +#define BANK_OFFSET_STRIDE     0x80000
> +
> +static const struct regmap_config llcc_regmap_config = {
> +       .reg_bits = 32,
> +       .reg_stride = 4,
> +       .val_bits = 32,
> +       .fast_io = true,
> +};
> +
> +/* Get the slice entry by index */
> +static struct llcc_slice_desc *llcc_slice_get_entry(struct device *dev,
int n)
> +{
> +       struct of_phandle_args phargs;
> +       struct llcc_drv_data *drv;
> +       const struct llcc_slice_config *llcc_data_ptr;
> +       struct llcc_slice_desc *desc;
> +       struct platform_device *pdev;
> +       u32 sz, count;
> +
> +       if (of_parse_phandle_with_args(dev->of_node, "cache-slices",
> +                                      "#cache-cells", n, &phargs))
> +               return ERR_PTR(-ENODEV);
> +
> +       pdev = of_find_device_by_node(phargs.np);
> +       if (!pdev)
> +               return ERR_PTR(-ENODEV);
> +
> +       drv = platform_get_drvdata(pdev);
> +       if (!drv)
> +               return ERR_PTR(-EFAULT);

EFAULT is a little weird here, right? Maybe EINVAL or ENODEV?

> +
> +       llcc_data_ptr = drv->cfg;
> +       sz = drv->cfg_size;
> +       count = 0;
> +
> +       while (llcc_data_ptr && count < sz) {
> +               if (llcc_data_ptr->usecase_id == phargs.args[0])
> +                       break;
> +               llcc_data_ptr++;
> +               count++;
> +       }
> +
> +       if (llcc_data_ptr == NULL || count == sz)
> +               return ERR_PTR(-ENODEV);
> +
> +       desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> +       if (!desc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       desc->slice_id = llcc_data_ptr->slice_id;
> +       desc->slice_size = llcc_data_ptr->max_cap;
> +       desc->dev = &pdev->dev;
> +
> +       return desc;
> +}
> +
> +/**
> + * llcc_slice_getd - get llcc slice descriptor
> + * @dev: Device pointer of the client
> + * @name: Name of the use case
> + *
> + * A pointer to llcc slice descriptor will be returned on success and
> + * and error pointer is returned on failure
> + */
> +struct llcc_slice_desc *llcc_slice_getd(struct device *dev, const char
*name)
> +{
> +       struct device_node *np = dev->of_node;
> +       int index = 0;
> +       const char *slice_name;
> +       struct property *prop;
> +
> +       if (!of_get_property(np, "cache-slice-names", NULL))
> +               return ERR_PTR(-ENOENT);
> +
> +       of_property_for_each_string(np, "cache-slice-names", prop,
slice_name) {
> +               if (!strcmp(name, slice_name))
> +                       break;
> +               index++;
> +       }
> +       return llcc_slice_get_entry(dev, index);
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_getd);
> +
> +/**
> + * llcc_slice_putd - llcc slice descritpor
> + * @desc: Pointer to llcc slice descriptor
> + */
> +void llcc_slice_putd(struct llcc_slice_desc *desc)
> +{
> +       devm_kfree(desc->dev, desc);
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_putd);
> +
> +static int llcc_update_act_ctrl(struct llcc_drv_data *drv, u32 sid,
> +                               u32 act_ctrl_reg_val, u32 status)
> +{
> +       u32 act_ctrl_reg;
> +       u32 status_reg;
> +       u32 slice_status;
> +       int ret = 0;
> +
> +       act_ctrl_reg = drv->bcast_off + LLCC_TRP_ACT_CTRLn(sid);
> +       status_reg = drv->bcast_off + LLCC_TRP_STATUSn(sid);
> +
> +       /* Set the ACTIVE trigger */
> +       act_ctrl_reg_val |= ACT_CTRL_ACT_TRIG;
> +       ret = regmap_write(drv->regmap, act_ctrl_reg, act_ctrl_reg_val);
> +       if (ret)
> +               return ret;
> +
> +       /* Clear the ACTIVE trigger */
> +       act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
> +       ret = regmap_write(drv->regmap, act_ctrl_reg, act_ctrl_reg_val);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_read_poll_timeout(drv->regmap, status_reg,
slice_status,
> +                       !(slice_status & status), 0,
LLCC_STATUS_READ_DELAY);
> +       return ret;
> +}
> +
> +/**
> + * llcc_slice_activate - Activate the llcc slice
> + * @desc: Pointer to llcc slice descriptor
> + *
> + * A value of zero will be returned on success and a negative errno will
> + * be returned in error cases
> + */
> +int llcc_slice_activate(struct llcc_slice_desc *desc)
> +{
> +       int ret;
> +       u32 act_ctrl_val;
> +       struct llcc_drv_data *drv;
> +
> +       drv = dev_get_drvdata(desc->dev);
> +       if (!drv)
> +               return -EINVAL;
> +
> +       mutex_lock(&drv->lock);
> +       if (test_bit(desc->slice_id, drv->bitmap)) {
> +               mutex_unlock(&drv->lock);
> +               return 0;
> +       }
> +
> +       act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
> +
> +       ret = llcc_update_act_ctrl(drv, desc->slice_id, act_ctrl_val,
> +                                 DEACTIVATE);
> +
> +       __set_bit(desc->slice_id, drv->bitmap);

If llcc_update_act_ctrl fails, your bitmap will become out of sync with
reality, and future calls to llcc_slice activate will return immediately.
Perhaps you should only set the bit if ret is zero.

> +       mutex_unlock(&drv->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_activate);
> +
> +/**
> + * llcc_slice_deactivate - Deactivate the llcc slice
> + * @desc: Pointer to llcc slice descriptor
> + *
> + * A value of zero will be returned on success and a negative errno will
> + * be returned in error cases
> + */
> +int llcc_slice_deactivate(struct llcc_slice_desc *desc)
> +{
> +       u32 act_ctrl_val;
> +       int ret;
> +       struct llcc_drv_data *drv;
> +
> +       drv = dev_get_drvdata(desc->dev);
> +       if (!drv)
> +               return -EINVAL;
> +
> +       mutex_lock(&drv->lock);
> +       if (!test_bit(desc->slice_id, drv->bitmap)) {
> +               mutex_unlock(&drv->lock);
> +               return 0;
> +       }
> +       act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE <<
ACT_CTRL_OPCODE_SHIFT;
> +
> +       ret = llcc_update_act_ctrl(drv, desc->slice_id, act_ctrl_val,
> +                                 ACTIVATE);
> +
> +       __clear_bit(desc->slice_id, drv->bitmap);

Conversely, only clear the bit if ret was zero.

If you fix these issues, then feel free to add my Reviewed-by to the next
spin of this patch.
-Evan
