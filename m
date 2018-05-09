Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965361AbeEIP7b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:59:31 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42001 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbeEIP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:59:26 -0400
X-Google-Smtp-Source: AB8JxZot35zwnGm7PyOk0tLNGcoTV8C9IdQN9N7TV8VZsRVhp/PC7W6r6GOu4MYM/dscGgG2JkjUtxZ0/HtLcloYsco=
MIME-Version: 1.0
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com> <1525859941-23654-3-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1525859941-23654-3-git-send-email-akshu.agrawal@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Wed, 09 May 2018 15:59:14 +0000
Message-ID: <CAGS+omCy8B343pW-b26aEuRLyYHiQjMO2Rph4L6_x37uJ7r6vA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ACPI: APD: Add AMD misc clock handler support
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Alexander.Deucher@amd.com, Mike Turquette <mturquette@baylibre.com>,
        sboyd@kernel.org, christian.koenig@amd.com,
        Dave Airlie <airlied@redhat.com>, Shaoyun.Liu@amd.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 4:01 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:

> AMD SoC exposes clock for general purpose use. The clock registration
> is done in clk-st driver. The MMIO mapping are passed on to the
> clock driver for accessing the registers.
> The misc clock handler will create MMIO mappings to access the
> clock registers and enable the clock driver to expose the clock
> for use of drivers which will connect to it.

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
> v2: Submitted with dependent patch, removed unneeded kfree for
devm_kzalloc
> v3: used devm_ioremap and fix coccinelle warning
>   drivers/acpi/acpi_apd.c | 47
+++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)

> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index d553b00..2664452 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -11,6 +11,7 @@
>    */

>   #include <linux/clk-provider.h>
> +#include <linux/platform_data/clk-st.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
>   #include <linux/clkdev.h>
> @@ -72,6 +73,47 @@ static int acpi_apd_setup(struct apd_private_data
*pdata)
>   }

>   #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
> +
> +static int misc_check_res(struct acpi_resource *ares, void *data)
> +{
> +       struct resource res;
> +
> +       return !acpi_dev_resource_memory(ares, &res);
> +}
> +
> +static int st_misc_setup(struct apd_private_data *pdata)
> +{
> +       struct acpi_device *adev = pdata->adev;
> +       struct platform_device *clkdev;
> +       struct st_clk_data *clk_data;
> +       struct resource_entry *rentry;
> +       struct list_head resource_list;
> +       int ret;
> +
> +       clk_data = devm_kzalloc(&adev->dev, sizeof(*clk_data),
GFP_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&resource_list);
> +       ret = acpi_dev_get_resources(adev, &resource_list, misc_check_res,
> +                                    NULL);
> +       if (ret < 0)
> +               return -ENOENT;
> +
> +       list_for_each_entry(rentry, &resource_list, node) {
> +               clk_data->base = devm_ioremap(&adev->dev,
rentry->res->start,
> +                                             resource_size(rentry->res));
> +               break;
> +       }
> +
> +       acpi_dev_free_resource_list(&resource_list);
> +
> +       clkdev = platform_device_register_data(&adev->dev, "clk-st",
> +                                              PLATFORM_DEVID_NONE,
clk_data,
> +                                              sizeof(*clk_data));
> +       return PTR_ERR_OR_ZERO(clkdev);
> +}
> +
>   static const struct apd_device_desc cz_i2c_desc = {
>          .setup = acpi_apd_setup,
>          .fixed_clk_rate = 133000000,
> @@ -94,6 +136,10 @@ static int acpi_apd_setup(struct apd_private_data
*pdata)
>          .fixed_clk_rate = 48000000,
>          .properties = uart_properties,
>   };
> +
> +static const struct apd_device_desc st_misc_desc = {
> +       .setup = st_misc_setup,
> +};
>   #endif

>   #ifdef CONFIG_ARM64
> @@ -179,6 +225,7 @@ static int acpi_apd_create_device(struct acpi_device
*adev,
>          { "AMD0020", APD_ADDR(cz_uart_desc) },
>          { "AMDI0020", APD_ADDR(cz_uart_desc) },
>          { "AMD0030", },
> +       { "AMD0040", APD_ADDR(st_misc_desc)},
>   #endif
>   #ifdef CONFIG_ARM64
>          { "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
> --
> 1.9.1
