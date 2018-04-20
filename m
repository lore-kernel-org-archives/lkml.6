Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeDTEhP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 00:37:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41494 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeDTEhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 00:37:14 -0400
X-Google-Smtp-Source: AIpwx4/PDZ2ezfJTUzImgM/wVnP7iB48R0z2LFKVtumFZHg/ET6frMJXxhzaA3gB8m3IkmI+pqc4oGztE80ZK5ARS7g=
MIME-Version: 1.0
In-Reply-To: <CALAqxLXJw-QOztJvt1sBSyxDg4NFz5KXmPv3PjF4VEChz20BGA@mail.gmail.com>
References: <20180301163331.987775783@linutronix.de> <CA+55aFzV8Q20vL83xa+1UKzeQ0w-SAksCDxJD4szALRDCSUZ2w@mail.gmail.com>
 <20180313063630.zxebyb7gczeiovyf@gmail.com> <CALAqxLXJw-QOztJvt1sBSyxDg4NFz5KXmPv3PjF4VEChz20BGA@mail.gmail.com>
From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 20 Apr 2018 06:37:12 +0200
Message-ID: <CANq1E4Tf27FJHTrO4ZVtWhYK=DLmwzszK=njOpgXZZXqzAOunA@mail.gmail.com>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
To: John Stultz <john.stultz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Tue, Mar 13, 2018 at 7:11 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Mar 12, 2018 at 11:36 PM, Ingo Molnar <mingo@kernel.org> wrote:
>> Ok, I have edited all the changelogs accordingly (and also flipped around the
>> 'clock MONOTONIC' language to the more readable 'the MONOTONIC clock' variant),
>> the resulting titles are (in order):
>>
>>  72199320d49d: timekeeping: Add the new CLOCK_MONOTONIC_ACTIVE clock
>>  d6ed449afdb3: timekeeping: Make the MONOTONIC clock behave like the BOOTTIME clock
>>  f2d6fdbfd238: Input: Evdev - unify MONOTONIC and BOOTTIME clock behavior
>>  d6c7270e913d: timekeeping: Remove boot time specific code
>>  7250a4047aa6: posix-timers: Unify MONOTONIC and BOOTTIME clock behavior
>>  127bfa5f4342: hrtimer: Unify MONOTONIC and BOOTTIME clock behavior
>>  92af4dcb4e1c: tracing: Unify the "boot" and "mono" tracing clocks
>>
>> I'll push these out after testing.
>
> I'm still anxious about userspace effects given how much I've seen the
> current behavior documented, and wouldn't pushed for this myself (I'm
> a worrier), but at least I'm not seeing any failures in initial
> testing w/ kselftest so far.

I get lots of timer-errors on Arch-Linux booting current master, after
a suspend/resume cycle. Just a selection of errors I see on resume:

systemd[1]: systemd-journald.service: Main process exited,
code=dumped, status=6/ABRT
rtkit-daemon[742]: The canary thread is apparently starving. Taking action.
systemd[1]: systemd-udevd.service: Watchdog timeout (limit 3min)!
systemd[1]: systemd-journald.service: Watchdog timeout (limit 3min)!
kernel: e1000e 0000:00:1f.6: Failed to restore TIMINCA clock rate delta: -22

Lots of crashes with SIGABRT due to these.

I did not bisect it, but it sounds related to me. Also, user-space
uses CLOCK_MONOTONIC for watchdog timers. That is, a process is
required to respond to a watchdog-request in a given MONOTONIC
time-frame. If this jumps during suspend/resume, watchdogs will fire
immediately. I don't see how this can work with the new MONOTONIC
behavior?

Thanks
David
