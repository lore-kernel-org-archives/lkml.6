Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525761143; cv=none;
        d=google.com; s=arc-20160816;
        b=KuBQxhNo5ZXczi9Zp9JSuUQdZtkD8dlbzvdR6Y06pr84HyfRnPEI1G4kC4dJT7iZN2
         ta/Sbk3jgM6iqWPQsReKzVLuBNuCPH2DBSwWBJHcpJlmcXsMGiUD1qe+Km47F+vHlihw
         FT85xGoBqllbRtCeBRi1uGtSjX8pRRLTv6AS3N1EjjCTl7lt38XRaoF8vXmVl/c1T+JW
         U2hSWIgh40vX2EjrslYRYJwWOrAUxj0gMjZDsizRafi1nU+NpVfXeKjjIwX4RiMWGgxU
         rOrpBBpGD7Wq2yXYTeWpGIKvRaOjDCRoJUTrqEb9K1Sgk6Aael98oyHurjyueldC1AUU
         ON6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=TimEAZeQaqy0iSWINMtVs20YrH+Pm/lKyEpxbjrpucQ=;
        b=zBzV/VsnYs6GYDBK9xfZJSQn1BGXpuk+qYmMOac3UEQ++GycwN6FLTAAIBx5LYeA4o
         8DBtUZWYYHS5f8+HbHReGOOiDWuvr1GL2KelmCRcsRSeXjSdAIuFBTmHZ4Y5DsbsGm3M
         oOkBxWra9owxWOtafUoCZ2IqE0LTxroFiutMasxZs3O9bKTZAy547HvVTz9ZPnbQemgp
         6INrdzK/9o9Sqrsize5myW3sUhssOv5iGfJtprTsAKLQwIsoc+Rbzx3GlPjS/AC+DwQJ
         om10OU+VnOJB7UPE+BEZHC2O42Fv/4TCUFeBlahi65H7UPToQuO1Pz3gqBp0WGXx6PNd
         LHSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z5nbuYuG;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z5nbuYuG;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZo/2d7XMCdlDJuuStRlegCQ7gm4AHWxGiAXPcbRlf+Rb0i7/FkwEptgnaO5sQ/DYMM5YA5ZQZ+Id9n0uZq25oA=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.21.1805080904460.8@nippy.intranet>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com> <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
 <alpine.LNX.2.21.1805080904460.8@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 08:32:22 +0200
X-Google-Sender-Auth: nVvW7UlCFFLcF5E1t_uMi24A5Yw
Message-ID: <CAMuHMdUCEc0n1R6-=8fcw2xng7ETPUEs86PhC_0=1jY_AYV6Bg@mail.gmail.com>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599876516759090449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Finn,

On Tue, May 8, 2018 at 1:44 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Mon, 7 May 2018, I wrote:
>> On Sun, 6 May 2018, Greg Kroah-Hartman wrote:
>> > > > Why not just have an "bus is registered" flag in your driver
>> > > > register function that refuses to let drivers register with the
>> > > > driver core if it isn't set?
>> > >
>> > > Perhaps that should happen in the core driver_register() function.
>> > > BUG_ON is frowned upon, after all. Would that be acceptable?
>> >
>> > I don't understand what you mean here, perhaps make a patch to show it?
>> >
>>
>> As an alternative to your suggestion (add flag to avoid the BUG_ON):
>>
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -148,7 +148,10 @@ int driver_register(struct device_driver *drv)
>>       int ret;
>>       struct device_driver *other;
>>
>> -     BUG_ON(!drv->bus->p);
>> +     if (!drv->bus->p) {
>> +             WARN_ONCE(1, "Cannot register driver with invalid bus\n");
>> +             return -EPROBE_DEFER;
>> +     }
>>
>>       if ((drv->bus->probe && drv->probe) ||
>>           (drv->bus->remove && drv->remove) ||
>>
>
> That rushed example I gave above seems to be confusing the issue. Sorry
> about that. (See sioux-core.c for the code that motivated it.)
>
> This example is the sort of flag removal that I had in mind --
>
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index ba912558a510..4ee22fb3db92 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -148,7 +148,8 @@ int driver_register(struct device_driver *drv)
>         int ret;
>         struct device_driver *other;
>
> -       BUG_ON(!drv->bus->p);
> +       if (!drv->bus->p)
> +               return -ENODEV;

If this is meant to handle the case where the device driver is registered
before the bus is registered, while the latter can still happen later,
then you want to return -EPROBE_DEFER.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
