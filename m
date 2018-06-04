Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeFDNWr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:22:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40612 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeFDNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:22:40 -0400
X-Google-Smtp-Source: ADUXVKIBwB3AZttYYFtMK3chCQH63DRLxVhOUqd8c8+49hcd9iDdpQy5JdVJOgwCTJ4YcLaFuwJ+RQ==
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Chris Chiu <chiu@endlessm.com>, corentin.chary@gmail.com,
        dvhart@infradead.org, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux@endlessm.com
References: <20180604123238.82200-1-chiu@endlessm.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
Date: Mon, 4 Jun 2018 15:22:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604123238.82200-1-chiu@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris.

On 04-06-18 14:32, Chris Chiu wrote:
> Make asus-wmi notify on hotkey kbd brightness changes, listen for
> brightness events and update the brightness directly in the driver.
> For this purpose, bound check on brightness in kbd_led_set must be
> based on the same data type to prevent illegal value been set.
> 
> Update the brightness by led_classdev_notify_brightness_hw_changed.
> This will allow userspace to monitor (poll) for brightness changes
> on the LED without reporting via input keymapping.

Is this really a case of the hardware itself processing the
keypress and then changing the brightness *itself* ?

 From the "[PATCH 2/2] platform/x86: asus-wmi: Add keyboard backlight
toggle support" patch I get the impression that the driver is
modifying the brightness from within the kernel rather then the
keyboard controller are ACPI embeddec-controller doing it itself.

If that is the case then the right fix is for the driver to stop
mucking with the brighness itself, it should simply report the
right keyboard events and export a led interface and then userspace
will do the right thing (and be able to offer flexible policies
to the user).

Regards,

Hans




> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>   drivers/platform/x86/asus-nb-wmi.c |  2 --
>   drivers/platform/x86/asus-wmi.c    | 21 +++++++++++++++++++--
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 136ff2b4cce5..7ce80e4bb5a3 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -493,8 +493,6 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>   	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
>   	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
>   	{ KE_KEY, 0xB5, { KEY_CALC } },
> -	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
> -	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>   	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
>   	{ KE_END, 0},
>   };
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 1f6e68f0b646..b4915b7718c1 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -460,6 +460,7 @@ static void kbd_led_update(struct work_struct *work)
>   		ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
>   
>   	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
> +	led_classdev_notify_brightness_hw_changed(&asus->kbd_led, asus->kbd_led_wk);
>   }
>   
>   static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
> @@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>   
>   	asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>   
> -	if (value > asus->kbd_led.max_brightness)
> +	if ((int)value > (int)asus->kbd_led.max_brightness)
>   		value = asus->kbd_led.max_brightness;
> -	else if (value < 0)
> +	else if ((int)value < 0)
>   		value = 0;
>   
>   	asus->kbd_led_wk = value;
> @@ -656,6 +657,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>   
>   		asus->kbd_led_wk = led_val;
>   		asus->kbd_led.name = "asus::kbd_backlight";
> +		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
>   		asus->kbd_led.brightness_set = kbd_led_set;
>   		asus->kbd_led.brightness_get = kbd_led_get;
>   		asus->kbd_led.max_brightness = 3;
> @@ -1700,6 +1702,13 @@ static int is_display_toggle(int code)
>   	return 0;
>   }
>   
> +static int is_kbd_led_event(int code)
> +{
> +	if (code == NOTIFY_KBD_BRTUP || code == NOTIFY_KBD_BRTDWN)
> +		return 1;
> +	return 0;
> +}
> +
>   static void asus_wmi_notify(u32 value, void *context)
>   {
>   	struct asus_wmi *asus = context;
> @@ -1745,6 +1754,14 @@ static void asus_wmi_notify(u32 value, void *context)
>   		}
>   	}
>   
> +	if (is_kbd_led_event(code)) {
> +		if (code == NOTIFY_KBD_BRTDWN)
> +			kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
> +		else
> +			kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
> +		goto exit;
> +	}
> +
>   	if (is_display_toggle(code) &&
>   	    asus->driver->quirks->no_display_toggle)
>   		goto exit;
> 
