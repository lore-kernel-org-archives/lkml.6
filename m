Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753693AbeDLWEI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:04:08 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33429 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeDLWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:04:07 -0400
X-Google-Smtp-Source: AIpwx48buMOHpsNjvRw7r5x4stgpIyU33spujp8b77PKx6mC699jF/o7BQT0wIJrWPda7gnBR2zeow==
MIME-Version: 1.0
References: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org> <1523390893-10904-3-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1523390893-10904-3-git-send-email-rishabhb@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 12 Apr 2018 22:02:57 +0000
X-Gmail-Original-Message-ID: <CAE=gft6DHtvkLAyAF30p6rwJrs845nxBOxWQ0gmHdJ0VQa4ZxQ@mail.gmail.com>
Message-ID: <CAE=gft6DHtvkLAyAF30p6rwJrs845nxBOxWQ0gmHdJ0VQa4ZxQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drivers: soc: Add LLCC driver
To: rishabhb@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        kyan@codeaurora.org, ckadabi@codeaurora.org,
        stanimir.varbanov@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

On Tue, Apr 10, 2018 at 1:09 PM Rishabh Bhatnagar <rishabhb@codeaurora.org>
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
>   drivers/soc/qcom/llcc-sdm845.c     | 110 ++++++++++
>   drivers/soc/qcom/llcc-slice.c      | 404
+++++++++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h | 168 +++++++++++++++
>   5 files changed, 701 insertions(+)
>   create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>   create mode 100644 drivers/soc/qcom/llcc-slice.c
>   create mode 100644 include/linux/soc/qcom/llcc-qcom.h

[...]
> diff --git a/drivers/soc/qcom/llcc-sdm845.c
b/drivers/soc/qcom/llcc-sdm845.c
> new file mode 100644
> index 0000000..619b226
> --- /dev/null
> +++ b/drivers/soc/qcom/llcc-sdm845.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/soc/qcom/llcc-qcom.h>
> +
> +/*
> + * SCT(System Cache Table) entry contains of the following parameters

contains the following members:

> + * name: Name of the client's use case for which the llcc slice is used
> + * uid: Unique id for the client's use case

s/uid/usecase_id/

> + * slice_id: llcc slice id for each client
> + * max_cap: The maximum capacity of the cache slice provided in KB
> + * priority: Priority of the client used to select victim line for
replacement
> + * fixed_size: Determine if the slice has a fixed capacity

"Boolean indicating if the slice has a fixed capacity" might be better

> diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
> new file mode 100644
> index 0000000..67a81b0
> --- /dev/null
> +++ b/drivers/soc/qcom/llcc-slice.c
...
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
> +       /*Set the ACTIVE trigger*/

Add spaces around /* */

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
> + * A value zero will be returned on success and a negative errno will

a value of zero

> + * be returned in error cases
> + */
> +int llcc_slice_activate(struct llcc_slice_desc *desc)
> +{
> +       int ret;
> +       u32 act_ctrl_val;
> +       struct llcc_drv_data *drv;
> +
> +       if (desc == NULL)
> +               return -EINVAL;

I think we can remove this check, right?

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
> + * A value zero will be returned on success and a negative errno will
> + * be returned in error cases
> + */
> +int llcc_slice_deactivate(struct llcc_slice_desc *desc)
> +{
> +       u32 act_ctrl_val;
> +       int ret;
> +       struct llcc_drv_data *drv;
> +
> +       if (desc == NULL)
> +               return -EINVAL;
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
> +       mutex_unlock(&drv->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_deactivate);
> +
> +/**
> + * llcc_get_slice_id - return the slice id
> + * @desc: Pointer to llcc slice descriptor
> + *
> + * A positive value will be returned on success and a negative errno will
> + * be returned on error
> + */
> +int llcc_get_slice_id(struct llcc_slice_desc *desc)
> +{
> +       if (!desc)
> +               return -EINVAL;

Can we remove this check too?

> +
> +       return desc->slice_id;
> +}
> +EXPORT_SYMBOL_GPL(llcc_get_slice_id);
> +
> +/**
> + * llcc_get_slice_size - return the slice id
> + * @desc: Pointer to llcc slice descriptor
> + *
> + * A positive value will be returned on success and zero will returned on
> + * error
> + */
> +size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
> +{
> +       if (!desc)
> +               return 0;

And this one?

-Evan
