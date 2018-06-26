Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4A126E58
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aqNu2QU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4A126E58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934133AbeFZUsz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:48:55 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38107 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934049AbeFZUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:48:52 -0400
Received: by mail-ot0-f195.google.com with SMTP id w22-v6so1380392otk.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkYENZhh4u3NNZPBHUv9qpfLwBrDX3KgDVTZJ6gTClg=;
        b=aqNu2QU3ltJ7Pe0GlLT1df2w0Ppw1AJ6M22xEK+e4H/p5n16RlyLsrKSZk8Yw4f7BO
         YhlZjHCQbMPBPjCmIlvthzq9XBKNvCPMhpSIWIe2vOTAmPL2Qb4/t8ZDliIJHqYCaTIU
         RIB2HROpNpAmc61ZBmfMud/X/7p5MYeYzxjds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkYENZhh4u3NNZPBHUv9qpfLwBrDX3KgDVTZJ6gTClg=;
        b=owBb18SPdiJWhy4ZvNymwaibToQHPeAagTusMpttPDK9h9aukmGyAIyOyx3318SBSP
         mpaUvchIm8BP6ZbsMwck4hL+YPbyLxtK7RzDay/o8Tv8egcni4S+InOyeIMS6HiyjAai
         Oe1CzZEoijVMEvuf+Hmz4OCwjtR1MlHV3CClXnP6IFeJHh03gZVXOEQRQFTU1gB/ZZJV
         Zi3gjCM9lmauvJdn3rUl4UV6xXmWE7WF7O3Q2Fqf6fo5DdE/0PuTfMIFgkoGUsR2Xfuy
         /kDKgcp3+Y1WFstlAARE4jHx+5OmupFeHWAmhXDUgSDSWg7dPjl9WYzhhN3vPnfFfcdv
         IBpw==
X-Gm-Message-State: APt69E32cJcURoSX86w+QHVBFUc6D24VD3Jlnt/+zleNUyWlVyIEaixD
        3aSm2ZxdKs1/g4HrYI7/utraFUA7BEI=
X-Google-Smtp-Source: AAOMgpdLIdscafqcDSxVJESvBU5P+4qEeOnLkdQjg+vU+9BqaWvpwjmGh/3DOyexIkgXyYKkG4xcIw==
X-Received: by 2002:a9d:58d:: with SMTP id 13-v6mr1666487otd.13.1530046131745;
        Tue, 26 Jun 2018 13:48:51 -0700 (PDT)
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id x33-v6sm625084ota.16.2018.06.26.13.48.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 13:48:51 -0700 (PDT)
Received: by mail-oi0-f48.google.com with SMTP id h79-v6so17284623oig.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:48:51 -0700 (PDT)
X-Received: by 2002:aca:b643:: with SMTP id g64-v6mr1642280oif.5.1530046130351;
 Tue, 26 Jun 2018 13:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180620121141.15403-1-georgi.djakov@linaro.org> <20180620121141.15403-7-georgi.djakov@linaro.org>
In-Reply-To: <20180620121141.15403-7-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Jun 2018 13:48:13 -0700
X-Gmail-Original-Message-ID: <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
Message-ID: <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add driver for the Qualcomm interconnect buses found in msm8916 based
> platforms.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/Kconfig        |   5 +
>  drivers/interconnect/Makefile       |   1 +
>  drivers/interconnect/qcom/Kconfig   |  11 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8916.c | 495 ++++++++++++++++++++++++++++
>  5 files changed, 514 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index a261c7d41deb..07a8276fa35a 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -8,3 +8,8 @@ menuconfig INTERCONNECT
>
>           If unsure, say no.
>
> +if INTERCONNECT
> +
> +source "drivers/interconnect/qcom/Kconfig"
> +
> +endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 97fca2e09d24..7944cbca0527 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_INTERCONNECT)             += core.o
> +obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> new file mode 100644
> index 000000000000..86465dc37bd4
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -0,0 +1,11 @@
> +config INTERCONNECT_QCOM
> +       bool "Qualcomm Network-on-Chip interconnect drivers"
> +       depends on INTERCONNECT
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       default y
> +
> +config INTERCONNECT_QCOM_MSM8916
> +       tristate "Qualcomm MSM8916 interconnect driver"
> +       depends on INTERCONNECT_QCOM
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on msm8916-based platforms.
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 2a0c41db91c4..e8b24c334c5d 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -1,2 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y += smd-rpm.o
> +
> +obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += msm8916.o
> diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
> new file mode 100644
> index 000000000000..c34f18cdea33
> --- /dev/null
> +++ b/drivers/interconnect/qcom/msm8916.c
> @@ -0,0 +1,495 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Linaro Ltd
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#include <dt-bindings/interconnect/qcom.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/interconnect-provider.h>

Nit: the previous two should be swapped for alphabetization.

> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "smd-rpm.h"
> +
> +#define RPM_MASTER_FIELD_BW    0x00007762

This is unused, since it moved into that other file.

> +#define RPM_BUS_MASTER_REQ      0x73616d62
> +#define RPM_BUS_SLAVE_REQ       0x766c7362
> +
> +#define to_qcom_provider(_provider) \
> +       container_of(_provider, struct qcom_icc_provider, provider)
> +
> +enum qcom_qos_mode {
> +       QCOM_QOS_MODE_BYPASS = 0,
> +       QCOM_QOS_MODE_FIXED,
> +       QCOM_QOS_MODE_MAX,
> +};
> +
> +struct qcom_icc_provider {
> +       struct icc_provider     provider;
> +       void __iomem            *base;
> +       struct clk              *bus_clk;
> +       struct clk              *bus_a_clk;
> +};
> +
> +#define MSM8916_MAX_LINKS      8
> +
> +/**
> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @links: an array of nodes where we can go next while traversing
> + * @id: a unique node identifier
> + * @num_links: the total number of @links
> + * @port: the offset index into the masters QoS register space
> + * @buswidth: width of the interconnect between a node and the bus (bytes)
> + * @ap_owned: the AP CPU does the writing to QoS registers
> + * @rpm: reference to the RPM SMD driver
> + * @qos_mode: QoS mode for ap_owned resources
> + * @mas_rpm_id:        RPM id for devices that are bus masters
> + * @slv_rpm_id:        RPM id for devices that are bus slaves
> + * @rate: current bus clock rate in Hz
> + */
> +struct qcom_icc_node {
> +       unsigned char *name;
> +       u16 links[MSM8916_MAX_LINKS];
> +       u16 id;
> +       u16 num_links;
> +       u16 port;
> +       u16 buswidth;
> +       bool ap_owned;
> +       struct qcom_smd_rpm *rpm;

This is unused.

> +       enum qcom_qos_mode qos_mode;
> +       int mas_rpm_id;
> +       int slv_rpm_id;
> +       u64 rate;
> +};
> +
> +struct qcom_icc_desc {
> +       struct qcom_icc_node **nodes;
> +       size_t num_nodes;
> +};
> +
> +#define DEFINE_QNODE(_name, _id, _port, _buswidth, _ap_owned,          \
> +                       _mas_rpm_id, _slv_rpm_id, _qos_mode,            \
> +                       _numlinks, ...)                                 \
> +               static struct qcom_icc_node _name = {                   \
> +               .id = _id,                                              \
> +               .name = #_name,                                         \
> +               .port = _port,                                          \
> +               .buswidth = _buswidth,                                  \
> +               .qos_mode = _qos_mode,                                  \
> +               .ap_owned = _ap_owned,                                  \
> +               .mas_rpm_id = _mas_rpm_id,                              \
> +               .slv_rpm_id = _slv_rpm_id,                              \
> +               .num_links = _numlinks,                                 \
> +               .links = { __VA_ARGS__ },                               \
> +       }
> +
> +DEFINE_QNODE(mas_video, MASTER_VIDEO_P0, 8, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_0, SNOC_MM_INT_2);
> +DEFINE_QNODE(mas_jpeg, MASTER_JPEG, 6, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_0, SNOC_MM_INT_2);
> +DEFINE_QNODE(mas_vfe, MASTER_VFE, 9, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_1, SNOC_MM_INT_2);
> +DEFINE_QNODE(mas_mdp, MASTER_MDP_PORT0, 7, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_0, SNOC_MM_INT_2);
> +DEFINE_QNODE(mas_qdss_bam, MASTER_QDSS_BAM, 11, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_QDSS_INT);
> +DEFINE_QNODE(mas_snoc_cfg, MASTER_SNOC_CFG, 0, 16, 0, 20, -1, QCOM_QOS_MODE_BYPASS, 1, SNOC_QDSS_INT);
> +DEFINE_QNODE(mas_qdss_etr, MASTER_QDSS_ETR, 10, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_QDSS_INT);
> +DEFINE_QNODE(mm_int_0, SNOC_MM_INT_0, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_MM_INT_BIMC);
> +DEFINE_QNODE(mm_int_1, SNOC_MM_INT_1, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_MM_INT_BIMC);
> +DEFINE_QNODE(mm_int_2, SNOC_MM_INT_2, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_INT_0);
> +DEFINE_QNODE(mm_int_bimc, SNOC_MM_INT_BIMC, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_1_MAS);
> +DEFINE_QNODE(snoc_int_0, SNOC_INT_0, 0, 8, 0, 99, 130, QCOM_QOS_MODE_FIXED, 3, SLAVE_QDSS_STM, SLAVE_SYSTEM_IMEM, MNOC_BIMC_MAS);
> +DEFINE_QNODE(snoc_int_1, SNOC_INT_1, 0, 8, 0, 100, 131, QCOM_QOS_MODE_FIXED, 3, SYSTEM_SLAVE_FAB_APPS, SLAVE_CATS_128, SLAVE_OCMEM_64);
> +DEFINE_QNODE(snoc_int_bimc, SNOC_INT_BIMC, 0, 8, 0, 101, 132, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_0_MAS);
> +DEFINE_QNODE(snoc_bimc_0_mas, SNOC_BIMC_0_MAS, 0, 8, 0, 3, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_0_SLV);
> +DEFINE_QNODE(snoc_bimc_1_mas, SNOC_BIMC_1_MAS, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_1_SLV);
> +DEFINE_QNODE(qdss_int, SNOC_QDSS_INT, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, SNOC_INT_0, SNOC_INT_BIMC);
> +DEFINE_QNODE(bimc_snoc_slv, BIMC_SNOC_SLV, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, SNOC_INT_0, SNOC_INT_1);
> +DEFINE_QNODE(snoc_pnoc_mas, MNOC_BIMC_MAS, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, MNOC_BIMC_SLV);
> +DEFINE_QNODE(pnoc_snoc_slv, PNOC_SNOC_SLV, 0, 8, 0, -1, 45, QCOM_QOS_MODE_FIXED, 3, SNOC_INT_0, SNOC_INT_BIMC, SNOC_INT_1);
> +DEFINE_QNODE(slv_srvc_snoc, SLAVE_SERVICE_SNOC, 0, 8, 0, -1, 29, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_qdss_stm, SLAVE_QDSS_STM, 0, 4, 0, -1, 30, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_imem, SLAVE_SYSTEM_IMEM, 0, 8, 0, -1, 26, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_apss, SYSTEM_SLAVE_FAB_APPS, 0, 4, 0, -1, 20, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_cats_0, SLAVE_CATS_128, 0, 16, 0, -1, 106, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_cats_1, SLAVE_OCMEM_64, 0, 8, 0, -1, 107, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(mas_apss, MASTER_AMPSS_M0, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
> +DEFINE_QNODE(mas_tcu0, MASTER_TCU_0, 5, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
> +DEFINE_QNODE(mas_tcu1, MASTER_TCU_1, 6, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
> +DEFINE_QNODE(mas_gfx, MASTER_GRAPHICS_3D, 2, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
> +DEFINE_QNODE(bimc_snoc_mas, BIMC_SNOC_MAS, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, BIMC_SNOC_SLV);
> +DEFINE_QNODE(snoc_bimc_0_slv, SNOC_BIMC_0_SLV, 0, 8, 0, -1, 24, QCOM_QOS_MODE_FIXED, 1, SLAVE_EBI_CH0);
> +DEFINE_QNODE(snoc_bimc_1_slv, SNOC_BIMC_1_SLV, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SLAVE_EBI_CH0);
> +DEFINE_QNODE(slv_ebi_ch0, SLAVE_EBI_CH0, 0, 8, 0, -1, 0, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_apps_l2, SLAVE_AMPSS_L2, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(snoc_pnoc_slv, MNOC_BIMC_SLV, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_0);
> +DEFINE_QNODE(pnoc_int_0, PNOC_INT_0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 8, PNOC_SNOC_MAS, PNOC_SLV_0, PNOC_SLV_1, PNOC_SLV_2, PNOC_SLV_3, PNOC_SLV_4, PNOC_SLV_8, PNOC_SLV_9);
> +DEFINE_QNODE(pnoc_int_1, PNOC_INT_1, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_SNOC_MAS);
> +DEFINE_QNODE(pnoc_m_0, PNOC_M_0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_0);
> +DEFINE_QNODE(pnoc_m_1, PNOC_M_1, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_SNOC_MAS);
> +DEFINE_QNODE(pnoc_s_0, PNOC_SLV_0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_CLK_CTL, SLAVE_TLMM, SLAVE_MSM_TCSR, SLAVE_SECURITY, SLAVE_MSS);
> +DEFINE_QNODE(pnoc_s_1, PNOC_SLV_1, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_IMEM_CFG, SLAVE_CRYPTO_0_CFG, SLAVE_RPM_MSG_RAM, SLAVE_MSM_PDM, SLAVE_PRNG);
> +DEFINE_QNODE(pnoc_s_2, PNOC_SLV_2, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_SPDM, SLAVE_BOOT_ROM, SLAVE_BIMC_CFG, SLAVE_PNOC_CFG, SLAVE_PMIC_ARB);
> +DEFINE_QNODE(pnoc_s_3, PNOC_SLV_3, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_MPM, SLAVE_IPS_CFG, SLAVE_RBCPR_CFG, SLAVE_QDSS_CFG, SLAVE_DEHR_CFG);
> +DEFINE_QNODE(pnoc_s_4, PNOC_SLV_4, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_VENUS_CFG, SLAVE_CAMERA_CFG, SLAVE_DISPLAY_CFG);
> +DEFINE_QNODE(pnoc_s_8, PNOC_SLV_8, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_USB_HS, SLAVE_SDCC_1, SLAVE_BLSP_1);
> +DEFINE_QNODE(pnoc_s_9, PNOC_SLV_9, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_SDCC_4, SLAVE_LPASS, SLAVE_GRAPHICS_3D_CFG);
> +DEFINE_QNODE(slv_imem_cfg, SLAVE_IMEM_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_crypto_0_cfg, SLAVE_CRYPTO_0_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_msg_ram, SLAVE_RPM_MSG_RAM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_pdm, SLAVE_MSM_PDM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_prng, SLAVE_PRNG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_clk_ctl, SLAVE_CLK_CTL, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_mss, SLAVE_MSS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_tlmm, SLAVE_TLMM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_tcsr, SLAVE_MSM_TCSR, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_security, SLAVE_SECURITY, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_spdm, SLAVE_SPDM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_pnoc_cfg, SLAVE_PNOC_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_pmic_arb, SLAVE_PMIC_ARB, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_bimc_cfg, SLAVE_BIMC_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_boot_rom, SLAVE_BOOT_ROM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_mpm, SLAVE_MPM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_qdss_cfg, SLAVE_QDSS_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_rbcpr_cfg, SLAVE_RBCPR_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_snoc_cfg, SLAVE_IPS_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_dehr_cfg, SLAVE_DEHR_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_venus_cfg, SLAVE_VENUS_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_display_cfg, SLAVE_DISPLAY_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_camera_cfg, SLAVE_CAMERA_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_usb_hs, SLAVE_USB_HS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_sdcc_1, SLAVE_SDCC_1, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_blsp_1, SLAVE_BLSP_1, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_sdcc_2, SLAVE_SDCC_4, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_gfx_cfg, SLAVE_GRAPHICS_3D_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(slv_audio, SLAVE_LPASS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> +DEFINE_QNODE(mas_blsp_1, MASTER_BLSP_1, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_1);
> +DEFINE_QNODE(mas_spdm, MASTER_SPDM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_0);
> +DEFINE_QNODE(mas_dehr, MASTER_DEHR, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_0);
> +DEFINE_QNODE(mas_audio, MASTER_LPASS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_0);
> +DEFINE_QNODE(mas_usb_hs, MASTER_USB_HS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_1);
> +DEFINE_QNODE(mas_pnoc_crypto_0, MASTER_CRYPTO_CORE0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_1);
> +DEFINE_QNODE(mas_pnoc_sdcc_1, MASTER_SDCC_1, 7, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_1);
> +DEFINE_QNODE(mas_pnoc_sdcc_2, MASTER_SDCC_2, 8, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_1);
> +DEFINE_QNODE(pnoc_snoc_mas, PNOC_SNOC_MAS, 0, 8, 0, 29, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_SNOC_SLV);
> +
> +static struct qcom_icc_node *msm8916_snoc_nodes[] = {
> +       &mas_video,
> +       &mas_jpeg,
> +       &mas_vfe,
> +       &mas_mdp,
> +       &mas_qdss_bam,
> +       &mas_snoc_cfg,
> +       &mas_qdss_etr,
> +       &mm_int_0,
> +       &mm_int_1,
> +       &mm_int_2,
> +       &mm_int_bimc,
> +       &snoc_int_0,
> +       &snoc_int_1,
> +       &snoc_int_bimc,
> +       &snoc_bimc_0_mas,
> +       &snoc_bimc_1_mas,
> +       &qdss_int,
> +       &bimc_snoc_slv,
> +       &snoc_pnoc_mas,
> +       &pnoc_snoc_slv,
> +       &slv_srvc_snoc,
> +       &slv_qdss_stm,
> +       &slv_imem,
> +       &slv_apss,
> +       &slv_cats_0,
> +       &slv_cats_1,
> +};
> +
> +static struct qcom_icc_desc msm8916_snoc = {
> +       .nodes = msm8916_snoc_nodes,
> +       .num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
> +};
> +
> +static struct qcom_icc_node *msm8916_bimc_nodes[] = {
> +       &mas_apss,
> +       &mas_tcu0,
> +       &mas_tcu1,
> +       &mas_gfx,
> +       &bimc_snoc_mas,
> +       &snoc_bimc_0_slv,
> +       &snoc_bimc_1_slv,
> +       &slv_ebi_ch0,
> +       &slv_apps_l2,
> +};
> +
> +static struct qcom_icc_desc msm8916_bimc = {
> +       .nodes = msm8916_bimc_nodes,
> +       .num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
> +};
> +
> +static struct qcom_icc_node *msm8916_pnoc_nodes[] = {
> +       &snoc_pnoc_slv,
> +       &pnoc_int_0,
> +       &pnoc_int_1,
> +       &pnoc_m_0,
> +       &pnoc_m_1,
> +       &pnoc_s_0,
> +       &pnoc_s_1,
> +       &pnoc_s_2,
> +       &pnoc_s_3,
> +       &pnoc_s_4,
> +       &pnoc_s_8,
> +       &pnoc_s_9,
> +       &slv_imem_cfg,
> +       &slv_crypto_0_cfg,
> +       &slv_msg_ram,
> +       &slv_pdm,
> +       &slv_prng,
> +       &slv_clk_ctl,
> +       &slv_mss,
> +       &slv_tlmm,
> +       &slv_tcsr,
> +       &slv_security,
> +       &slv_spdm,
> +       &slv_pnoc_cfg,
> +       &slv_pmic_arb,
> +       &slv_bimc_cfg,
> +       &slv_boot_rom,
> +       &slv_mpm,
> +       &slv_qdss_cfg,
> +       &slv_rbcpr_cfg,
> +       &slv_snoc_cfg,
> +       &slv_dehr_cfg,
> +       &slv_venus_cfg,
> +       &slv_display_cfg,
> +       &slv_camera_cfg,
> +       &slv_usb_hs,
> +       &slv_sdcc_1,
> +       &slv_blsp_1,
> +       &slv_sdcc_2,
> +       &slv_gfx_cfg,
> +       &slv_audio,
> +       &mas_blsp_1,
> +       &mas_spdm,
> +       &mas_dehr,
> +       &mas_audio,
> +       &mas_usb_hs,
> +       &mas_pnoc_crypto_0,
> +       &mas_pnoc_sdcc_1,
> +       &mas_pnoc_sdcc_2,
> +       &pnoc_snoc_mas,
> +};
> +
> +static struct qcom_icc_desc msm8916_pnoc = {
> +       .nodes = msm8916_pnoc_nodes,
> +       .num_nodes = ARRAY_SIZE(msm8916_pnoc_nodes),
> +};
> +
> +static int qcom_icc_init(struct icc_node *node)
> +{
> +       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
> +       int ret;
> +
> +       /* TODO: init qos and priority */
> +
> +       clk_set_rate(qp->bus_clk, INT_MAX);

Vroom! What's the rationale here? I wonder if it might be better to
avoid touching the clocks initially, and expect that the boot loader
sets up a decent initial set of bus frequencies for consumers that
never enable bus scaling? Otherwise, I worry that this driver becomes
basically an essential driver for the platform solely because of this
line and the one below, when really it might not be.

> +       ret = clk_prepare_enable(qp->bus_clk);
> +       if (ret)
> +               pr_info("%s: error enabling bus clk (%d)\n", __func__, ret);
> +       clk_set_rate(qp->bus_a_clk, INT_MAX);
> +       ret = clk_prepare_enable(qp->bus_a_clk);
> +       if (ret)
> +               pr_info("%s: error enabling bus_a clk (%d)\n", __func__, ret);
> +
> +       return 0;
> +}
> +
> +static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw, u32 peak_bw,
> +                             u32 *agg_avg, u32 *agg_peak)
> +{
> +       *agg_avg += avg_bw;
> +       *agg_peak = max(*agg_peak, peak_bw);
> +
> +       return 0;
> +}
> +
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
> +                       u32 avg, u32 peak)
> +{
> +       struct qcom_icc_provider *qp;
> +       struct qcom_icc_node *qn;
> +       struct icc_node *node;
> +       struct icc_provider *provider;
> +       u64 avg_bw = icc_units_to_bps(avg);
> +       u64 peak_bw = icc_units_to_bps(peak);
> +       u64 rate = 0;
> +       int ret = 0;
> +
> +       if (!src)
> +               node = dst;
> +       else
> +               node = src;
> +
> +       qn = node->data;
> +       provider = node->provider;
> +       qp = to_qcom_provider(node->provider);
> +
> +       /* set bandwidth */
> +       if (qn->ap_owned) {
> +               /* TODO: set QoS */
> +       } else {
> +               /* send message to the RPM processor */
> +               if (qn->mas_rpm_id != -1) {
> +                       ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> +                                                   RPM_BUS_MASTER_REQ,
> +                                                   qn->mas_rpm_id,
> +                                                   avg_bw);

You don't check for failure here, and potentially clobber failure with
success. Unless only one of mas_rpm_id and slv_rpm_id is ever set. But
no, I see SNOC_INT_0/1 set both. Same for below.

> +               }
> +
> +               if (qn->slv_rpm_id != -1) {
> +                       ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> +                                                   RPM_BUS_SLAVE_REQ,
> +                                                   qn->slv_rpm_id,
> +                                                   avg_bw);
> +               }
> +       }
> +
> +       rate = max(avg_bw, peak_bw);
> +
> +       do_div(rate, qn->buswidth);
> +
> +       if (qn->rate != rate) {
> +               ret = clk_set_rate(qp->bus_clk, rate);
> +               if (ret) {
> +                       pr_err("set clk rate %lld error %d\n", rate, ret);
> +                       return ret;
> +               }
> +
> +               ret = clk_set_rate(qp->bus_a_clk, rate);
> +               if (ret) {
> +                       pr_err("set clk rate %lld error %d\n", rate, ret);
> +                       return ret;
> +               }
> +
> +               qn->rate = rate;
> +       }
> +
> +       return ret;
> +}
> +
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +       const struct qcom_icc_desc *desc;
> +       struct qcom_icc_node **qnodes;
> +       struct qcom_icc_provider *qp;
> +       struct resource *res;
> +       struct icc_provider *provider;
> +       size_t num_nodes, i;
> +       int ret;
> +
> +       /* wait for RPM */
> +       if (!qcom_icc_rpm_smd_available())
> +               return -EPROBE_DEFER;
> +
> +       desc = of_device_get_match_data(&pdev->dev);
> +       if (!desc)
> +               return -EINVAL;
> +
> +       qnodes = desc->nodes;
> +       num_nodes = desc->num_nodes;
> +
> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
> +       if (!qp)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       qp->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(qp->base))
> +               return PTR_ERR(qp->base);
> +
> +       qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> +       if (IS_ERR(qp->bus_clk))
> +               return PTR_ERR(qp->bus_clk);
> +
> +       qp->bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
> +       if (IS_ERR(qp->bus_a_clk))
> +               return PTR_ERR(qp->bus_a_clk);
> +
> +       provider = &qp->provider;
> +       provider->dev = &pdev->dev;
> +       provider->set = &qcom_icc_set;
> +       provider->aggregate = &qcom_icc_aggregate;
> +       INIT_LIST_HEAD(&provider->nodes);
> +       provider->data = qp;
> +
> +       ret = icc_provider_add(provider);
> +       if (ret) {
> +               dev_err(&pdev->dev, "error adding interconnect provider\n");
> +               return ret;
> +       }
> +
> +       for (i = 0; i < num_nodes; i++) {
> +               struct icc_node *node;
> +               int ret;
> +               size_t j;
> +
> +               node = icc_node_create(qnodes[i]->id);
> +               if (IS_ERR(node)) {
> +                       ret = PTR_ERR(node);
> +                       goto err;
> +               }
> +
> +               node->name = qnodes[i]->name;
> +               node->data = qnodes[i];
> +               icc_node_add(node, provider);
> +
> +               dev_dbg(&pdev->dev, "registered node %s\n", node->name);
> +
> +               ret = qcom_icc_init(node);
> +               if (ret)
> +                       dev_err(&pdev->dev, "%s init error (%d)\n", node->name,
> +                               ret);
> +
> +               /* populate links */
> +               for (j = 0; j < qnodes[i]->num_links; j++)
> +                       if (qnodes[i]->links[j])
> +                               icc_link_create(node, qnodes[i]->links[j]);
> +       }
> +
> +       platform_set_drvdata(pdev, provider);
> +
> +       return ret;
> +err:
> +       icc_provider_del(provider);
> +       return ret;
> +}
> +
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +       struct icc_provider *provider = platform_get_drvdata(pdev);
> +
> +       icc_provider_del(provider);

This function can fail, so you should probably pass the failure along.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id qnoc_of_match[] = {
> +       { .compatible = "qcom,msm8916-pnoc", .data = &msm8916_pnoc },
> +       { .compatible = "qcom,msm8916-snoc", .data = &msm8916_snoc },
> +       { .compatible = "qcom,msm8916-bimc", .data = &msm8916_bimc },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +       .probe = qnoc_probe,
> +       .remove = qnoc_remove,
> +       .driver = {
> +               .name = "qnoc-msm8916",
> +               .of_match_table = qnoc_of_match,
> +       },
> +};
> +module_platform_driver(qnoc_driver);
> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm msm8916 NoC driver");
> +MODULE_LICENSE("GPL v2");
