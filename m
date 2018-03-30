Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeC3LHG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:07:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41872 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC3LHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:07:05 -0400
X-Google-Smtp-Source: AIpwx49uV5pnwTaDXma3K46A3JxaCYV30WSbRQY75zyUE89tuhTNY5nH8qWdReQP0nKscB+BUdPcbjaiTFmYM+NkqnA=
MIME-Version: 1.0
In-Reply-To: <20180326084629.100070-2-yixun.lan@amlogic.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com> <20180326084629.100070-2-yixun.lan@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 30 Mar 2018 13:06:43 +0200
Message-ID: <CAFBinCDwN7FapV885gS2rjJNdvz=n1oNGbNeTmzXnoOK+JgVZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: meson-saradc: squash and share the common
 adc platform data
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:46 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> Extract and promote common adc platform data into a new structure,
> to make it better share the info between several SoCs,
> this will avoid duplicating the code all over the place,
> Save a few memory and make the code more maintainable.
>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

this will also help me when I add support for the internal temperature
sensor (as Meson8b and Meson8m2 share the same settings, except the
name)

> ---
>  drivers/iio/adc/meson_saradc.c | 75 +++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 29fa7736d80c..799ed929ab99 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -219,15 +219,19 @@ enum meson_sar_adc_chan7_mux_sel {
>         CHAN7_MUX_CH7_INPUT = 0x7,
>  };
>
> -struct meson_sar_adc_data {
> +struct meson_sar_adc_param {
>         bool                                    has_bl30_integration;
>         unsigned long                           clock_rate;
>         u32                                     bandgap_reg;
>         unsigned int                            resolution;
> -       const char                              *name;
>         const struct regmap_config              *regmap_config;
>  };
>
> +struct meson_sar_adc_data {
> +       const struct meson_sar_adc_param        *param;
> +       const char                              *name;
> +};
> +
>  struct meson_sar_adc_priv {
>         struct regmap                           *regmap;
>         struct regulator                        *vref;
> @@ -276,7 +280,7 @@ static int meson_sar_adc_calib_val(struct iio_dev *indio_dev, int val)
>         /* use val_calib = scale * val_raw + offset calibration function */
>         tmp = div_s64((s64)val * priv->calibscale, MILLION) + priv->calibbias;
>
> -       return clamp(tmp, 0, (1 << priv->data->resolution) - 1);
> +       return clamp(tmp, 0, (1 << priv->data->param->resolution) - 1);
>  }
>
>  static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
> @@ -328,7 +332,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>         }
>
>         fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK, regval);
> -       fifo_val &= GENMASK(priv->data->resolution - 1, 0);
> +       fifo_val &= GENMASK(priv->data->param->resolution - 1, 0);
>         *val = meson_sar_adc_calib_val(indio_dev, fifo_val);
>
>         return 0;
> @@ -447,7 +451,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
>
>         mutex_lock(&indio_dev->mlock);
>
> -       if (priv->data->has_bl30_integration) {
> +       if (priv->data->param->has_bl30_integration) {
>                 /* prevent BL30 from using the SAR ADC while we are using it */
>                 regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
>                                 MESON_SAR_ADC_DELAY_KERNEL_BUSY,
> @@ -473,7 +477,7 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
>  {
>         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>
> -       if (priv->data->has_bl30_integration)
> +       if (priv->data->param->has_bl30_integration)
>                 /* allow BL30 to use the SAR ADC again */
>                 regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
>                                 MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
> @@ -557,7 +561,7 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>                 }
>
>                 *val = ret / 1000;
> -               *val2 = priv->data->resolution;
> +               *val2 = priv->data->param->resolution;
>                 return IIO_VAL_FRACTIONAL_LOG2;
>
>         case IIO_CHAN_INFO_CALIBBIAS:
> @@ -630,7 +634,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>          */
>         meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_CH7_INPUT);
>
> -       if (priv->data->has_bl30_integration) {
> +       if (priv->data->param->has_bl30_integration) {
>                 /*
>                  * leave sampling delay and the input clocks as configured by
>                  * BL30 to make sure BL30 gets the values it expects when
> @@ -710,7 +714,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>                 return ret;
>         }
>
> -       ret = clk_set_rate(priv->adc_clk, priv->data->clock_rate);
> +       ret = clk_set_rate(priv->adc_clk, priv->data->param->clock_rate);
>         if (ret) {
>                 dev_err(indio_dev->dev.parent,
>                         "failed to set adc clock rate\n");
> @@ -723,14 +727,15 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  static void meson_sar_adc_set_bandgap(struct iio_dev *indio_dev, bool on_off)
>  {
>         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +       const struct meson_sar_adc_param *param = priv->data->param;
>         u32 enable_mask;
>
> -       if (priv->data->bandgap_reg == MESON_SAR_ADC_REG11)
> +       if (param->bandgap_reg == MESON_SAR_ADC_REG11)
>                 enable_mask = MESON_SAR_ADC_REG11_BANDGAP_EN;
>         else
>                 enable_mask = MESON_SAR_ADC_DELTA_10_TS_VBG_EN;
>
> -       regmap_update_bits(priv->regmap, priv->data->bandgap_reg, enable_mask,
> +       regmap_update_bits(priv->regmap, param->bandgap_reg, enable_mask,
>                            on_off ? enable_mask : 0);
>  }
>
> @@ -842,8 +847,8 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
>         int ret, nominal0, nominal1, value0, value1;
>
>         /* use points 25% and 75% for calibration */
> -       nominal0 = (1 << priv->data->resolution) / 4;
> -       nominal1 = (1 << priv->data->resolution) * 3 / 4;
> +       nominal0 = (1 << priv->data->param->resolution) / 4;
> +       nominal1 = (1 << priv->data->param->resolution) * 3 / 4;
>
>         meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
>         usleep_range(10, 20);
> @@ -881,48 +886,52 @@ static const struct iio_info meson_sar_adc_iio_info = {
>         .read_raw = meson_sar_adc_iio_info_read_raw,
>  };
>
> -static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
> -       .has_bl30_integration = false,
> -       .clock_rate = 1150000,
> -       .bandgap_reg = MESON_SAR_ADC_DELTA_10,
> -       .regmap_config = &meson_sar_adc_regmap_config_meson8,
> -       .resolution = 10,
> -       .name = "meson-meson8-saradc",
> -};
> -
> -static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
> +static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {
>         .has_bl30_integration = false,
>         .clock_rate = 1150000,
>         .bandgap_reg = MESON_SAR_ADC_DELTA_10,
>         .regmap_config = &meson_sar_adc_regmap_config_meson8,
>         .resolution = 10,
> -       .name = "meson-meson8b-saradc",
>  };
>
> -static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
> +static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
>         .has_bl30_integration = true,
>         .clock_rate = 1200000,
>         .bandgap_reg = MESON_SAR_ADC_REG11,
>         .regmap_config = &meson_sar_adc_regmap_config_gxbb,
>         .resolution = 10,
> -       .name = "meson-gxbb-saradc",
>  };
>
> -static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
> +static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>         .has_bl30_integration = true,
>         .clock_rate = 1200000,
>         .bandgap_reg = MESON_SAR_ADC_REG11,
>         .regmap_config = &meson_sar_adc_regmap_config_gxbb,
>         .resolution = 12,
> +};
> +
> +static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
> +       .param = &meson_sar_adc_meson8_param,
> +       .name = "meson-meson8-saradc",
> +};
> +
> +static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
> +       .param = &meson_sar_adc_meson8_param,
> +       .name = "meson-meson8b-saradc",
> +};
> +
> +static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
> +       .param = &meson_sar_adc_gxbb_param,
> +       .name = "meson-gxbb-saradc",
> +};
> +
> +static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
> +       .param = &meson_sar_adc_gxl_param,
>         .name = "meson-gxl-saradc",
>  };
>
>  static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
> -       .has_bl30_integration = true,
> -       .clock_rate = 1200000,
> -       .bandgap_reg = MESON_SAR_ADC_REG11,
> -       .regmap_config = &meson_sar_adc_regmap_config_gxbb,
> -       .resolution = 12,
> +       .param = &meson_sar_adc_gxl_param,
>         .name = "meson-gxm-saradc",
>  };
>
> @@ -999,7 +1008,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>                 return ret;
>
>         priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> -                                            priv->data->regmap_config);
> +                                            priv->data->param->regmap_config);
>         if (IS_ERR(priv->regmap))
>                 return PTR_ERR(priv->regmap);
>
> --
> 2.15.1
>
