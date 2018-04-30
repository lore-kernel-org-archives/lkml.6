Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754998AbeD3Qw5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:52:57 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45496 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754863AbeD3Qwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:52:55 -0400
X-Google-Smtp-Source: AB8JxZrgLHCct2inCh3pCRpgmlShh4IgVtkwwhAmiTAM+GZ5O1fM3DTTtn08x6PF1ePCWlF98y95rSRMi6netPvxeCY=
MIME-Version: 1.0
References: <20180427041100.133772-1-joelaf@google.com> <20180430123813.3b8315d8@gandalf.local.home>
In-Reply-To: <20180430123813.3b8315d8@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 30 Apr 2018 16:52:44 +0000
Message-ID: <CAJWu+ooY-BXFQO+TK526pZpE6gsGRZdHq6i7yM7LSmgXi4552g@mail.gmail.com>
Subject: Re: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep splat
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 9:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Apr 2018 21:11:00 -0700
> Joel Fernandes <joelaf@google.com> wrote:

> > I'm able to reproduce a lockdep splat when CONFIG_PROVE_LOCKING=y and
> > CONFIG_PREEMPTIRQ_EVENTS=y.
> >
> > $ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
> > ---
> > [   26.112609] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
> > [   26.112636] WARNING: CPU: 0 PID: 118 at kernel/locking/lockdep.c:3854
> > [...]
> > [   26.144229] Call Trace:
> > [   26.144926]  <IRQ>
> > [   26.145506]  lock_acquire+0x55/0x1b0
> > [   26.146499]  ? __do_softirq+0x46f/0x4d9
> > [   26.147571]  ? __do_softirq+0x46f/0x4d9
> > [   26.148646]  trace_preempt_on+0x8f/0x240
> > [   26.149744]  ? trace_preempt_on+0x4d/0x240
> > [   26.150862]  ? __do_softirq+0x46f/0x4d9
> > [   26.151930]  preempt_count_sub+0x18a/0x1a0
> > [   26.152985]  __do_softirq+0x46f/0x4d9
> > [   26.153937]  irq_exit+0x68/0xe0
> > [   26.154755]  smp_apic_timer_interrupt+0x271/0x280
> > [   26.156056]  apic_timer_interrupt+0xf/0x20
> > [   26.157105]  </IRQ>

> I'm not able to trigger this. Is there more to it?

No that should be it. I have a 100% repro on v4.16. I will try on a newer
kernel and let you know.

thanks,

- Joel
