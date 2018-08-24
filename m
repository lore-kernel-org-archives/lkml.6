Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A70C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CFD2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DB3ISm4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CFD2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeHXXzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:55:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38229 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHXXzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:55:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so7813360ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNCKu8etep/CDaW3Kw9IbRXgKTfjL64T9Gi7/KtT/IY=;
        b=DB3ISm4xMEx3u0Q1Mba4SIHXJlb0l9B9FsjQVp2OL1gndmpR8rzE3ju49kXmr0ycwP
         Xz4OWl3RFQzz5jQbF7cjFLF7fTV4wH2O0ie+fY7MVvbgZYKxjR1sxXorBibdiE+PDamf
         8+Mvth9vsHDT6EMKyC4eTzjfgxBm51FgxvbAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNCKu8etep/CDaW3Kw9IbRXgKTfjL64T9Gi7/KtT/IY=;
        b=o64GJmSoQPnLe+7J2n6H3I0G57QFGzZ02uiU0Uz++tEU/5xYqkfiaC77GqJEcu70vs
         dLg0vFBH6Z7RPVPRt5njk/h/mLNzm5pumaQac7pLZHg0EEqkWRCv+iDrk3/+UQFgxuZD
         stJNguiJnQkkfpP2XKfWgDtaijXytCr5G0NggzwjelzMGvFhY5ToWb+NIFowPBaJOOIz
         UButnsplqMGZT2+qOv+QIjB8edOKMsRWg2ZiqVQRsTbAjnq52XfX750veSkfLnA6u1Vj
         6Qinz3Lng6f4tIU2zZzJEcVWqfTP2PMddptHHxmvw6/kcqVSjhOvN2m+jUABsiyNoSjF
         w7hw==
X-Gm-Message-State: APzg51Bhr0waMmZZ4ch0xrZZWfskgtvlLw7kBPPNeskCW8gEymKyBiGO
        yF6igTwHh5L7k0TK3dtJPzfm8uP+HCc=
X-Google-Smtp-Source: ANB0VdbqfGirtZP/aWq8stBC8SyzIMfRSXIMINT+1wzhNwaVuJmrtGbt1VyFXgti6+frFC/1KXjvpA==
X-Received: by 2002:a2e:29da:: with SMTP id p87-v6mr2217172ljp.12.1535141974159;
        Fri, 24 Aug 2018 13:19:34 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id z18-v6sm1459837lfj.89.2018.08.24.13.19.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:19:34 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f1-v6so7783858ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:19:33 -0700 (PDT)
X-Received: by 2002:a2e:1248:: with SMTP id t69-v6mr2202086lje.129.1535141973498;
 Fri, 24 Aug 2018 13:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-4-git-send-email-vnkgutta@codeaurora.org>
 <CAE=gft4vheqe9Yqb3H_gMChUmQqvmBeeWvKWCf_j4sWrFceFiQ@mail.gmail.com> <fc5ab365cc3808161294af4b1b2b6312@codeaurora.org>
In-Reply-To: <fc5ab365cc3808161294af4b1b2b6312@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 24 Aug 2018 13:18:56 -0700
X-Gmail-Original-Message-ID: <CAE=gft4ywi9+2HJVs4bjwQqo0-pMnzQzAq-WTiriLbxiPeg21g@mail.gmail.com>
Message-ID: <CAE=gft4ywi9+2HJVs4bjwQqo0-pMnzQzAq-WTiriLbxiPeg21g@mail.gmail.com>
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

On Fri, Aug 24, 2018 at 11:32 AM <vnkgutta@codeaurora.org> wrote:
>
> On 2018-08-23 16:04, Evan Green wrote:
> > On Fri, Aug 17, 2018 at 5:08 PM Venkata Narendra Kumar Gutta
> > <vnkgutta@codeaurora.org> wrote:
> >>
> >> From: Channagoud Kadabi <ckadabi@codeaurora.org>
> >>
> >> Add error reporting driver for Single Bit Errors (SBEs) and Double Bit
> >> Errors (DBEs). As of now, this driver supports erp for Last Level
> >> Cache
> >> Controller (LLCC). This driver takes care of dumping registers and
> >> adding
> >> config options to enable and disable panic when the errors happen in
> >> cache.
> >>
> >> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> >> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> >> Co-developed-by: Venkata Narendra Kumar Gutta
> >> <vnkgutta@codeaurora.org>
> >> ---
> >>  MAINTAINERS                        |   8 +
> >>  drivers/edac/Kconfig               |  28 +++
> >>  drivers/edac/Makefile              |   1 +
> >>  drivers/edac/qcom_edac.c           | 446
> >> +++++++++++++++++++++++++++++++++++++
> >>  include/linux/soc/qcom/llcc-qcom.h |  25 +++
> >>  5 files changed, 508 insertions(+)
> >>  create mode 100644 drivers/edac/qcom_edac.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 0a23427..0bff713 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -5227,6 +5227,14 @@ L:       linux-edac@vger.kernel.org
> >>  S:     Maintained
> >>  F:     drivers/edac/ti_edac.c
> >>
> >> +EDAC-QUALCOMM
> >> +M:     Channagoud Kadabi <ckadabi@codeaurora.org>
> >> +M:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> >> +L:     linux-arm-msm@vger.kernel.org
> >> +L:     linux-edac@vger.kernel.org
> >> +S:     Maintained
> >> +F:     drivers/edac/qcom_edac.c
> >> +
> >>  EDIROL UA-101/UA-1000 DRIVER
> >>  M:     Clemens Ladisch <clemens@ladisch.de>
> >>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
> >> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> >> index 57304b2..da8f150 100644
> >> --- a/drivers/edac/Kconfig
> >> +++ b/drivers/edac/Kconfig
> >> @@ -460,4 +460,32 @@ config EDAC_TI
> >>           Support for error detection and correction on the
> >>            TI SoCs.
> >>
> >> +config EDAC_QCOM
> >> +       tristate "QCOM EDAC Controller"
> >> +       depends on EDAC
> >> +       help
> >> +         Support for error detection and correction on the
> >> +         QCOM SoCs.
> >> +
> >> +config EDAC_QCOM_LLCC
> >> +       tristate "QCOM EDAC Controller for LLCC Cache"
> >> +       depends on EDAC_QCOM && QCOM_LLCC
> >> +       help
> >> +         Support for error detection and correction on the
> >> +         QCOM LLCC cache. Report errors caught by LLCC ECC
> >> +         mechanism.
> >> +
> >> +         For debugging issues having to do with stability and overall
> >> system
> >> +          health, you should probably say 'Y' here.
> >> +
> >> +config EDAC_QCOM_LLCC_PANIC_ON_UE
> >> +       bool "Panic on uncorrectable errors - qcom llcc"
> >> +       depends on EDAC_QCOM_LLCC
> >> +       help
> >> +         Forcibly cause a kernel panic if an uncorrectable error (UE)
> >> is
> >> +         detected. This can reduce debugging times on hardware which
> >> may be
> >> +         operating at voltages or frequencies outside normal
> >> specification.
> >> +
> >> +         For production builds, you should probably say 'N' here.
> >> +
> >>  endif # EDAC
> >> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> >> index 02b43a7..716096d 100644
> >> --- a/drivers/edac/Makefile
> >> +++ b/drivers/edac/Makefile
> >> @@ -77,3 +77,4 @@ obj-$(CONFIG_EDAC_ALTERA)             +=
> >> altera_edac.o
> >>  obj-$(CONFIG_EDAC_SYNOPSYS)            += synopsys_edac.o
> >>  obj-$(CONFIG_EDAC_XGENE)               += xgene_edac.o
> >>  obj-$(CONFIG_EDAC_TI)                  += ti_edac.o
> >> +obj-$(CONFIG_EDAC_QCOM)                        += qcom_edac.o
> >> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> >> new file mode 100644
> >> index 0000000..9a8c670
> >> --- /dev/null
> >> +++ b/drivers/edac/qcom_edac.c
> >> @@ -0,0 +1,446 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/edac.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/smp.h>
> >> +#include <linux/soc/qcom/llcc-qcom.h>
> >> +
> >> +#include "edac_mc.h"
> >> +#include "edac_device.h"
> >> +
> >> +#ifdef CONFIG_EDAC_QCOM_LLCC_PANIC_ON_UE
> >> +#define LLCC_ERP_PANIC_ON_UE            1
> >> +#else
> >> +#define LLCC_ERP_PANIC_ON_UE            0
> >> +#endif
> >> +
> >> +#define EDAC_LLCC                       "qcom_llcc"
> >> +
> >> +#define TRP_SYN_REG_CNT                 6
> >> +
> >> +#define DRP_SYN_REG_CNT                 8
> >> +
> >> +#define LLCC_COMMON_STATUS0             0x0003000C
> >> +#define LLCC_LB_CNT_MASK                GENMASK(31, 28)
> >> +#define LLCC_LB_CNT_SHIFT               28
> >> +
> >> +/* single & Double Bit syndrome register offsets */
> >
> > Strange capitalization going on here.
> I'll fix this.
>
> >
> >> +#define TRP_ECC_SB_ERR_SYN0             0x0002304C
> >> +#define TRP_ECC_DB_ERR_SYN0             0x00020370
> >> +#define DRP_ECC_SB_ERR_SYN0             0x0004204C
> >> +#define DRP_ECC_DB_ERR_SYN0             0x00042070
> >
> > I think the convention is to use lowercase hex everywhere.
>
> I didn't get you. Do you mean, the Macros should be in lower case or the
> comments?

I mean 0x0002304C should be 0x0002304c.

>
> >
> >> +
> >> +/* Error register offsets */
> >> +#define TRP_ECC_ERROR_STATUS1           0x00020348
> >> +#define TRP_ECC_ERROR_STATUS0           0x00020344
> >> +#define DRP_ECC_ERROR_STATUS1           0x00042048
> >> +#define DRP_ECC_ERROR_STATUS0           0x00042044
> >> +
> >> +/* TRP, DRP interrupt register offsets */
> >> +#define DRP_INTERRUPT_STATUS            0x00041000
> >> +#define TRP_INTERRUPT_0_STATUS          0x00020480
> >> +#define DRP_INTERRUPT_CLEAR             0x00041008
> >> +#define DRP_ECC_ERROR_CNTR_CLEAR        0x00040004
> >> +#define TRP_INTERRUPT_0_CLEAR           0x00020484
> >> +#define TRP_ECC_ERROR_CNTR_CLEAR        0x00020440
> >> +
> >> +/* Mask and shift macros */
> >> +#define ECC_DB_ERR_COUNT_MASK           GENMASK(4, 0)
> >> +#define ECC_DB_ERR_WAYS_MASK            GENMASK(31, 16)
> >> +#define ECC_DB_ERR_WAYS_SHIFT           BIT(4)
> >> +
> >> +#define ECC_SB_ERR_COUNT_MASK           GENMASK(23, 16)
> >> +#define ECC_SB_ERR_COUNT_SHIFT          BIT(4)
> >> +#define ECC_SB_ERR_WAYS_MASK            GENMASK(15, 0)
> >> +
> >> +#define SB_ECC_ERROR                    BIT(0)
> >> +#define DB_ECC_ERROR                    BIT(1)
> >> +
> >> +#define DRP_TRP_INT_CLEAR               GENMASK(1, 0)
> >> +#define DRP_TRP_CNT_CLEAR               GENMASK(1, 0)
> >> +
> >> +/* Config registers offsets*/
> >> +#define DRP_ECC_ERROR_CFG               0x00040000
> >> +
> >> +/* TRP, DRP interrupt register offsets */
> >> +#define CMN_INTERRUPT_0_ENABLE          0x0003001C
> >> +#define CMN_INTERRUPT_2_ENABLE          0x0003003C
> >> +#define TRP_INTERRUPT_0_ENABLE          0x00020488
> >> +#define DRP_INTERRUPT_ENABLE            0x0004100C
> >> +
> >> +#define SB_ERROR_THRESHOLD              0x1
> >> +#define SB_ERROR_THRESHOLD_SHIFT        24
> >> +#define SB_DB_TRP_INTERRUPT_ENABLE      0x3
> >> +#define TRP0_INTERRUPT_ENABLE           0x1
> >> +#define DRP0_INTERRUPT_ENABLE           BIT(6)
> >> +#define SB_DB_DRP_INTERRUPT_ENABLE      0x3
> >> +
> >> +enum {
> >> +       LLCC_DRAM_CE = 0,
> >> +       LLCC_DRAM_UE,
> >> +       LLCC_TRAM_CE,
> >> +       LLCC_TRAM_UE,
> >> +       LLCC_ERR_TYPE_MAX = LLCC_TRAM_UE + 1,
> >
> > This is a nit, or perhaps personal preference, but I prefer to not
> > have initializers for sentinel values, since it's one more thing
> > someone could forget to update when adding new values.
>
> I'll get rid of this, I was using this one to allocate the memory for
> llcc_driv_data->edac_reg, (struct llcc_edac_reg_data).
> But the suggestion was to initialize that one statically.

Sounds good.

>
>
> >
> >> +};
> >> +
> >> +static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
> >> +{
> >> +       u32 sb_err_threshold;
> >> +       int ret;
> >> +
> >> +       /* Enable TRP in instance 2 of common interrupt enable
> >> register */
> >
> > Can we get a comment explaining what's so special about instance 2?
> > Instances 1 and 3 get no love?
>
> I'll try to elaborate on this.
>
> >
> >> +       ret = regmap_update_bits(llcc_bcast_regmap,
> >> CMN_INTERRUPT_2_ENABLE,
> >> +                                TRP0_INTERRUPT_ENABLE,
> >> +                                TRP0_INTERRUPT_ENABLE);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Enable ECC interrupts on Tag Ram */
> >> +       ret = regmap_update_bits(llcc_bcast_regmap,
> >> TRP_INTERRUPT_0_ENABLE,
> >> +                                SB_DB_TRP_INTERRUPT_ENABLE,
> >> +                                SB_DB_TRP_INTERRUPT_ENABLE);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Enable SB error for Data RAM */
> >> +       sb_err_threshold = (SB_ERROR_THRESHOLD <<
> >> SB_ERROR_THRESHOLD_SHIFT);
> >> +       ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
> >> +                          sb_err_threshold);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Enable DRP in instance 2 of common interrupt enable
> >> register */
> >> +       ret = regmap_update_bits(llcc_bcast_regmap,
> >> CMN_INTERRUPT_2_ENABLE,
> >> +                                DRP0_INTERRUPT_ENABLE,
> >> +                                DRP0_INTERRUPT_ENABLE);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Enable ECC interrupts on Data Ram */
> >> +       ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
> >> +                          SB_DB_DRP_INTERRUPT_ENABLE);
> >> +       return ret;
> >> +}
> >> +
> >> +/* Clear the error interrupt and counter registers */
> >> +static int
> >> +qcom_llcc_clear_errors_status(int err_type, struct llcc_drv_data
> >> *drv)
> >
> > Another nit: errors_status is kind of weird. Maybe
> > qcom_llcc_clear_errors or qcom_llcc_clear_error_status?
>
> I'll update the name.
>
> >
> >> +{
> >> +       int ret = 0;
> >> +
> >> +       switch (err_type) {
> >> +       case LLCC_DRAM_CE:
> >> +       case LLCC_DRAM_UE:
> >> +               /* Clear the interrupt */
> >> +               ret = regmap_write(drv->bcast_regmap,
> >> DRP_INTERRUPT_CLEAR,
> >> +                                  DRP_TRP_INT_CLEAR);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               /* Clear the counters */
> >> +               ret = regmap_write(drv->bcast_regmap,
> >> DRP_ECC_ERROR_CNTR_CLEAR,
> >> +                                  DRP_TRP_CNT_CLEAR);
> >> +               if (ret)
> >> +                       return ret;
> >> +               break;
> >> +       case LLCC_TRAM_CE:
> >> +       case LLCC_TRAM_UE:
> >> +               ret = regmap_write(drv->bcast_regmap,
> >> TRP_INTERRUPT_0_CLEAR,
> >> +                                  DRP_TRP_INT_CLEAR);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               ret = regmap_write(drv->bcast_regmap,
> >> TRP_ECC_ERROR_CNTR_CLEAR,
> >> +                                  DRP_TRP_CNT_CLEAR);
> >> +               if (ret)
> >> +                       return ret;
> >> +               break;
> >
> > A default case that errors or complains or both would be nice.
>
> Ok, I had this thought too, but we never run into that scenario,
> that's we don't ever call this function with any other types,
> Had it been an API it makes sense to have a default case.
> The internal functions require them too! I don't know!!
> What do you think?
> As we say, if it's good to have it, I'll add it.

I personally like the default case, I find it to be defensive against
someone adding code later who passes the wrong value or type down.
Others might disagree. It's up to you.
