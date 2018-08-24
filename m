Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1E2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E67208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gB/96pJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E67208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHXTrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:47:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39712 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeHXTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:47:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3-v6so3598109pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=4IkTW6mkPu3UmFz59qB+JCmby0Kdk6luI5P07pHpZT8=;
        b=gB/96pJsaBT92Iv9wFl6HZQfaM3VtKe/vdp2067zFdtZeAQisvNNZ4muVCI5VkrG04
         g+5iIyQDy2SxVqx3ilFhTWdF6ILbxMGFXFRBJRXLReeb1pYgv/NZNG67ALhA5c1ptApg
         w/RwmE/XoAHS/L6yu95a8knFDHomKQH1rVocc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=4IkTW6mkPu3UmFz59qB+JCmby0Kdk6luI5P07pHpZT8=;
        b=Z7mVtz/ihJZm/ciNrXFUpjuthxRNlo2d1iWYPRnujYlwa39W40ZuVwsDiYEsoMrp3z
         9YF8Vf9A4ZsqvJIxXhcy6spRE4rHNwS1ZDR/zVpo/UijQKa8+BJ3x+A1BKfSl7EfJQ6Z
         o5Woc7Kp3D3yG5kyFmdmHxWCsDZtEFuK1GIFbpK5yhxwUQEpvb67cI+SunzP9WfccJVc
         d+c5+ogrnwEqzckXZOJYsk59qaIbmkFzEInTOdDxdsvD3waw7GeIDq8WOAoKSQ/yEeOH
         vXWP8Txc3qaXtZvkMDjFIp+zZD6VZBlQpykCqexG7tIqn3wTyELfnv0i2mYFqP0M5Q4S
         qx7g==
X-Gm-Message-State: APzg51CAm4THPpv0CnkjcaZmzUpytxCkJl7sVVGJUieb4SXQWEsZfeIz
        Cx3GH3B23kFPPkRzPDmmK7TX8TV99PmsHg==
X-Google-Smtp-Source: ANB0VdZxD7Y/bmPF3v2Int0DoGht3hmKwhdsVzs4wL+ByetfVb3qtzGG3FOgTQZ1jojaia7RmkkBeA==
X-Received: by 2002:a62:2c91:: with SMTP id s139-v6mr2638246pfs.3.1535127110533;
        Fri, 24 Aug 2018 09:11:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 84-v6sm16887970pfj.33.2018.08.24.09.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 09:11:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        bp@alien8.de, ckadabi@codeaurora.org, devicetree@vger.kernel.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, rishabhb@codeaurora.org, robh+dt@kernel.org,
        robh@kernel.org, tsoni@codeaurora.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1534550915-18230-4-git-send-email-vnkgutta@codeaurora.org>
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-4-git-send-email-vnkgutta@codeaurora.org>
Message-ID: <153512710906.28926.10438185172171294721@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/4] drivers: edac: Add EDAC driver support for QCOM SoCs
Date:   Fri, 24 Aug 2018 09:11:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Venkata Narendra Kumar Gutta (2018-08-17 17:08:34)
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 57304b2..da8f150 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -460,4 +460,32 @@ config EDAC_TI
>           Support for error detection and correction on the
>            TI SoCs.
>  =

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
> +         For debugging issues having to do with stability and overall sy=
stem
> +          health, you should probably say 'Y' here.
> +
> +config EDAC_QCOM_LLCC_PANIC_ON_UE
> +       bool "Panic on uncorrectable errors - qcom llcc"

Why isn't this a generic option for all EDAC?

> +       depends on EDAC_QCOM_LLCC
> +       help
> +         Forcibly cause a kernel panic if an uncorrectable error (UE) is
> +         detected. This can reduce debugging times on hardware which may=
 be
> +         operating at voltages or frequencies outside normal specificati=
on.
> +
> +         For production builds, you should probably say 'N' here.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 02b43a7..716096d 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -77,3 +77,4 @@ obj-$(CONFIG_EDAC_ALTERA)             +=3D altera_edac.o
>  obj-$(CONFIG_EDAC_SYNOPSYS)            +=3D synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)               +=3D xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)                  +=3D ti_edac.o
> +obj-$(CONFIG_EDAC_QCOM)                        +=3D qcom_edac.o

Maybe put this in sort of alphabetical order so conflicts don't happen.

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

Used? Maybe it should just be linux/of.h

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/smp.h>

Why?

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
> +#define TRP_ECC_SB_ERR_SYN0             0x0002304C
> +#define TRP_ECC_DB_ERR_SYN0             0x00020370
> +#define DRP_ECC_SB_ERR_SYN0             0x0004204C
> +#define DRP_ECC_DB_ERR_SYN0             0x00042070
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
> +       LLCC_DRAM_CE =3D 0,
> +       LLCC_DRAM_UE,
> +       LLCC_TRAM_CE,
> +       LLCC_TRAM_UE,
> +       LLCC_ERR_TYPE_MAX =3D LLCC_TRAM_UE + 1,

What's the point?

> +};
> +
> +static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
> +{
> +       u32 sb_err_threshold;
> +       int ret;
> +
> +       /* Enable TRP in instance 2 of common interrupt enable register */

What is TRP?

> +       ret =3D regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENA=
BLE,
> +                                TRP0_INTERRUPT_ENABLE,
> +                                TRP0_INTERRUPT_ENABLE);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable ECC interrupts on Tag Ram */
> +       ret =3D regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENA=
BLE,
> +                                SB_DB_TRP_INTERRUPT_ENABLE,
> +                                SB_DB_TRP_INTERRUPT_ENABLE);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable SB error for Data RAM */

SB is single bit?

> +       sb_err_threshold =3D (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SH=
IFT);
> +       ret =3D regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
> +                          sb_err_threshold);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable DRP in instance 2 of common interrupt enable register */

DRP is double bit?

> +       ret =3D regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENA=
BLE,
> +                                DRP0_INTERRUPT_ENABLE,
> +                                DRP0_INTERRUPT_ENABLE);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable ECC interrupts on Data Ram */
> +       ret =3D regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
> +                          SB_DB_DRP_INTERRUPT_ENABLE);
> +       return ret;
> +}
> +
> +/* Clear the error interrupt and counter registers */
> +static int
> +qcom_llcc_clear_errors_status(int err_type, struct llcc_drv_data *drv)
> +{
> +       int ret =3D 0;
> +
> +       switch (err_type) {
> +       case LLCC_DRAM_CE:
> +       case LLCC_DRAM_UE:
> +               /* Clear the interrupt */
> +               ret =3D regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLE=
AR,
> +                                  DRP_TRP_INT_CLEAR);
> +               if (ret)
> +                       return ret;
> +
> +               /* Clear the counters */

A lot of these comments are just saying what the register write is doing
which is fairly obvious from the register names. Can you remove these
obvious comments?

> +               ret =3D regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNT=
R_CLEAR,
> +                                  DRP_TRP_CNT_CLEAR);
> +               if (ret)
> +                       return ret;
> +               break;
> +       case LLCC_TRAM_CE:
> +       case LLCC_TRAM_UE:
> +               ret =3D regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_C=
LEAR,
> +                                  DRP_TRP_INT_CLEAR);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNT=
R_CLEAR,
> +                                  DRP_TRP_CNT_CLEAR);
> +               if (ret)
> +                       return ret;
> +               break;
> +       }
> +       return ret;
> +}
> +
> +/* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
> +static int
> +dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
> +{
> +       struct llcc_edac_reg_data *reg_data =3D &(drv->edac_reg[err_type]=
);

const? Also, drop the useless parenthesis.

> +       int err_cnt, err_ways, ret, i;
> +       u32 synd_reg, synd_val;
> +
> +       for (i =3D 0; i < reg_data->reg_cnt; i++) {
> +               synd_reg =3D reg_data->synd_reg + (i * 4);
> +               ret =3D regmap_read(drv->regmap, drv->offsets[bank] + syn=
d_reg,
> +                                 &synd_val);
> +               if (ret)
> +                       goto clear;
> +               edac_printk(KERN_CRIT, EDAC_LLCC, "%s: ECC_SYN%d: 0x%8x\n=
",
> +                           reg_data->err_name, i, synd_val);
> +       }
> +
> +       ret =3D regmap_read(drv->regmap,
> +                         drv->offsets[bank] + reg_data->err_status_reg,
> +                         &err_cnt);
> +       if (ret)
> +               goto clear;
> +
> +       err_cnt &=3D reg_data->err_count_mask;
> +       err_cnt >>=3D reg_data->err_count_shift;
> +       edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error count: 0x%4x\n",
> +                   reg_data->err_name, err_cnt);
> +
> +       ret =3D regmap_read(drv->regmap,
> +                         drv->offsets[bank] + reg_data->err_ways_status,
> +                         &err_ways);
> +       if (ret)
> +               goto clear;
> +
> +       err_ways &=3D reg_data->err_ways_mask;
> +       err_ways >>=3D reg_data->err_ways_shift;
> +
> +       edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error ways: 0x%4x\n",
> +                   reg_data->err_name, err_ways);
> +
> +clear:
> +       ret =3D qcom_llcc_clear_errors_status(err_type, drv);
> +       return ret;

Just 'return qcom_llcc_clear_errors_status(...)'

> +}
> +
> +static int
> +dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 ba=
nk)
> +{
> +       struct llcc_drv_data *drv =3D edev_ctl->pvt_info;
> +       int ret =3D 0;

Please don't assign local variables at the start of a function and then
reassign them again immediately after. It hides initialization problems.

> +
> +       ret =3D dump_syn_reg_values(drv, bank, err_type);
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
> +                                     "LLCC Data RAM uncorrectable Error"=
);
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
> +       irqreturn_t irq_rc =3D IRQ_NONE;
> +       u32 drp_error, trp_error, i;
> +       struct llcc_drv_data *drv;
> +       int ret;
> +
> +       edac_dev_ctl =3D (struct edac_device_ctl_info *)edev_ctl;

Remove useless cast please.

> +       drv =3D edac_dev_ctl->pvt_info;
> +
> +       for (i =3D 0; i < drv->num_banks; i++) {
> +               /* Look for Data RAM errors */
> +               ret =3D regmap_read(drv->regmap,
> +                                 drv->offsets[i] + DRP_INTERRUPT_STATUS,
> +                                 &drp_error);
> +               if (ret)
> +                       return irq_rc;
> +
> +               if (drp_error & SB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Single Bit Error detected in Data Ra=
m\n");
> +                       ret =3D dump_syn_reg(edev_ctl, LLCC_DRAM_CE, i);
> +                       if (!ret)
> +                               irq_rc =3D IRQ_HANDLED;

Rename 'irq_rc' to 'handled' and make it a bool and then break from all
these 'return irq_rc' places and 'if (handled) return IRQ_HANDLED;
return IRQ_NONE;' at the end of this function so we have one exit point
from the irq handler.

> +               } else if (drp_error & DB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Double Bit Error detected in Data Ra=
m\n");
> +                       ret =3D dump_syn_reg(edev_ctl, LLCC_DRAM_UE, i);
> +                       if (!ret)
> +                               irq_rc =3D IRQ_HANDLED;
> +               }
> +
> +               /* Look for Tag RAM errors */
> +               ret =3D regmap_read(drv->regmap,
> +                                 drv->offsets[i] + TRP_INTERRUPT_0_STATU=
S,
> +                                 &trp_error);
> +               if (ret)
> +                       return irq_rc;
> +
> +               if (trp_error & SB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Single Bit Error detected in Tag Ram=
\n");
> +                       ret =3D dump_syn_reg(edev_ctl, LLCC_TRAM_CE, i);
> +                       if (!ret)
> +                               irq_rc =3D IRQ_HANDLED;
> +               } else if (trp_error & DB_ECC_ERROR) {
> +                       edac_printk(KERN_CRIT, EDAC_LLCC,
> +                                   "Double Bit Error detected in Tag Ram=
\n");
> +                       ret =3D dump_syn_reg(edev_ctl, LLCC_TRAM_UE, i);
> +                       if (!ret)
> +                               irq_rc =3D IRQ_HANDLED;
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
> +       reg_data =3D &edac_reg[LLCC_DRAM_CE];
> +       reg_data->err_name =3D "DRAM Single-bit";
> +       reg_data->reg_cnt =3D DRP_SYN_REG_CNT;
> +       reg_data->synd_reg =3D DRP_ECC_SB_ERR_SYN0;
> +       reg_data->err_status_reg =3D DRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask =3D ECC_SB_ERR_COUNT_MASK;
> +       reg_data->err_count_shift =3D ECC_SB_ERR_COUNT_SHIFT;
> +       reg_data->err_ways_status =3D DRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask =3D ECC_SB_ERR_WAYS_MASK;
> +
> +       /* Initialize register info for LLCC_DRAM_UE */
> +       reg_data =3D &edac_reg[LLCC_DRAM_UE];
> +       reg_data->err_name =3D "DRAM Double-bit";
> +       reg_data->reg_cnt =3D DRP_SYN_REG_CNT;
> +       reg_data->synd_reg =3D DRP_ECC_DB_ERR_SYN0;
> +       reg_data->err_status_reg =3D DRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask =3D ECC_DB_ERR_COUNT_MASK;
> +       reg_data->err_ways_status =3D DRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask =3D ECC_DB_ERR_WAYS_MASK;
> +       reg_data->err_ways_shift =3D ECC_DB_ERR_WAYS_SHIFT;
> +
> +       /* Initialize register info for LLCC_TRAM_CE */
> +       reg_data =3D &edac_reg[LLCC_TRAM_CE];
> +       reg_data->err_name =3D "TRAM Single-bit";
> +       reg_data->reg_cnt =3D TRP_SYN_REG_CNT;
> +       reg_data->synd_reg =3D TRP_ECC_SB_ERR_SYN0;
> +       reg_data->err_status_reg =3D TRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask =3D ECC_SB_ERR_COUNT_MASK;
> +       reg_data->err_count_shift =3D ECC_SB_ERR_COUNT_SHIFT;
> +       reg_data->err_ways_status =3D TRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask =3D ECC_SB_ERR_WAYS_MASK;
> +
> +       /* Initialize register info for LLCC_TRAM_UE */
> +       reg_data =3D &edac_reg[LLCC_TRAM_UE];
> +       reg_data->err_name =3D "TRAM Double-bit";
> +       reg_data->reg_cnt =3D TRP_SYN_REG_CNT;
> +       reg_data->synd_reg =3D TRP_ECC_DB_ERR_SYN0;
> +       reg_data->err_status_reg =3D TRP_ECC_ERROR_STATUS1;
> +       reg_data->err_count_mask =3D ECC_DB_ERR_COUNT_MASK;
> +       reg_data->err_ways_status =3D TRP_ECC_ERROR_STATUS0;
> +       reg_data->err_ways_mask =3D ECC_DB_ERR_WAYS_MASK;
> +       reg_data->err_ways_shift =3D ECC_DB_ERR_WAYS_SHIFT;

Why can't these things be a static const array that the driver looks up
in? What's the point of it being per-device instance?

> +}
> +
> +static int qcom_llcc_edac_probe(struct platform_device *pdev)
> +{
> +       struct llcc_drv_data *llcc_driv_data =3D pdev->dev.platform_data;
> +       struct edac_device_ctl_info *edev_ctl;
> +       struct device *dev =3D &pdev->dev;
> +       int ecc_irq;
> +       int rc;
> +
> +       /* Initialize register set for the error types*/
> +       llcc_driv_data->edac_reg =3D devm_kcalloc(dev, LLCC_ERR_TYPE_MAX,
> +                                       sizeof(struct llcc_edac_reg_data),
> +                                       GFP_KERNEL);
> +       llcc_edac_reg_data_init(llcc_driv_data->edac_reg);
> +
> +       rc =3D qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
> +       if (rc)
> +               return rc;
> +
> +       /* Allocate edac control info */
> +       edev_ctl =3D edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
> +                                             llcc_driv_data->num_banks, =
1,
> +                                             NULL, 0,
> +                                             edac_device_alloc_index());
> +
> +       if (!edev_ctl)
> +               return -ENOMEM;
> +
> +       edev_ctl->dev =3D dev;
> +       edev_ctl->mod_name =3D dev_name(dev);
> +       edev_ctl->dev_name =3D dev_name(dev);
> +       edev_ctl->ctl_name =3D "llcc";
> +       edev_ctl->panic_on_ue =3D LLCC_ERP_PANIC_ON_UE;
> +       edev_ctl->pvt_info =3D llcc_driv_data;
> +
> +       rc =3D edac_device_add_device(edev_ctl);
> +       if (rc)
> +               goto out_mem;
> +
> +       platform_set_drvdata(pdev, edev_ctl);
> +
> +       /* Request for ecc irq */
> +       ecc_irq =3D llcc_driv_data->ecc_irq;
> +       if (ecc_irq < 0) {
> +               rc =3D -ENODEV;

Return error code from platform_get_irq()? Oh, that's weird. Why is some
other driver getting and storing the irq away? Hopefully it isn't a
shared IRQ.

> +               goto out_dev;
> +       }
> +       rc =3D devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
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
> +       struct edac_device_ctl_info *edev_ctl =3D dev_get_drvdata(&pdev->=
dev);
> +
> +       edac_device_del_device(edev_ctl->dev);
> +       edac_device_free_ctl_info(edev_ctl);
> +       platform_set_drvdata(pdev, NULL);

No need. Don't set platform data to NULL.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id qcom_llcc_edac_match_table[] =3D {
> +#ifdef EDAC_QCOM_LLCC

Huh? Shouldn't this driver only be compiled when this config is enabled?

> +       { .compatible =3D "qcom,llcc-edac" },
> +#endif
> +       { },
> +};
> +
> +static struct platform_driver qcom_llcc_edac_driver =3D {
> +       .probe =3D qcom_llcc_edac_probe,
> +       .remove =3D qcom_llcc_edac_remove,
> +       .driver =3D {
> +               .name =3D "qcom_llcc_edac",
> +               .of_match_table =3D qcom_llcc_edac_match_table,
> +       },
> +};
> +module_platform_driver(qcom_llcc_edac_driver);
> +
> +MODULE_DESCRIPTION("QCOM EDAC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/=
llcc-qcom.h
> index 2e4b34d..25096e0 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -84,6 +84,7 @@ struct llcc_drv_data {
>         struct regmap *regmap;
>         struct regmap *bcast_regmap;
>         const struct llcc_slice_config *cfg;
> +       struct llcc_edac_reg_data *edac_reg;

Why a pointer instead of an array of proper size?

>         struct mutex lock;
>         u32 cfg_size;
>         u32 max_slices;
> @@ -93,6 +94,30 @@ struct llcc_drv_data {
>         int ecc_irq;
>  };
>  =

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

Just name instead?

> +       int reg_cnt;
> +       int synd_reg;
> +       int err_status_reg;
> +       int err_count_mask;
> +       int err_count_shift;
> +       int err_ways_status;
> +       int err_ways_mask;
> +       int err_ways_shift;

Do any of these need to be signed types? Use u8 for register offsets and
shifts, u32 for masks and unsigned ints for counts please.

> +};
