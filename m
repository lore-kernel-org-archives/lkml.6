Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeB1PBS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:01:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56092 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeB1PBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:01:17 -0500
X-Google-Smtp-Source: AG47ELvO/gLerhbVV50FvJh+w7QOCBwDaDEjN2EwxzyYulU071YOe2A8AwujvuB80Sco4lbfaKJbKw==
Subject: Re: [PATCH v1] extcon: int3496: Ignore incorrect IoRestriction for ID
 pin
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, linux-kernel@vger.kernel.org
References: <20180226193444.69883-1-andriy.shevchenko@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c1d4636-237c-2344-6c7c-fcd4468f48b9@redhat.com>
Date: Wed, 28 Feb 2018 16:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226193444.69883-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-02-18 20:34, Andy Shevchenko wrote:
> The commit 70216fd937fe introduced a workaround for incorrect
> IoRestriction mode in ACPI table.
> 
> Now, when GPIO ACPI library does it in generic way, just set
> an appropriate quirk flag instead.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me and everything still works after this change,
so with the earlier review remarks fixed this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
>   drivers/extcon/extcon-intel-int3496.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index 191e99f06a9a..acaccb128fc4 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -50,7 +50,11 @@ static const struct acpi_gpio_params vbus_gpios = { INT3496_GPIO_VBUS_EN, 0, fal
>   static const struct acpi_gpio_params mux_gpios = { INT3496_GPIO_USB_MUX, 0, false };
>   
>   static const struct acpi_gpio_mapping acpi_int3496_default_gpios[] = {
> -	{ "id-gpios", &id_gpios, 1 },
> +	/*
> +	 * Some platforms have a bug in ACPI GPIO description making IRQ
> +	 * GPIO to be output only. Ask the GPIO core to ignore this limit.
> +	 */
> +	{ "id-gpios", &id_gpios, 1, ACPI_GPIO_QUIRK_NO_IO_RESTRICTION },
>   	{ "vbus-gpios", &vbus_gpios, 1 },
>   	{ "mux-gpios", &mux_gpios, 1 },
>   	{ },
> @@ -112,9 +116,6 @@ static int int3496_probe(struct platform_device *pdev)
>   		ret = PTR_ERR(data->gpio_usb_id);
>   		dev_err(dev, "can't request USB ID GPIO: %d\n", ret);
>   		return ret;
> -	} else if (gpiod_get_direction(data->gpio_usb_id) != GPIOF_DIR_IN) {
> -		dev_warn(dev, FW_BUG "USB ID GPIO not in input mode, fixing\n");
> -		gpiod_direction_input(data->gpio_usb_id);
>   	}
>   
>   	data->usb_id_irq = gpiod_to_irq(data->gpio_usb_id);
> 
