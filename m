Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeEGN74 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:59:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33607 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeEGN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:59:51 -0400
X-Google-Smtp-Source: AB8JxZp7Zn1aptVK9/Ei6XQcqTitPAUTGXkjYCdPTMs4Z9cLSp5qv0vlgHxOf8xe7TKRhkXh+lfFqYQAQ+v3RPHzqcc=
MIME-Version: 1.0
In-Reply-To: <1525421338-1021-2-git-send-email-hl@rock-chips.com>
References: <1525421338-1021-1-git-send-email-hl@rock-chips.com> <1525421338-1021-2-git-send-email-hl@rock-chips.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 7 May 2018 15:59:49 +0200
Message-ID: <CAFqH_511VgKG+_rqPNGf5Ez2+tc_ijqNQA_rYW1xr6903BSSoA@mail.gmail.com>
Subject: Re: [PATCH 2/4] phy: rockchip-typec: support variable phy config value
To: Lin Huang <hl@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Chris Zhong <zyw@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>, jani.nikula@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, daniel.vetter@intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

Thanks for the patch, apart from the new build warnings introduced
some more comments below.

2018-05-04 10:08 GMT+02:00 Lin Huang <hl@rock-chips.com>:
> the phy config values used to fix in dp firmware, but some boards
> need change these values to do training and get the better eye diagram
> result. So support that in phy driver.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-typec.c | 286 +++++++++++++++++++-----------
>  include/soc/rockchip/rockchip_phy_typec.h |  72 ++++++++
>  2 files changed, 259 insertions(+), 99 deletions(-)
>  create mode 100644 include/soc/rockchip/rockchip_phy_typec.h
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 76a4b58..831a93b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -63,6 +63,7 @@
>
>  #include <linux/mfd/syscon.h>
>  #include <linux/phy/phy.h>
> +#include <soc/rockchip/rockchip_phy_typec.h>
>
>  #define CMN_SSM_BANDGAP                        (0x21 << 2)
>  #define CMN_SSM_BIAS                   (0x22 << 2)
> @@ -323,23 +324,31 @@
>   * clock 0: PLL 0 div 1
>   * clock 1: PLL 1 div 2
>   */
> -#define CLK_PLL_CONFIG                 0X30
> +#define CLK_PLL1_DIV1                  0x20
> +#define CLK_PLL1_DIV2                  0x30
>  #define CLK_PLL_MASK                   0x33
>
>  #define CMN_READY                      BIT(0)
>
> +#define DP_PLL_CLOCK_ENABLE_ACK                BIT(3)
>  #define DP_PLL_CLOCK_ENABLE            BIT(2)
> +#define DP_PLL_ENABLE_ACK              BIT(1)
>  #define DP_PLL_ENABLE                  BIT(0)
>  #define DP_PLL_DATA_RATE_RBR           ((2 << 12) | (4 << 8))
>  #define DP_PLL_DATA_RATE_HBR           ((2 << 12) | (4 << 8))
>  #define DP_PLL_DATA_RATE_HBR2          ((1 << 12) | (2 << 8))
> +#define DP_PLL_DATA_RATE_MASK          0xff00
>
> -#define DP_MODE_A0                     BIT(4)
> -#define DP_MODE_A2                     BIT(6)
> -#define DP_MODE_ENTER_A0               0xc101
> -#define DP_MODE_ENTER_A2               0xc104
> +#define DP_MODE_MASK                   0xf
> +#define DP_MODE_ENTER_A0               BIT(0)
> +#define DP_MODE_ENTER_A2               BIT(2)
> +#define DP_MODE_ENTER_A3               BIT(3)
> +#define DP_MODE_A0_ACK                 BIT(4)
> +#define DP_MODE_A2_ACK                 BIT(6)
> +#define DP_MODE_A3_ACK                 BIT(7)
> +#define DP_LINK_RESET_DEASSERTED       BIT(8)
>
> -#define PHY_MODE_SET_TIMEOUT           100000
> +#define PHY_MODE_SET_TIMEOUT           1000000
>

Why do you need to increase this timeout? Is because the software link
training timed out using the old value?


>  #define PIN_ASSIGN_C_E                 0x51d9
>  #define PIN_ASSIGN_D_F                 0x5100
> @@ -349,51 +358,7 @@
>  #define MODE_DFP_USB                   BIT(1)
>  #define MODE_DFP_DP                    BIT(2)
>
> -struct usb3phy_reg {
> -       u32 offset;
> -       u32 enable_bit;
> -       u32 write_enable;
> -};
> -
> -/**
> - * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
> - * @reg: the base address for usb3-phy config.
> - * @typec_conn_dir: the register of type-c connector direction.
> - * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
> - * @external_psm: the register of type-c phy external psm clock.
> - * @pipe_status: the register of type-c phy pipe status.
> - * @usb3_host_disable: the register of type-c usb3 host disable.
> - * @usb3_host_port: the register of type-c usb3 host port.
> - * @uphy_dp_sel: the register of type-c phy DP select control.
> - */
> -struct rockchip_usb3phy_port_cfg {
> -       unsigned int reg;
> -       struct usb3phy_reg typec_conn_dir;
> -       struct usb3phy_reg usb3tousb2_en;
> -       struct usb3phy_reg external_psm;
> -       struct usb3phy_reg pipe_status;
> -       struct usb3phy_reg usb3_host_disable;
> -       struct usb3phy_reg usb3_host_port;
> -       struct usb3phy_reg uphy_dp_sel;
> -};
> -
> -struct rockchip_typec_phy {
> -       struct device *dev;
> -       void __iomem *base;
> -       struct extcon_dev *extcon;
> -       struct regmap *grf_regs;
> -       struct clk *clk_core;
> -       struct clk *clk_ref;
> -       struct reset_control *uphy_rst;
> -       struct reset_control *pipe_rst;
> -       struct reset_control *tcphy_rst;
> -       const struct rockchip_usb3phy_port_cfg *port_cfgs;
> -       /* mutex to protect access to individual PHYs */
> -       struct mutex lock;
> -
> -       bool flip;
> -       u8 mode;
> -};
> +#define DEFAULT_RATE                   162000
>

DEFAULT_RATE seems a very common name for me, maybe add a prefix?


>  struct phy_reg {
>         u16 value;
> @@ -417,15 +382,15 @@ struct phy_reg usb3_pll_cfg[] = {
>         { 0x8,          CMN_DIAG_PLL0_LF_PROG },
>  };
>
> -struct phy_reg dp_pll_cfg[] = {
> +struct phy_reg dp_pll_rbr_cfg[] = {
>         { 0xf0,         CMN_PLL1_VCOCAL_INIT },
>         { 0x18,         CMN_PLL1_VCOCAL_ITER },
>         { 0x30b9,       CMN_PLL1_VCOCAL_START },
> -       { 0x21c,        CMN_PLL1_INTDIV },
> +       { 0x87,         CMN_PLL1_INTDIV },
>         { 0,            CMN_PLL1_FRACDIV },
> -       { 0x5,          CMN_PLL1_HIGH_THR },
> -       { 0x35,         CMN_PLL1_SS_CTRL1 },
> -       { 0x7f1e,       CMN_PLL1_SS_CTRL2 },
> +       { 0x22,         CMN_PLL1_HIGH_THR },
> +       { 0x8000,       CMN_PLL1_SS_CTRL1 },
> +       { 0,            CMN_PLL1_SS_CTRL2 },
>         { 0x20,         CMN_PLL1_DSM_DIAG },
>         { 0,            CMN_PLLSM1_USER_DEF_CTRL },
>         { 0,            CMN_DIAG_PLL1_OVRD },
> @@ -436,9 +401,52 @@ struct phy_reg dp_pll_cfg[] = {
>         { 0x8,          CMN_DIAG_PLL1_LF_PROG },
>         { 0x100,        CMN_DIAG_PLL1_PTATIS_TUNE1 },
>         { 0x7,          CMN_DIAG_PLL1_PTATIS_TUNE2 },
> -       { 0x4,          CMN_DIAG_PLL1_INCLK_CTRL },
> +       { 0x1,          CMN_DIAG_PLL1_INCLK_CTRL },
> +};
> +
> +struct phy_reg dp_pll_hbr_cfg[] = {
> +       { 0xf0,         CMN_PLL1_VCOCAL_INIT },
> +       { 0x18,         CMN_PLL1_VCOCAL_ITER },
> +       { 0x30b4,       CMN_PLL1_VCOCAL_START },
> +       { 0xe1,         CMN_PLL1_INTDIV },
> +       { 0,            CMN_PLL1_FRACDIV },
> +       { 0x5,          CMN_PLL1_HIGH_THR },
> +       { 0x8000,       CMN_PLL1_SS_CTRL1 },
> +       { 0,            CMN_PLL1_SS_CTRL2 },
> +       { 0x20,         CMN_PLL1_DSM_DIAG },
> +       { 0x1000,       CMN_PLLSM1_USER_DEF_CTRL },
> +       { 0,            CMN_DIAG_PLL1_OVRD },
> +       { 0,            CMN_DIAG_PLL1_FBH_OVRD },
> +       { 0,            CMN_DIAG_PLL1_FBL_OVRD },
> +       { 0x7,          CMN_DIAG_PLL1_V2I_TUNE },
> +       { 0x45,         CMN_DIAG_PLL1_CP_TUNE },
> +       { 0x8,          CMN_DIAG_PLL1_LF_PROG },
> +       { 0x1,          CMN_DIAG_PLL1_PTATIS_TUNE1 },
> +       { 0x1,          CMN_DIAG_PLL1_PTATIS_TUNE2 },
> +       { 0x1,          CMN_DIAG_PLL1_INCLK_CTRL },
>  };
>
> +struct phy_reg dp_pll_hbr2_cfg[] = {
> +       { 0xf0,         CMN_PLL1_VCOCAL_INIT },
> +       { 0x18,         CMN_PLL1_VCOCAL_ITER },
> +       { 0x30b4,       CMN_PLL1_VCOCAL_START },
> +       { 0xe1,         CMN_PLL1_INTDIV },
> +       { 0,            CMN_PLL1_FRACDIV },
> +       { 0x5,          CMN_PLL1_HIGH_THR },
> +       { 0x8000,       CMN_PLL1_SS_CTRL1 },
> +       { 0,            CMN_PLL1_SS_CTRL2 },
> +       { 0x20,         CMN_PLL1_DSM_DIAG },
> +       { 0x1000,       CMN_PLLSM1_USER_DEF_CTRL },
> +       { 0,            CMN_DIAG_PLL1_OVRD },
> +       { 0,            CMN_DIAG_PLL1_FBH_OVRD },
> +       { 0,            CMN_DIAG_PLL1_FBL_OVRD },
> +       { 0x7,          CMN_DIAG_PLL1_V2I_TUNE },
> +       { 0x45,         CMN_DIAG_PLL1_CP_TUNE },
> +       { 0x8,          CMN_DIAG_PLL1_LF_PROG },
> +       { 0x1,          CMN_DIAG_PLL1_PTATIS_TUNE1 },
> +       { 0x1,          CMN_DIAG_PLL1_PTATIS_TUNE2 },
> +       { 0x1,          CMN_DIAG_PLL1_INCLK_CTRL },
> +};
>  static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
>         {
>                 .reg = 0xff7c0000,
> @@ -484,7 +492,7 @@ static void tcphy_cfg_24m(struct rockchip_typec_phy *tcphy)
>
>         rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
>         rdata &= ~CLK_PLL_MASK;
> -       rdata |= CLK_PLL_CONFIG;
> +       rdata |= CLK_PLL1_DIV2;
>         writel(rdata, tcphy->base + CMN_DIAG_HSCLK_SEL);
>  }
>
> @@ -498,17 +506,44 @@ static void tcphy_cfg_usb3_pll(struct rockchip_typec_phy *tcphy)
>                        tcphy->base + usb3_pll_cfg[i].addr);
>  }
>
> -static void tcphy_cfg_dp_pll(struct rockchip_typec_phy *tcphy)
> +static void tcphy_cfg_dp_pll(struct rockchip_typec_phy *tcphy, int link_rate)
>  {
> -       u32 i;
> +       struct phy_reg *phy_cfg;
> +       u32 clk_ctrl;
> +       u32 i, cfg_size, hsclk_sel;
> +
> +       hsclk_sel = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
> +       hsclk_sel &= ~CLK_PLL_MASK;
> +
> +       switch (link_rate) {
> +       case 162000:
> +               clk_ctrl = DP_PLL_DATA_RATE_RBR;
> +               hsclk_sel |= CLK_PLL1_DIV2;
> +               phy_cfg = dp_pll_rbr_cfg;
> +               cfg_size = ARRAY_SIZE(dp_pll_rbr_cfg);
> +               break;
> +       case 270000:
> +               clk_ctrl = DP_PLL_DATA_RATE_HBR;
> +               hsclk_sel |= CLK_PLL1_DIV2;
> +               phy_cfg = dp_pll_hbr_cfg;
> +               cfg_size = ARRAY_SIZE(dp_pll_hbr_cfg);
> +               break;
> +       case 540000:
> +               clk_ctrl = DP_PLL_DATA_RATE_HBR2;
> +               hsclk_sel |= CLK_PLL1_DIV1;
> +               phy_cfg = dp_pll_hbr2_cfg;
> +               cfg_size = ARRAY_SIZE(dp_pll_hbr2_cfg);
> +               break;
> +       }
> +
> +       clk_ctrl |= DP_PLL_CLOCK_ENABLE | DP_PLL_ENABLE;
> +       writel(clk_ctrl, tcphy->base + DP_CLK_CTL);
>
> -       /* set the default mode to RBR */
> -       writel(DP_PLL_CLOCK_ENABLE | DP_PLL_ENABLE | DP_PLL_DATA_RATE_RBR,
> -              tcphy->base + DP_CLK_CTL);
> +       writel(hsclk_sel, tcphy->base + CMN_DIAG_HSCLK_SEL);
>
>         /* load the configuration of PLL1 */
> -       for (i = 0; i < ARRAY_SIZE(dp_pll_cfg); i++)
> -               writel(dp_pll_cfg[i].value, tcphy->base + dp_pll_cfg[i].addr);
> +       for (i = 0; i < cfg_size; i++)
> +               writel(phy_cfg[i].value, tcphy->base + phy_cfg[i].addr);
>  }
>
>  static void tcphy_tx_usb3_cfg_lane(struct rockchip_typec_phy *tcphy, u32 lane)
> @@ -535,9 +570,10 @@ static void tcphy_rx_usb3_cfg_lane(struct rockchip_typec_phy *tcphy, u32 lane)
>         writel(0xfb, tcphy->base + XCVR_DIAG_BIDI_CTRL(lane));
>  }
>
> -static void tcphy_dp_cfg_lane(struct rockchip_typec_phy *tcphy, u32 lane)
> +static void tcphy_dp_cfg_lane(struct rockchip_typec_phy *tcphy, int link_rate,
> +                             u8 swing, u8 pre_emp, u32 lane)
>  {
> -       u16 rdata;
> +       u16 val;

>From what I see you are only renaming rdata to val, there is any reason?

>
>         writel(0xbefc, tcphy->base + XCVR_PSM_RCTRL(lane));
>         writel(0x6799, tcphy->base + TX_PSC_A0(lane));
> @@ -545,25 +581,31 @@ static void tcphy_dp_cfg_lane(struct rockchip_typec_phy *tcphy, u32 lane)
>         writel(0x98, tcphy->base + TX_PSC_A2(lane));
>         writel(0x98, tcphy->base + TX_PSC_A3(lane));
>
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_000(lane));
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_001(lane));
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_010(lane));
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_011(lane));
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_100(lane));
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_101(lane));
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_110(lane));
> -       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_111(lane));
> -       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_10(lane));
> -       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_01(lane));
> -       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_00(lane));
> -       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_11(lane));
> -
> -       writel(0x128, tcphy->base + TX_TXCC_CAL_SCLR_MULT(lane));
> -       writel(0x400, tcphy->base + TX_DIAG_TX_DRV(lane));
> -
> -       rdata = readl(tcphy->base + XCVR_DIAG_PLLDRC_CTRL(lane));
> -       rdata = (rdata & 0x8fff) | 0x6000;
> -       writel(rdata, tcphy->base + XCVR_DIAG_PLLDRC_CTRL(lane));
> +       writel(tcphy->config[swing][pre_emp].swing,
> +              tcphy->base + TX_TXCC_MGNFS_MULT_000(lane));
> +       writel(tcphy->config[swing][pre_emp].pe,
> +              tcphy->base + TX_TXCC_CPOST_MULT_00(lane));
> +
> +       if (swing == 2 && pre_emp == 0 && link_rate != 540000) {
> +               writel(0x700, tcphy->base + TX_DIAG_TX_DRV(lane));
> +               writel(0x13c, tcphy->base + TX_TXCC_CAL_SCLR_MULT(lane));
> +       } else {
> +               writel(0x128, tcphy->base + TX_TXCC_CAL_SCLR_MULT(lane));
> +               writel(0x0400, tcphy->base + TX_DIAG_TX_DRV(lane));
> +       }
> +
> +       val = readl(tcphy->base + XCVR_DIAG_PLLDRC_CTRL(lane));
> +       val = val & 0x8fff;
> +       switch (link_rate) {
> +       case 162000:
> +       case 270000:
> +               val |= (6 << 12);
> +               break;
> +       case 540000:
> +               val |= (4 << 12);
> +               break;
> +       }
> +       writel(val, tcphy->base + XCVR_DIAG_PLLDRC_CTRL(lane));
>  }
>
>  static inline int property_enable(struct rockchip_typec_phy *tcphy,
> @@ -754,30 +796,33 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
>         tcphy_cfg_24m(tcphy);
>
>         if (mode == MODE_DFP_DP) {
> -               tcphy_cfg_dp_pll(tcphy);
> +               tcphy_cfg_dp_pll(tcphy, DEFAULT_RATE);
>                 for (i = 0; i < 4; i++)
> -                       tcphy_dp_cfg_lane(tcphy, i);
> +                       tcphy_dp_cfg_lane(tcphy, DEFAULT_RATE, 0, 0, i);
>
>                 writel(PIN_ASSIGN_C_E, tcphy->base + PMA_LANE_CFG);
>         } else {
>                 tcphy_cfg_usb3_pll(tcphy);
> -               tcphy_cfg_dp_pll(tcphy);
> +               tcphy_cfg_dp_pll(tcphy, DEFAULT_RATE);
>                 if (tcphy->flip) {
>                         tcphy_tx_usb3_cfg_lane(tcphy, 3);
>                         tcphy_rx_usb3_cfg_lane(tcphy, 2);
> -                       tcphy_dp_cfg_lane(tcphy, 0);
> -                       tcphy_dp_cfg_lane(tcphy, 1);
> +                       tcphy_dp_cfg_lane(tcphy, DEFAULT_RATE, 0, 0, 0);
> +                       tcphy_dp_cfg_lane(tcphy, DEFAULT_RATE, 0, 0, 1);
>                 } else {
>                         tcphy_tx_usb3_cfg_lane(tcphy, 0);
>                         tcphy_rx_usb3_cfg_lane(tcphy, 1);
> -                       tcphy_dp_cfg_lane(tcphy, 2);
> -                       tcphy_dp_cfg_lane(tcphy, 3);
> +                       tcphy_dp_cfg_lane(tcphy, DEFAULT_RATE, 0, 0, 2);
> +                       tcphy_dp_cfg_lane(tcphy, DEFAULT_RATE, 0, 0, 3);
>                 }
>
>                 writel(PIN_ASSIGN_D_F, tcphy->base + PMA_LANE_CFG);
>         }
>
> -       writel(DP_MODE_ENTER_A2, tcphy->base + DP_MODE_CTL);
> +       val = readl(tcphy->base + DP_MODE_CTL);
> +       val &= ~DP_MODE_MASK;
> +       val |= DP_MODE_ENTER_A2 | DP_LINK_RESET_DEASSERTED;
> +       writel(val, tcphy->base + DP_MODE_CTL);
>
>         reset_control_deassert(tcphy->uphy_rst);
>
> @@ -990,7 +1035,7 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
>         property_enable(tcphy, &cfg->uphy_dp_sel, 1);
>
>         ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
> -                                val, val & DP_MODE_A2, 1000,
> +                                val, val & DP_MODE_A2_ACK, 1000,
>                                  PHY_MODE_SET_TIMEOUT);
>         if (ret < 0) {
>                 dev_err(tcphy->dev, "failed to wait TCPHY enter A2\n");
> @@ -999,13 +1044,19 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
>
>         tcphy_dp_aux_calibration(tcphy);
>
> -       writel(DP_MODE_ENTER_A0, tcphy->base + DP_MODE_CTL);
> +       /* enter A0 mode */
> +       val = readl(tcphy->base + DP_MODE_CTL);
> +       val &= ~DP_MODE_MASK;
> +       val |= DP_MODE_ENTER_A0;
> +       writel(val, tcphy->base + DP_MODE_CTL);
>
>         ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
> -                                val, val & DP_MODE_A0, 1000,
> +                                val, val & DP_MODE_A0_ACK, 1000,
>                                  PHY_MODE_SET_TIMEOUT);
>         if (ret < 0) {
> -               writel(DP_MODE_ENTER_A2, tcphy->base + DP_MODE_CTL);
> +               val &= ~DP_MODE_MASK;
> +               val |= DP_MODE_ENTER_A2;
> +               writel(val, tcphy->base + DP_MODE_CTL);
>                 dev_err(tcphy->dev, "failed to wait TCPHY enter A0\n");
>                 goto power_on_finish;
>         }
> @@ -1023,6 +1074,7 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
>  static int rockchip_dp_phy_power_off(struct phy *phy)
>  {
>         struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
> +       u32 val;
>
>         mutex_lock(&tcphy->lock);
>
> @@ -1031,7 +1083,10 @@ static int rockchip_dp_phy_power_off(struct phy *phy)
>
>         tcphy->mode &= ~MODE_DFP_DP;
>
> -       writel(DP_MODE_ENTER_A2, tcphy->base + DP_MODE_CTL);
> +       val = readl(tcphy->base + DP_MODE_CTL);
> +       val &= ~DP_MODE_MASK;
> +       val |= DP_MODE_ENTER_A2;
> +       writel(val, tcphy->base + DP_MODE_CTL);
>
>         if (tcphy->mode == MODE_DISCONNECT)
>                 tcphy_phy_deinit(tcphy);
> @@ -1047,6 +1102,30 @@ static const struct phy_ops rockchip_dp_phy_ops = {
>         .owner          = THIS_MODULE,
>  };
>
> +static int type_c_dp_phy_config(struct phy *phy, int link_rate,

s/type_c/typec/ to be coherent with the rest of the code.

> +                        int lanes, u8 swing, u8 pre_emp)
> +{
> +       struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
> +       u8 i;
> +
> +       tcphy_cfg_dp_pll(tcphy, link_rate);
> +
> +       if (tcphy->mode == MODE_DFP_DP) {
> +               for (i = 0; i < 4; i++)
> +                       tcphy_dp_cfg_lane(tcphy, link_rate, swing, pre_emp, i);
> +       } else {
> +               if (tcphy->flip) {
> +                       tcphy_dp_cfg_lane(tcphy, link_rate, swing, pre_emp, 0);
> +                       tcphy_dp_cfg_lane(tcphy, link_rate, swing, pre_emp, 1);
> +               } else {
> +                       tcphy_dp_cfg_lane(tcphy, link_rate, swing, pre_emp, 2);
> +                       tcphy_dp_cfg_lane(tcphy, link_rate, swing, pre_emp, 3);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
>                           struct device *dev)
>  {
> @@ -1087,6 +1166,14 @@ static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
>                 return PTR_ERR(tcphy->tcphy_rst);
>         }
>
> +       /*
> +        * check if phy_config pass from dts, if yes,
> +        * need to use this phy config to do software training later
> +        */
> +       if (!of_property_read_u32_array(dev->of_node, "rockchip,phy_config",
> +               (u32 *)tcphy->config, sizeof(tcphy->config) / sizeof(u32)))
> +               tcphy->need_software_training = 1;
> +
>         return 0;
>  }
>
> @@ -1171,6 +1258,7 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       tcphy->typec_phy_config = type_c_dp_phy_config;

type_c_dp_phy_config -> typec_dp_phy_config

>         pm_runtime_enable(dev);
>
>         for_each_available_child_of_node(np, child_np) {
> diff --git a/include/soc/rockchip/rockchip_phy_typec.h b/include/soc/rockchip/rockchip_phy_typec.h
> new file mode 100644
> index 0000000..e25840e
> --- /dev/null
> +++ b/include/soc/rockchip/rockchip_phy_typec.h
> @@ -0,0 +1,72 @@
> +/*

Add the SPDX License identifier ...

> + * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd
> + * Author: Lin Huang <hl@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.

... and remove the above notice.

> + */
> +#ifndef __SOC_ROCKCHIP_PHY_TYPEC_H
> +#define __SOC_ROCKCHIP_PHY_TYPEC_H
> +
> +

Remove the extra new line.

> +struct usb3phy_reg {
> +       u32 offset;
> +       u32 enable_bit;
> +       u32 write_enable;
> +};
> +
> +/**
> + * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
> + * @reg: the base address for usb3-phy config.
> + * @typec_conn_dir: the register of type-c connector direction.
> + * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
> + * @external_psm: the register of type-c phy external psm clock.
> + * @pipe_status: the register of type-c phy pipe status.
> + * @usb3_host_disable: the register of type-c usb3 host disable.
> + * @usb3_host_port: the register of type-c usb3 host port.
> + * @uphy_dp_sel: the register of type-c phy DP select control.
> + */
> +struct rockchip_usb3phy_port_cfg {
> +       unsigned int reg;
> +       struct usb3phy_reg typec_conn_dir;
> +       struct usb3phy_reg usb3tousb2_en;
> +       struct usb3phy_reg external_psm;
> +       struct usb3phy_reg pipe_status;
> +       struct usb3phy_reg usb3_host_disable;
> +       struct usb3phy_reg usb3_host_port;
> +       struct usb3phy_reg uphy_dp_sel;
> +};
> +
> +struct phy_config {
> +       int swing;
> +       int pe;
> +};
> +
> +struct rockchip_typec_phy {
> +       struct device *dev;
> +       void __iomem *base;
> +       struct extcon_dev *extcon;
> +       struct regmap *grf_regs;
> +       struct clk *clk_core;
> +       struct clk *clk_ref;
> +       struct reset_control *uphy_rst;
> +       struct reset_control *pipe_rst;
> +       struct reset_control *tcphy_rst;
> +       struct rockchip_usb3phy_port_cfg *port_cfgs;
> +       /* mutex to protect access to individual PHYs */
> +       struct mutex lock;
> +       struct phy_config config[3][4];
> +       u8 need_software_training;
> +       bool flip;
> +       u8 mode;
> +       int (*typec_phy_config)(struct phy *phy, int link_rate,
> +                               int lanes, u8 swing, u8 pre_emp);
> +};
> +
> +#endif

Best regards,
 Enric

> --
> 2.7.4
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
