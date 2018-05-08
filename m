Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525765161; cv=none;
        d=google.com; s=arc-20160816;
        b=YA8CFCuER5lK71zisiDQRth1JagaBakb3Nz3RAWQr3ZHyzEmmEreSCYX5uKr+q/gPy
         WaxUQ4gLgFndkRNZp14FPyLD1D9Fvwg4uLTw7FAYzWOTRQyK8WthakNKBLehf9oYLm6U
         QQK1b4izAT77CXO1GzTi+PFW8XtnUHb+HyL+qi9vjj3w0ofuNPeKmfaQ8PT5+Ersub2K
         VhVAzOeYMkvIvySRLFxwcBypMKInROnEtIYTH5PbZ4hmah5ReSdHLQFhSIHv6VqyK2mt
         qmtLVrcLcIxNP4nsquwX0jHAB6h14Ztrp9NlEb7MBecxX6m7tYqIe5b0MA83KC2VdOBB
         lPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bv7+DC1aViuyw3GPQZ/EsRb9rQNS+iDtCTSf6+poOC8=;
        b=rJjhspXDRryFEq7J7i4icp/WRh+4J6WY5D5XwKxr6EeWGZyOGRqXt+74rWqYHmQZeq
         qAf8eA2B9epFZsTP8GJD/RNwZmmPDCUDeGJLT7M4Yu43wDwBmFWJDIrXiqX77VkYR+vV
         CajZ5WnXsRQsysjXy+0qd3mAA7vcPtl0+jvTcOpXFUVr2hllIm39kgbwsGrEWfoTFkTh
         y6zKD8wUZCy/qRuztUr8LvIZJxgByLqP7JVgAWpDKS5oqRTj1MiS326V5twRo0WKKd2z
         017atRSHILUp3z4nnrADPNchrJ3kR8OoKk9n9FtE76j3CpjKbLYtg1a4tWp2eLb7juqZ
         DktA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NAtoHmdl;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NAtoHmdl;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZrEfSGxOap2gZvB/p0uFr2fZvy+1UwhG617EdEyF9VgUynik9h6PmY1pSi/r62qW+zDPOzIneX+lBqmb68HSO0=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <5aee5ede.1c69fb81.353b4.5021SMTPIN_ADDED_MISSING@mx.google.com>
References: <5aee5ede.1c69fb81.353b4.5021SMTPIN_ADDED_MISSING@mx.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 09:39:20 +0200
X-Google-Sender-Auth: 6bC3FzKkL3LfDPL9MP0g4FlTP-E
Message-ID: <CAMuHMdXLTmJt6vKt-E-h2nzWdvv0Rw6J=vLbg55owK_-CRCiiw@mail.gmail.com>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599880729627848960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Finn,

On Sun, May 6, 2018 at 3:47 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Loading a NuBus driver module on a non-NuBus machine triggers the
> BUG_ON(!drv->bus->p) in driver_register() because the bus does not get
> registered unless MACH_IS_MAC(). Avoid this by registering the bus
> unconditionally using postcore_initcall().
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/nubus/bus.c   | 3 ++-
>  drivers/nubus/nubus.c | 5 -----
>  include/linux/nubus.h | 1 -
>  3 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> index d306c348c857..27ca9f1a281b 100644
> --- a/drivers/nubus/bus.c
> +++ b/drivers/nubus/bus.c
> @@ -63,7 +63,7 @@ static struct device nubus_parent = {
>         .init_name      = "nubus",
>  };
>
> -int __init nubus_bus_register(void)
> +static int __init nubus_bus_register(void)
>  {
>         int err;
>
> @@ -78,6 +78,7 @@ int __init nubus_bus_register(void)
>         device_unregister(&nubus_parent);
>         return err;
>  }
> +postcore_initcall(nubus_bus_register);

nubus_bus_register() two things:

  1. Register the NuBus parent device, which represents the bus host,
  2. Register the NuBus bus, which represents the bus type.

I think this should be split in two, and only the latter should be done
regardless of the presence of NuBus host hardware, to fix the crash.

>
>  static void nubus_device_release(struct device *dev)
>  {
> diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
> index 4621ff98138c..f6bab483f4cb 100644
> --- a/drivers/nubus/nubus.c
> +++ b/drivers/nubus/nubus.c
> @@ -869,15 +869,10 @@ static void __init nubus_scan_bus(void)
>
>  static int __init nubus_init(void)
>  {
> -       int err;
> -
>         if (!MACH_IS_MAC)
>                 return 0;
>
>         nubus_proc_init();
> -       err = nubus_bus_register();
> -       if (err)
> -               return err;

Hence you should still register the NuBus parent device here.

>         nubus_scan_bus();
>         return 0;
>  }


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
