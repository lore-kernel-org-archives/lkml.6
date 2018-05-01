Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755513AbeEAPBK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:01:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36831 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeEAPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:01:08 -0400
X-Google-Smtp-Source: AB8JxZpOovyP4nVgN1p32bRTL97/mu4PUBd1XyvMNpxCVAnuavN732nIGllMd5nPj6rRty9hswDKEWEDh1yYWloHO8E=
MIME-Version: 1.0
References: <20180501014204.67548-1-joelaf@google.com> <20180501014204.67548-2-joelaf@google.com>
 <20180501100210.32181f48@gandalf.local.home>
In-Reply-To: <20180501100210.32181f48@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 15:00:52 +0000
Message-ID: <CAJWu+op6MhP_i+6b6aqTtbEKmFvb3nX8qZMN0pkE_9EpJBJVSw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 1/6] softirq: reorder trace_softirqs_on to prevent
 lockdep splat
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

On Tue, May 1, 2018 at 7:02 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Apr 2018 18:41:59 -0700
> Joel Fernandes <joelaf@google.com> wrote:

> > I'm able to reproduce a lockdep splat when CONFIG_PROVE_LOCKING=y and
> > CONFIG_PREEMPTIRQ_EVENTS=y.

> Needs more info in the change log. It also requires that
> CONFIG_DEBUG_LOCKED=y is set.

> Add this to the change log:

> The issue was this:

> Start with: preempt_count = 1 << SOFTIRQ_SHIFT

>          __local_bh_enable(cnt = 1 << SOFTIRQ_SHIFT) {
>                  if (softirq_count() == (cnt && SOFTIRQ_MASK)) {
>                          trace_softirqs_on() {
>                                  current->softirqs_enabled = 1;
>                          }
>                  }
>                  preempt_count_sub(cnt) {
>                          trace_preempt_on() {
>                                  tracepoint() {
>                                          rcu_read_lock_sched() {
>                                                  // jumps into lockdep

> Where preempt_count still has softirqs disabled, but
> current->softirqs_enabled is true, and we get a splat.

> This patch should be separate (as you had it before), and needs to be
> submitted now because it already causes issues. We can add:

> Cc: stable@vger.kernel.org
> Fixes: d59158162e032 ("tracing: Add support for preempt and irq
enable/disable events")

Ok, I'll split and resubmit with your reasoning in the changelog.

Just to clarify, my changelog was based on older patches, that's why the
reason appears different but the root cause is the same. In an earlier
series, I was doing lockdep_{off,on} around the rcu_read_lock_sched call so
that stage wasn't splatting, but then after the read_lock is held, the
tracepoint probe such as those registered by preemptoff tracer  was
acquiring locks and causing the same splat.

Anyway, this just for some justification of why changelog appears to
present a different scenario with the same fix. But I'll change it to yours
and resubmit with the tags, thanks a lot for looking into it,

thanks,

- Joel
