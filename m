Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524732350; cv=none;
        d=google.com; s=arc-20160816;
        b=ONFgfxxnq4wDd2MkOKvbpPfN6HZ5xhfIGWu9bZupMlFy1c3QW7DkOdXJV2iYk0BmuS
         lszs45AS7bBWsV/qpXsN/fSDXf4/+yyioxpVMGHzd0yfATqQ+ioS3/CcbwUwwTf1U3Mw
         fFMOrLQOwX90jfCTKMBEcyI98QdIfNDi4V9zuUcEu/2GJOkgjgUvAurrfDO+Id6Ps+A/
         6uLkLf8LX7RXgRO2JpmEl1MX4pwZU0g/nSFNvNC1X1Ja2A/QS6Pnv9nPROk1r3b6M3LO
         /z6xKiCETfKV1uYdjfOvEGgYU82mXIyyqykX3lbVl2UXMmyeuHHll0rwRTHaggN2QVcQ
         KiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5PFvN7umsxkCEy2XpAHtlgcNWA/CibLzrLgXqA7lfdY=;
        b=m/W2RbldqqFIRnD/JUPl8MdkEn13CkHkIVqU2afWNaUxhEHakQGdUGPW52jli9urKE
         cKzLZPW4x3S5wIXTQI4le9A1pclJRvHfHFIaXQyFgAtOGndkR0mji+ydWzc3ekJMYsdh
         wXsKxNI6Gx4DHyU82I8qGnB7sHNFy7fwqE3WzZ7FWPvmvFI9KJ06v21fadjNszT2ivo3
         40Of3wP3sig8wVTIIZE07O4G9dzgnh/mGO9ixrnv0Yf0m69O6XVAH+FsX7jPhNuDWUM0
         lKFOlUkU+I3gfoxRdz6w/2/Hlvc2HMoqxKIrfIK4UDp4XTabuOoKeLh0W6I+Or4ZlL+6
         dd+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ks8GTmJm;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ks8GTmJm;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx4+bKn+aKEIxeJjnkEh5Mv+gkQEaRakeydEoAUBJLW+QMP48IIl5nmNYLqcyZT56rmn7ZhB7rAsk3P/tlwFDBp8=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180426083542.GA31073@kroah.com>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
 <20180425160645.GA16732@kroah.com> <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
 <20180426070410.GM14025@kroah.com> <CAMuHMdWLCQoHzuW1UZNP9gdRV3EE6_yPcdyX1NDy65q7Nt4tZw@mail.gmail.com>
 <20180426083542.GA31073@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Apr 2018 10:45:49 +0200
X-Google-Sender-Auth: T8AcLMTHAcm24CuJaAvJl7L8ZHA
Message-ID: <CAMuHMdWO+C3g4T_rPbcyPFgVpqubjj4HZ++O+P7d0VYYFP0xWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>, Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>, Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365566189003865?=
X-GMAIL-MSGID: =?utf-8?q?1598797749023491363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Thu, Apr 26, 2018 at 10:35 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 26, 2018 at 09:40:08AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 26, 2018 at 9:04 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Wed, Apr 25, 2018 at 07:53:06PM +0200, Geert Uytterhoeven wrote:
>> >> On Wed, Apr 25, 2018 at 6:06 PM, Greg Kroah-Hartman
>> >> <gregkh@linuxfoundation.org> wrote:
>> >> > On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
>> >> >> The driver_override implementation is susceptible to a race condition
>> >> >> when different threads are reading vs storing a different driver
>> >> >> override.  Add locking to avoid this race condition.
>> >> >>
>> >> >> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
>> >> >> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
>> >> >> condition with driver_override").
>> >> >>
>> >> >> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
>> >> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> >> Reviewed-by: Todd Kjos <tkjos@google.com>
>> >> >> Cc: stable <stable@vger.kernel.org>
>> >>
>> >> > As this should go to stable kernels, I've fixed it up to apply without
>> >> > patch 1 as that's not a real "fix" that anyone needs...
>> >> >
>> >> > Please try to remember to put fixes first, and then "trivial" things
>> >> > later on in a series.
>> >>
>> >> I did it on purpose, as the fix is much more ugly without patch 1 applied.
>> >> Can't you just take patch 1, too? More consistency is always nice, even for
>> >> stable ;-)
>> >
>> > Consistency is nice, but when you have bug fixes that rely on "trivial"
>> > patches, it's usually not nice :(
>> >
>> > I already committed patch 2 to my tree without 1, so let's leave it
>> > as-is for now.
>>
>> Unfortunately the version you committed is buggy: the race condition
>> also covers the NULL check removed by the trivial patch you skipped,
>> so now you can get inconsistent behavior (no output or "(null)") on the
>> same running kernel version...
>>
>> Please revert and apply both. Thanks!
>
> Ugh, you are right, sorry about that.
>
> I've reverted the offending patch, and added them in the correct order
> now, I should have listened to you :)

Np, issue detected and fixed.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
