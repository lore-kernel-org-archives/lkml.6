Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524728410; cv=none;
        d=google.com; s=arc-20160816;
        b=NjMgQgoqckpFrrilrqhdy7Nl90K/mtesV3u207sftr5al5UibY8odSZWQ/bpFrqr0T
         P/Z1jjvlP06GRNfNmD/tWKntK1CVqSEGOtw3pcw3VzMkQogQFRxzi6onQk77HIo9isQn
         97u1OaZPJc+JYKg/BgwYDUCHOdmju2SI0brp97qDFyFh46IXH3XBlMui9Ph1G3njLGOe
         LKRv0dLgixpObc/AEYaimn08HoH9IXalT4ASUojmSzEn8E3Yj/KFNqNeYw80/E7vaREk
         dkscpar33FwD9v3YVyNPXl3o86i/dkW+batqXCbKvZwGw5X+w/eB3FWuMKe+tyIX67XM
         CIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wgv+IQHFPTmGiwQ6Dyax7Ajj3ZX8TS+nKQV7v3OHW24=;
        b=Cgi2xzNLOitdSVFNclUU0rq7BEt+6mN8DyXumjeUtBxHqkdqEtH65wVEs4kEMMK6Uw
         beW0QCeqXWk/fjhGt+LwHQE/nUkye5VIJQg90PZDYs/utYfEMo9Csoo8owmnCe7OMbnM
         ww+8LV9l5kAvVvG44CSdGzceAyR5kFFepPW0rk5Hy5VyjQZZWB6HuMI2NZQWk2+oCcta
         A7EEKCd2VZnF06FmqfYTtYajLKFY5g/tvpBOFSRbpHB/+Xyh1bPjnt9qJe6M8yuKS1PM
         g5jNHeHBl+0Fze0DFDT9clF1njF9hKok6XbfOvLS5dionCn5MP0tTyykMom80aLI94p5
         NnfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o+H8K+6p;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o+H8K+6p;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx48n7WNexGPvalIha38RE7N1NBWZRe6A0A2OCW7zAsy+Zd+8IrO92NwTdqlNZbu47ZH/vNKYu6vgkwtiR2JCQC8=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180426070410.GM14025@kroah.com>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
 <20180425160645.GA16732@kroah.com> <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
 <20180426070410.GM14025@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Apr 2018 09:40:08 +0200
X-Google-Sender-Auth: 9W2LqgpmNPK6Zxm4z56ZrOwbVRE
Message-ID: <CAMuHMdWLCQoHzuW1UZNP9gdRV3EE6_yPcdyX1NDy65q7Nt4tZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>, Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>, Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365566189003865?=
X-GMAIL-MSGID: =?utf-8?q?1598793616922797006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Thu, Apr 26, 2018 at 9:04 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 25, 2018 at 07:53:06PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Apr 25, 2018 at 6:06 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
>> >> The driver_override implementation is susceptible to a race condition
>> >> when different threads are reading vs storing a different driver
>> >> override.  Add locking to avoid this race condition.
>> >>
>> >> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
>> >> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
>> >> condition with driver_override").
>> >>
>> >> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> Reviewed-by: Todd Kjos <tkjos@google.com>
>> >> Cc: stable <stable@vger.kernel.org>
>>
>> > As this should go to stable kernels, I've fixed it up to apply without
>> > patch 1 as that's not a real "fix" that anyone needs...
>> >
>> > Please try to remember to put fixes first, and then "trivial" things
>> > later on in a series.
>>
>> I did it on purpose, as the fix is much more ugly without patch 1 applied.
>> Can't you just take patch 1, too? More consistency is always nice, even for
>> stable ;-)
>
> Consistency is nice, but when you have bug fixes that rely on "trivial"
> patches, it's usually not nice :(
>
> I already committed patch 2 to my tree without 1, so let's leave it
> as-is for now.

Unfortunately the version you committed is buggy: the race condition
also covers the NULL check removed by the trivial patch you skipped,
so now you can get inconsistent behavior (no output or "(null)") on the
same running kernel version...

Please revert and apply both. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
