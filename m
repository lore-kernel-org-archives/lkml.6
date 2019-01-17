Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF67C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7861320652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfAQOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:42:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34437 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfAQOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:42:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so11589919qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Rb/4byw/fHcdZeQdDscfjYtn1FJeU6rrqOF3dDBCPQ=;
        b=hS9hgKMk+S1oMOpOx/kw5yL8LkU5vTIL5Zj8vsuGt+ze7KTEeBRhiPa09FzGkkARQb
         tVjdfDpKn4rhuF8hcb0u8oSWThsPWgAYpyxPnUcFbHOptXqNLUKtZKVWN/nPRNBP69lA
         oz1IQSYS3IhBVvmIgsN6vy4HbLNFJUxuJD51wfwAT8deUmt8N6AO00/MBXil71wLAQ4o
         ktnPUS+51J1xpKS658YKKq7Z1DDYRKhG+GW5Ny8QhxLCRbFXtc3M9dX9/4ZkhGa51by2
         k1HXx6PdcEAOtBLnezW7iZOmozT15hgIaBO0Ql1RIFFr4L0/mlwBV9qqhFhl+xa/rRXv
         S9yg==
X-Gm-Message-State: AJcUukf98E43qJgleN0t7kbYe2Thf6nurcvPTOWnh5HZzYiS462ddZ/J
        MTH1ayEY/O30s8Ii2pDZedXGeYd0reRlt7/MybsBnw==
X-Google-Smtp-Source: ALg8bN5clvx+hcivhKw8btlV7W6WnwRiSGlBmDNP5UDFxbSb4OJA6DvuFXpibSjYNrtqJ85f1e46mO5IMG9rfzI5VC0=
X-Received: by 2002:ac8:1a08:: with SMTP id v8mr11335299qtj.362.1547736176123;
 Thu, 17 Jan 2019 06:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20190117092948.32079-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190117092948.32079-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 17 Jan 2019 15:42:44 +0100
Message-ID: <CAO-hwJKyBHM1Yy8=pQrbDoArTOX4=8G6f0jECv4x1mth+LZZDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Input: elantech: Use SMBus based on bus info
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

Hi Kai-Heng,

On Thu, Jan 17, 2019 at 10:30 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> There are some new HP laptops with Elantech touchpad don't support
> multitouch.
>
> Both ETP_BUS_SMB_HST_NTFY_ONLY and ETP_BUS_PS2_SMB_HST_NTFY devices can
> use SMBus to support 5 fingers touch, so we need to chech them too.
>
> So use elantech_use_host_notify() to do a more thouroughly check.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/input/mouse/elantech.c | 58 +++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 9fe075c137dc..5bcf1c147eb1 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1799,6 +1799,34 @@ static int elantech_create_smbus(struct psmouse *psmouse,
>                                   leave_breadcrumbs);
>  }
>
> +static bool elantech_use_host_notify(struct psmouse *psmouse,
> +                                    struct elantech_device_info *info)
> +{
> +       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +               return true;
> +
> +       switch (info->bus) {
> +       case ETP_BUS_PS2_ONLY:
> +               /* expected case */
> +               break;
> +       case ETP_BUS_SMB_ALERT_ONLY:
> +               /* fall-through  */
> +       case ETP_BUS_PS2_SMB_ALERT:
> +               psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> +               break;
> +       case ETP_BUS_SMB_HST_NTFY_ONLY:
> +               /* fall-through  */
> +       case ETP_BUS_PS2_SMB_HST_NTFY:
> +               return true;
> +       default:
> +               psmouse_dbg(psmouse,
> +                           "Ignoring SMBus bus provider %d.\n",
> +                           info->bus);
> +       }
> +
> +       return false;
> +}
> +
>  /**
>   * elantech_setup_smbus - called once the PS/2 devices are enumerated
>   * and decides to instantiate a SMBus InterTouch device.
> @@ -1818,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>                  * i2c_blacklist_pnp_ids.
>                  * Old ICs are up to the user to decide.
>                  */
> -               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> +               if (!elantech_use_host_notify(psmouse, info) ||

That was my initial approach of the series, but I ended up being more
conservative as this would flip all of the existing elantech SMBUS
capable touchpads to use elan_i2c.
And I didn't want to deal with 4/5 year old laptops that suddenly broke.

So I wonder if you can restrict this default change to the recent
laptops (let's say 2018+). Maybe by looking at their FW version or
something else in the DMI?

Cheers,
Benjamin

>                     psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
>                         return -ENXIO;
>         }
> @@ -1838,34 +1866,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
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
