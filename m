Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756436AbeDXKvh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:51:37 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34146 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756190AbeDXKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:51:34 -0400
X-Google-Smtp-Source: AIpwx4+EuHM/zWxywW6NYBrgwCBmMaAPzstuQKzPcJcVEvb4Fw8iFrRX9HMs8U7fjLfB9D631l0ZvPZwmZge1SZwGnk=
MIME-Version: 1.0
In-Reply-To: <20180424103737.GA19011@piout.net>
References: <5add30d1.1c69fb81.b868a.84f1SMTPIN_ADDED_MISSING@mx.google.com>
 <CAMuHMdULPOWQPo1G1s5m52rNLzhmPFzfwxsZH0iR_OwVc8VRKw@mail.gmail.com> <20180424103737.GA19011@piout.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Apr 2018 12:51:32 +0200
X-Google-Sender-Auth: DUvW8icZ0HnDbtaxjtk8nSUVvDE
Message-ID: <CAMuHMdVh8Pg9r9OoDzh9fWmkcuS1NDQUBOLzRQkiKXD+V+XbPA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Finn Thain <fthain@telegraphics.com.au>, Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Apr 24, 2018 at 12:37 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 24/04/2018 12:06:30+0200, Geert Uytterhoeven wrote:
>> On Mon, Apr 23, 2018 at 3:02 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> > This fixes a bug in read_persistent_clock() which causes the system
>> > clock to lag the Real Time Clock by one month. The problem was noticed
>> > on a Mac, but theoretically it must also affect Atari, BVME6000 and Q40.
>> >
>> > The tm_mon value in the struct rtc_time passed to mach_hwclk() is
>> > zero-based, and atari_mste_hwclk(), atari_tt_hwclk(), bvme6000_hwclk(),
>> > mac_hwclk() and q40_hwclk() all make this adjustment. Unfortunately,
>> > dn_dummy_hwclk(), mvme147_hwclk(), mvme16x_hwclk(), sun3_hwclk() and
>> > sun3x_hwclk() fail to decrement tm_mon.
>> >
>> > Bring these platforms into line and fix read_persistent_clock() so it
>> > works correctly on all m68k platforms.
>> >
>> > The datasheets for the RTC devices found on the affected platforms
>> > all confirm that the year is stored as a value in the range 0-99 and
>> > the month is stored as a value in the range 1-12. Please refer to the
>> > datasheets for MC146818 (Apollo), DS1643 (MVME), ICM7170 (Sun 3)
>> > and M48T02 (Sun 3x).
>> >
>> > Reported-by: Stan Johnson <userm57@yahoo.com>
>> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>>
>> Thanks, applied and queued for v4.18.
>>
>> <snip>
>>
>> > --- a/arch/m68k/kernel/time.c
>> > +++ b/arch/m68k/kernel/time.c
>> > @@ -74,17 +74,17 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
>> >  void read_persistent_clock(struct timespec *ts)
>> >  {
>> >         struct rtc_time time;
>> > +
>> >         ts->tv_sec = 0;
>> >         ts->tv_nsec = 0;
>> >
>> > -       if (mach_hwclk) {
>> > -               mach_hwclk(0, &time);
>> > +       if (!mach_hwclk)
>> > +               return;
>> > +
>> > +       mach_hwclk(0, &time);
>> >
>> > -               if ((time.tm_year += 1900) < 1970)
>> > -                       time.tm_year += 100;
>
> Note that this change may break existing users. I'm perfectly fine with
> it as doing this is generally wrong anyway and this is something I'd
> like to see eliminated.

The year handling is moved into the various mach_hwclk() implementations
in the same patch (in the "<snip>" part).

>
>> > -               ts->tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
>> > -                                     time.tm_hour, time.tm_min, time.tm_sec);
>> > -       }
>> > +       ts->tv_sec = mktime(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
>> > +                           time.tm_hour, time.tm_min, time.tm_sec);
>>
>> That might explain why my Amiga spends so much time on file system checks
>> since I wrote the rp5c01 RTC driver...

Upon closer look, it's not, as Amiga no longer provides mach_hwclk().
So it must be due to fsck running before the rtc module is loaded?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
