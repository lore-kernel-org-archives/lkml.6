Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF219C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D35C24689
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM4wg7nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D35C24689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbeFVRN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:13:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44694 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbeFVRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:13:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id h12-v6so3504438pfk.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hndOTLEMMEaM87m7bDaqTAMTsZMcG4BRfupFLFDT+kA=;
        b=VM4wg7nHD/910I+ea9cTsg0eV6gsD/q2IenW04pto7JX8Gm+XmzncQTGZOlrTCzNi7
         6MSsl+DGIga9kNpYCRdqchHkOTumZkduCKs16pFEw+FlMdkLsqhO+iaPBbIP09M2YV3a
         Tdr1EVok/S/B+Twe8qf4lHxzqAtnCjoypJsDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hndOTLEMMEaM87m7bDaqTAMTsZMcG4BRfupFLFDT+kA=;
        b=JFRVkTjp0EG6U3EmArPkXsGGjUW7Ppf9gdbPpGPs1jnKRhtim2rslT8+ny2AoOkTae
         uq3XEIRLfn20uG96LT2wlEr6SFguv/F0bM5BLOsCAvzwdTjLKkAZmdDOHAPN/Tcvh+bw
         QbMFs1+ql78CUbS/PDuzfCi1q9yEp5HtbXx8m9Rd9AtY+moSAOUiMiokD4QZzOlH69gN
         +v9ZCLOYwr8sHoewM2OPBFUP3e+yOgD9IA8FaZh/+tHT7gl1jGn19/n/bkc9vkPPpFOv
         tC6Ft7c982TG3PGYXQClYwu0jrC/Yu3d9Z6wkpL3X8uT5Qc3IvkhkT/TUmwVH05M3hb4
         CcNA==
X-Gm-Message-State: APt69E2u74AqCZkqDHI6/VjyqFyxoC4HLu/v2Nz8HEjZzp2S1dM1iqiC
        pVv4dHUx97wQ/4py+sQE68inzA==
X-Google-Smtp-Source: ADUXVKLrt60XS9dQiNuCifpFV+/Ye/SEqdOhWZX0olVI02E9IFA+kyWSrcQO7nyqF4V4T5fcE610Tg==
X-Received: by 2002:aa7:85c9:: with SMTP id z9-v6mr2609573pfn.55.1529687636992;
        Fri, 22 Jun 2018 10:13:56 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z19-v6sm12124134pfe.163.2018.06.22.10.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:13:56 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:13:54 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org, evgreen@chromium.org,
        robh@kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v8 2/2] drivers: soc: Add LLCC driver
Message-ID: <20180622171354.GI10336@builder>
References: <1527122121-31452-1-git-send-email-rishabhb@codeaurora.org>
 <1527122121-31452-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527122121-31452-3-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23 May 17:35 PDT 2018, Rishabh Bhatnagar wrote:

> LLCC (Last Level Cache Controller) provides additional cache memory
> in the system. LLCC is partitioned into multiple slices and each
> slice gets its own priority, size, ID and other config parameters.
> LLCC driver programs these parameters for each slice. Clients that
> are assigned to use LLCC need to get information such size & ID of the
> slice they get and activate or deactivate the slice as needed. LLCC driver
> provides API for the clients to perform these operations.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/Kconfig           |  17 ++
>  drivers/soc/qcom/Makefile          |   2 +
>  drivers/soc/qcom/llcc-sdm845.c     |  94 +++++++++++
>  drivers/soc/qcom/llcc-slice.c      | 335 +++++++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/llcc-qcom.h | 180 ++++++++++++++++++++
>  5 files changed, 628 insertions(+)
>  create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>  create mode 100644 drivers/soc/qcom/llcc-slice.c
>  create mode 100644 include/linux/soc/qcom/llcc-qcom.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e050eb8..0b550f9 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -21,6 +21,23 @@ config QCOM_GSBI
>            functions for connecting the underlying serial UART, SPI, and I2C
>            devices to the output pins.
>  
> +config QCOM_LLCC
> +	tristate "Qualcomm Technologies, Inc. LLCC driver"
> +	depends on ARCH_QCOM
> +	help
> +	  Qualcomm Technologies, Inc. platform specific
> +	  Last Level Cache Controller(LLCC) driver. This provides interfaces
> +	  to clients that use the LLCC. Say yes here to enable LLCC slice
> +	  driver.
> +
> +config QCOM_SDM845_LLCC
> +	tristate "Qualcomm Technologies, Inc. SDM845 LLCC driver"
> +	depends on QCOM_LLCC
> +	help
> +	  Say yes here to enable the LLCC driver for SDM845. This provides
> +	  data required to configure LLCC so that clients can start using the
> +	  LLCC slices.
> +
>  config QCOM_MDT_LOADER
>  	tristate
>  	select QCOM_SCM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index dcebf28..e16d6a2 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -12,3 +12,5 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>  obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>  obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
> +obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
> +obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
> diff --git a/drivers/soc/qcom/llcc-sdm845.c b/drivers/soc/qcom/llcc-sdm845.c
> new file mode 100644
> index 0000000..2e1e4f0
> --- /dev/null
> +++ b/drivers/soc/qcom/llcc-sdm845.c
> @@ -0,0 +1,94 @@
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
> + * priority: Priority of the client used to select victim line for replacement
> + * fixed_size: Boolean indicating if the slice has a fixed capacity
> + * bonus_ways: Bonus ways are additional ways to be used for any slice,
> + *		if client ends up using more than reserved cache ways. Bonus
> + *		ways are allocated only if they are not reserved for some
> + *		other client.
> + * res_ways: Reserved ways for the cache slice, the reserved ways cannot
> + *		be used by any other client than the one its assigned to.
> + * cache_mode: Each slice operates as a cache, this controls the mode of the
> + *             slice: normal or TCM(Tightly Coupled Memory)
> + * probe_target_ways: Determines what ways to probe for access hit. When
> + *                    configured to 1 only bonus and reserved ways are probed.
> + *                    When configured to 0 all ways in llcc are probed.
> + * dis_cap_alloc: Disable capacity based allocation for a client
> + * retain_on_pc: If this bit is set and client has maintained active vote
> + *               then the ways assigned to this client are not flushed on power
> + *               collapse.
> + * activate_on_init: Activate the slice immediately after the SCT is programmed
> + */
> +#define SCT_ENTRY(uid, sid, mc, p, fs, bway, rway, cmod, ptw, dca, rp, a) \
> +	{					\
> +		.usecase_id = uid,		\
> +		.slice_id = sid,		\
> +		.max_cap = mc,			\
> +		.priority = p,			\
> +		.fixed_size = fs,		\
> +		.bonus_ways = bway,		\
> +		.res_ways = rway,		\
> +		.cache_mode = cmod,		\
> +		.probe_target_ways = ptw,	\
> +		.dis_cap_alloc = dca,		\
> +		.retain_on_pc = rp,		\
> +		.activate_on_init = a,		\
> +	}
> +
> +static struct llcc_slice_config sdm845_data[] =  {
> +	SCT_ENTRY(LLCC_CPUSS,    1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1),
> +	SCT_ENTRY(LLCC_VIDSC0,   2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_VIDSC1,   3,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_ROTATOR,  4,  563,  2, 1, 0x0,   0x00e, 2, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_VOICE,    5,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_AUDIO,    6,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_MDMHPGRW, 7,  1024, 2, 0, 0xfc,  0xf00, 0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_MDM,      8,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_CMPT,     10, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_GPUHTW,   11, 512,  1, 1, 0xc,   0x0,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_GPU,      12, 2304, 1, 0, 0xff0, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_MMUHWT,   13, 256,  2, 0, 0x0,   0x1,   0, 0, 1, 0, 1),
> +	SCT_ENTRY(LLCC_CMPTDMA,  15, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_DISP,     16, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_VIDFW,    17, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_MDMHPFX,  20, 1024, 2, 1, 0x0,   0xf00, 0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_MDMPNG,   21, 1024, 0, 1, 0x1e,  0x0,   0, 0, 1, 1, 0),
> +	SCT_ENTRY(LLCC_AUDHW,    22, 1024, 1, 1, 0xffc, 0x2,   0, 0, 1, 1, 0),
> +};
> +
> +static int sdm845_qcom_llcc_probe(struct platform_device *pdev)
> +{
> +	return qcom_llcc_probe(pdev, sdm845_data, ARRAY_SIZE(sdm845_data));
> +}
> +
> +static const struct of_device_id sdm845_qcom_llcc_of_match[] = {
> +	{ .compatible = "qcom,sdm845-llcc", },
> +	{ }
> +};
> +
> +static struct platform_driver sdm845_qcom_llcc_driver = {
> +	.driver = {
> +		.name = "sdm845-llcc",
> +		.of_match_table = sdm845_qcom_llcc_of_match,
> +	},
> +	.probe = sdm845_qcom_llcc_probe,
> +};
> +module_platform_driver(sdm845_qcom_llcc_driver);
> +
> +MODULE_DESCRIPTION("QCOM sdm845 LLCC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
> new file mode 100644
> index 0000000..fcaad1a
> --- /dev/null
> +++ b/drivers/soc/qcom/llcc-slice.c
> @@ -0,0 +1,335 @@
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
> +#define ACTIVATE                      BIT(0)
> +#define DEACTIVATE                    BIT(1)
> +#define ACT_CTRL_OPCODE_ACTIVATE      BIT(0)
> +#define ACT_CTRL_OPCODE_DEACTIVATE    BIT(1)
> +#define ACT_CTRL_ACT_TRIG             BIT(0)
> +#define ACT_CTRL_OPCODE_SHIFT         0x01
> +#define ATTR1_PROBE_TARGET_WAYS_SHIFT 0x02
> +#define ATTR1_FIXED_SIZE_SHIFT        0x03
> +#define ATTR1_PRIORITY_SHIFT          0x04
> +#define ATTR1_MAX_CAP_SHIFT           0x10
> +#define ATTR0_RES_WAYS_MASK           GENMASK(11, 0)
> +#define ATTR0_BONUS_WAYS_MASK         GENMASK(27, 16)
> +#define ATTR0_BONUS_WAYS_SHIFT        0x10
> +#define LLCC_STATUS_READ_DELAY        100
> +
> +#define CACHE_LINE_SIZE_SHIFT         6
> +
> +#define LLCC_COMMON_STATUS0           0x0003000c
> +#define LLCC_LB_CNT_MASK              GENMASK(31, 28)
> +#define LLCC_LB_CNT_SHIFT             28
> +
> +#define MAX_CAP_TO_BYTES(n)           (n * SZ_1K)
> +#define LLCC_TRP_ACT_CTRLn(n)         (n * SZ_4K)
> +#define LLCC_TRP_STATUSn(n)           (4 + n * SZ_4K)
> +#define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
> +#define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
> +
> +#define BANK_OFFSET_STRIDE	      0x80000
> +
> +static struct llcc_drv_data *drv_data;
> +
> +static const struct regmap_config llcc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +};
> +
> +/**
> + * llcc_slice_getd - get llcc slice descriptor
> + * @uid: usecase_id for the client
> + *
> + * A pointer to llcc slice descriptor will be returned on success and
> + * and error pointer is returned on failure
> + */
> +struct llcc_slice_desc *llcc_slice_getd(u32 uid)
> +{
> +	const struct llcc_slice_config *cfg;
> +	struct llcc_slice_desc *desc;
> +	u32 sz, count;
> +
> +	cfg = drv_data->cfg;
> +	sz = drv_data->cfg_size;
> +
> +	for (count = 0; cfg && count < sz; count++, cfg++)
> +		if (cfg->usecase_id == uid)
> +			break;
> +
> +	if (count == sz || !cfg)
> +		return ERR_PTR(-ENODEV);
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	desc->slice_id = cfg->slice_id;
> +	desc->slice_size = cfg->max_cap;
> +
> +	return desc;
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_getd);
> +
> +/**
> + * llcc_slice_putd - llcc slice descritpor
> + * @desc: Pointer to llcc slice descriptor
> + */
> +void llcc_slice_putd(struct llcc_slice_desc *desc)
> +{
> +	kfree(desc);
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_putd);
> +
> +static int llcc_update_act_ctrl(u32 sid,
> +				u32 act_ctrl_reg_val, u32 status)
> +{
> +	u32 act_ctrl_reg;
> +	u32 status_reg;
> +	u32 slice_status;
> +	int ret;
> +
> +	act_ctrl_reg = drv_data->bcast_off + LLCC_TRP_ACT_CTRLn(sid);
> +	status_reg = drv_data->bcast_off + LLCC_TRP_STATUSn(sid);
> +
> +	/* Set the ACTIVE trigger */
> +	act_ctrl_reg_val |= ACT_CTRL_ACT_TRIG;
> +	ret = regmap_write(drv_data->regmap, act_ctrl_reg, act_ctrl_reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear the ACTIVE trigger */
> +	act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
> +	ret = regmap_write(drv_data->regmap, act_ctrl_reg, act_ctrl_reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(drv_data->regmap, status_reg,
> +				      slice_status, !(slice_status & status),
> +				      0, LLCC_STATUS_READ_DELAY);
> +	return ret;
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
> +	int ret;
> +	u32 act_ctrl_val;
> +
> +	mutex_lock(&drv_data->lock);
> +	if (test_bit(desc->slice_id, drv_data->bitmap)) {
> +		mutex_unlock(&drv_data->lock);
> +		return 0;
> +	}
> +
> +	act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
> +
> +	ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
> +				  DEACTIVATE);
> +	if (ret) {
> +		mutex_unlock(&drv_data->lock);
> +		return ret;
> +	}
> +
> +	__set_bit(desc->slice_id, drv_data->bitmap);
> +	mutex_unlock(&drv_data->lock);
> +
> +	return ret;
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
> +	u32 act_ctrl_val;
> +	int ret;
> +
> +	mutex_lock(&drv_data->lock);
> +	if (!test_bit(desc->slice_id, drv_data->bitmap)) {
> +		mutex_unlock(&drv_data->lock);
> +		return 0;
> +	}
> +	act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE << ACT_CTRL_OPCODE_SHIFT;
> +
> +	ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
> +				  ACTIVATE);
> +	if (ret) {
> +		mutex_unlock(&drv_data->lock);
> +		return ret;
> +	}
> +
> +	__clear_bit(desc->slice_id, drv_data->bitmap);
> +	mutex_unlock(&drv_data->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(llcc_slice_deactivate);
> +
> +/**
> + * llcc_get_slice_id - return the slice id
> + * @desc: Pointer to llcc slice descriptor
> + */
> +int llcc_get_slice_id(struct llcc_slice_desc *desc)
> +{
> +	return desc->slice_id;
> +}
> +EXPORT_SYMBOL_GPL(llcc_get_slice_id);
> +
> +/**
> + * llcc_get_slice_size - return the slice id
> + * @desc: Pointer to llcc slice descriptor
> + */
> +size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
> +{
> +	return desc->slice_size;
> +}
> +EXPORT_SYMBOL_GPL(llcc_get_slice_size);
> +
> +static int qcom_llcc_cfg_program(struct platform_device *pdev)
> +{
> +	int i;
> +	u32 attr1_cfg;
> +	u32 attr0_cfg;
> +	u32 attr1_val;
> +	u32 attr0_val;
> +	u32 max_cap_cacheline;
> +	u32 sz;
> +	int ret;
> +	const struct llcc_slice_config *llcc_table;
> +	struct llcc_slice_desc desc;
> +	u32 bcast_off = drv_data->bcast_off;
> +
> +	sz = drv_data->cfg_size;
> +	llcc_table = drv_data->cfg;
> +
> +	for (i = 0; i < sz; i++) {
> +		attr1_cfg = bcast_off +
> +				LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
> +		attr0_cfg = bcast_off +
> +				LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
> +
> +		attr1_val = llcc_table[i].cache_mode;
> +		attr1_val |= llcc_table[i].probe_target_ways <<
> +				ATTR1_PROBE_TARGET_WAYS_SHIFT;
> +		attr1_val |= llcc_table[i].fixed_size <<
> +				ATTR1_FIXED_SIZE_SHIFT;
> +		attr1_val |= llcc_table[i].priority <<
> +				ATTR1_PRIORITY_SHIFT;
> +
> +		max_cap_cacheline = MAX_CAP_TO_BYTES(llcc_table[i].max_cap);
> +
> +		/* LLCC instances can vary for each target.
> +		 * The SW writes to broadcast register which gets propagated
> +		 * to each llcc instace (llcc0,.. llccN).
> +		 * Since the size of the memory is divided equally amongst the
> +		 * llcc instances, we need to configure the max cap accordingly.
> +		 */
> +		max_cap_cacheline = max_cap_cacheline / drv_data->num_banks;
> +		max_cap_cacheline >>= CACHE_LINE_SIZE_SHIFT;
> +		attr1_val |= max_cap_cacheline << ATTR1_MAX_CAP_SHIFT;
> +
> +		attr0_val = llcc_table[i].res_ways & ATTR0_RES_WAYS_MASK;
> +		attr0_val |= llcc_table[i].bonus_ways << ATTR0_BONUS_WAYS_SHIFT;
> +
> +		ret = regmap_write(drv_data->regmap, attr1_cfg, attr1_val);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(drv_data->regmap, attr0_cfg, attr0_val);
> +		if (ret)
> +			return ret;
> +		if (llcc_table[i].activate_on_init) {
> +			desc.slice_id = llcc_table[i].slice_id;
> +			ret = llcc_slice_activate(&desc);
> +		}
> +	}
> +	return ret;
> +}
> +
> +int qcom_llcc_probe(struct platform_device *pdev,
> +		      const struct llcc_slice_config *llcc_cfg, u32 sz)
> +{
> +	u32 num_banks;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret, i;
> +
> +	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
> +	if (!drv_data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	drv_data->regmap = devm_regmap_init_mmio(dev, base,
> +					&llcc_regmap_config);
> +	if (IS_ERR(drv_data->regmap))
> +		return PTR_ERR(drv_data->regmap);
> +
> +	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
> +						&num_banks);
> +	if (ret)
> +		return ret;
> +
> +	num_banks &= LLCC_LB_CNT_MASK;
> +	num_banks >>= LLCC_LB_CNT_SHIFT;
> +	drv_data->num_banks = num_banks;
> +
> +	for (i = 0; i < sz; i++)
> +		if (llcc_cfg[i].slice_id > drv_data->max_slices)
> +			drv_data->max_slices = llcc_cfg[i].slice_id;
> +
> +	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
> +							GFP_KERNEL);
> +	if (!drv_data->offsets)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_banks; i++)
> +		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
> +
> +	drv_data->bcast_off = num_banks * BANK_OFFSET_STRIDE;
> +
> +	drv_data->bitmap = devm_kcalloc(dev,
> +	BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
> +						GFP_KERNEL);
> +	if (!drv_data->bitmap)
> +		return -ENOMEM;
> +
> +	drv_data->cfg = llcc_cfg;
> +	drv_data->cfg_size = sz;
> +	mutex_init(&drv_data->lock);
> +	platform_set_drvdata(pdev, drv_data);
> +
> +	return qcom_llcc_cfg_program(pdev);
> +}
> +EXPORT_SYMBOL_GPL(qcom_llcc_probe);
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> new file mode 100644
> index 0000000..7e3b9c6
> --- /dev/null
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -0,0 +1,180 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#ifndef __LLCC_QCOM__
> +#define __LLCC_QCOM__
> +
> +#define LLCC_CPUSS       1
> +#define LLCC_VIDSC0      2
> +#define LLCC_VIDSC1      3
> +#define LLCC_ROTATOR     4
> +#define LLCC_VOICE       5
> +#define LLCC_AUDIO       6
> +#define LLCC_MDMHPGRW    7
> +#define LLCC_MDM         8
> +#define LLCC_CMPT        10
> +#define LLCC_GPUHTW      11
> +#define LLCC_GPU         12
> +#define LLCC_MMUHWT      13
> +#define LLCC_CMPTDMA     15
> +#define LLCC_DISP        16
> +#define LLCC_VIDFW       17
> +#define LLCC_MDMHPFX     20
> +#define LLCC_MDMPNG      21
> +#define LLCC_AUDHW       22
> +
> +/**
> + * llcc_slice_desc - Cache slice descriptor
> + * @slice_id: llcc slice id
> + * @slice_size: Size allocated for the llcc slice
> + */
> +struct llcc_slice_desc {
> +	u32 slice_id;
> +	size_t slice_size;
> +};
> +
> +/**
> + * llcc_slice_config - Data associated with the llcc slice
> + * @usecase_id: usecase id for which the llcc slice is used
> + * @slice_id: llcc slice id assigned to each slice
> + * @max_cap: maximum capacity of the llcc slice
> + * @priority: priority of the llcc slice
> + * @fixed_size: whether the llcc slice can grow beyond its size
> + * @bonus_ways: bonus ways associated with llcc slice
> + * @res_ways: reserved ways associated with llcc slice
> + * @cache_mode: mode of the llcc slice
> + * @probe_target_ways: Probe only reserved and bonus ways on a cache miss
> + * @dis_cap_alloc: Disable capacity based allocation
> + * @retain_on_pc: Retain through power collapse
> + * @activate_on_init: activate the slice on init
> + */
> +struct llcc_slice_config {
> +	u32 usecase_id;
> +	u32 slice_id;
> +	u32 max_cap;
> +	u32 priority;
> +	bool fixed_size;
> +	u32 bonus_ways;
> +	u32 res_ways;
> +	u32 cache_mode;
> +	u32 probe_target_ways;
> +	bool dis_cap_alloc;
> +	bool retain_on_pc;
> +	bool activate_on_init;
> +};
> +
> +/**
> + * llcc_drv_data - Data associated with the llcc driver
> + * @regmap: regmap associated with the llcc device
> + * @cfg: pointer to the data structure for slice configuration
> + * @lock: mutex associated with each slice
> + * @cfg_size: size of the config data table
> + * @max_slices: max slices as read from device tree
> + * @bcast_off: Offset of the broadcast bank
> + * @num_banks: Number of llcc banks
> + * @bitmap: Bit map to track the active slice ids
> + * @offsets: Pointer to the bank offsets array
> + */
> +struct llcc_drv_data {
> +	struct regmap *regmap;
> +	const struct llcc_slice_config *cfg;
> +	struct mutex lock;
> +	u32 cfg_size;
> +	u32 max_slices;
> +	u32 bcast_off;
> +	u32 num_banks;
> +	unsigned long *bitmap;
> +	u32 *offsets;
> +};
> +
> +#if IS_ENABLED(CONFIG_QCOM_LLCC)
> +/**
> + * llcc_slice_getd - get llcc slice descriptor
> + * @uid: usecase_id of the client
> + */
> +struct llcc_slice_desc *llcc_slice_getd(u32 uid);
> +
> +/**
> + * llcc_slice_putd - llcc slice descritpor
> + * @desc: Pointer to llcc slice descriptor
> + */
> +void llcc_slice_putd(struct llcc_slice_desc *desc);
> +
> +/**
> + * llcc_get_slice_id - get slice id
> + * @desc: Pointer to llcc slice descriptor
> + */
> +int llcc_get_slice_id(struct llcc_slice_desc *desc);
> +
> +/**
> + * llcc_get_slice_size - llcc slice size
> + * @desc: Pointer to llcc slice descriptor
> + */
> +size_t llcc_get_slice_size(struct llcc_slice_desc *desc);
> +
> +/**
> + * llcc_slice_activate - Activate the llcc slice
> + * @desc: Pointer to llcc slice descriptor
> + */
> +int llcc_slice_activate(struct llcc_slice_desc *desc);
> +
> +/**
> + * llcc_slice_deactivate - Deactivate the llcc slice
> + * @desc: Pointer to llcc slice descriptor
> + */
> +int llcc_slice_deactivate(struct llcc_slice_desc *desc);
> +
> +/**
> + * qcom_llcc_probe - program the sct table
> + * @pdev: platform device pointer
> + * @table: soc sct table
> + * @sz: Size of the config table
> + */
> +int qcom_llcc_probe(struct platform_device *pdev,
> +		      const struct llcc_slice_config *table, u32 sz);
> +#else
> +static inline struct llcc_slice_desc *llcc_slice_getd(u32 uid)
> +{
> +	return NULL;
> +}
> +
> +static inline void llcc_slice_putd(struct llcc_slice_desc *desc)
> +{
> +
> +};
> +
> +static inline int llcc_get_slice_id(struct llcc_slice_desc *desc)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
> +{
> +	return 0;
> +}
> +static inline int llcc_slice_activate(struct llcc_slice_desc *desc)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int llcc_slice_deactivate(struct llcc_slice_desc *desc)
> +{
> +	return -EINVAL;
> +}
> +static inline int qcom_llcc_probe(struct platform_device *pdev,
> +		      const struct llcc_slice_config *table, u32 sz)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int qcom_llcc_remove(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
