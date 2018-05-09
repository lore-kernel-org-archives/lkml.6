Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525872737; cv=none;
        d=google.com; s=arc-20160816;
        b=Pd/R9p+bovc96rvF/iVP/GiEq2X92hCLK7wWWyUjxcQ1/n9Ceq1WEbDcCD84mkJ1kB
         A4q7PBqoP83u05IEXX+nUETIk966CCYOHwuktPvgLg/2YLmNwyKG7syGXRN9xZTc4CYg
         oIBDKEjc3ZDJasymi6UhzW6duZFb56fbstqaw7xLNR+kxWl8nnPi+Jhu4hEzK+UAqTl9
         4RitWyVlZOTQwKpqx3k9taDw+lNxrIINwQPwV3gWSXfMGJMC0M44Z7JmoYsawx3TTRhc
         /cKvUoKqQrv+iGedQe9CmpI4RbRvTnAk/OHfaxVA/Xm16DlOxH/26ojqv50nChNXAgay
         vOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7VdZER34IXtGuqui7oay0lGbU1lQEzTIOQn+Pibe78w=;
        b=Gy9546GF3UTpQzHwK3MsQGBuPY8vRVA6Et+x/EE9tpVJnogVuTSNIq+lRjjDYd3G9O
         r1BK1J6OHKZwBp4u/NPbOkFJEJ+US5iNUn3JCLMQ0zB+ZVTkwQUJESGYLzAQ2f+dQvGd
         4rVqwVdOf3Q7hFwNvAKeN1aL4JsUOkuaiP50mae/wq8x+tPb2VGkynj4q29XQTOoCAZ7
         bxSVO1KictPEnZT6xzLc6J3xpjbNn2R3AAzrnewglqdVWObqD3i6aseb8tGPbLLcUm1o
         DZnE7mrzILLGjsEdClGe/biSlN9u2NgHZXeit3b5oe5WdsTrQ/IOake36SWNxmXXL8M7
         qEFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VlEhAwIy;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VlEhAwIy;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZo5wSX48C+8Ap/mkLoz5cmrzjjs7YCflC1PLyedn0+7cx7oCJ6lvvyOKSKzP2ZhZGPb2zxaS468gGMk/wdq+WM=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180509103954.GR16141@n2100.armlinux.org.uk>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
 <20180425160645.GA16732@kroah.com> <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
 <20180426070410.GM14025@kroah.com> <CAMuHMdWLCQoHzuW1UZNP9gdRV3EE6_yPcdyX1NDy65q7Nt4tZw@mail.gmail.com>
 <20180426083542.GA31073@kroah.com> <CAMuHMdWO+C3g4T_rPbcyPFgVpqubjj4HZ++O+P7d0VYYFP0xWA@mail.gmail.com>
 <20180509103954.GR16141@n2100.armlinux.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 May 2018 15:32:16 +0200
X-Google-Sender-Auth: pJLVjN7l8-N7t8cAt5bKVjBA_8Y
Message-ID: <CAMuHMdVD59kA1BRrce+jHEMr7Sq7AqEzQEXJWL7SPDUY32Fgmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>, Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365566189003865?=
X-GMAIL-MSGID: =?utf-8?q?1599993531400634345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Russell,

On Wed, May 9, 2018 at 12:39 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Apr 26, 2018 at 10:45:49AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 26, 2018 at 10:35 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Thu, Apr 26, 2018 at 09:40:08AM +0200, Geert Uytterhoeven wrote:
>> >> On Thu, Apr 26, 2018 at 9:04 AM, Greg Kroah-Hartman
>> >> <gregkh@linuxfoundation.org> wrote:
>> >> > On Wed, Apr 25, 2018 at 07:53:06PM +0200, Geert Uytterhoeven wrote:
>> >> >> On Wed, Apr 25, 2018 at 6:06 PM, Greg Kroah-Hartman
>> >> >> <gregkh@linuxfoundation.org> wrote:
>> >> >> > On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
>> >> >> >> The driver_override implementation is susceptible to a race condition
>> >> >> >> when different threads are reading vs storing a different driver
>> >> >> >> override.  Add locking to avoid this race condition.
>> >> >> >>
>> >> >> >> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
>> >> >> >> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
>> >> >> >> condition with driver_override").
>> >> >> >>
>> >> >> >> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
>> >> >> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> >> >> Reviewed-by: Todd Kjos <tkjos@google.com>
>> >> >> >> Cc: stable <stable@vger.kernel.org>
>> >> >>
>> >> >> > As this should go to stable kernels, I've fixed it up to apply without
>> >> >> > patch 1 as that's not a real "fix" that anyone needs...
>> >> >> >
>> >> >> > Please try to remember to put fixes first, and then "trivial" things
>> >> >> > later on in a series.
>> >> >>
>> >> >> I did it on purpose, as the fix is much more ugly without patch 1 applied.
>> >> >> Can't you just take patch 1, too? More consistency is always nice, even for
>> >> >> stable ;-)
>> >> >
>> >> > Consistency is nice, but when you have bug fixes that rely on "trivial"
>> >> > patches, it's usually not nice :(
>> >> >
>> >> > I already committed patch 2 to my tree without 1, so let's leave it
>> >> > as-is for now.
>> >>
>> >> Unfortunately the version you committed is buggy: the race condition
>> >> also covers the NULL check removed by the trivial patch you skipped,
>> >> so now you can get inconsistent behavior (no output or "(null)") on the
>> >> same running kernel version...
>> >>
>> >> Please revert and apply both. Thanks!
>> >
>> > Ugh, you are right, sorry about that.
>> >
>> > I've reverted the offending patch, and added them in the correct order
>> > now, I should have listened to you :)
>>
>> Np, issue detected and fixed.
>> Thanks!
>
> So what about the patches you submitted to the patch system - should
> I pick those up or not?

I think only the 4th patch (#8759) in the series is still applicable.

> Please don't ask other maintainers to take patches that have been
> submitted to the patch system without first changing their status,
> they're liable to get applied anyway.

They got picked up by Greg, on request of a third party who wanted them in
-stable ASAP. Not much I can do to prevent that.
Especially with an "Odd Fixes" maintainership status.

I tried to change the status of the patches Greg applied, but it failed:

    Your request to update the patch failed because:
    An internal state error was detected.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
