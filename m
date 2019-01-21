Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EDC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FABF2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfAUId1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:33:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45343 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfAUId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:33:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so22634600qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWHD6GZkicUZZQd88GT/77cN1Bqp4YkwdA1lo5V7F24=;
        b=YEgoCd6ysbMExnOACfihvaCPlYVbD9v9+pKrvm0S+C4RPWxPWiy728L4BgW977qMrQ
         w+cVu2e2qsXNK95GYe9M7P0CSU/ZY9TiZCx17Ik+z+qaIo2IParE/QhXCGrmgHr7bAR/
         OJgfzc4xQFacAGy+xoWYA2JhacxGWkKt2V710l5ZcjTCjC77ddUYSaO+kgQAlDarK7TU
         4a+WAlHn4ZeLwmaDaBERgj8m2J0/alfY1tu+gBEw6l3oljfwAwEzdBNulkGOwy3X1dAo
         rzTvpPiVR/kDoAFBDvMwzJfEmy36rgwr+5910oj1xpExiBTOBWBCxZuSIqcV/Lsu5ASY
         lGEg==
X-Gm-Message-State: AJcUukdqG8QIBQPxIDuOnYlBaL0p1jTmtXkb82NimX5TON7wdK5LdnzA
        lT4RRKZklFQ1zxYwfyvNQ2MhPapFxo1Ftcf0Ty0lPw==
X-Google-Smtp-Source: ALg8bN62oCPAWbDzCoZ/R50wmYxc/Fc0aGWTr7Z3m20wfciv4nWDpohCWe0NRpOrNHjMTka3I1BuhXKGizQL6yTj9Fs=
X-Received: by 2002:a0c:81b5:: with SMTP id 50mr25079345qvd.166.1548059605449;
 Mon, 21 Jan 2019 00:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20190121070258.1844-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190121070258.1844-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 21 Jan 2019 09:33:14 +0100
Message-ID: <CAO-hwJLPFzwkY+tkgeas8066CNygfyTY2EoVrximURx4dwQ0TQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: elantech: Enable SMBus on new (2018+) systems
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 8:03 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> There are some new HP laptops with Elantech touchpad don't support
> multitouch.
>
> Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is
> supported, but in addition to firmware version, the bus type also
> informs us if the IC can support SMBus, so also check that.
>
> In case of breaking old ICs, only enables SMBus on systems manufactured
> after 2018, alongsides aforementioned checks.
>
> Lastly, consolidats all check into elantech_use_host_notify() and use it
> to determine whether to use PS/2 or SMBus.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Wording.
> - Further restrain on older systems (< 2018).
>
>  drivers/input/mouse/elantech.c | 63 ++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 9fe075c137dc..2594130b0079 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1799,6 +1799,39 @@ static int elantech_create_smbus(struct psmouse *psmouse,
>                                   leave_breadcrumbs);
>  }
>
> +static bool elantech_use_host_notify(struct psmouse *psmouse,
> +                                    struct elantech_device_info *info)
> +{
> +       bool host_notify = false;
> +
> +       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +               host_notify = true;
> +       else {
> +               switch (info->bus) {
> +               case ETP_BUS_PS2_ONLY:
> +                       /* expected case */
> +                       break;
> +               case ETP_BUS_SMB_ALERT_ONLY:
> +                       /* fall-through  */
> +               case ETP_BUS_PS2_SMB_ALERT:
> +                       psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> +                       break;
> +               case ETP_BUS_SMB_HST_NTFY_ONLY:
> +                       /* fall-through  */
> +               case ETP_BUS_PS2_SMB_HST_NTFY:
> +                       host_notify = true;
> +                       break;
> +               default:
> +                       psmouse_dbg(psmouse,
> +                                   "Ignoring SMBus bus provider %d.\n",
> +                                   info->bus);
> +               }
> +       }
> +
> +       /* SMbus implementation is stable after 2018 */
> +       return host_notify && (dmi_get_bios_year() >= 2018);

Strictly speaking, the check for the year should be in the `switch
(info->bus)`, but OTOH, laptops with ETP_NEW_IC_SMBUS_HOST_NOTIFY
should be manufactured after 2018 too, so we should be good.

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> +}
> +
>  /**
>   * elantech_setup_smbus - called once the PS/2 devices are enumerated
>   * and decides to instantiate a SMBus InterTouch device.
> @@ -1818,7 +1851,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>                  * i2c_blacklist_pnp_ids.
>                  * Old ICs are up to the user to decide.
>                  */
> -               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> +               if (!elantech_use_host_notify(psmouse, info) ||
>                     psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
>                         return -ENXIO;
>         }
> @@ -1838,34 +1871,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>         return 0;
>  }
>
> -static bool elantech_use_host_notify(struct psmouse *psmouse,
> -                                    struct elantech_device_info *info)
> -{
> -       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> -               return true;
> -
> -       switch (info->bus) {
> -       case ETP_BUS_PS2_ONLY:
> -               /* expected case */
> -               break;
> -       case ETP_BUS_SMB_ALERT_ONLY:
> -               /* fall-through  */
> -       case ETP_BUS_PS2_SMB_ALERT:
> -               psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> -               break;
> -       case ETP_BUS_SMB_HST_NTFY_ONLY:
> -               /* fall-through  */
> -       case ETP_BUS_PS2_SMB_HST_NTFY:
> -               return true;
> -       default:
> -               psmouse_dbg(psmouse,
> -                           "Ignoring SMBus bus provider %d.\n",
> -                           info->bus);
> -       }
> -
> -       return false;
> -}
> -
>  int elantech_init_smbus(struct psmouse *psmouse)
>  {
>         struct elantech_device_info info;
> --
> 2.17.1
>
