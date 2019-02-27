Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE774C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B2D20645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfB0J5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:57:15 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46949 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfB0J5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:57:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id z25so18410012qti.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAoRLra1XXszsSR0IdCenIw5JzavIH0kwImBz3gWHSI=;
        b=ZEPYngV1ITtnlskuQOCHoVtg5L3CGEU1+gi0ifdGXEw1yuNU15LHnTk/lsdkuQpo8F
         7Srf8kl+biaZwiQ0mHNkjY9i6vIju0gxDLA/g4FDnCXNQecfXlJ/6Xtvn2A3JgcojwAK
         ah0xJnNENrN89FQZcCSVqPoQ20oGjPmZxHO/iyale13xgWCCHCskjGPaMBH0gKcrIu0n
         yIsz/bJe9yqkgz/QE3dZbi2KP5VqyeMdr0nEWCi8ZKdkqUT2j7S5T/MFfjcTr2n7PzGs
         l+J4JsOdsSrkQI/1CdJuG7WJxeP9fohFY5ZyrnE8bJqbiELElzUFRim7ewd/LNjhxYac
         Xz3g==
X-Gm-Message-State: APjAAAWz0tYlByX7p/C33QcA+ZCqEVYaRjCDQWpr3ZcQHSNRxYh3bvrG
        7KdH0NHaVh5zQtjEUWa0VJPSiHdFI/IBV5mWUDHC8Q==
X-Google-Smtp-Source: AHgI3IZwQNTgsB3Cif4vde0kX/Guy1cJWTAMPnh/GjFfXn08TJ+5yrpaTzOuhsVOBdAG2iE/3YPYbb9JYNd73mecQno=
X-Received: by 2002:ac8:22d1:: with SMTP id g17mr931744qta.30.1551261433544;
 Wed, 27 Feb 2019 01:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20190226234853.20441-1-louis@kragniz.eu>
In-Reply-To: <20190226234853.20441-1-louis@kragniz.eu>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 27 Feb 2019 10:57:02 +0100
Message-ID: <CAO-hwJLrKDTrOxy3_JYKcTync_6Qis3wdMkwgMUj_WpZr2Xj-g@mail.gmail.com>
Subject: Re: [PATCH] HID: quirks: use correct format chars in dbg_hid
To:     Louis Taylor <louis@kragniz.eu>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:50 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When building with -Wformat, clang warns:
>
> drivers/hid/hid-quirks.c:1075:27: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   bl_entry->driver_data, bl_entry->vendor,
>                                          ^~~~~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1076:4: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   bl_entry->product);
>                   ^~~~~~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1242:12: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   quirks, hdev->vendor, hdev->product);
>                           ^~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1242:26: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   quirks, hdev->vendor, hdev->product);
>                                         ^~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> 4 warnings generated.
>
> This patch fixes the format strings to use the correct format type for unsigned
> ints.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  drivers/hid/hid-quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 94088c0ed68a..b4e49e1b6f4a 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
>         }
>
>         if (bl_entry != NULL)
> -               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%x:0x%x\n",

Can you make it %04x instead?
The VID/PID are usually 4 hex chars, and without the '04' format,
you'll end up having a varying length result, which is not that nice.

Cheers,
Benjamin

>                         bl_entry->driver_data, bl_entry->vendor,
>                         bl_entry->product);
>
> @@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
>                 quirks |= bl_entry->driver_data;
>
>         if (quirks)
> -               dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found squirk 0x%lx for HID device 0x%x:0x%x\n",
>                         quirks, hdev->vendor, hdev->product);
>         return quirks;
>  }
> --
> 2.20.1
>
