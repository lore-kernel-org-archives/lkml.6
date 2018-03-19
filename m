Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030231AbeCSRwS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:52:18 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40359 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965752AbeCSRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:52:10 -0400
X-Google-Smtp-Source: AG47ELsyxYDKwRZ9MhNvhft3ZYJQImf5+SErAKzO3iy6Wo0lBnVpSWcb2D4QgwgPtKt3DZ9loIxGUg==
MIME-Version: 1.0
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org> <1521193500-4696-5-git-send-email-mgautam@codeaurora.org>
In-Reply-To: <1521193500-4696-5-git-send-email-mgautam@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 19 Mar 2018 17:51:31 +0000
X-Gmail-Original-Message-ID: <CAE=gft6yM58dru2DnjASbi+YG_KanDbBhO2nCLBerZw4NjT-=g@mail.gmail.com>
Message-ID: <CAE=gft6yM58dru2DnjASbi+YG_KanDbBhO2nCLBerZw4NjT-=g@mail.gmail.com>
Subject: Re: [PATCH 4/6] phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
To: Manu Gautam <mgautam@codeaurora.org>
Cc: kishon@ti.com, linux-arm-msm@vger.kernel.org,
        vivek.gautam@codeaurora.org, varada@codeaurora.org,
        weiyongjun1@huawei.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manu,

On Fri, Mar 16, 2018 at 2:46 AM Manu Gautam <mgautam@codeaurora.org> wrote:

> QMP V3 UNI PHY is a single lane USB3 PHY without support
> for DisplayPort (DP).
> Main difference from DP combo QMPv3 PHY is that UNI PHY
> doesn't have dual RX/TX lanes and no separate DP_COM
> block for configuration related to type-c or DP.
> While at it, fix has_pwrdn_delay attribute for USB-DP
> PHY configuration.

> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp.c | 148
++++++++++++++++++++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp.h |   5 ++
>   2 files changed, 153 insertions(+)

...
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h
b/drivers/phy/qualcomm/phy-qcom-qmp.h
> index d1c6905..5d78d43 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
> @@ -214,6 +214,8 @@
>   #define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN            0x030
>   #define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE    0x034
>   #define QSERDES_V3_RX_RX_TERM_BW                       0x07c
> +#define QSERDES_V3_RX_VGA_CAL_CNTRL1                   0x0bc

I noticed you add this definition, but never use it. Are you missing a
QMP_PHY_INIT_CFG line for this register in qmp_v3_usb3_uniphy_rx_tbl[], or
is that register "don't care"? It looks important, and while its default
value out of reset might be valid, you never know what nutty value boot
firmware might set it to.

> +#define QSERDES_V3_RX_VGA_CAL_CNTRL2                   0x0c0
>   #define QSERDES_V3_RX_RX_EQ_GAIN2_LSB                  0x0c8
>   #define QSERDES_V3_RX_RX_EQ_GAIN2_MSB                  0x0cc
>   #define QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2            0x0d4
> @@ -227,6 +229,7 @@
>   #define QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL            0x10c
>   #define QSERDES_V3_RX_RX_BAND                          0x110
>   #define QSERDES_V3_RX_RX_INTERFACE_MODE                        0x11c
> +#define QSERDES_V3_RX_RX_MODE_00                       0x164

>   /* Only for QMP V3 PHY - PCS registers */
>   #define QPHY_V3_PCS_POWER_DOWN_CONTROL                 0x004
> @@ -273,6 +276,8 @@
>   #define QPHY_V3_PCS_FLL_CNT_VAL_H_TOL                  0x0d0
>   #define QPHY_V3_PCS_FLL_MAN_CODE                       0x0d4
>   #define QPHY_V3_PCS_RX_SIGDET_LVL                      0x1d8
> +#define QPHY_V3_PCS_REFGEN_REQ_CONFIG1                 0x20c
> +#define QPHY_V3_PCS_REFGEN_REQ_CONFIG2                 0x210

>   /* Only for QMP V3 PHY - PCS_MISC registers */
>   #define QPHY_V3_PCS_MISC_CLAMP_ENABLE                  0x0c
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
