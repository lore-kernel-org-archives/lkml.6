Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030942AbeBNPFf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:05:35 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:43349 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030382AbeBNPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:05:34 -0500
X-Google-Smtp-Source: AH8x224TRn5psa6LP4+0R7+gtSjziOqU66v8dIUKfLUQ45wAs1GJ5dVL3D1KmlaCD3ztsjsQM52mUmsA5f8AsZ7HxXo=
MIME-Version: 1.0
In-Reply-To: <s5htvvw7aqc.wl-tiwai@suse.de>
References: <001a113f711a23fe310561f21d1a@google.com> <CACT4Y+Z1oSMf8t4fWZ8_Na+TU=S59z-PTYeK71qO=Awy+nAmqw@mail.gmail.com>
 <s5hmv1tbx2v.wl-tiwai@suse.de> <CACT4Y+Zqm=kYx5weFtDROs1u8vNqW8oy-Dt05tsq1xZ=KLUFUw@mail.gmail.com>
 <s5hh8s1bte4.wl-tiwai@suse.de> <s5hwp0xa75m.wl-tiwai@suse.de>
 <CACT4Y+a3jcLadSNqMDCZLOJMzcDDw6bYeUWftr+-HTwEc=xhxw@mail.gmail.com> <s5htvvw7aqc.wl-tiwai@suse.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 16:05:11 +0100
Message-ID: <CACT4Y+bQAFTvH78jYvy_jwwcH=af_XResaVW-9fps7QgLDTk_g@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in memcpy
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        syzbot <syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 8, 2018 at 2:15 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sun, 07 Jan 2018 12:30:53 +0100,
> Dmitry Vyukov wrote:
>>
>> On Thu, Jan 4, 2018 at 6:03 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Thu, 04 Jan 2018 15:17:23 +0100,
>> > Takashi Iwai wrote:
>> >>
>> >> On Thu, 04 Jan 2018 15:01:06 +0100,
>> >> Dmitry Vyukov wrote:
>> >> >
>> >> > On Thu, Jan 4, 2018 at 1:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > > On Thu, 04 Jan 2018 13:08:45 +0100,
>> >> > > Dmitry Vyukov wrote:
>> >> > >>
>> >> > >> On Thu, Jan 4, 2018 at 1:03 PM, syzbot
>> >> > >> <syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com> wrote:
>> >> > >> > Hello,
>> >> > >> >
>> >> > >> > syzkaller hit the following crash on
>> >> > >> > 30a7acd573899fd8b8ac39236eff6468b195ac7d
>> >> > >> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> >> > >> > compiler: gcc (GCC) 7.1.1 20170620
>> >> > >> > .config is attached
>> >> > >> > Raw console output is attached.
>> >> > >> > Unfortunately, I don't have any reproducer for this bug yet.
>> >> > >> >
>> >> > >> >
>> >> > >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> > >> > Reported-by: syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com
>> >> > >> > It will help syzbot understand when the bug is fixed. See footer for
>> >> > >> > details.
>> >> > >> > If you forward the report, please keep this part and the footer.
>> >> > >>
>> >> > >> This looks ALSA-related. +ALSA maintainers.
>> >> > >
>> >> > > Not sure exactly what triggers it.  It's the simple memcpy(), and I
>> >> > > don't know where RCU is involved in that code path.
>> >> > >
>> >> > > BTW, other two suspicious RCU usage reports are actually stopped at
>> >> > > the second WARN_ON() after the RCU message, and the second WARN_ON()
>> >> > > is independent from RCU; it's the known spurious WARN_ON() and was
>> >> > > already removed in the sound git tree.
>> >> >
>> >> >
>> >> > Hi Takashi,
>> >> >
>> >> > Another similar one just popped up:
>> >> >
>> >> > https://groups.google.com/forum/#!topic/syzkaller-bugs/X3d6-PIrJM0
>> >> >
>> >> > This looks like mulaw_decode enters an infinite loop, or at least
>> >> > doing very large amount of computations without a resched, e.g.
>> >> > (uint64_t)-1 number of iterations of something along these lines.
>> >>
>> >> OK, that makes sense.
>> >>
>> >> My rough guess is that it's the misconfigured aloop device by
>> >> concurrent setup.  The aloop device allows to restrict the parameters
>> >> of the other side of the connection, and something bad may happen
>> >> there if both sides are updated concurrently.
>> >>
>> >> We've seen segfault by memset() at loopback_preapre() in
>> >> sound/drivers/aloop.c by syzbot+3902b5220e8ca27889ca, too, which
>> >> indicates also the wrongly setup parameters that overflows the
>> >> allocated buffer.
>> >
>> > Below two patches may possibly plug the holes, but I'm not entirely
>> > sure whether that's the exact culprit.  Could you put them into syzbot
>> > to watch whether they have any influence?
>>
>> Hi Takashi,
>>
>> I've gave an answer to this here:
>> https://groups.google.com/d/msg/syzkaller-bugs/7ucgCkAJKSk/skZjgavRAQAJ
>
> OK, noted.
>
>> > In anyway, they are obvious bugs to be fixed, so I'm going to queue to
>> > my tree.
>>
>> The options are:
>> 1. You can ask syzbot to test the patch separately. This requires a
>> reproducer, but there is this bug which has a reproducer and seems to
>> have the same root cause:
>> https://groups.google.com/d/msg/syzkaller-bugs/KrPUlf-nm5g/Vk0xEq-HAAAJ
>
> Ah, I didn't know that each bot can test patches individually.
>
>> 2. You can reproduce it with the reproducer from here:
>> https://groups.google.com/d/msg/syzkaller-bugs/KrPUlf-nm5g/Vk0xEq-HAAAJ
>> and then test the patch as extensively as needed.
>
> Yes, I could test and find the culprit with the given reproducer.
>
>> 3. If you have some confidence that the patch fixes the problem, then
>> mark the commit with the tag:
>> Reported-by: syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com
>> then syzbot will notify if this still happens after the commit reaches
>> tested trees.
>
> Some have been already tagged with reported-by.  Some are mostly
> irrelevant but casually found during the debug session for the bugs
> syzkaller spotted.


I think this is fixed with:

#syz fix: ALSA: pcm: Abort properly at pending signal in OSS read/write loops
