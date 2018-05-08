Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525763248; cv=none;
        d=google.com; s=arc-20160816;
        b=0fA+2nEl8Mhmpq5WaFHxPzpSQ7dQcpf8m6Qoi9PngunFACq3DTC42xIjRLD7ejucnc
         nwUt2SEDEDEeY1Eh7vwmrhnOBnwQW3gtrgI/EVdPmvlTvZO1dB4IgwtodCYaQFheoFin
         8agKLgzRsmMkyxsGSc5AAtPD4Yyzn4CWsHfIg4ovyjonvSjQ/5N7mU09XA2cOa8Lw5lA
         m0nujd2bnfAP0rahhkx84tPOxlVI4kIWu8G9vv0i/9Vm4d7gOREi6+FWgy4WWjSBmRS6
         O3g2X1z9vefBshqTG7tviP+d0drFx0iQg+zj6fXFYdI3GTlNqllXW9uteVIdWEItpgO3
         l0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uMobeMjclevp6TkvvKtvu1NzF98vTUcJXz7A7BRacLs=;
        b=W6FcK5DaF3WD/vMfjPvlE5qV/OzfWgR0fIZTzJCIw7bLG56jqUWBUS/WuoDOHa8riK
         /7VdZdmSsBKQPxLkZeWf1BtZxyXDjhbHJlMHBEzorMx48wPiMg9ovH/taKYUdoLJSc0t
         zrm37qig88UIfIOgit1dJjxz/Ej4jr5SO5xrsU1rd0I1yK/fBJjtwQYbuy6sebnWYWE0
         zY3sWAc/AYi0zEIhFRQS7UjelGfASQM6CnGXdQJ45sHIhjEdvY1Y6l2Y9Iina6kC3EZa
         QrvOyq4hFX7XPV1zvzZUXIz54LwiZ8XBpK43MLB0OWRN1QmmK3NDG09qVgAMuXYHthxD
         6law==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=k1CTcpuD;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=k1CTcpuD;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZrJwXpWoLPEkQyU4/lEgfou3N6oIK2w2YGI89MNjfdlT/iQz+ogFX7A7fin+bNzUikv5H/ba3ddZR21tHMM4rc=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180508070037.GA4792@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com> <CAOmrzk+bY5wUxJhNAwO-pf+O--HiqJ63rB3BmxRsY8qq_PeLmw@mail.gmail.com>
 <20180508070037.GA4792@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 09:07:27 +0200
X-Google-Sender-Auth: -2CatyeO7HxG2gRH-aEFY9aL6kg
Message-ID: <CAMuHMdUAWfmiaZG7snEQRL1N-w69NuSYzeoQgQosQRf_JTZ5OQ@mail.gmail.com>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>,
	"Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599878724025755314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Tue, May 8, 2018 at 9:00 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, May 07, 2018 at 09:51:12AM +1200, Michael Schmitz wrote:
>> the BUG() was triggered by loading a Mac Nubus network card module on
>> a multiplatform kernel running on an Amiga machine. Up to Finn's Nubus
>> core rewrite (this February), we've seen no errors. Since then, Nubus
>> drivers fail to register because the Nubus bus is only registered on
>> Macs.
>>
>> Can't see link order involved here at all.
>
> The link order is totally involved here :)
>
> Link order determines the order in which init calls are run, so you need
> to ensure that your bus code comes before any drivers that use that bus
> code in link order.  That way, at init time, your bus is created first,
> preventing this type of error to happen.

The issue here is not due to link ordering, but due to the bus not being
registered on a system that doesn't have that particular bus.

Akin to booting a kernel on an old PC without PCI, and loading a driver
module for a PCI network card. I guess that doesn't crash (because no one
has a PC without PCI anymore? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
