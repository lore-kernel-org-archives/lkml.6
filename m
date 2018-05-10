Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeEJUQW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:16:22 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45938 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEJUQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:16:18 -0400
X-Google-Smtp-Source: AB8JxZol/YqGipo8SV4AjD4moo47MfvwqQcWWxn7wRs5PErVC68+kO5qgx8Hvg3S7YbvZ51BXSqTWQ==
MIME-Version: 1.0
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org> <1525810921-15878-3-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1525810921-15878-3-git-send-email-rishabhb@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 10 May 2018 20:15:39 +0000
X-Gmail-Original-Message-ID: <CAE=gft6n8tyjqbi19eVSWT=_isQSv6sbsJK18i42Adb6LGw6HQ@mail.gmail.com>
Message-ID: <CAE=gft6n8tyjqbi19eVSWT=_isQSv6sbsJK18i42Adb6LGw6HQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drivers: soc: Add LLCC driver
To: rishabhb@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,
On Tue, May 8, 2018 at 1:23 PM Rishabh Bhatnagar <rishabhb@codeaurora.org>
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
>   drivers/soc/qcom/llcc-sdm845.c     | 106 ++++++++++++
>   drivers/soc/qcom/llcc-slice.c      | 335
+++++++++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h | 162 ++++++++++++++++++
>   5 files changed, 622 insertions(+)
>   create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>   create mode 100644 drivers/soc/qcom/llcc-slice.c
>   create mode 100644 include/linux/soc/qcom/llcc-qcom.h

...
> diff --git a/drivers/soc/qcom/llcc-sdm845.c
b/drivers/soc/qcom/llcc-sdm845.c
> new file mode 100644
> index 0000000..e5e792c
> --- /dev/null
> +++ b/drivers/soc/qcom/llcc-sdm845.c
> @@ -0,0 +1,106 @@
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
> + * SCT(System Cache Table) entry contains of the following members:
> + * usecase_id: Unique id for the client's use case
> + * slice_id: llcc slice id for each client
> + * max_cap: The maximum capacity of the cache slice provided in KB
> + * priority: Priority of the client used to select victim line for
replacement
> + * fixed_size: Boolean indicating if the slice has a fixed capacity
> + * bonus_ways: Bonus ways are additional ways to be used for any slice,
> + *             if client ends up using more than reserved cache ways.
Bonus
> + *             ways are allocated only if they are not reserved for some
> + *             other client.
> + * res_ways: Reserved ways for the cache slice, the reserved ways cannot
> + *             be used by any other client than the one its assigned to.
> + * cache_mode: Each slice operates as a cache, this controls the mode of
the
> + *             slice: normal or TCM(Tightly Coupled Memory)
> + * probe_target_ways: Determines what ways to probe for access hit. When
> + *                    configured to 1 only bonus and reserved ways are
probed.
> + *                    When configured to 0 all ways in llcc are probed.
> + * dis_cap_alloc: Disable capacity based allocation for a client
> + * retain_on_pc: If this bit is set and client has maintained active vote
> + *               then the ways assigned to this client are not flushed
on power
> + *               collapse.
> + * activate_on_init: Activate the slice immediately after the SCT is
programmed
> + */
> +#define SCT_ENTRY(uid, sid, mc, p, fs, bway, rway, cmod, ptw, dca, rp,
a) \
> +       {                                       \
> +               .usecase_id = uid,              \
> +               .slice_id = sid,                \
> +               .max_cap = mc,                  \
> +               .priority = p,                  \
> +               .fixed_size = fs,               \
> +               .bonus_ways = bway,             \
> +               .res_ways = rway,               \
> +               .cache_mode = cmod,             \
> +               .probe_target_ways = ptw,       \
> +               .dis_cap_alloc = dca,           \
> +               .retain_on_pc = rp,             \
> +               .activate_on_init = a,          \
> +       }
> +
> +static struct llcc_slice_config sdm845_data[] =  {
> +       SCT_ENTRY(1,  1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1),
> +       SCT_ENTRY(2,  2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
> +       SCT_ENTRY(3,  3,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
> +       SCT_ENTRY(4,  4,  563,  2, 1, 0x0,   0x00e, 2, 0, 1, 1, 0),
> +       SCT_ENTRY(5,  5,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(6,  6,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(7,  7,  1024, 2, 0, 0xfc,  0xf00, 0, 0, 1, 1, 0),
> +       SCT_ENTRY(8,  8,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(10, 10, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(11, 11, 512,  1, 1, 0xc,   0x0,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(12, 12, 2304, 1, 0, 0xff0, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(13, 13, 256,  2, 0, 0x0,   0x1,   0, 0, 1, 0, 1),
> +       SCT_ENTRY(15, 15, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(16, 16, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(17, 17, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(20, 20, 1024, 2, 1, 0x0,   0xf00, 0, 0, 1, 1, 0),
> +       SCT_ENTRY(21, 21, 1024, 0, 1, 0x1e,  0x0,   0, 0, 1, 1, 0),
> +       SCT_ENTRY(22, 22, 1024, 1, 1, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +};

Now that drivers are hardcoding IDs when calling llcc_slice_getd, should we
add #defines in llcc-qcom.h for each of the usecase IDs? Then this would
change the entries to look like:
        SCT_ENTRY(QCOM_LLCC_CPUSS,  1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1,
1, 1),

and drivers using it would call llcc_slice_getd(QCOM_LLCC_CPUSS), rather
than llcc_slice_getd(1).

> diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
> new file mode 100644
> index 0000000..209df55
> --- /dev/null
> +++ b/drivers/soc/qcom/llcc-slice.c
> @@ -0,0 +1,335 @@
...
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
> +
> +       mutex_lock(&drv_data->lock);
> +       if (test_bit(desc->slice_id, drv_data->bitmap)) {
> +               mutex_unlock(&drv_data->lock);
> +               return 0;
> +       }
> +
> +       act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
> +
> +       ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
> +                                 DEACTIVATE);
> +       if (ret)
> +               return ret;

I had asked for this in the last revision, and thank you for putting that
in so that the bitmap matches reality. Unfortunately this introduces
another error, which is that you never unlock the mutex :(

> +
> +       __set_bit(desc->slice_id, drv_data->bitmap);
> +       mutex_unlock(&drv_data->lock);
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
> +
> +       mutex_lock(&drv_data->lock);
> +       if (!test_bit(desc->slice_id, drv_data->bitmap)) {
> +               mutex_unlock(&drv_data->lock);
> +               return 0;
> +       }
> +       act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE <<
ACT_CTRL_OPCODE_SHIFT;
> +
> +       ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
> +                                 ACTIVATE);
> +       if (ret)
> +               return ret;

Same here, mutex left locked.

> +
> +       __clear_bit(desc->slice_id, drv_data->bitmap);
> +       mutex_unlock(&drv_data->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_deactivate);
> +
> +/**
> + * llcc_get_slice_id - return the slice id
> + * @desc: Pointer to llcc slice descriptor
> + */
> +int llcc_get_slice_id(struct llcc_slice_desc *desc)
> +{
> +       return desc->slice_id;
> +}
> +EXPORT_SYMBOL_GPL(llcc_get_slice_id);
> +
> +/**
> + * llcc_get_slice_size - return the slice id
> + * @desc: Pointer to llcc slice descriptor
> + */
> +size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
> +{
> +       return desc->slice_size;
> +}
> +EXPORT_SYMBOL_GPL(llcc_get_slice_size);
> +
> +static int qcom_llcc_cfg_program(struct platform_device *pdev)
> +{
> +       int i;
> +       u32 attr1_cfg;
> +       u32 attr0_cfg;
> +       u32 attr1_val;
> +       u32 attr0_val;
> +       u32 max_cap_cacheline;
> +       u32 sz;
> +       int ret = 0;
> +       const struct llcc_slice_config *llcc_table;
> +       struct llcc_slice_desc desc;
> +       u32 bcast_off = drv_data->bcast_off;
> +
> +       sz = drv_data->cfg_size;
> +       llcc_table = drv_data->cfg;
> +
> +       for (i = 0; i < sz; i++) {
> +               attr1_cfg = bcast_off +
> +
LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
> +               attr0_cfg = bcast_off +
> +
LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
> +
> +               attr1_val = llcc_table[i].cache_mode;
> +               attr1_val |= llcc_table[i].probe_target_ways <<
> +                               ATTR1_PROBE_TARGET_WAYS_SHIFT;
> +               attr1_val |= llcc_table[i].fixed_size <<
> +                               ATTR1_FIXED_SIZE_SHIFT;
> +               attr1_val |= llcc_table[i].priority <<
ATTR1_PRIORITY_SHIFT;
> +
> +               max_cap_cacheline =
MAX_CAP_TO_BYTES(llcc_table[i].max_cap);
> +
> +               /* LLCC instances can vary for each target.
> +                * The SW writes to broadcast register which gets
propagated
> +                * to each llcc instace (llcc0,.. llccN).
> +                * Since the size of the memory is divided equally
amongst the
> +                * llcc instances, we need to configure the max cap
accordingly.
> +                */
> +               max_cap_cacheline = max_cap_cacheline /
drv_data->num_banks;
> +               max_cap_cacheline >>= CACHE_LINE_SIZE_SHIFT;
> +               attr1_val |= max_cap_cacheline << ATTR1_MAX_CAP_SHIFT;
> +
> +               attr0_val = llcc_table[i].res_ways & ATTR0_RES_WAYS_MASK;
> +               attr0_val |= llcc_table[i].bonus_ways <<
ATTR0_BONUS_WAYS_SHIFT;
> +
> +               ret = regmap_write(drv_data->regmap, attr1_cfg,
attr1_val);
> +               if (ret)
> +                       return ret;
> +               ret = regmap_write(drv_data->regmap, attr0_cfg,
attr0_val);
> +               if (ret)
> +                       return ret;
> +               if (llcc_table[i].activate_on_init) {
> +                       desc.slice_id = llcc_table[i].slice_id;
> +                       ret = llcc_slice_activate(&desc);
> +               }
> +       }
> +       return ret;
> +}
> +
> +int qcom_llcc_probe(struct platform_device *pdev,
> +                     const struct llcc_slice_config *llcc_cfg, u32 sz)
> +{
> +
> +       u32 num_banks = 0;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       void __iomem *base;
> +       int ret = 0;
> +       int i;
> +
> +       drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
> +       if (!drv_data)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       drv_data->regmap = devm_regmap_init_mmio(dev, base,
> +                                       &llcc_regmap_config);
> +       if (IS_ERR(drv_data->regmap))
> +               return PTR_ERR(drv_data->regmap);
> +
> +       ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
> +                                               &num_banks);
> +       if (ret)
> +               return ret;
> +
> +       num_banks &= LLCC_LB_CNT_MASK;
> +       num_banks >>= LLCC_LB_CNT_SHIFT;
> +       drv_data->num_banks = num_banks;
> +
> +       ret = of_property_read_u32(pdev->dev.of_node, "max-slices",
> +                                 &drv_data->max_slices);
> +       if (ret)
> +               return ret;
> +

The way this driver is written, there is only one sane value for
max-slices, and it can be derived by finding the max slice_id in llcc_cfg.
You only use "max-slices" to size the bitmap, but then use the slice_id
everywhere when indexing into the bitmap, so as far as I can tell this DT
property is not needed. Can we remove it from the binding and just derive
the value by iterating over llcc_cfg to find the max slice_id?

-Evan
