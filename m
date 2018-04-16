Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeDPKiJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:38:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40191 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeDPKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:38:07 -0400
X-Google-Smtp-Source: AIpwx48B5pM1QwUPJd+zxZ//ClvMIqvtjYtBEy9VG4+RsOLRMBaWIxDpk46sFJJO/p27eVfEfQzwSg==
Message-ID: <1523875084.2601.28.camel@baylibre.com>
Subject: Re: [PATCH v5 2/7] clk: meson: aoclk: refactor common code into
 dedicated file
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 16 Apr 2018 12:38:04 +0200
In-Reply-To: <20180409143749.71197-3-yixun.lan@amlogic.com>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
         <20180409143749.71197-3-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 22:37 +0800, Yixun Lan wrote:
> We try to refactor the common code into one dedicated file,
> while preparing to add new Meson-AXG aoclk driver, this would
> help us to better share the code by all aoclk drivers.
> 
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig       |  7 ++++
>  drivers/clk/meson/Makefile      |  1 +
>  drivers/clk/meson/gxbb-aoclk.c  | 91 ++++++++++++++---------------------------
>  drivers/clk/meson/gxbb-aoclk.h  |  7 ++++
>  drivers/clk/meson/meson-aoclk.c | 82 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/meson-aoclk.h | 35 ++++++++++++++++
>  6 files changed, 163 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/clk/meson/meson-aoclk.c
>  create mode 100644 drivers/clk/meson/meson-aoclk.h
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index d5cbec522aec..fddc7ec7b820 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -3,6 +3,12 @@ config COMMON_CLK_AMLOGIC
>  	depends on OF
>  	depends on ARCH_MESON || COMPILE_TEST
>  
> +config COMMON_CLK_MESON_AO
> +	bool
> +	depends on OF
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select COMMON_CLK_REGMAP_MESON
> +
>  config COMMON_CLK_REGMAP_MESON
>  	bool
>  	select REGMAP
> @@ -21,6 +27,7 @@ config COMMON_CLK_GXBB
>  	bool
>  	depends on COMMON_CLK_AMLOGIC
>  	select RESET_CONTROLLER
> +	select COMMON_CLK_MESON_AO
>  	select COMMON_CLK_REGMAP_MESON
>  	select MFD_SYSCON
>  	help
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index ffee82e60b7a..0a8df284f4e7 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
> +obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
> diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
> index eebb580b9e0f..f2e0640a7f74 100644
> --- a/drivers/clk/meson/gxbb-aoclk.c
> +++ b/drivers/clk/meson/gxbb-aoclk.c
> @@ -52,39 +52,13 @@
>   * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>   * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
> -#include <linux/clk-provider.h>
> -#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/regmap.h>
>  #include <linux/init.h>
> -#include <linux/delay.h>
> -#include <dt-bindings/clock/gxbb-aoclkc.h>
> -#include <dt-bindings/reset/gxbb-aoclkc.h>
>  #include "clk-regmap.h"
>  #include "gxbb-aoclk.h"
>  
> -struct gxbb_aoclk_reset_controller {
> -	struct reset_controller_dev reset;
> -	unsigned int *data;
> -	struct regmap *regmap;
> -};
> -
> -static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
> -			       unsigned long id)
> -{
> -	struct gxbb_aoclk_reset_controller *reset =
> -		container_of(rcdev, struct gxbb_aoclk_reset_controller, reset);
> -
> -	return regmap_write(reset->regmap, AO_RTI_GEN_CNTL_REG0,
> -			    BIT(reset->data[id]));
> -}
> -
> -static const struct reset_control_ops gxbb_aoclk_reset_ops = {
> -	.reset = gxbb_aoclk_do_reset,
> -};
> -
>  #define GXBB_AO_GATE(_name, _bit)					\
>  static struct clk_regmap _name##_ao = {					\
>  	.data = &(struct clk_regmap_gate_data) {			\
> @@ -117,7 +91,7 @@ static struct aoclk_cec_32k cec_32k_ao = {
>  	},
>  };
>  
> -static unsigned int gxbb_aoclk_reset[] = {
> +static const unsigned int gxbb_aoclk_reset[] = {
>  	[RESET_AO_REMOTE] = 16,
>  	[RESET_AO_I2C_MASTER] = 18,
>  	[RESET_AO_I2C_SLAVE] = 19,
> @@ -135,7 +109,7 @@ static struct clk_regmap *gxbb_aoclk_gate[] = {
>  	[CLKID_AO_IR_BLASTER] = &ir_blaster_ao,
>  };
>  
> -static struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
> +static const struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
>  	.hws = {
>  		[CLKID_AO_REMOTE] = &remote_ao.hw,
>  		[CLKID_AO_I2C_MASTER] = &i2c_master_ao.hw,
> @@ -145,58 +119,55 @@ static struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
>  		[CLKID_AO_IR_BLASTER] = &ir_blaster_ao.hw,
>  		[CLKID_AO_CEC_32K] = &cec_32k_ao.hw,
>  	},
> -	.num = 7,
> +	.num = NR_CLKS,
>  };
>  
> -static int gxbb_aoclkc_probe(struct platform_device *pdev)
> +static int gxbb_register_cec_ao_32k(struct platform_device *pdev)
>  {
> -	struct gxbb_aoclk_reset_controller *rstc;
>  	struct device *dev = &pdev->dev;
>  	struct regmap *regmap;
> -	int ret, clkid;
> -
> -	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
> -	if (!rstc)
> -		return -ENOMEM;
> +	int ret;
>  
>  	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
>  	if (IS_ERR(regmap)) {
>  		dev_err(dev, "failed to get regmap\n");
> -		return -ENODEV;
> -	}
> -
> -	/* Reset Controller */
> -	rstc->regmap = regmap;
> -	rstc->data = gxbb_aoclk_reset;
> -	rstc->reset.ops = &gxbb_aoclk_reset_ops;
> -	rstc->reset.nr_resets = ARRAY_SIZE(gxbb_aoclk_reset);
> -	rstc->reset.of_node = dev->of_node;
> -	ret = devm_reset_controller_register(dev, &rstc->reset);
> -
> -	/*
> -	 * Populate regmap and register all clks
> -	 */
> -	for (clkid = 0; clkid < ARRAY_SIZE(gxbb_aoclk_gate); clkid++) {
> -		gxbb_aoclk_gate[clkid]->map = regmap;
> -
> -		ret = devm_clk_hw_register(dev,
> -					   gxbb_aoclk_onecell_data.hws[clkid]);
> -		if (ret)
> -			return ret;
> +		return PTR_ERR(regmap);
>  	}
>  
>  	/* Specific clocks */
>  	cec_32k_ao.regmap = regmap;
>  	ret = devm_clk_hw_register(dev, &cec_32k_ao.hw);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clk cec_32k_ao register failed.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct meson_aoclk_data gxbb_aoclkc_data = {
> +	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
> +	.num_reset	= ARRAY_SIZE(gxbb_aoclk_reset),
> +	.reset		= gxbb_aoclk_reset,
> +	.num_clks	= ARRAY_SIZE(gxbb_aoclk_gate),
> +	.clks		= gxbb_aoclk_gate,
> +	.hw_data	= &gxbb_aoclk_onecell_data,
> +};
> +
> +static int gxbb_aoclkc_probe(struct platform_device *pdev)
> +{
> +	int ret = gxbb_register_cec_ao_32k(pdev);
>  	if (ret)
>  		return ret;
>  
> -	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> -			&gxbb_aoclk_onecell_data);
> +	return meson_aoclkc_probe(pdev);
>  }
>  
>  static const struct of_device_id gxbb_aoclkc_match_table[] = {
> -	{ .compatible = "amlogic,meson-gx-aoclkc" },
> +	{
> +		.compatible	= "amlogic,meson-gx-aoclkc",
> +		.data		= &gxbb_aoclkc_data,
> +	},
>  	{ }
>  };
>  
> diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
> index badc4c22b4ee..b031f1a0213e 100644
> --- a/drivers/clk/meson/gxbb-aoclk.h
> +++ b/drivers/clk/meson/gxbb-aoclk.h
> @@ -8,6 +8,10 @@
>  #ifndef __GXBB_AOCLKC_H
>  #define __GXBB_AOCLKC_H
>  
> +#include "meson-aoclk.h"
> +
> +#define NR_CLKS	7
> +
>  /* AO Configuration Clock registers offsets */
>  #define AO_RTI_PWR_CNTL_REG1	0x0c
>  #define AO_RTI_PWR_CNTL_REG0	0x10
> @@ -26,4 +30,7 @@ struct aoclk_cec_32k {
>  
>  extern const struct clk_ops meson_aoclk_cec_32k_ops;
>  
> +#include <dt-bindings/clock/gxbb-aoclkc.h>
> +#include <dt-bindings/reset/gxbb-aoclkc.h>
> +
>  #endif /* __GXBB_AOCLKC_H */
> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
> new file mode 100644
> index 000000000000..74338ef0a62b
> --- /dev/null
> +++ b/drivers/clk/meson/meson-aoclk.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson-AXG Clock Controller Driver
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include "clk-regmap.h"
> +#include "meson-aoclk.h"
> +
> +static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct meson_aoclk_reset_controller *rstc =
> +		container_of(rcdev, struct meson_aoclk_reset_controller, reset);
> +
> +	return regmap_write(rstc->regmap, rstc->data->reset_reg,
> +			    BIT(rstc->data->reset[id]));
> +}
> +
> +static const struct reset_control_ops meson_aoclk_reset_ops = {
> +	.reset = meson_aoclk_do_reset,
> +};
> +
> +int meson_aoclkc_probe(struct platform_device *pdev)
> +{
> +	struct meson_aoclk_reset_controller *rstc;
> +	struct meson_aoclk_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	int ret, clkid;
> +
> +	data = (struct meson_aoclk_data *) of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
> +	if (!rstc)
> +		return -ENOMEM;
> +
> +	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to get regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	/* Reset Controller */
> +	rstc->data = data;
> +	rstc->regmap = regmap;
> +	rstc->reset.ops = &meson_aoclk_reset_ops;
> +	rstc->reset.nr_resets = data->num_reset,
> +	rstc->reset.of_node = dev->of_node;
> +	ret = devm_reset_controller_register(dev, &rstc->reset);
> +	if (ret) {
> +		dev_err(dev, "failed to register reset controller\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Populate regmap and register all clks
> +	 */
> +	for (clkid = 0; clkid < data->num_clks; clkid++) {
> +		data->clks[clkid]->map = regmap;
> +
> +		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +		(void *) data->hw_data);
> +}

Missing new line here. Please run checkpatch and pay attention to git warnings
about whitespace errors.

> diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
> new file mode 100644
> index 000000000000..ec59e027dd37
> --- /dev/null
> +++ b/drivers/clk/meson/meson-aoclk.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#ifndef __MESON_AOCLK_H__
> +#define __MESON_AOCLK_H__
> +
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include "clk-regmap.h"
> +
> +struct meson_aoclk_data {
> +	const unsigned int			reset_reg;
> +	const int				num_reset;
> +	const unsigned int			*reset;
> +	int					num_clks;
> +	struct clk_regmap			**clks;
> +	const struct clk_hw_onecell_data	*hw_data;
> +};
> +
> +struct meson_aoclk_reset_controller {
> +	struct reset_controller_dev		reset;
> +	const struct meson_aoclk_data		*data;
> +	struct regmap				*regmap;
> +};
> +
> +int meson_aoclkc_probe(struct platform_device *pdev);
> +#endif
> +
