Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16FCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B5D20936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B5D20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbeGKAvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbeGKAvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:51:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E32B208EC;
        Wed, 11 Jul 2018 00:49:59 +0000 (UTC)
Date:   Tue, 10 Jul 2018 20:49:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 7/7] kselftests: Add tests for the preemptoff and
 irqsoff tracers
Message-ID: <20180710204958.22910589@gandalf.local.home>
In-Reply-To: <20180628182149.226164-8-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-8-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 11:21:49 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Here we add unit tests for the preemptoff and irqsoff tracer by using a
> kernel module introduced previously to trigger atomic sections in the
> kernel.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

This looks fine. The only patch that needs to be changed and resent is
patch 6 and 7. Just send 6, and this one again because it depends on
patch 6.

I'll go ahead and apply 1-5 and kick off my other tests.

Thanks!

-- Steve


> ---
>  tools/testing/selftests/ftrace/config         |  3 +
>  .../test.d/preemptirq/irqsoff_tracer.tc       | 73 +++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> 
> diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
> index b01924c71c09..29588b328345 100644
> --- a/tools/testing/selftests/ftrace/config
> +++ b/tools/testing/selftests/ftrace/config
> @@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
>  CONFIG_TRACER_SNAPSHOT=y
>  CONFIG_STACK_TRACER=y
>  CONFIG_HIST_TRIGGERS=y
> +CONFIG_PREEMPT_TRACER=y
> +CONFIG_IRQSOFF_TRACER=y
> +CONFIG_TEST_ATOMIC_SECTIONS=m
> diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> new file mode 100644
> index 000000000000..1806d340035d
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: test for the preemptirqsoff tracer
> +
> +MOD=test_atomic_sections
> +
> +fail() {
> +    reset_tracer
> +    rmmod $MOD || true
> +    exit_fail
> +}
> +
> +unsup() { #msg
> +    reset_tracer
> +    rmmod $MOD || true
> +    echo $1
> +    exit_unsupported
> +}
> +
> +modprobe $MOD || unsup "$MOD module not available"
> +rmmod $MOD
> +
> +grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
> +grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
> +
> +reset_tracer
> +
> +# Simulate preemptoff section for half a second couple of times
> +echo preemptoff > current_tracer
> +sleep 1
> +modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
> +rmmod $MOD || fail
> +
> +cat trace
> +
> +# Confirm which tracer
> +grep -q "tracer: preemptoff" trace || fail
> +
> +# Check the end of the section
> +egrep -q "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep -q "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +
> +# Simulate irqsoff section for half a second couple of times
> +echo irqsoff > current_tracer
> +sleep 1
> +modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
> +rmmod $MOD || fail
> +
> +cat trace
> +
> +# Confirm which tracer
> +grep -q "tracer: irqsoff" trace || fail
> +
> +# Check the end of the section
> +egrep -q "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep -q "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +exit 0

