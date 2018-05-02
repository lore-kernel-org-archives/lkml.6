Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeEBOaL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:30:11 -0400
Received: from mout.web.de ([212.227.15.14]:58367 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBOaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:30:00 -0400
Subject: Re: [PATCH] platform/x86: asus-wmi: Add keyboard backlight toggle
 support
To: Chris Chiu <chiu@endlessm.com>, corentin.chary@gmail.com,
        dvhart@infradead.org, andy@infradead.org
Cc: acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
References: <20180502060224.44903-1-chiu@endlessm.com>
From: "Puma D." <puma.d@web.de>
Message-ID: <09b12fe1-3023-5e16-7c80-e73a8c3634fd@web.de>
Date: Wed, 2 May 2018 16:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502060224.44903-1-chiu@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:IRSTPkDXa+XbraONAD3V8qt8w+lWs2X/8kNLlJJMdN5MQ/XErBj
 n3+x3YMERFskHM+6+pWbI/kVqJ8P72h5L1Azm0sBmcTWlQ5TR31fXIqzek6T6ilIAqFDBqi
 WRWPXGUOlwjWWBKbw3SmdJOkESMqvOCuk5WBXhX4sNBXurw2V+L2Cgi9ywJgrarLB6y0Y/t
 Za9AdYXMsIAy9oIZTDxUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:chAjjBcTJIs=:UrAOFpuzotMo/ppcMsCKoV
 rOsPSIXswnx+B8Q2EOAvlQndKoUMJNQROE5lOaU5xkYTsl7Xd+5DdYLYHPKvQGk1GzddbRZrK
 x7dixr9i6brn39g7CA3g+SIIJGA3KvrpCnaA9ifgUUsRWXf/UyWRFraPI7/tdNvM/8aEokpWK
 Fybfycml7Nkm6EjadKUGh0cqas+P8t8g5U4BwbjMJdFIEu9QbG6mVDDi31fYWlMqEcVQfGjlA
 PyVqMnukj+nsBcuilv7/Ker+sMtttVB0Gf4yI4aXuXc222wVlZ5sawDNcESdr0axv9RlGLYpt
 ua8TTszHlTXhJrcvaFpRyQ/Gtn2OyyVAuLKzQNQntkvgHV88OdhMKG822FBohPVW5bIiQ8MeM
 R5khFPMqYTUnJA6uGT2dN+hjI0FE00JLnK1CBR0ceiKWoNe4E9KeueYj6eslVdBPWveTU/6J7
 2n2ZkZV2w2+XJCAcx/QC5QnAeEmDxYV744/ADXPfytD2/SE9/2MzExiGVHzFjFufB+T9iG/Vt
 VNGU7Dgk9xSNc7+uY/rOFKGqhFuVOlk/eyWyaddRvKphpOa/VpijNYBqsqmZ8ycwhH6yk4xb4
 FHCmDhrNqjQvH8AoqMsHdV+SP0eziMvJeoDbBtKsGTyqZ+Vx9oh3kjx+oLG8x0yS19U/0Je4C
 9fqy33MYffVawiB8YhbegixNnsAlcvZefBrYLTeFpczC3ncbPFTAjWrSdbh6TZB7t8mYgj4Ca
 WMd9q1UxamTXC7683TH1bFAln0AMI5fiD1oGwRKwXlhgXYaRjv+HtUFsuzp4NyzItqLSofCKq
 XDa7M7i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.2018 08:02, Chris Chiu wrote:
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
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>   drivers/platform/x86/asus-nb-wmi.c | 1 +
>   drivers/platform/x86/asus-wmi.c    | 8 ++++++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 136ff2b..14c502e 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -496,6 +496,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>   	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>   	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>   	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
> +	{ KE_KEY, 0xC7, { KEY_KBDILLUMTOGGLE } },
>   	{ KE_END, 0},
>   };
>   
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 1f6e68f..b64ff90 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -67,6 +67,7 @@ MODULE_LICENSE("GPL");
>   #define NOTIFY_BRNDOWN_MAX		0x2e
>   #define NOTIFY_KBD_BRTUP		0xc4
>   #define NOTIFY_KBD_BRTDWN		0xc5
> +#define NOTIFY_KBD_BRTTOGGLE		0xc7
>   
>   /* WMI Methods */
>   #define ASUS_WMI_METHODID_SPEC	        0x43455053 /* BIOS SPECification */
> @@ -1745,6 +1746,13 @@ static void asus_wmi_notify(u32 value, void *context)
>   		}
>   	}
>   
> +	if (code == NOTIFY_KBD_BRTTOGGLE) {
> +		if (asus->kbd_led_wk < asus->kbd_led.max_brightness)
> +			code = NOTIFY_KBD_BRTUP;
> +		else
> +			code = NOTIFY_KBD_BRTTOGGLE;
> +	}
Did you intend the else branch to be a noop?

> +
>   	if (is_display_toggle(code) &&
>   	    asus->driver->quirks->no_display_toggle)
>   		goto exit;
