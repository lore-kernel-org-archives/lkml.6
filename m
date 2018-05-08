Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525764911; cv=none;
        d=google.com; s=arc-20160816;
        b=mNQCxgjdLeD4cMFt+fx0xpYWuRvfp9xF580g8VRs0LsL/2Zs5Pt6TKUizL9K0dIZnC
         TN7W01aVLQtKzzEUe+cp0488Bm0eO74dYmvtBip79j6GrgbNzKIsXq2SNMzZULCAb7WT
         Lijdk4riyVJm2sIOr1gmGxUHgl4JsDBB+FJnIDH19BhHRLvC6YiNRvAmk3O3r9+bYYHx
         L4ozDC2R/hnYixV7vm9hQu3ds7CVi0FS77V5EZMvWJllsxFrFoVEzn9O+8XMOBWn4Xwu
         KP8227S/MqvFv/sgHS7iNQ2l2fTAOgIcFevF51r1mYg8W3F3MToxGF9BviRDwOE/JYkZ
         e3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Tqn/6XDMmOPmXqxw1tuj6Ivo/XnchCtdvWongIExG/o=;
        b=TBuPYqrc/Hh4tMq+/P4J6Z3T4THoaQiI/FZ5DMYpPu8oUQcTNaSzzSwAEQ0C+9nrWc
         91NP9nR+x+VaMgesKLKC8VFhqjRb9fMrrDzwz4gRHYVJS/zQGDU9Yn9e67gZbKhNJlxB
         702W62Mpi3iImXjNJoJPU/ogI9aZZDuxzav+Btr9Avev2OlQrcoe91HuIoIzMOB440F4
         YzAkjNb6LpRjK9oDLPNZNbEorDyCy6UrYy67QcxTTufJ9pt3UumbbmfSPmP2O2Qujw/t
         PA2BfHXTRk07RVQMo65URMOf+fNHbRtCiONKOmYTke1O2H26qTvlCN/cTjUbkeKjseC+
         MzyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TXmwmbhu;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TXmwmbhu;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZr79c35QcZmoNYjA8e3Bu38bfSK49LJ5pClZQ6sq85YCUTJ2wJUiKuWPXzDmtos888CZ/V51c9Rl79hFP6SixA=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180508072522.GA26568@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com> <CAOmrzk+bY5wUxJhNAwO-pf+O--HiqJ63rB3BmxRsY8qq_PeLmw@mail.gmail.com>
 <20180508070037.GA4792@kroah.com> <CAMuHMdUAWfmiaZG7snEQRL1N-w69NuSYzeoQgQosQRf_JTZ5OQ@mail.gmail.com>
 <20180508072522.GA26568@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 09:35:10 +0200
X-Google-Sender-Auth: Ue2ibHlufZuCh7L-aM12MOYuOOA
Message-ID: <CAMuHMdX+utbGHOV1p_oFwaKigxGBMMgkC_v5hWCO4EoVXeqezg@mail.gmail.com>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>,
	"Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599880467478274566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Tue, May 8, 2018 at 9:25 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, May 08, 2018 at 09:07:27AM +0200, Geert Uytterhoeven wrote:
>> On Tue, May 8, 2018 at 9:00 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Mon, May 07, 2018 at 09:51:12AM +1200, Michael Schmitz wrote:
>> >> the BUG() was triggered by loading a Mac Nubus network card module on
>> >> a multiplatform kernel running on an Amiga machine. Up to Finn's Nubus
>> >> core rewrite (this February), we've seen no errors. Since then, Nubus
>> >> drivers fail to register because the Nubus bus is only registered on
>> >> Macs.
>> >>
>> >> Can't see link order involved here at all.
>> >
>> > The link order is totally involved here :)
>> >
>> > Link order determines the order in which init calls are run, so you need
>> > to ensure that your bus code comes before any drivers that use that bus
>> > code in link order.  That way, at init time, your bus is created first,
>> > preventing this type of error to happen.
>>
>> The issue here is not due to link ordering, but due to the bus not being
>> registered on a system that doesn't have that particular bus.
>
> But how can that happen if the bus code is not present in the system at
> that point in time?  Hardware doesn't matter at all here.

The bus code is present in the system.
The bus is just not registered by the NuBus bus driver if the hardware
doesn't have a NuBus host.

>> Akin to booting a kernel on an old PC without PCI, and loading a driver
>> module for a PCI network card. I guess that doesn't crash (because no one
>> has a PC without PCI anymore? ;-)
>
> No, it should work just fine, try it!  :)
>
> The driver will not bind to anything, but the bus code should work
> properly, as long as it is initialized before the driver tries to
> register with that specific bus type.

Hence the NuBus bus code should register the bus irregardless of the
presence of the NuBus host hardware.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
