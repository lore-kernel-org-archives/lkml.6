Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AB8JxZpJDz7SLQtZTVljs77bV2rDsJlSIVE2HuX+my4fSZH4ILut5SHRh47qkA9/oI1ESJSecQs3
ARC-Seal: i=1; a=rsa-sha256; t=1525766389; cv=none;
        d=google.com; s=arc-20160816;
        b=yf5EMelVo9jOMNoT4sec0w33YrTXCxpPWz+zX7hXaUJImDN+wCJs9HIulaS6nDcoDQ
         BIbSOEk+rS9KuhnfrbA2Dcy1qGEzXmFaaJogWR3lFMdaOKBHKK9Z6kU7hnh/L3wJVrAZ
         xqeOUdFbMFPnjP4XuEr5OyS7q+xohGxhrERbz6dPPLD25nCYbD6TsSEvPyVncNUft0EK
         NKF4ytPgN2QmeoKT3/dOEiTbKT67NcB7Cy4sL9ls0h/QFtOAQaWKsnoiVeQhjBs9P7xP
         6fgOJy2bfeAZbuj145fLlNkoCXtvqXZbEIW0+i62dNrdvKmhfsRQY1A5OAd0vStloKLP
         Ebzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:arc-authentication-results;
        bh=QriWg46DPFNw5k+CwxrcwviWfYW71mWTzfPt2gz+j30=;
        b=rshB7m+zGymZzVExLmDY8uyCE2/nMIuv6IiuLAVV2rsi11DMPjYCfW/KCalnZDMAlW
         tMU7zHJ89tlSrZcxJV0d1t9EeKsn6NOZwfg3HjSywHX+WPxw8BhexRAfXQNvOTKX3ovB
         7P67tXUFFVn0IGllA+BrvGdNUNvc9RSRLPnCUr9KKZ4TPg+CvXRb5KW+RaBk7GzWfo5J
         REm/0bQXli9pJZl6RIXFq6DvjUUqtBxbT7np4GQKMMowO4gMBw9ZZwae+QAeXhi4YOm9
         VcBQQr3DJY8O47gnfKje6n3uBvcQ7f28jnsTuGeD3GySjOEhNe5JGkX9x83uPV/oRE03
         NrGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Date: Tue, 8 May 2018 17:59:52 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    linux-m68k <linux-m68k@lists.linux-m68k.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
In-Reply-To: <CAMuHMdUCEc0n1R6-=8fcw2xng7ETPUEs86PhC_0=1jY_AYV6Bg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1805081638020.30@nippy.intranet>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com> <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet> <20180506202018.GC8924@kroah.com> <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
 <alpine.LNX.2.21.1805080904460.8@nippy.intranet> <CAMuHMdUCEc0n1R6-=8fcw2xng7ETPUEs86PhC_0=1jY_AYV6Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599882017533775174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 8 May 2018, Geert Uytterhoeven wrote:

> > This example is the sort of flag removal that I had in mind --
> >
> > diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> > index ba912558a510..4ee22fb3db92 100644
> > --- a/drivers/base/driver.c
> > +++ b/drivers/base/driver.c
> > @@ -148,7 +148,8 @@ int driver_register(struct device_driver *drv)
> >         int ret;
> >         struct device_driver *other;
> >
> > -       BUG_ON(!drv->bus->p);
> > +       if (!drv->bus->p)
> > +               return -ENODEV;
> 
> If this is meant to handle the case where the device driver is registered
> before the bus is registered, while the latter can still happen later,
> then you want to return -EPROBE_DEFER.
> 

Returning -EAGAIN might be appropriate if driver_register() could 
reasonably expect the bus to come into existence.

However, a separation of concerns would seem to imply that the driver core 
has no way of knowing whether that might happen.

Anyway, this discussion is academic. The patch was only meant to 
illustrate a way to remove code instead of adding it, while achieving the 
same goal.

I'm not proposing this patch. I don't claim to understand all of the 
considerations that apply here. I'm certain there are situations where 
BUG_ON is appropriate. This may be one of those situations.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
