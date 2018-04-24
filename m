Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbeDXMyW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:54:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46781 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932866AbeDXMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:54:17 -0400
X-Google-Smtp-Source: AB8JxZpJRplundQGk+iGiVK/dDBAy3OqQLRet1V88gHaJX2TvfxqIknJWdqz8kZorM9g3q3sTMhWqBE7tEB8rQ6/bVM=
MIME-Version: 1.0
In-Reply-To: <20180424103737.GA19011@piout.net>
References: <5add30d1.1c69fb81.b868a.84f1SMTPIN_ADDED_MISSING@mx.google.com>
 <CAMuHMdULPOWQPo1G1s5m52rNLzhmPFzfwxsZH0iR_OwVc8VRKw@mail.gmail.com> <20180424103737.GA19011@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Apr 2018 14:54:15 +0200
X-Google-Sender-Auth: ODDbitCf9Ywgyr8r475azYDrDv0
Message-ID: <CAK8P3a2LxZND3bg5dCaS4OgQv+fxZ3q6Fd8kUwkC1vhwhr-C-g@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>, Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:37 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 24/04/2018 12:06:30+0200, Geert Uytterhoeven wrote:
>>
>> On Mon, Apr 23, 2018 at 3:02 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
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
> Note that this change may break existing users.

I had the same thought but then realized that the +=100 logic was simply
moved into the individual drivers, so the behavior should not change here.

> I'm perfectly fine with
> it as doing this is generally wrong anyway and this is something I'd
> like to see eliminated.

I think most of the m68k RTC hardware uses two-digit BCD year numbers,
so we can't just remove it without implementing something else to
lift the RTC into the current century.

       Arnd
