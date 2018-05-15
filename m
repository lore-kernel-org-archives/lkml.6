Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeEOLXf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:23:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58796 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752740AbeEOLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:23:33 -0400
Subject: Re: [RFC PATCH 01/10] devfreq: rockchip-dfi: Move GRF definitions to
 a common place.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc: Lin Huang <hl@rock-chips.com>, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        Sean Paul <seanpaul@chromium.org>, kernel@collabora.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-2-enric.balletbo@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c217cf74-c5fe-4e4b-7b55-7672381b3eaf@arm.com>
Date: Tue, 15 May 2018 12:23:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514211610.26618-2-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 14/05/18 22:16, Enric Balletbo i Serra wrote:
> Some rk3399 GRF (Generic Register Files) definitions can be used for
> different drivers. Move these definitions to a common include so we
> don't need to duplicate these definitions.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
>   include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
>   2 files changed, 28 insertions(+), 16 deletions(-)
>   create mode 100644 include/soc/rockchip/rk3399_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 22b113363ffc..2fbbcbeb644f 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,6 +26,8 @@
>   #include <linux/list.h>
>   #include <linux/of.h>
>   
> +#include <soc/rockchip/rk3399_grf.h>
> +
>   #define RK3399_DMC_NUM_CH	2
>   
>   /* DDRMON_CTRL */
> @@ -43,18 +45,6 @@
>   #define DDRMON_CH1_COUNT_NUM		0x3c
>   #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>   
> -/* pmu grf */
> -#define PMUGRF_OS_REG2	0x308
> -#define DDRTYPE_SHIFT	13
> -#define DDRTYPE_MASK	7
> -
> -enum {
> -	DDR3 = 3,
> -	LPDDR3 = 6,
> -	LPDDR4 = 7,
> -	UNUSED = 0xFF
> -};
> -
>   struct dmc_usage {
>   	u32 access;
>   	u32 total;
> @@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>   	u32 ddr_type;
>   
>   	/* get ddr type */
> -	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
> +	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
>   
>   	/* clear DDRMON_CTRL setting */
>   	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>   
>   	/* set ddr type to dfi */
> -	if (ddr_type == LPDDR3)
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
>   		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type == LPDDR4)
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
>   		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>   
>   	/* enable count, use software mode */
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
> new file mode 100644
> index 000000000000..0f94034e2e9a
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip Generic Register Files definitions

Nit: s/Generic/General/

(that's what the TRMs say)

Robin.

> + *
> + * Copyright (c) 2018, Collabora Ltd.
> + * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> + */
> +
> +#ifndef __SOC_RK3399_GRF_H
> +#define __SOC_RK3399_GRF_H
> +
> +/* PMU GRF Registers */
> +#define RK3399_PMUGRF_OS_REG2		0x308
> +#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> +#define RK3399_PMUGRF_DDRTYPE_MASK	7
> +#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +
> +#endif
> 
