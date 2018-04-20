Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeDTGtM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:49:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52647 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeDTGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:49:11 -0400
X-Google-Smtp-Source: AIpwx49IiVJ9oDtXmUpLxlJZbtkulLDpRhO1PZkg2KaXSzuVsT3vmuVZvo0+uu/BHMQ6UgNpVC6gBKsXnsSPNUiGlBs=
MIME-Version: 1.0
In-Reply-To: <20180420054457.GA26393@jagdpanzerIV>
References: <20180301163331.987775783@linutronix.de> <CA+55aFzV8Q20vL83xa+1UKzeQ0w-SAksCDxJD4szALRDCSUZ2w@mail.gmail.com>
 <20180313063630.zxebyb7gczeiovyf@gmail.com> <CALAqxLXJw-QOztJvt1sBSyxDg4NFz5KXmPv3PjF4VEChz20BGA@mail.gmail.com>
 <CANq1E4Tf27FJHTrO4ZVtWhYK=DLmwzszK=njOpgXZZXqzAOunA@mail.gmail.com> <20180420054457.GA26393@jagdpanzerIV>
From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 20 Apr 2018 08:49:10 +0200
Message-ID: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Apr 20, 2018 at 7:44 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (04/20/18 06:37), David Herrmann wrote:
>>
>> I get lots of timer-errors on Arch-Linux booting current master, after
>> a suspend/resume cycle. Just a selection of errors I see on resume:
>
> Hello David,
> Any chance you can revert the patches in question and test? I'm running
> ARCH (4.17.0-rc1-dbg-00042-gaa03ddd9c434) and suspend/resume cycle does
> not trigger any errors. Except for this one
>
>         kernel: do_IRQ: 0.55 No irq handler for vector

I can easily reproduce it by sleeping for >5min, so the systemd
watchdog timers are triggered. The patches don't revert cleanly, so I
didn't look into booting without them, yet. I will try just linking
the monotonic clock to the monotonic_active clock later.

Also, doesn't this hunk in 72199320d49d need a 'break;':

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index b258bee13b02..6259dbc0191a 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -73,6 +73,8 @@ int do_clock_gettime(clockid_t which_clock, struct
timespec64 *tp)
        case CLOCK_BOOTTIME:
                get_monotonic_boottime64(tp);
                break;
+       case CLOCK_MONOTONIC_ACTIVE:
+               ktime_get_active_ts64(tp);
        default:
                return -EINVAL;
        }
