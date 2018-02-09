Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbeBIGZn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 01:25:43 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45864 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeBIGZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 01:25:41 -0500
X-Google-Smtp-Source: AH8x224QxZS92l/GkWGX6F0unX7tqV7WCS9YH4VvoAZTsBCZptedUKh15LigPdmiHMUbvaZO7Bhhg790sulZey5Fnds=
MIME-Version: 1.0
In-Reply-To: <20180208215012.nrfhnr56r5jeb7vt@earth.universe>
References: <5822b56a4e65e27183f8bf712d5889b11f90111e.1515118527.git.baolin.wang@linaro.org>
 <20180208215012.nrfhnr56r5jeb7vt@earth.universe>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 9 Feb 2018 14:25:40 +0800
Message-ID: <CAMz4kuKb517P43DRsnqwkAUsa6rRXk7PdNuYoiPVq5cUQnF8tA@mail.gmail.com>
Subject: Re: [PATCH] power: reset: Add Spreadtrum SC27xx PMIC power off support
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 9 February 2018 at 05:50, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Baolin,
>
> On Mon, Jan 15, 2018 at 03:58:57PM +0800, Baolin Wang wrote:
>> On Spreadtrum platform, we need power off system through external SC27xx
>> series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 chips.
>> Thus this patch adds SC27xx series PMICs power-off support.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/power/reset/Kconfig           |    9 +++++
>>  drivers/power/reset/Makefile          |    1 +
>>  drivers/power/reset/sc27xx-poweroff.c |   65 +++++++++++++++++++++++++++++++++
>>  3 files changed, 75 insertions(+)
>>  create mode 100644 drivers/power/reset/sc27xx-poweroff.c
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index ca0de1a..611ae56 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -227,5 +227,14 @@ config SYSCON_REBOOT_MODE
>>         register, then the bootloader can read it to take different
>>         action according to the mode.
>>
>> +config POWER_RESET_SC27XX
>> +     tristate "Spreadtrum SC27xx PMIC power-off driver"
>> +     depends on MFD_SC27XX_PMIC || COMPILE_TEST
>> +     help
>> +       This driver supports powering off a system through
>> +       Spreadtrum SC27xx series PMICs. The SC27xx series
>> +       PMICs includes the SC2720, SC2721, SC2723, SC2730
>> +       and SC2731 chips.
>> +
>>  endif
>>
>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
>> index aeb65ed..225d645 100644
>> --- a/drivers/power/reset/Makefile
>> +++ b/drivers/power/reset/Makefile
>> @@ -27,3 +27,4 @@ obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
>>  obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
>>  obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>>  obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>> +obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
>> diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
>> new file mode 100644
>> index 0000000..8e4b6a0
>> --- /dev/null
>> +++ b/drivers/power/reset/sc27xx-poweroff.c
>> @@ -0,0 +1,65 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2017 Spreadtrum Communications Inc.
>> + * Copyright (c) 2017 Linaro Ltd.
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/syscore_ops.h>
>> +
>> +#define SC27XX_PWR_PD_HW     0xc2c
>> +#define SC27XX_PWR_OFF_EN    BIT(0)
>> +
>> +static struct regmap *regmap;
>> +
>> +/*
>> + * On Spreadtrum platform, we need power off system through external SC27xx
>> + * series PMICs, and it is one similar SPI bus mapped by regmap to access PMIC,
>> + * which is not fast io access.
>> + *
>> + * So before stopping other cores, we need release other cores' resource by
>> + * taking cpus down to avoid racing regmap or spi mutex lock when poweroff
>> + * system through PMIC.
>> + */
>> +void sc27xx_poweroff_shutdown(void)
>> +{
>> +     int cpu = smp_processor_id();
>> +
>> +     freeze_secondary_cpus(cpu);
>> +}
>> +
>> +static struct syscore_ops poweroff_syscore_ops = {
>> +     .shutdown = sc27xx_poweroff_shutdown,
>> +};
>> +
>> +static void sc27xx_poweroff_do_poweroff(void)
>> +{
>> +     regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
>> +}
>> +
>> +static int sc27xx_poweroff_probe(struct platform_device *pdev)
>> +{
>
> if (regmap)
>     return -EINVAL;

OK.

>
>> +     regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +     if (!regmap)
>> +             return -ENODEV;
>> +
>> +     pm_power_off = sc27xx_poweroff_do_poweroff;
>> +     register_syscore_ops(&poweroff_syscore_ops);
>> +     return 0;
>> +}
>
> static void sc27xx_poweroff_remove(struct platform_device *pdev) {
>     if (pm_power_off == sc27xx_poweroff_do_poweroff)
>         pm_power_off = NULL;
>     regmap = NULL;
> }

OK. I will add it in next version.

>
>> +static struct platform_driver sc27xx_poweroff_driver = {
>> +     .probe = sc27xx_poweroff_probe,
>
> .remove = sc27xx_poweroff_remove,
>
>> +     .driver = {
>> +             .name = "sc27xx-poweroff",
>> +     },
>> +};
>> +module_platform_driver(sc27xx_poweroff_driver);
>> +
>> +MODULE_DESCRIPTION("Spreadtrum SC27xx PMIC Poweroff Driver");
>> +MODULE_LICENSE("GPL v2");
>
> MODULE_ALIAS("platform:sc27xx-poweroff");

OK. Thanks for your comments.

-- 
Baolin.wang
Best Regards
