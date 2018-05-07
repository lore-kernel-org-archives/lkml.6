Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525697594; cv=none;
        d=google.com; s=arc-20160816;
        b=POjLU3yqIJ8qmW/g9hESmG1tWhzyBbkOEwJsN5V8EkrD+Khmv7CJwbKBYpBuhh5B3y
         q6AFpkVdbkcGgjbvoznjBlWemKp86CRPUnyrwExII3liyH78ezii9yDRWrvc8AbR4iyv
         iNQazTXQIGk//m5pMK7F2ALZ/MGOZ04W6sT4kEcwRjOZb9Glx230GeeK32w/OygcGIR2
         D/p89xJRX5nZPwOGh02P/QXPywE6IhvHoW0ECdC/n+4gwVL2XJZ1mf7QByz8dlXBcAFE
         8lWIh4vIbvk3bScDPW8dxsFn+tj/i+M4NWZFqnRb158FLW1v7uvl5z5V0PYIxLN9x2Kb
         z3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=A6+yvOI/kzqzhVfgCICPo36DJePeOYaM601A/VgrFbc=;
        b=isBlxSqI1GOR60WwMZQwGUM1D433WdAXeGjFMAxN9fc2mrc2LBkrhkVw+0459nIPow
         fiu/mEWbwWcrLJIsbHrXIneWPrVg+AD3g6cyFiWsm80zSJpg6nXElBeCOVrx8Zb7olgu
         UmrGlOtuUIJckNq9dLpRTQtx7XGdPz+iZHpgQ7O9oSFulQimavZxgVOVyiLlU576A50j
         BuXRaDYeZ5SfO98cY+runiK6Jw5S13mnPQmIrNnx9Q+Hrz6QGqvzwbZPgKJydK690NCK
         iNV+3mqkG5q+hx2yXMrFjqahk87lflfoYE7JptcEHV+E6E9c+H4WLDxngslTyoBpVt33
         KZug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AQkWljV5;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AQkWljV5;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZrfVDgEHMdgw9sebx8Yu1z1HVgetohZuvSfrVJvRIEcmQ2JGfzuyBgK3INMfqXWKl2eOcNTfIhGB09n8bPFXg8=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com> <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 May 2018 14:53:13 +0200
X-Google-Sender-Auth: WRBTu4gbcLFf16zZ5TzmflmtB88
Message-ID: <CAMuHMdV_5p0Un3xMC1SMw71xpLAzVH0u4oJCTeGeo7jXS4KZSA@mail.gmail.com>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599809880878552044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Finn,

(responding immediately to patches doing non-kosher things ;-)

On Mon, May 7, 2018 at 1:57 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 6 May 2018, Greg Kroah-Hartman wrote:
>> > > Why not just have an "bus is registered" flag in your driver
>> > > register function that refuses to let drivers register with the
>> > > driver core if it isn't set?
>> >
>> > Perhaps that should happen in the core driver_register() function.
>> > BUG_ON is frowned upon, after all. Would that be acceptable?
>>
>> I don't understand what you mean here, perhaps make a patch to show it?
>>
>
> As an alternative to your suggestion (add flag to avoid the BUG_ON):
>
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -148,7 +148,10 @@ int driver_register(struct device_driver *drv)
>         int ret;
>         struct device_driver *other;
>
> -       BUG_ON(!drv->bus->p);
> +       if (!drv->bus->p) {
> +               WARN_ONCE(1, "Cannot register driver with invalid bus\n");
> +               return -EPROBE_DEFER;
> +       }
>
>         if ((drv->bus->probe && drv->probe) ||
>             (drv->bus->remove && drv->remove) ||
>
> I'm not actually proposing this change; just responding to your question.

The bus_type.p field may be unused by some bus drivers, hence this
would prevent their drivers from being registered.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
