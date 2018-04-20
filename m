Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbeDTFpD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 01:45:03 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41518 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbeDTFpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 01:45:01 -0400
X-Google-Smtp-Source: AIpwx49cnSEz76+Dgnp6OREKtLdCkowqwXLBkl31fXrUWO3PV6z3Ewm3Im97dgt54cAegAb0c0deLg==
Date: Fri, 20 Apr 2018 14:44:57 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
Message-ID: <20180420054457.GA26393@jagdpanzerIV>
References: <20180301163331.987775783@linutronix.de>
 <CA+55aFzV8Q20vL83xa+1UKzeQ0w-SAksCDxJD4szALRDCSUZ2w@mail.gmail.com>
 <20180313063630.zxebyb7gczeiovyf@gmail.com>
 <CALAqxLXJw-QOztJvt1sBSyxDg4NFz5KXmPv3PjF4VEChz20BGA@mail.gmail.com>
 <CANq1E4Tf27FJHTrO4ZVtWhYK=DLmwzszK=njOpgXZZXqzAOunA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANq1E4Tf27FJHTrO4ZVtWhYK=DLmwzszK=njOpgXZZXqzAOunA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/20/18 06:37), David Herrmann wrote:
>
> I get lots of timer-errors on Arch-Linux booting current master, after
> a suspend/resume cycle. Just a selection of errors I see on resume:

Hello David,
Any chance you can revert the patches in question and test? I'm running
ARCH (4.17.0-rc1-dbg-00042-gaa03ddd9c434) and suspend/resume cycle does
not trigger any errors. Except for this one

	kernel: do_IRQ: 0.55 No irq handler for vector

> systemd[1]: systemd-journald.service: Main process exited,
> code=dumped, status=6/ABRT
> rtkit-daemon[742]: The canary thread is apparently starving. Taking action.
> systemd[1]: systemd-udevd.service: Watchdog timeout (limit 3min)!
> systemd[1]: systemd-journald.service: Watchdog timeout (limit 3min)!
> kernel: e1000e 0000:00:1f.6: Failed to restore TIMINCA clock rate delta: -22
> 
> Lots of crashes with SIGABRT due to these.
> 
> I did not bisect it, but it sounds related to me. Also, user-space
> uses CLOCK_MONOTONIC for watchdog timers. That is, a process is
> required to respond to a watchdog-request in a given MONOTONIC
> time-frame. If this jumps during suspend/resume, watchdogs will fire
> immediately. I don't see how this can work with the new MONOTONIC
> behavior?

	-ss
