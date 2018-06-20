Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F0FC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B4A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B4A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932808AbeFTUFS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932600AbeFTUFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:17 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D652083A;
        Wed, 20 Jun 2018 20:05:15 +0000 (UTC)
Date:   Wed, 20 Jun 2018 16:05:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zilstra <peterz@infradead.org>
Cc:     Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep
 splat
Message-ID: <20180620160513.0453247e@gandalf.local.home>
In-Reply-To: <20180427041100.133772-1-joelaf@google.com>
References: <20180427041100.133772-1-joelaf@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter, can you ack this.

On Thu, 26 Apr 2018 21:11:00 -0700
Joel Fernandes <joelaf@google.com> wrote:

> I'm able to reproduce a lockdep splat when CONFIG_PROVE_LOCKING=y and
> CONFIG_PREEMPTIRQ_EVENTS=y.
> 
> $ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
> ---

BTW, the "---" here causes git to ignore everything underneath it :-/

> [   26.112609] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
> [   26.112636] WARNING: CPU: 0 PID: 118 at kernel/locking/lockdep.c:3854
> [...]
> [   26.144229] Call Trace:
> [   26.144926]  <IRQ>
> [   26.145506]  lock_acquire+0x55/0x1b0
> [   26.146499]  ? __do_softirq+0x46f/0x4d9
> [   26.147571]  ? __do_softirq+0x46f/0x4d9
> [   26.148646]  trace_preempt_on+0x8f/0x240
> [   26.149744]  ? trace_preempt_on+0x4d/0x240
> [   26.150862]  ? __do_softirq+0x46f/0x4d9
> [   26.151930]  preempt_count_sub+0x18a/0x1a0
> [   26.152985]  __do_softirq+0x46f/0x4d9
> [   26.153937]  irq_exit+0x68/0xe0
> [   26.154755]  smp_apic_timer_interrupt+0x271/0x280
> [   26.156056]  apic_timer_interrupt+0xf/0x20
> [   26.157105]  </IRQ>
> 
> The problem is the softirqs annotation in lockdep goes out of sync with
> the reality of the world that softirq is still off. This causes a
> lockdep splat because the preempt_count_sub can call into a preemptoff
> tracer or the trace events code, which inturn can call into lockdep
> *before* softirqs are really turned back on, which can cause a softirqs
> invalid annotation splat in lockdep.
> 
> The same issue was fixed in local_bh_disable_ip which has a comment so:
> /*
>  * The preempt tracer hooks into preempt_count_add and will break
>  * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
>  * is set and before current->softirq_enabled is cleared.
>  * We must manually increment preempt_count here and manually
>  * call the trace_preempt_off later.
>  */
> 
> I have done a similar change to the local_bh_enable path to fix it.

I now have a config that triggers this with this test:

 tools/testing/selftests/ftrace/ftracetest test.d/event/toplevel-enable.tc

and I see it never was Acked-by by Peter.

Peter, can you ack this and I can apply it. It does fix a lockdep
corruption issue.

Thanks!

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Fenguang Wu <fengguang.wu@intel.com>
> Cc: Baohong Liu <baohong.liu@intel.com>
> Cc: Vedang Patel <vedang.patel@intel.com>
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/softirq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 177de3640c78..8a040bcaa033 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> +	if (preempt_count() == cnt)
> +		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> +
>  	if (softirq_count() == (cnt & SOFTIRQ_MASK))
>  		trace_softirqs_on(_RET_IP_);
> -	preempt_count_sub(cnt);
> +
> +	__preempt_count_sub(cnt);
>  }
>  
>  /*

