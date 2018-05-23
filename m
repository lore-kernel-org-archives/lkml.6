Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeEWIuI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:50:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36898 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754349AbeEWIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:50:03 -0400
X-Google-Smtp-Source: ADUXVKJcyggnLT1WiPWEEuGJncc9oC2QW6NdHeaa6UIX+TSeTn9YN2OlJel8KQpyhizNDa6vijHPZShhQ+6760XsE4o=
MIME-Version: 1.0
In-Reply-To: <1527061353-16902-4-git-send-email-hl@rock-chips.com>
References: <1527061353-16902-1-git-send-email-hl@rock-chips.com> <1527061353-16902-4-git-send-email-hl@rock-chips.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Wed, 23 May 2018 10:50:01 +0200
Message-ID: <CAFqH_50AzhWLuGkm8P62GdPmJNs8nKmqRE8+JTyq4PxJHSc2+Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] phy: rockchip-typec: support variable phy config value
To: Lin Huang <hl@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Chris Zhong <zyw@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        daniel.vetter@intel.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-23 9:42 GMT+02:00 Lin Huang <hl@rock-chips.com>:
> the phy config values used to fix in dp firmware, but some boards
> need change these values to do training and get the better eye diagram
> result. So support that in phy driver.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - update patch following Enric suggest
> Changes in v3:
> - delete need_software_training variable
> - add default phy config value, if dts do not define phy config value, use these value
> Changes in v4:
> - rename variable config to tcphy_default_config
> Changes in v5:
> - None
> Changes in v6:
> - split the header file to new patch
> Changes in v7:
> - add default case when check link rate
> - move struct rockchip_typec_phy new element to this patch
>
>  drivers/phy/rockchip/phy-rockchip-typec.c | 263 ++++++++++++++++++++++++------
>  include/soc/rockchip/rockchip_phy_typec.h |   8 +
>  2 files changed, 218 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 795055f..69af90e 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -324,21 +324,29 @@
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
>  #define PHY_MODE_SET_TIMEOUT           100000
>
> @@ -350,6 +358,8 @@
>  #define MODE_DFP_USB                   BIT(1)
>  #define MODE_DFP_DP                    BIT(2)
>
> +#define DP_DEFAULT_RATE                162000
> +
>  struct phy_reg {
>         u16 value;
>         u32 addr;
> @@ -372,15 +382,15 @@ struct phy_reg usb3_pll_cfg[] = {
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
> @@ -391,9 +401,52 @@ struct phy_reg dp_pll_cfg[] = {
>         { 0x8,          CMN_DIAG_PLL1_LF_PROG },
>         { 0x100,        CMN_DIAG_PLL1_PTATIS_TUNE1 },
>         { 0x7,          CMN_DIAG_PLL1_PTATIS_TUNE2 },
> -       { 0x4,          CMN_DIAG_PLL1_INCLK_CTRL },
> +       { 0x1,          CMN_DIAG_PLL1_INCLK_CTRL },
>  };
>
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
> +};
> +
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
> @@ -418,6 +471,24 @@ static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
>         { /* sentinel */ }
>  };
>
> +/* default phy config */
> +static const struct phy_config tcphy_default_config[3][4] = {
> +       {{ .swing = 0x2a, .pe = 0x00 },
> +        { .swing = 0x1f, .pe = 0x15 },
> +        { .swing = 0x14, .pe = 0x22 },
> +        { .swing = 0x02, .pe = 0x2b } },
> +
> +       {{ .swing = 0x21, .pe = 0x00 },
> +        { .swing = 0x12, .pe = 0x15 },
> +        { .swing = 0x02, .pe = 0x22 },
> +        { .swing = 0,    .pe = 0 } },
> +
> +       {{ .swing = 0x15, .pe = 0x00 },
> +        { .swing = 0x00, .pe = 0x15 },
> +        { .swing = 0,    .pe = 0 },
> +        { .swing = 0,    .pe = 0 } },
> +};
> +
>  static void tcphy_cfg_24m(struct rockchip_typec_phy *tcphy)
>  {
>         u32 i, rdata;
> @@ -439,7 +510,7 @@ static void tcphy_cfg_24m(struct rockchip_typec_phy *tcphy)
>
>         rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
>         rdata &= ~CLK_PLL_MASK;
> -       rdata |= CLK_PLL_CONFIG;
> +       rdata |= CLK_PLL1_DIV2;
>         writel(rdata, tcphy->base + CMN_DIAG_HSCLK_SEL);
>  }
>
> @@ -453,17 +524,45 @@ static void tcphy_cfg_usb3_pll(struct rockchip_typec_phy *tcphy)
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
> +       case 540000:
> +               clk_ctrl = DP_PLL_DATA_RATE_HBR2;
> +               hsclk_sel |= CLK_PLL1_DIV1;
> +               phy_cfg = dp_pll_hbr2_cfg;
> +               cfg_size = ARRAY_SIZE(dp_pll_hbr2_cfg);
> +               break;
> +       case 270000:
> +               clk_ctrl = DP_PLL_DATA_RATE_HBR;
> +               hsclk_sel |= CLK_PLL1_DIV2;
> +               phy_cfg = dp_pll_hbr_cfg;
> +               cfg_size = ARRAY_SIZE(dp_pll_hbr_cfg);
> +               break;
> +       case 162000:
> +       default:
> +               clk_ctrl = DP_PLL_DATA_RATE_RBR;
> +               hsclk_sel |= CLK_PLL1_DIV2;
> +               phy_cfg = dp_pll_rbr_cfg;
> +               cfg_size = ARRAY_SIZE(dp_pll_rbr_cfg);
> +               break;
> +       }
>
> -       /* set the default mode to RBR */
> -       writel(DP_PLL_CLOCK_ENABLE | DP_PLL_ENABLE | DP_PLL_DATA_RATE_RBR,
> -              tcphy->base + DP_CLK_CTL);
> +       clk_ctrl |= DP_PLL_CLOCK_ENABLE | DP_PLL_ENABLE;
> +       writel(clk_ctrl, tcphy->base + DP_CLK_CTL);
> +
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
> @@ -490,9 +589,10 @@ static void tcphy_rx_usb3_cfg_lane(struct rockchip_typec_phy *tcphy, u32 lane)
>         writel(0xfb, tcphy->base + XCVR_DIAG_BIDI_CTRL(lane));
>  }
>
> -static void tcphy_dp_cfg_lane(struct rockchip_typec_phy *tcphy, u32 lane)
> +static void tcphy_dp_cfg_lane(struct rockchip_typec_phy *tcphy, int link_rate,
> +                             u8 swing, u8 pre_emp, u32 lane)
>  {
> -       u16 rdata;
> +       u16 val;
>
>         writel(0xbefc, tcphy->base + XCVR_PSM_RCTRL(lane));
>         writel(0x6799, tcphy->base + TX_PSC_A0(lane));
> @@ -500,25 +600,32 @@ static void tcphy_dp_cfg_lane(struct rockchip_typec_phy *tcphy, u32 lane)
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
> +       case 540000:
> +               val |= (4 << 12);
> +               break;
> +       case 162000:
> +       case 270000:
> +       default:
> +               val |= (6 << 12);
> +               break;
> +       }
> +       writel(val, tcphy->base + XCVR_DIAG_PLLDRC_CTRL(lane));
>  }
>
>  static inline int property_enable(struct rockchip_typec_phy *tcphy,
> @@ -709,30 +816,33 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
>         tcphy_cfg_24m(tcphy);
>
>         if (mode == MODE_DFP_DP) {
> -               tcphy_cfg_dp_pll(tcphy);
> +               tcphy_cfg_dp_pll(tcphy, DP_DEFAULT_RATE);
>                 for (i = 0; i < 4; i++)
> -                       tcphy_dp_cfg_lane(tcphy, i);
> +                       tcphy_dp_cfg_lane(tcphy, DP_DEFAULT_RATE, 0, 0, i);
>
>                 writel(PIN_ASSIGN_C_E, tcphy->base + PMA_LANE_CFG);
>         } else {
>                 tcphy_cfg_usb3_pll(tcphy);
> -               tcphy_cfg_dp_pll(tcphy);
> +               tcphy_cfg_dp_pll(tcphy, DP_DEFAULT_RATE);
>                 if (tcphy->flip) {
>                         tcphy_tx_usb3_cfg_lane(tcphy, 3);
>                         tcphy_rx_usb3_cfg_lane(tcphy, 2);
> -                       tcphy_dp_cfg_lane(tcphy, 0);
> -                       tcphy_dp_cfg_lane(tcphy, 1);
> +                       tcphy_dp_cfg_lane(tcphy, DP_DEFAULT_RATE, 0, 0, 0);
> +                       tcphy_dp_cfg_lane(tcphy, DP_DEFAULT_RATE, 0, 0, 1);
>                 } else {
>                         tcphy_tx_usb3_cfg_lane(tcphy, 0);
>                         tcphy_rx_usb3_cfg_lane(tcphy, 1);
> -                       tcphy_dp_cfg_lane(tcphy, 2);
> -                       tcphy_dp_cfg_lane(tcphy, 3);
> +                       tcphy_dp_cfg_lane(tcphy, DP_DEFAULT_RATE, 0, 0, 2);
> +                       tcphy_dp_cfg_lane(tcphy, DP_DEFAULT_RATE, 0, 0, 3);
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
> @@ -945,7 +1055,7 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
>         property_enable(tcphy, &cfg->uphy_dp_sel, 1);
>
>         ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
> -                                val, val & DP_MODE_A2, 1000,
> +                                val, val & DP_MODE_A2_ACK, 1000,
>                                  PHY_MODE_SET_TIMEOUT);
>         if (ret < 0) {
>                 dev_err(tcphy->dev, "failed to wait TCPHY enter A2\n");
> @@ -954,13 +1064,19 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
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
> @@ -978,6 +1094,7 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
>  static int rockchip_dp_phy_power_off(struct phy *phy)
>  {
>         struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
> +       u32 val;
>
>         mutex_lock(&tcphy->lock);
>
> @@ -986,7 +1103,10 @@ static int rockchip_dp_phy_power_off(struct phy *phy)
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
> @@ -1002,9 +1122,35 @@ static const struct phy_ops rockchip_dp_phy_ops = {
>         .owner          = THIS_MODULE,
>  };
>
> +static int typec_dp_phy_config(struct phy *phy, int link_rate,
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
> +       int ret;
> +
>         tcphy->grf_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
>                                                           "rockchip,grf");
>         if (IS_ERR(tcphy->grf_regs)) {
> @@ -1042,6 +1188,16 @@ static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
>                 return PTR_ERR(tcphy->tcphy_rst);
>         }
>
> +       /*
> +        * check if phy_config pass from dts, if no,
> +        * use default phy config value.
> +        */
> +       ret = of_property_read_u32_array(dev->of_node, "rockchip,phy-config",
> +               (u32 *)tcphy->config, sizeof(tcphy->config) / sizeof(u32));
> +       if (ret)
> +               memcpy(tcphy->config, tcphy_default_config,
> +                      sizeof(tcphy->config));
> +
>         return 0;
>  }
>
> @@ -1126,6 +1282,7 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       tcphy->typec_phy_config = typec_dp_phy_config;
>         pm_runtime_enable(dev);
>
>         for_each_available_child_of_node(np, child_np) {
> diff --git a/include/soc/rockchip/rockchip_phy_typec.h b/include/soc/rockchip/rockchip_phy_typec.h
> index 4afe039..8e45c4d 100644
> --- a/include/soc/rockchip/rockchip_phy_typec.h
> +++ b/include/soc/rockchip/rockchip_phy_typec.h
> @@ -35,6 +35,11 @@ struct rockchip_usb3phy_port_cfg {
>         struct usb3phy_reg uphy_dp_sel;
>  };
>
> +struct phy_config {
> +       int swing;
> +       int pe;
> +};
> +
>  struct rockchip_typec_phy {
>         struct device *dev;
>         void __iomem *base;
> @@ -50,6 +55,9 @@ struct rockchip_typec_phy {
>         struct mutex lock;
>         bool flip;
>         u8 mode;
> +       struct phy_config config[3][4];
> +       int (*typec_phy_config)(struct phy *phy, int link_rate,
> +                               int lanes, u8 swing, u8 pre_emp);
>  };
>
>  #endif
> --
> 2.7.4
>

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
