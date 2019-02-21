Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F7F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KwkdVR05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfBUXXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:23:47 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40711 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUXXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:23:44 -0500
Received: by mail-ua1-f65.google.com with SMTP id c5so319591uaq.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6co8PGy7u85N+i3IlEktJmTVtQ6xkF9M55t0eDiBs3Y=;
        b=KwkdVR05mH9V4K25y/0vvm+PLLGBQjN8HO91K94Eoc/DzLn83lhTieFHXW6x/9QwT1
         AZvqGZCaKRm9Z7LQA6PfR4HQ77a4lMDKgbnsQjd8PncD2noEp9YyHs40pWmaJAX/xM4Q
         UcHr//7ZG7mNLtz8BWnbNDeVrlAHrgDpECa2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6co8PGy7u85N+i3IlEktJmTVtQ6xkF9M55t0eDiBs3Y=;
        b=WCJZzst/pBaIIX6kaON11vSEkxWKqNlSjEVWD/JI9y8gZrO57PLYyihC9HJja1bg7G
         riC4OdfLqTTz6+QVRi1UH/RiJsmjC9dYqyyFIiNFwwhCSExW0N1IPO7/bNnnvcy3ABE3
         BJ5iAQKA7r7aJsb561wG5eMtGPH/Ak+s1IGfNfjAk4twnUAfDs75MKg0M/86UZwonEIX
         Oq8j3Fj2L1vlhyX073qAecprpx8KhN4dviXmsT+2x8a73mnr8z9S16KFmuiR6Dj1sHZr
         db42VREyP07yGF9Q9YZADNnj4cbtQjjfHTt42LGDF4H9FeE4nVTSJrLZDOs7OOhjbFjr
         WuAA==
X-Gm-Message-State: AHQUAuZ76OiHxKQdqolwbzAYIIgeftiogiezGnS4yrDvhZfFjSBT9SU5
        fZ8xW7wHx/jLg7s/TFcS8ryL2H4HLf0=
X-Google-Smtp-Source: AHgI3IYiqGqpwgZ5VW2MluNFbR3A620LTGnlh1i3KldTl5TlRSITCyIlYny53yLmTBvnCu/qrKAYyw==
X-Received: by 2002:ab0:72d5:: with SMTP id g21mr667307uap.16.1550791422747;
        Thu, 21 Feb 2019 15:23:42 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id k75sm99048vkk.1.2019.02.21.15.23.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 15:23:42 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id q17so360582uam.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:23:41 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr693156vsq.48.1550791421383;
 Thu, 21 Feb 2019 15:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20190221230641.8797-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190221230641.8797-1-aaro.koskinen@iki.fi>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 15:23:29 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLFwHSCVqJTGbr=HjeaWsW-TZ_1k=ubjEYgDQBxOV9nJg@mail.gmail.com>
Message-ID: <CAGXu5jLFwHSCVqJTGbr=HjeaWsW-TZ_1k=ubjEYgDQBxOV9nJg@mail.gmail.com>
Subject: Re: [PATCH v3] panic/reboot: allow specifying reboot_mode for panic only
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 3:06 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
>
> Allow specifying reboot_mode for panic only. This is needed on systems
> where ramoops is used to store panic logs, and user wants to use warm
> reset to preserve those, while still having cold reset on normal reboots.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>         v3: Move REBOOT_UNDEFINED before REBOOT_COLD.
>
>         v2: https://marc.info/?t=155078129700004&r=1&w=2
>
>             Use REBOOT_UNDEFINED instead of -1
>
>         v1: https://marc.info/?t=154957416600005&r=1&w=2
>
>  .../admin-guide/kernel-parameters.txt         |  4 +++-
>  include/linux/reboot.h                        |  2 ++
>  kernel/panic.c                                |  2 ++
>  kernel/reboot.c                               | 20 ++++++++++++++-----
>  4 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 858b6c0b9a15..5705b4689565 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3949,7 +3949,9 @@
>                                 [[,]s[mp]#### \
>                                 [[,]b[ios] | a[cpi] | k[bd] | t[riple] | e[fi] | p[ci]] \
>                                 [[,]f[orce]
> -                       Where reboot_mode is one of warm (soft) or cold (hard) or gpio,
> +                       Where reboot_mode is one of warm (soft) or cold (hard) or gpio
> +                                       (prefix with 'panic_' to set mode for panic
> +                                       reboot only),
>                               reboot_type is one of bios, acpi, kbd, triple, efi, or pci,
>                               reboot_force is either force or not specified,
>                               reboot_cpu is s[mp]#### with #### being the processor
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index e63799a6e895..3734cd8f38a8 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -14,6 +14,7 @@ struct device;
>  #define SYS_POWER_OFF  0x0003  /* Notify of system power off */
>
>  enum reboot_mode {
> +       REBOOT_UNDEFINED = -1,
>         REBOOT_COLD = 0,
>         REBOOT_WARM,
>         REBOOT_HARD,
> @@ -21,6 +22,7 @@ enum reboot_mode {
>         REBOOT_GPIO,
>  };
>  extern enum reboot_mode reboot_mode;
> +extern enum reboot_mode panic_reboot_mode;
>
>  enum reboot_type {
>         BOOT_TRIPLE     = 't',
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f121e6ba7e11..a0d839f883b7 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -306,6 +306,8 @@ void panic(const char *fmt, ...)
>                  * shutting down.  But if there is a chance of
>                  * rebooting the system it will be rebooted.
>                  */
> +               if (panic_reboot_mode != REBOOT_UNDEFINED)
> +                       reboot_mode = panic_reboot_mode;
>                 emergency_restart();
>         }
>  #ifdef __sparc__
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e1b79b6a2735..b9e79e8c7226 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -31,6 +31,7 @@ EXPORT_SYMBOL(cad_pid);
>  #define DEFAULT_REBOOT_MODE
>  #endif
>  enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
> +enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
>
>  /*
>   * This variable is used privately to keep track of whether or not
> @@ -519,6 +520,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
>  static int __init reboot_setup(char *str)
>  {
>         for (;;) {
> +               enum reboot_mode *mode;
> +
>                 /*
>                  * Having anything passed on the command line via
>                  * reboot= will cause us to disable DMI checking
> @@ -526,17 +529,24 @@ static int __init reboot_setup(char *str)
>                  */
>                 reboot_default = 0;
>
> +               if (!strncmp(str, "panic_", 6)) {
> +                       mode = &panic_reboot_mode;
> +                       str += 6;
> +               } else {
> +                       mode = &reboot_mode;
> +               }
> +
>                 switch (*str) {
>                 case 'w':
> -                       reboot_mode = REBOOT_WARM;
> +                       *mode = REBOOT_WARM;
>                         break;
>
>                 case 'c':
> -                       reboot_mode = REBOOT_COLD;
> +                       *mode = REBOOT_COLD;
>                         break;
>
>                 case 'h':
> -                       reboot_mode = REBOOT_HARD;
> +                       *mode = REBOOT_HARD;
>                         break;
>
>                 case 's':
> @@ -553,11 +563,11 @@ static int __init reboot_setup(char *str)
>                                 if (rc)
>                                         return rc;
>                         } else
> -                               reboot_mode = REBOOT_SOFT;
> +                               *mode = REBOOT_SOFT;
>                         break;
>                 }
>                 case 'g':
> -                       reboot_mode = REBOOT_GPIO;
> +                       *mode = REBOOT_GPIO;
>                         break;
>
>                 case 'b':
> --
> 2.17.0
>


-- 
Kees Cook
