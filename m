Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeEBGcU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:32:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42523 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeEBGcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:32:16 -0400
X-Google-Smtp-Source: AB8JxZoV7CH6hkrWPj80nVwlZPaFY9ocvbYtZxMw82LlzAFxqjiPh/vWgWZUuRCF+/dCZf+OtjN9mR0i7I2ynTA1Cag=
MIME-Version: 1.0
In-Reply-To: <20180502060224.44903-1-chiu@endlessm.com>
References: <20180502060224.44903-1-chiu@endlessm.com>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Wed, 2 May 2018 14:32:15 +0800
Message-ID: <CAPpJ_ecHKTC0=NyOfRwKuXJmRbYnD7YegHGE4Fsr-RzrUL060A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Add keyboard backlight toggle support
To: Chris Chiu <chiu@endlessm.com>
Cc: corentin.chary@gmail.com, dvhart@infradead.org, andy@infradead.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-02 14:02 GMT+08:00 Chris Chiu <chiu@endlessm.com>:
> Some Asus laptops like UX550GE has hotkey (Fn+F7) for keyboard
> backlight toggle. In this UX550GE, the hotkey incremet the level
> of brightness for each keypress from 1 to 3, and then switch it
> off when the brightness has been the max. This commit interprets
> the code 0xc7 generated from hotkey to KEY_KBDILLUMUP to increment
> the brightness, then pass KEY_KBDILLUMTOGGLE to user space after
> the brightness max been reached for switching the led off.
>
> https://phabricator.endlessm.com/T21390
>

Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 1 +
>  drivers/platform/x86/asus-wmi.c    | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 136ff2b..14c502e 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -496,6 +496,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>         { KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>         { KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>         { KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
> +       { KE_KEY, 0xC7, { KEY_KBDILLUMTOGGLE } },
>         { KE_END, 0},
>  };
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 1f6e68f..b64ff90 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -67,6 +67,7 @@ MODULE_LICENSE("GPL");
>  #define NOTIFY_BRNDOWN_MAX             0x2e
>  #define NOTIFY_KBD_BRTUP               0xc4
>  #define NOTIFY_KBD_BRTDWN              0xc5
> +#define NOTIFY_KBD_BRTTOGGLE           0xc7
>
>  /* WMI Methods */
>  #define ASUS_WMI_METHODID_SPEC         0x43455053 /* BIOS SPECification */
> @@ -1745,6 +1746,13 @@ static void asus_wmi_notify(u32 value, void *context)
>                 }
>         }
>
> +       if (code == NOTIFY_KBD_BRTTOGGLE) {
> +               if (asus->kbd_led_wk < asus->kbd_led.max_brightness)
> +                       code = NOTIFY_KBD_BRTUP;
> +               else
> +                       code = NOTIFY_KBD_BRTTOGGLE;
> +       }
> +
>         if (is_display_toggle(code) &&
>             asus->driver->quirks->no_display_toggle)
>                 goto exit;
> --
> 2.7.4
>
