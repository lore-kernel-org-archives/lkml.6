Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBIOuZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:50:25 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45452 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeBIOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:50:23 -0500
X-Google-Smtp-Source: AH8x225dZjqlNSHAsP1l7DmtL5patsQ/DF44JZbXNyHz+vpUq/iGM6EzuuQSNl9BSVPiH5D5LubihEX5TcLvQWT9+GM=
MIME-Version: 1.0
In-Reply-To: <20180209142318.14451-1-carlo@caione.org>
References: <20180209142318.14451-1-carlo@caione.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2018 16:50:22 +0200
Message-ID: <CAHp75VdrZVJ+mgx=9PkLuGbtTCru3S-0jVDNVcBft4a5Nr+pyw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
To: Carlo Caione <carlo@caione.org>
Cc: Linux Upstreaming Team <linux@endlessm.com>,
        Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carlo Caione <carlo@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 4:23 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> On at least one notebook (ECS EF20EA) the 'hp-detect' GPIO is defined in
> the DSDT table by the ACPI GpioIo resources in _CRS. Add this mapping to
> the rt5645 driver to enable the jack detection also on non-DT platforms.
>
> Method (_CRS, 0, NotSerialized)
> {
>   Name (SBUF, ResourceTemplate ()
>   {
>     I2cSerialBusV2 (0x001A, ControllerInitiated, 0x00061A80,
>         AddressingMode7Bit, "\\_SB.PCI0.I2C2",
>         0x00, ResourceConsumer, , Exclusive,
>         )
>     GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x0000,
>         "\\_SB.GPO3", 0x00, ResourceConsumer, ,
>         )
>         {   // Pin list
>             0x004F
>         }
>     GpioIo (Shared, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
>         "\\_SB.GPO3", 0x00, ResourceConsumer, ,
>         )
>         {   // Pin list
>             0x004F
>         }
>   })
>   Return (SBUF) /* \_SB_.PCI0.I2C2.RTK2._CRS.SBUF */
> }
>

Sorry everyone, hit reply only to Carlo, but everything he addressed
here is like I proposed.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>
> Changelog:
>
> v2:
>   - s/ACPI_HANDLE/has_acpi_companion/
> ---
>  sound/soc/codecs/rt5645.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 8f140c8b93ac..8e3d1e4ddb63 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3764,6 +3764,13 @@ static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
>         return 0;
>  }
>
> +static const struct acpi_gpio_params hp_detect_gpios = { 1, 0, false };
> +
> +static const struct acpi_gpio_mapping cht_rt5645_gpios[] = {
> +       { "hp-detect-gpios", &hp_detect_gpios, 1 },
> +       {},
> +};
> +
>  static int rt5645_i2c_probe(struct i2c_client *i2c,
>                     const struct i2c_device_id *id)
>  {
> @@ -3779,6 +3786,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>         if (rt5645 == NULL)
>                 return -ENOMEM;
>
> +       if (has_acpi_companion(&i2c->dev))
> +               if (devm_acpi_dev_add_driver_gpios(&i2c->dev, cht_rt5645_gpios))
> +                       dev_dbg(&i2c->dev, "Failed to add driver gpios\n");
> +
>         rt5645->i2c = i2c;
>         i2c_set_clientdata(i2c, rt5645);
>
> --
> 2.14.1
>



-- 
With Best Regards,
Andy Shevchenko
