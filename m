Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5493C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B29208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Juhl1FlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B29208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeHXCgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:36:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34001 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeHXCgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:36:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id g9-v6so5331685lfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ym/jGvGGu/z3KmByt9dd2IFm3ejIddgJhSJtNJS9sKw=;
        b=Juhl1FlCoRjA2QwBS8lJdH1WNKx9PsNwqPQiGqvH1cMwMB2vR7HwvV1Ssyaxz7u3Om
         Yxmm5ouaEucJ3gHv8h9z1LMzK4xYfEXRKc65qfscnlYKKvNVHVjYrPoTLhJRVFrJLeKP
         +wHYZqtQdvUOEj0zuYMVK7J8Xs/53Nvwf/EME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ym/jGvGGu/z3KmByt9dd2IFm3ejIddgJhSJtNJS9sKw=;
        b=iiEXw5UGlK9oAyPz1WuRXsNjE7lJswwsDXO0hYCeoLMAKWlVKBJB25YPQEJLUH0BR0
         axUt3bPJOnnp7cCGxSIBzeC4sTArqAK7qAkj0wDv8VrCJ4IRdQuBAjrCYxd7PpkbAy/V
         dIX0JPnS5Rk4+951TbIZBbGuWeLvF6M+D/OBSStFim1R36z/P7lH+PmG9nXNvBo5zzZf
         ZDJH8asifmTCrM70++PCZrSyd/5hXz5K9QoiePMVHOo31YRkznGJXNjmTB3dMzCFMswy
         PU1f3OJ9hHMn2YcR3PIuTJBq3QOJQLP1DbKh5wnppqIiKrCHA0TSQbU5LwJjjJiK37bj
         tXBw==
X-Gm-Message-State: AOUpUlFoc0h+LcSBbdUTc34AM+4x1L5HPHsUGW96XP6r9WBsw+JKLOkt
        DiPyPp++23DMurAicZrbeaqgimDUQ5I=
X-Google-Smtp-Source: AA+uWPwfEWyhxUG0tk48JuaKCCSC4+X0TZEHkN4WWT+SMfQWJcVkTNsxY7fV+lJdoaGviRY9LXakqA==
X-Received: by 2002:a19:4a09:: with SMTP id x9-v6mr21940658lfa.80.1535065481912;
        Thu, 23 Aug 2018 16:04:41 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r22-v6sm930492ljh.22.2018.08.23.16.04.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:04:40 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id m84-v6so5412996lje.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:04:40 -0700 (PDT)
X-Received: by 2002:a2e:89c5:: with SMTP id c5-v6mr18852113ljk.19.1535065480399;
 Thu, 23 Aug 2018 16:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org> <1534550915-18230-4-git-send-email-vnkgutta@codeaurora.org>
In-Reply-To: <1534550915-18230-4-git-send-email-vnkgutta@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Aug 2018 16:04:03 -0700
X-Gmail-Original-Message-ID: <CAE=gft4vheqe9Yqb3H_gMChUmQqvmBeeWvKWCf_j4sWrFceFiQ@mail.gmail.com>
Message-ID: <CAE=gft4vheqe9Yqb3H_gMChUmQqvmBeeWvKWCf_j4sWrFceFiQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drivers: edac: Add EDAC driver support for QCOM SoCs
To:     vnkgutta@codeaurora.org
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 5:08 PM Venkata Narendra Kumar Gutta
<vnkgutta@codeaurora.org> wrote:
>
> From: Channagoud Kadabi <ckadabi@codeaurora.org>
>
> Add error reporting driver for Single Bit Errors (SBEs) and Double Bit
> Errors (DBEs). As of now, this driver supports erp for Last Level Cache
> Controller (LLCC). This driver takes care of dumping registers and adding
> config options to enable and disable panic when the errors happen in cache.
>
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Co-developed-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  MAINTAINERS                        |   8 +
>  drivers/edac/Kconfig               |  28 +++
>  drivers/edac/Makefile              |   1 +
>  drivers/edac/qcom_edac.c           | 446 +++++++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/llcc-qcom.h |  25 +++
>  5 files changed, 508 insertions(+)
>  create mode 100644 drivers/edac/qcom_edac.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a23427..0bff713 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5227,6 +5227,14 @@ L:       linux-edac@vger.kernel.org
>  S:     Maintained
>  F:     drivers/edac/ti_edac.c
>
> +EDAC-QUALCOMM
> +M:     Channagoud Kadabi <ckadabi@codeaurora.org>
> +M:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> +L:     linux-arm-msm@vger.kernel.org
> +L:     linux-edac@vger.kernel.org
> +S:     Maintained
> +F:     drivers/edac/qcom_edac.c
> +
>  EDIROL UA-101/UA-1000 DRIVER
>  M:     Clemens Ladisch <clemens@ladisch.de>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 57304b2..da8f150 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -460,4 +460,32 @@ config EDAC_TI
>           Support for error detection and correction on the
>            TI SoCs.
>
> +config EDAC_QCOM
> +       tristate "QCOM EDAC Controller"
> +       depends on EDAC
> +       help
> +         Support for error detection and correction on the
> +         QCOM SoCs.
> +
> +config EDAC_QCOM_LLCC
> +       tristate "QCOM EDAC Controller for LLCC Cache"
> +       depends on EDAC_QCOM && QCOM_LLCC
> +       help
> +         Support for error detection and correction on the
> +         QCOM LLCC cache. Report errors caught by LLCC ECC
> +         mechanism.
> +
> +         For debugging issues having to do with stability and overall system
> +          health, you should probably say 'Y' here.
> +
> +config EDAC_QCOM_LLCC_PANIC_ON_UE
> +       bool "Panic on uncorrectable errors - qcom llcc"
> +       depends on EDAC_QCOM_LLCC
> +       help
> +         Forcibly cause a kernel panic if an uncorrectable error (UE) is
> +         detected. This can reduce debugging times on hardware which may be
> +         operating at voltages or frequencies outside normal specification.
> +
> +         For production builds, you should probably say 'N' here.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 02b43a7..716096d 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -77,3 +77,4 @@ obj-$(CONFIG_EDAC_ALTERA)             += altera_edac.o
>  obj-$(CONFIG_EDAC_SYNOPSYS)            += synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)               += xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)                  += ti_edac.o
> +obj-$(CONFIG_EDAC_QCOM)                        += qcom_edac.o
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> new file mode 100644
> index 0000000..9a8c670
> --- /dev/null
> +++ b/drivers/edac/qcom_edac.c
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/edac.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/smp.h>
> +#include <linux/soc/qcom/llcc-qcom.h>
> +
> +#include "edac_mc.h"
> +#include "edac_device.h"
> +
> +#ifdef CONFIG_EDAC_QCOM_LLCC_PANIC_ON_UE
> +#define LLCC_ERP_PANIC_ON_UE            1
> +#else
> +#define LLCC_ERP_PANIC_ON_UE            0
> +#endif
> +
> +#define EDAC_LLCC                       "qcom_llcc"
> +
> +#define TRP_SYN_REG_CNT                 6
> +
> +#define DRP_SYN_REG_CNT                 8
> +
> +#define LLCC_COMMON_STATUS0             0x0003000C
> +#define LLCC_LB_CNT_MASK                GENMASK(31, 28)
> +#define LLCC_LB_CNT_SHIFT               28
> +
> +/* single & Double Bit syndrome register offsets */

Strange capitalization going on here.

> +#define TRP_ECC_SB_ERR_SYN0             0x0002304C
> +#define TRP_ECC_DB_ERR_SYN0             0x00020370
> +#define DRP_ECC_SB_ERR_SYN0             0x0004204C
> +#define DRP_ECC_DB_ERR_SYN0             0x00042070

I think the convention is to use lowercase hex everywhere.

> +
> +/* Error register offsets */
> +#define TRP_ECC_ERROR_STATUS1           0x00020348
> +#define TRP_ECC_ERROR_STATUS0           0x00020344
> +#define DRP_ECC_ERROR_STATUS1           0x00042048
> +#define DRP_ECC_ERROR_STATUS0           0x00042044
> +
> +/* TRP, DRP interrupt register offsets */
> +#define DRP_INTERRUPT_STATUS            0x00041000
> +#define TRP_INTERRUPT_0_STATUS          0x00020480
> +#define DRP_INTERRUPT_CLEAR             0x00041008
> +#define DRP_ECC_ERROR_CNTR_CLEAR        0x00040004
> +#define TRP_INTERRUPT_0_CLEAR           0x00020484
> +#define TRP_ECC_ERROR_CNTR_CLEAR        0x00020440
> +
> +/* Mask and shift macros */
> +#define ECC_DB_ERR_COUNT_MASK           GENMASK(4, 0)
> +#define ECC_DB_ERR_WAYS_MASK            GENMASK(31, 16)
> +#define ECC_DB_ERR_WAYS_SHIFT           BIT(4)
> +
> +#define ECC_SB_ERR_COUNT_MASK           GENMASK(23, 16)
> +#define ECC_SB_ERR_COUNT_SHIFT          BIT(4)
> +#define ECC_SB_ERR_WAYS_MASK            GENMASK(15, 0)
> +
> +#define SB_ECC_ERROR                    BIT(0)
> +#define DB_ECC_ERROR                    BIT(1)
> +
> +#define DRP_TRP_INT_CLEAR               GENMASK(1, 0)
> +#define DRP_TRP_CNT_CLEAR               GENMASK(1, 0)
> +
> +/* Config registers offsets*/
> +#define DRP_ECC_ERROR_CFG               0x00040000
> +
> +/* TRP, DRP interrupt register offsets */
> +#define CMN_INTERRUPT_0_ENABLE          0x0003001C
> +#define CMN_INTERRUPT_2_ENABLE          0x0003003C
> +#define TRP_INTERRUPT_0_ENABLE          0x00020488
> +#define DRP_INTERRUPT_ENABLE            0x0004100C
> +
> +#define SB_ERROR_THRESHOLD              0x1
> +#define SB_ERROR_THRESHOLD_SHIFT        24
> +#define SB_DB_TRP_INTERRUPT_ENABLE      0x3
> +#define TRP0_INTERRUPT_ENABLE           0x1
> +#define DRP0_INTERRUPT_ENABLE           BIT(6)
> +#define SB_DB_DRP_INTERRUPT_ENABLE      0x3
> +
> +enum {
> +       LLCC_DRAM_CE = 0,
> +       LLCC_DRAM_UE,
> +       LLCC_TRAM_CE,
> +       LLCC_TRAM_UE,
> +       LLCC_ERR_TYPE_MAX = LLCC_TRAM_UE + 1,

This is a nit, or perhaps personal preference, but I prefer to not
have initializers for sentinel values, since it's one more thing
someone could forget to update when adding new values.

> +};
> +
> +static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
> +{
> +       u32 sb_err_threshold;
> +       int ret;
> +
> +       /* Enable TRP in instance 2 of common interrupt enable register */

Can we get a comment explaining what's so special about instance 2?
Instances 1 and 3 get no love?

> +       ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
> +                                TRP0_INTERRUPT_ENABLE,
> +                                TRP0_INTERRUPT_ENABLE);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable ECC interrupts on Tag Ram */
> +       ret = regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENABLE,
> +                                SB_DB_TRP_INTERRUPT_ENABLE,
> +                                SB_DB_TRP_INTERRUPT_ENABLE);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable SB error for Data RAM */
> +       sb_err_threshold = (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SHIFT);
> +       ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
> +                          sb_err_threshold);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable DRP in instance 2 of common interrupt enable register */
> +       ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
> +                                DRP0_INTERRUPT_ENABLE,
> +                                DRP0_INTERRUPT_ENABLE);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable ECC interrupts on Data Ram */
> +       ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
> +                          SB_DB_DRP_INTERRUPT_ENABLE);
> +       return ret;
> +}
> +
> +/* Clear the error interrupt and counter registers */
> +static int
> +qcom_llcc_clear_errors_status(int err_type, struct llcc_drv_data *drv)

Another nit: errors_status is kind of weird. Maybe
qcom_llcc_clear_errors or qcom_llcc_clear_error_status?

> +{
> +       int ret = 0;
> +
> +       switch (err_type) {
> +       case LLCC_DRAM_CE:
> +       case LLCC_DRAM_UE:
> +               /* Clear the interrupt */
> +               ret = regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLEAR,
> +                                  DRP_TRP_INT_CLEAR);
> +               if (ret)
> +                       return ret;
> +
> +               /* Clear the counters */
> +               ret = regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNTR_CLEAR,
> +                                  DRP_TRP_CNT_CLEAR);
> +               if (ret)
> +                       return ret;
> +               break;
> +       case LLCC_TRAM_CE:
> +       case LLCC_TRAM_UE:
> +               ret = regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_CLEAR,
> +                                  DRP_TRP_INT_CLEAR);
> +               if (ret)
> +                       return ret;
> +
> +               ret = regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNTR_CLEAR,
> +                                  DRP_TRP_CNT_CLEAR);
> +               if (ret)
> +                       return ret;
> +               break;

A default case that errors or complains or both would be nice.

> +       }
> +       return ret;
> +}
> +
> +/* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
> +static int
> +dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
> +{
> +       struct llcc_edac_reg_data *reg_data = &(drv->edac_reg[err_type]);
> +       int err_cnt, err_ways, ret, i;
> +       u32 synd_reg, synd_val;
> +
> +       for (i = 0; i < reg_data->reg_cnt; i++) {
> +               synd_reg = reg_data->synd_reg + (i * 4);
> +               ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
> +                                 &synd_val);
> +               if (ret)
> +                       goto clear;
> +               edac_printk(KERN_CRIT, EDAC_LLCC, "%s: ECC_SYN%d: 0x%8x\n",
> +                           reg_data->err_name, i, synd_val);
> +       }
> +
> +       ret = regmap_read(drv->regmap,
> +                         drv->offsets[bank] + reg_data->err_status_reg,
> +                         &err_cnt);
> +       if (ret)
> +               goto clear;
> +
> +       err_cnt &= reg_data->err_count_mask;
> +       err_cnt >>= reg_data->err_count_shift;
> +       edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error count: 0x%4x\n",
> +                   reg_data->err_name, err_cnt);
> +
> +       ret = regmap_read(drv->regmap,
> +                         drv->offsets[bank] + reg_data->err_ways_status,
> +                         &err_ways);
> +       if (ret)
> +               goto clear;
> +
> +       err_ways &= reg_data->err_ways_mask;
> +       err_ways >>= reg_data->err_ways_shift;
> +
> +       edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error ways: 0x%4x\n",
> +                   reg_data->err_name, err_ways);
> +
> +clear:
> +       ret = qcom_llcc_clear_errors_status(err_type, drv);
> +       return ret;
> +}

Nice job consolidating those 4 functions down into one.

> +
> +static int
> +dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
> +{
> +       struct llcc_drv_data *drv = edev_ctl->pvt_info;
> +       int ret = 0;
> +
> +       ret = dump_syn_reg_values(drv, bank, err_type);
> +       if (ret)
> +               return ret;
> +
> +       switch (err_type) {
> +       case LLCC_DRAM_CE:
> +               edac_device_handle_ce(edev_ctl, 0, bank,
> +                                     "LLCC Data RAM correctable Error");
> +               break;
> +       case LLCC_DRAM_UE:
> +               edac_device_handle_ue(edev_ctl, 0, bank,
> +                                     "LLCC Data RAM uncorrectable Error");
> +               break;
> +       case LLCC_TRAM_CE:
> +               edac_device_handle_ce(edev_ctl, 0, bank,
> +                                     "LLCC Tag RAM correctable Error");
> +               break;
> +       case LLCC_TRAM_UE:
> +               edac_device_handle_ue(edev_ctl, 0, bank,
> +                                     "LLCC Tag RAM uncorrectable Error");
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static irqreturn_t
> +llcc_ecc_irq_handler(int irq, void *edev_ctl)
> +{
> +       struct edac_device_ctl_info *edac_dev_ctl;
> +       irqreturn_t irq_rc = IRQ_NONE;
> +       u32 drp_error, trp_error, i;
> +       struct llcc_drv_data *drv;
> +       int ret;
> +
> +       edac_dev_ctl = (struct edac_device_ctl_info *)edev_ctl;
> +       drv = edac_dev_ctl->pvt_info;
> +
> +       for (i = 0; i < drv->num_banks; i++) {
> +               /* Look for Data RAM errors */
> +               ret = regmap_read(drv->regmap,
> +                                 drv->offsets[i] + DRP_INTERRUPT_STATUS,
> +                                 &drp_error);
> +               if (ret)
> +                       return irq_rc;
> +
> +               if (drp_error & SB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Single Bit Error detected in Data Ram\n");
> +                       ret = dump_syn_reg(edev_ctl, LLCC_DRAM_CE, i);
> +                       if (!ret)
> +                               irq_rc = IRQ_HANDLED;
> +               } else if (drp_error & DB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Double Bit Error detected in Data Ram\n");
> +                       ret = dump_syn_reg(edev_ctl, LLCC_DRAM_UE, i);
> +                       if (!ret)
> +                               irq_rc = IRQ_HANDLED;
> +               }
> +
> +               /* Look for Tag RAM errors */
> +               ret = regmap_read(drv->regmap,
> +                                 drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
> +                                 &trp_error);
> +               if (ret)
> +                       return irq_rc;
> +
> +               if (trp_error & SB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Single Bit Error detected in Tag Ram\n");
> +                       ret = dump_syn_reg(edev_ctl, LLCC_TRAM_CE, i);
> +                       if (!ret)
> +                               irq_rc = IRQ_HANDLED;
> +               } else if (trp_error & DB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Double Bit Error detected in Tag Ram\n");
> +                       ret = dump_syn_reg(edev_ctl, LLCC_TRAM_UE, i);
> +                       if (!ret)
> +                               irq_rc = IRQ_HANDLED;
> +               }
> +       }
> +
> +       return irq_rc;
> +}
> +
> +static void llcc_edac_reg_data_init(struct llcc_edac_reg_data *edac_reg)
> +{
> +
> +       struct llcc_edac_reg_data *reg_data;
> +
> +       /* Initialize register info for LLCC_DRAM_CE */
> +       reg_data = &edac_reg[LLCC_DRAM_CE];
> +       reg_data->err_name = "DRAM Single-bit";
> +       reg_data->reg_cnt = DRP_SYN_REG_CNT;
> +       reg_data->synd_reg = DRP_ECC_SB_ERR_SYN0;
> +       reg_data->err_status_reg = DRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask = ECC_SB_ERR_COUNT_MASK;
> +       reg_data->err_count_shift = ECC_SB_ERR_COUNT_SHIFT;
> +       reg_data->err_ways_status = DRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask = ECC_SB_ERR_WAYS_MASK;
> +
> +       /* Initialize register info for LLCC_DRAM_UE */
> +       reg_data = &edac_reg[LLCC_DRAM_UE];
> +       reg_data->err_name = "DRAM Double-bit";
> +       reg_data->reg_cnt = DRP_SYN_REG_CNT;
> +       reg_data->synd_reg = DRP_ECC_DB_ERR_SYN0;
> +       reg_data->err_status_reg = DRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask = ECC_DB_ERR_COUNT_MASK;
> +       reg_data->err_ways_status = DRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask = ECC_DB_ERR_WAYS_MASK;
> +       reg_data->err_ways_shift = ECC_DB_ERR_WAYS_SHIFT;
> +
> +       /* Initialize register info for LLCC_TRAM_CE */
> +       reg_data = &edac_reg[LLCC_TRAM_CE];
> +       reg_data->err_name = "TRAM Single-bit";
> +       reg_data->reg_cnt = TRP_SYN_REG_CNT;
> +       reg_data->synd_reg = TRP_ECC_SB_ERR_SYN0;
> +       reg_data->err_status_reg = TRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask = ECC_SB_ERR_COUNT_MASK;
> +       reg_data->err_count_shift = ECC_SB_ERR_COUNT_SHIFT;
> +       reg_data->err_ways_status = TRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask = ECC_SB_ERR_WAYS_MASK;
> +
> +       /* Initialize register info for LLCC_TRAM_UE */
> +       reg_data = &edac_reg[LLCC_TRAM_UE];
> +       reg_data->err_name = "TRAM Double-bit";
> +       reg_data->reg_cnt = TRP_SYN_REG_CNT;
> +       reg_data->synd_reg = TRP_ECC_DB_ERR_SYN0;
> +       reg_data->err_status_reg = TRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask = ECC_DB_ERR_COUNT_MASK;
> +       reg_data->err_ways_status = TRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask = ECC_DB_ERR_WAYS_MASK;
> +       reg_data->err_ways_shift = ECC_DB_ERR_WAYS_SHIFT;

This should all just be a statically initialized const table, there's
no need to do this in code.

> +}
> +
> +static int qcom_llcc_edac_probe(struct platform_device *pdev)
> +{
> +       struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
> +       struct edac_device_ctl_info *edev_ctl;
> +       struct device *dev = &pdev->dev;
> +       int ecc_irq;
> +       int rc;
> +
> +       /* Initialize register set for the error types*/
> +       llcc_driv_data->edac_reg = devm_kcalloc(dev, LLCC_ERR_TYPE_MAX,
> +                                       sizeof(struct llcc_edac_reg_data),
> +                                       GFP_KERNEL);
> +       llcc_edac_reg_data_init(llcc_driv_data->edac_reg);
> +
> +       rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
> +       if (rc)
> +               return rc;
> +
> +       /* Allocate edac control info */
> +       edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
> +                                             llcc_driv_data->num_banks, 1,
> +                                             NULL, 0,
> +                                             edac_device_alloc_index());
> +
> +       if (!edev_ctl)
> +               return -ENOMEM;
> +
> +       edev_ctl->dev = dev;
> +       edev_ctl->mod_name = dev_name(dev);
> +       edev_ctl->dev_name = dev_name(dev);
> +       edev_ctl->ctl_name = "llcc";
> +       edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
> +       edev_ctl->pvt_info = llcc_driv_data;
> +
> +       rc = edac_device_add_device(edev_ctl);
> +       if (rc)
> +               goto out_mem;
> +
> +       platform_set_drvdata(pdev, edev_ctl);
> +
> +       /* Request for ecc irq */
> +       ecc_irq = llcc_driv_data->ecc_irq;
> +       if (ecc_irq < 0) {
> +               rc = -ENODEV;
> +               goto out_dev;
> +       }
> +       rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
> +                             IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
> +       if (rc)
> +               goto out_dev;
> +
> +       return rc;
> +
> +out_dev:
> +       edac_device_del_device(edev_ctl->dev);
> +out_mem:
> +       edac_device_free_ctl_info(edev_ctl);
> +
> +       return rc;
> +}
> +
> +static int qcom_llcc_edac_remove(struct platform_device *pdev)
> +{
> +       struct edac_device_ctl_info *edev_ctl = dev_get_drvdata(&pdev->dev);
> +
> +       edac_device_del_device(edev_ctl->dev);
> +       edac_device_free_ctl_info(edev_ctl);
> +       platform_set_drvdata(pdev, NULL);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id qcom_llcc_edac_match_table[] = {
> +#ifdef EDAC_QCOM_LLCC
> +       { .compatible = "qcom,llcc-edac" },
> +#endif
> +       { },
> +};
> +
> +static struct platform_driver qcom_llcc_edac_driver = {
> +       .probe = qcom_llcc_edac_probe,
> +       .remove = qcom_llcc_edac_remove,
> +       .driver = {
> +               .name = "qcom_llcc_edac",
> +               .of_match_table = qcom_llcc_edac_match_table,
> +       },
> +};
> +module_platform_driver(qcom_llcc_edac_driver);
> +
> +MODULE_DESCRIPTION("QCOM EDAC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 2e4b34d..25096e0 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -84,6 +84,7 @@ struct llcc_drv_data {
>         struct regmap *regmap;
>         struct regmap *bcast_regmap;
>         const struct llcc_slice_config *cfg;
> +       struct llcc_edac_reg_data *edac_reg;

This needs a comment description.

>         struct mutex lock;
>         u32 cfg_size;
>         u32 max_slices;
> @@ -93,6 +94,30 @@ struct llcc_drv_data {
>         int ecc_irq;
>  };
>
> +/**
> + * llcc_edac_reg_data - llcc edac registers data for each error type
> + * @err_name: name of the error
> + * @reg_cnt: number of registers
> + * @synd_reg: syndrome register address
> + * @err_status_reg: Status register address to read the error count
> + * @err_count_mask: Mask value to get the error count
> + * @err_count_shift: Shift value to get the error count
> + * @err_ways_status: Status register address to read error ways
> + * @err_ways_mask: Mask value to get the error ways
> + * @err_ways_shift: Shift value to get the error ways
> + */
> +struct llcc_edac_reg_data {
> +       char *err_name;
> +       int reg_cnt;
> +       int synd_reg;
> +       int err_status_reg;
> +       int err_count_mask;
> +       int err_count_shift;
> +       int err_ways_status;
> +       int err_ways_mask;
> +       int err_ways_shift;
> +};
> +
>  #if IS_ENABLED(CONFIG_QCOM_LLCC)
>  /**
>   * llcc_slice_getd - get llcc slice descriptor
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
