Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeEGOKV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:10:21 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:41343 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeEGOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:10:20 -0400
X-Google-Smtp-Source: AB8JxZpM4s/Q54iydPIgymol9eFMmbA0I+TBQsJ8AwhliLXW/UzXDSCe/3DlpRgan9VPCV6NvV7CWIrPjoR9PFFVL68=
MIME-Version: 1.0
In-Reply-To: <20180503030438.51150-1-chiu@endlessm.com>
References: <20180503030438.51150-1-chiu@endlessm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 7 May 2018 17:10:18 +0300
Message-ID: <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight toggle support
To: Chris Chiu <chiu@endlessm.com>
Cc: Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 6:04 AM, Chris Chiu <chiu@endlessm.com> wrote:
> Some Asus laptops like UX550GE has hotkey (Fn+F7) for keyboard
> backlight toggle. In this UX550GE, the hotkey incremet the level
> of brightness for each keypress from 1 to 3, and then switch it
> off when the brightness has been the max. This commit interprets
> the code 0xc7 generated from hotkey to KEY_KBDILLUMUP to increment
> the brightness, then pass KEY_KBDILLUMTOGGLE to user space after
> the brightness max been reached for switching the led off.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>
> Notes:
>     v2:
>     - Remove redundant 'else' branch logic
>
>  drivers/platform/x86/asus-nb-wmi.c | 1 +
>  drivers/platform/x86/asus-wmi.c    | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 136ff2b4cce5..14c502e18579 100644
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
> index 1f6e68f0b646..4a3ba575c9ce 100644
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
> @@ -1745,6 +1746,10 @@ static void asus_wmi_notify(u32 value, void *context)
>                 }
>         }
>
> +       if (code == NOTIFY_KBD_BRTTOGGLE)
> +               if (asus->kbd_led_wk < asus->kbd_led.max_brightness)
> +                       code = NOTIFY_KBD_BRTUP;
> +
>         if (is_display_toggle(code) &&
>             asus->driver->quirks->no_display_toggle)
>                 goto exit;
> --
> 2.14.1
>



-- 
With Best Regards,
Andy Shevchenko
