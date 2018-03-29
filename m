Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeC2UiP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:38:15 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33946 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeC2UiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:38:11 -0400
X-Google-Smtp-Source: AIpwx49LSo4/8tDAz11uOoy2adOv4vvOFEzGS4U4yXr99ndVN9y7zGMc63zk+lBP024vMLgRzaMwv1oYD1E48xaGdH4=
MIME-Version: 1.0
In-Reply-To: <1522321466-21755-8-git-send-email-mgautam@codeaurora.org>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org> <1522321466-21755-8-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Mar 2018 13:38:09 -0700
X-Google-Sender-Auth: w5DRGgAfEP_hoShV8ZEREXK3fGY
Message-ID: <CAD=FV=X70gNedZjCiKQTOqtDf5UttViAiibgRjCoKWVJZqcKEQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 29, 2018 at 4:04 AM, Manu Gautam <mgautam@codeaurora.org> wrote:
> There are two QUSB2 PHYs present on sdm845. In order
> to improve eye diagram for both the PHYs some parameters
> need to be changed. Provide device tree properties to
> override these from board specific device tree files.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 112 +++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 40fdef8..adcc3f8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -60,6 +60,17 @@
>  #define CORE_RESET                             BIT(5)
>  #define CORE_RESET_MUX                         BIT(6)
>
> +/* QUSB2PHY_IMP_CTRL1 register bits */
> +#define IMP_RES_OFFSET_MASK                    GENMASK(5, 0)
> +#define IMP_RES_OFFSET_SHIFT                   0x0
> +
> +/* QUSB2PHY_PORT_TUNE1 register bits */
> +#define HSTX_TRIM_MASK                         GENMASK(7, 4)
> +#define HSTX_TRIM_SHIFT                                0x4
> +#define PREEMPH_HALF_WIDTH                     BIT(2)
> +#define PREEMPHASIS_EN_MASK                    GENMASK(1, 0)
> +#define PREEMPHASIS_EN_SHIFT                   0x0
> +
>  #define QUSB2PHY_PLL_ANALOG_CONTROLS_TWO       0x04
>  #define QUSB2PHY_PLL_CLOCK_INVERTERS           0x18c
>  #define QUSB2PHY_PLL_CMODE                     0x2c
> @@ -241,6 +252,18 @@ struct qusb2_phy_cfg {
>   * @tcsr: TCSR syscon register map
>   * @cell: nvmem cell containing phy tuning value
>   *
> + * @override_imp_res_offset: PHY should use different rescode offset
> + * @imp_res_offset_value: rescode offset to be updated in IMP_CTRL1 register
> + *
> + * @override_hstx_trim: PHY should use different HSTX o/p current value
> + * @hstx_trim_value: HSTX_TRIM value to be updated in TUNE1 register
> + *
> + * @override_preemphasis: PHY should use different pre-amphasis amplitude
> + * @preemphasis_level: Amplitude Pre-Emphasis to be updated in TUNE1 register
> + *
> + * @override_preemphasis_width: PHY should use different pre-emphasis duration
> + * @preemphasis_width: half/full-width Pre-Emphasis updated via TUNE1
> + *

nit: spacing here doesn't match spacing in the structure.  AKA: you've
smashed together all 8 properties in the structure but not in the
description.


>   * @cfg: phy config data
>   * @has_se_clk_scheme: indicate if PHY has single-ended ref clock scheme
>   * @phy_initialized: indicate if PHY has been initialized
> @@ -259,12 +282,35 @@ struct qusb2_phy {
>         struct regmap *tcsr;
>         struct nvmem_cell *cell;
>
> +       bool override_imp_res_offset;
> +       u8 imp_res_offset_value;
> +       bool override_hstx_trim;
> +       u8 hstx_trim_value;
> +       bool override_preemphasis;
> +       u8 preemphasis_level;
> +       bool override_preemphasis_width;
> +       u8 preemphasis_width;
> +
>         const struct qusb2_phy_cfg *cfg;
>         bool has_se_clk_scheme;
>         bool phy_initialized;
>         enum phy_mode mode;
>  };
>
> +static inline void qusb2_write_mask(void __iomem *base, u32 offset,
> +                                   u32 val, u32 mask)
> +{
> +       u32 reg;
> +
> +       reg = readl(base + offset);
> +       reg &= ~mask;
> +       reg |= val;

"reg |= (val & mask)" instead of just "reg |= val"

You don't do any bounds checking of the device tree entries and this
will at least make sure that a bad value for a field won't screw up
other fields (and so, presumably, it will be easier to find the bug).


> +       writel(reg, base + offset);
> +
> +       /* Ensure above write is completed */
> +       readl(base + offset);

You're using readl() and writel() which have barriers.  Why do you
need this extra readl()?


> +}
> +
>  static inline void qusb2_setbits(void __iomem *base, u32 offset, u32 val)
>  {
>         u32 reg;
> @@ -305,6 +351,42 @@ void qcom_qusb2_phy_configure(void __iomem *base,
>  }
>
>  /*
> + * Update board specific PHY tuning override values if specified from
> + * device tree.
> + *

nit: remove extra comment line with just a "*" on it.


> + */
> +static void qusb2_phy_override_phy_params(struct qusb2_phy *qphy)
> +{
> +       const struct qusb2_phy_cfg *cfg = qphy->cfg;
> +
> +       if (qphy->override_imp_res_offset)
> +               qusb2_write_mask(qphy->base, QUSB2PHY_IMP_CTRL1,
> +                            qphy->imp_res_offset_value << IMP_RES_OFFSET_SHIFT,
> +                            IMP_RES_OFFSET_MASK);
> +
> +       if (qphy->override_hstx_trim)
> +               qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
> +                                qphy->hstx_trim_value << HSTX_TRIM_SHIFT,
> +                                HSTX_TRIM_MASK);
> +
> +       if (qphy->override_preemphasis)
> +               qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
> +                               qphy->preemphasis_level << PREEMPHASIS_EN_SHIFT,
> +                               PREEMPHASIS_EN_MASK);
> +
> +       if (qphy->override_preemphasis_width) {
> +               if (qphy->preemphasis_width)
> +                       qusb2_setbits(qphy->base,
> +                                     cfg->regs[QUSB2PHY_PORT_TUNE1],
> +                                     PREEMPH_HALF_WIDTH);
> +               else
> +                       qusb2_clrbits(qphy->base,
> +                                     cfg->regs[QUSB2PHY_PORT_TUNE1],
> +                                     PREEMPH_HALF_WIDTH);
> +       }
> +}
> +
> +/*
>   * Fetches HS Tx tuning value from nvmem and sets the
>   * QUSB2PHY_PORT_TUNE1/2 register.
>   * For error case, skip setting the value and use the default value.
> @@ -525,6 +607,9 @@ static int qusb2_phy_init(struct phy *phy)
>         qcom_qusb2_phy_configure(qphy->base, cfg->regs, cfg->tbl,
>                                  cfg->tbl_num);
>
> +       /* Override board specific PHY tuning values */
> +       qusb2_phy_override_phy_params(qphy);
> +
>         /* Set efuse value for tuning the PHY */
>         qusb2_phy_set_tune2_param(qphy);
>
> @@ -647,7 +732,7 @@ static int qusb2_phy_exit(struct phy *phy)
>                 .compatible     = "qcom,msm8996-qusb2-phy",
>                 .data           = &msm8996_phy_cfg,
>         }, {
> -               .compatible     = "qcom,qusb2-v2-phy",
> +               .compatible     = "qcom,sdm845-qusb2-phy",
>                 .data           = &qusb2_v2_phy_cfg,

Can you change the name of the structure to match (AKA include sdm845?)


>         },
>         { },
> @@ -736,6 +821,31 @@ static int qusb2_phy_probe(struct platform_device *pdev)
>                 qphy->cell = NULL;
>                 dev_dbg(dev, "failed to lookup tune2 hstx trim value\n");
>         }
> +
> +       if (of_find_property(dev->of_node, "qcom,imp-res-offset-value", NULL)) {

Get rid of the extra of_find_property().  Just use the error code from
the property_read() to know if it was there and you've done two steps
in one (read it and know if it was there).


> +               qphy->override_imp_res_offset = true;
> +               of_property_read_u8(dev->of_node, "qcom,imp-res-offset-value",
> +                                   &qphy->imp_res_offset_value);

You probably don't want of_property_read_u8(), even if you intend the
property to bit in 8 bits.  You probably want to use
of_property_read_u32() to read into a temporary value and then copy
that to your 8-bit structure element.

If you use of_property_read_u8 then you have to "/bits/ 8" in the
device tree and that's ugly and doesn't seem to be what's done very
often.  People just always stick a u32 in the device tree.



-Doug
