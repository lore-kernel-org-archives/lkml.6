Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934141AbeCGQv7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:51:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39590 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933919AbeCGQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:51:29 -0500
X-Google-Smtp-Source: AG47ELs1UsLiOE5ANc+UdhU1/YmYz2Hb/Q8rJBaEcQsoai+230NXeDSYKMWbyRL6uvAkFlhNSR8xnw==
Date: Wed, 7 Mar 2018 16:51:26 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] mfd: rave-sp: Add code to print firmware versions
Message-ID: <20180307165126.do5ecbm7ne2llmhb@dell>
References: <20180226150739.13457-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226150739.13457-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Andrey Smirnov wrote:

> Add code that would query and print out bootloader and application
> firmware version info.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Lee:
> 
> The reason 'part_number_firmware' and 'part_number_firmware' are a
> part of struct rave_sp is because there exists another patch on top of
> this one that exposes those fields via sysfs. The latter patch is not
> currently being upstreamed (might be in the future), so if keeping
> this arrangement is too ugly, let me know, and I'll get rid of those
> fields in 'rave_sp'.

That's okay.

>  drivers/mfd/rave-sp.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index c8173de5653a..9e4c83ff2aec 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -160,6 +160,8 @@ struct rave_sp_variant {
>   * @variant:			Device variant specific information
>   * @event_notifier_list:	Input event notification chain
>   *
> + * @part_number_firmware:	Firmware version
> + * @part_number_bootloader:	Bootloader version
>   */
>  struct rave_sp {
>  	struct serdev_device *serdev;
> @@ -171,8 +173,42 @@ struct rave_sp {
>  
>  	const struct rave_sp_variant *variant;
>  	struct blocking_notifier_head event_notifier_list;
> +
> +	const char *part_number_firmware;
> +	const char *part_number_bootloader;
>  };
>  
> +struct rave_sp_version {
> +	u8     hardware;
> +	__le16 major;
> +	u8     minor;
> +	u8     letter[2];
> +} __packed;
> +
> +struct rave_sp_status {
> +	struct rave_sp_version bootloader_version;
> +	struct rave_sp_version firmware_version;
> +	u16 rdu_eeprom_flag;
> +	u16 dds_eeprom_flag;
> +	u8  pic_flag;
> +	u8  orientation;
> +	u32 etc;
> +	s16 temp[2];
> +	u8  backlight_current[3];
> +	u8  dip_switch;
> +	u8  host_interrupt;
> +	u16 voltage_28;
> +	u8  i2c_device_status;
> +	u8  power_status;
> +	u8  general_status;
> +#define RAVE_SP_STATUS_GS_FIRMWARE_MODE	BIT(1)

I'm more concerned with the seemingly unused #define shoved in the
middle of a struct definition -- which I am not a fan of.

Better to introduce it when you start using it and outside of the
struct definition please.

The remainder of the patch looks okay.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
