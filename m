Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755590AbeEANU1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:20:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33251 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeEANUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:20:24 -0400
X-Google-Smtp-Source: AB8JxZoP2ogtnRilhbxG1B4Vly8sIKIeQCri5yjzu53TE6cq92GslusQMNWaDptxW4q9hF4YUAmbT63WrzGFktdXXjI=
MIME-Version: 1.0
In-Reply-To: <20180428102111.18384-3-yixun.lan@amlogic.com>
References: <20180428102111.18384-1-yixun.lan@amlogic.com> <20180428102111.18384-3-yixun.lan@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 1 May 2018 15:20:02 +0200
Message-ID: <CAFBinCA6N=q6ZtuA9nfd=8VJjZMg9v8bdqZabVWiyc2-sGB0Qw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: stmmac: dwmac-meson: extend phy mode setting
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yixun,

On Sat, Apr 28, 2018 at 12:21 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>   In the Meson-AXG SoC, the phy mode setting of PRG_ETH0 in the glue layer
> is extended from bit[0] to bit[2:0].
>   There is no problem if we configure it to the RGMII 1000M PHY mode,
> since the register setting is coincidentally compatible with previous one,
> but for the RMII 100M PHY mode, the configuration need to be changed to
> value - b100.
>   This patch was verified with a RTL8201F 100M ethernet PHY.
>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 120 +++++++++++++++---
>  1 file changed, 104 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> index 7cb794094a70..4ff231df7322 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/of_net.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
> @@ -29,6 +30,10 @@
>
>  #define PRG_ETH0_RGMII_MODE            BIT(0)
>
> +#define PRG_ETH0_EXT_PHY_MODE_MASK     GENMASK(2, 0)
> +#define PRG_ETH0_EXT_RGMII_MODE                1
> +#define PRG_ETH0_EXT_RMII_MODE         4
> +
>  /* mux to choose between fclk_div2 (bit unset) and mpll2 (bit set) */
>  #define PRG_ETH0_CLK_M250_SEL_SHIFT    4
>  #define PRG_ETH0_CLK_M250_SEL_MASK     GENMASK(4, 4)
> @@ -47,12 +52,20 @@
>
>  #define MUX_CLK_NUM_PARENTS            2
>
> +struct meson8b_dwmac;
> +
> +struct meson8b_dwmac_data {
> +       int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
> +};
> +
>  struct meson8b_dwmac {
> -       struct device           *dev;
> -       void __iomem            *regs;
> -       phy_interface_t         phy_mode;
> -       struct clk              *rgmii_tx_clk;
> -       u32                     tx_delay_ns;
> +       struct device                   *dev;
> +       void __iomem                    *regs;
> +
> +       const struct meson8b_dwmac_data *data;
> +       phy_interface_t                 phy_mode;
> +       struct clk                      *rgmii_tx_clk;
> +       u32                             tx_delay_ns;
>  };
>
>  struct meson8b_dwmac_clk_configs {
> @@ -171,6 +184,59 @@ static int meson8b_init_rgmii_tx_clk(struct meson8b_dwmac *dwmac)
>         return 0;
>  }
>
> +static int meson8b_set_phy_mode(struct meson8b_dwmac *dwmac)
> +{
> +       switch (dwmac->phy_mode) {
> +       case PHY_INTERFACE_MODE_RGMII:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +               /* enable RGMII mode */
> +               meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
> +                                       PRG_ETH0_RGMII_MODE,
> +                                       PRG_ETH0_RGMII_MODE);
> +               break;
> +       case PHY_INTERFACE_MODE_RMII:
> +               /* disable RGMII mode -> enables RMII mode */
> +               meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
> +                                       PRG_ETH0_RGMII_MODE, 0);
> +               break;
> +       default:
> +               dev_err(dwmac->dev, "fail to set phy-mode %s\n",
> +                       phy_modes(dwmac->phy_mode));
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int meson_axg_set_phy_mode(struct meson8b_dwmac *dwmac)
> +{
> +       switch (dwmac->phy_mode) {
> +       case PHY_INTERFACE_MODE_RGMII:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +               /* enable RGMII mode */
> +               meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
> +                                       PRG_ETH0_EXT_PHY_MODE_MASK,
> +                                       PRG_ETH0_EXT_RGMII_MODE);
> +               break;
> +       case PHY_INTERFACE_MODE_RMII:
> +               /* disable RGMII mode -> enables RMII mode */
if you have to re-send it for whatever reason:
maybe you could remove the comments from meson_axg_set_phy_mode. the
"older" register layout requires un-setting RGMII mode to enable RMII
mode. however, for AXG there seem to be two dedicated values (1 and 4)
for each mode

apart from that:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> +               meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
> +                                       PRG_ETH0_EXT_PHY_MODE_MASK,
> +                                       PRG_ETH0_EXT_RMII_MODE);
> +               break;
> +       default:
> +               dev_err(dwmac->dev, "fail to set phy-mode %s\n",
> +                       phy_modes(dwmac->phy_mode));
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
>  {
>         int ret;
> @@ -188,10 +254,6 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
>
>         case PHY_INTERFACE_MODE_RGMII_ID:
>         case PHY_INTERFACE_MODE_RGMII_TXID:
> -               /* enable RGMII mode */
> -               meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_RGMII_MODE,
> -                                       PRG_ETH0_RGMII_MODE);
> -
>                 /* only relevant for RMII mode -> disable in RGMII mode */
>                 meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
>                                         PRG_ETH0_INVERTED_RMII_CLK, 0);
> @@ -224,10 +286,6 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
>                 break;
>
>         case PHY_INTERFACE_MODE_RMII:
> -               /* disable RGMII mode -> enables RMII mode */
> -               meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_RGMII_MODE,
> -                                       0);
> -
>                 /* invert internal clk_rmii_i to generate 25/2.5 tx_rx_clk */
>                 meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
>                                         PRG_ETH0_INVERTED_RMII_CLK,
> @@ -274,6 +332,11 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>                 goto err_remove_config_dt;
>         }
>
> +       dwmac->data = (const struct meson8b_dwmac_data *)
> +               of_device_get_match_data(&pdev->dev);
> +       if (!dwmac->data)
> +               return -EINVAL;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>         dwmac->regs = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(dwmac->regs)) {
> @@ -298,6 +361,10 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_remove_config_dt;
>
> +       ret = dwmac->data->set_phy_mode(dwmac);
> +       if (ret)
> +               goto err_remove_config_dt;
> +
>         ret = meson8b_init_prg_eth(dwmac);
>         if (ret)
>                 goto err_remove_config_dt;
> @@ -316,10 +383,31 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static const struct meson8b_dwmac_data meson8b_dwmac_data = {
> +       .set_phy_mode = meson8b_set_phy_mode,
> +};
> +
> +static const struct meson8b_dwmac_data meson_axg_dwmac_data = {
> +       .set_phy_mode = meson_axg_set_phy_mode,
> +};
> +
>  static const struct of_device_id meson8b_dwmac_match[] = {
> -       { .compatible = "amlogic,meson8b-dwmac" },
> -       { .compatible = "amlogic,meson8m2-dwmac" },
> -       { .compatible = "amlogic,meson-gxbb-dwmac" },
> +       {
> +               .compatible = "amlogic,meson8b-dwmac",
> +               .data = &meson8b_dwmac_data,
> +       },
> +       {
> +               .compatible = "amlogic,meson8m2-dwmac",
> +               .data = &meson8b_dwmac_data,
> +       },
> +       {
> +               .compatible = "amlogic,meson-gxbb-dwmac",
> +               .data = &meson8b_dwmac_data,
> +       },
> +       {
> +               .compatible = "amlogic,meson-axg-dwmac",
> +               .data = &meson_axg_dwmac_data,
> +       },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);
> --
> 2.17.0
>
