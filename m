Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95862C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CF5219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKkTUvzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CF5219CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeHFEOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbeHFEOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:14:20 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16646219C9;
        Mon,  6 Aug 2018 02:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533521254;
        bh=TiMByG+RGH9jlUXoiz1XVA9FnO/yKAfGsMpS9EhxoWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZKkTUvzGFHIQsobDxhKtZyTN9kPyGnTMlG7V9DK1dQsQa/2z0OSg1fD+CqM6FDum6
         eQrmdius79MO1m1vEuxlpp0ohdGaXv6Rtl85L35vsAiArCShg26Ek/qaibQa/KaLoW
         Vel57v+1JQu+SXaGlxyLfkJzVc9qYjyBIjchDNZA=
Date:   Mon, 6 Aug 2018 11:07:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 0/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-Id: <20180806110729.fc79c61d5208cf642e223e90@kernel.org>
In-Reply-To: <CAJWu+oq3HD3VhYzvRJA-8HQksdrX5zYr4kz7EUpDYvCNQRUGXw@mail.gmail.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180802235527.ddb0d1837154e3f98571b3b0@kernel.org>
        <CAJWu+opoT6Ky-pwAwBbjDkyt0Y_UF1QUnDshu-_vLTU5K87_HQ@mail.gmail.com>
        <20180803162340.32b4b3fde55a4f5a5c28b425@kernel.org>
        <CAJWu+opO9-bb5RWorbQ54vq0rU1U6NFSnH9BDwGTvXhSaPmPTg@mail.gmail.com>
        <CAJWu+oq3HD3VhYzvRJA-8HQksdrX5zYr4kz7EUpDYvCNQRUGXw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2018 09:46:56 -0700
Joel Fernandes <joelaf@google.com> wrote:

> Hi Masami,
> 
> On Fri, Aug 3, 2018 at 9:51 PM, Joel Fernandes <joelaf@google.com> wrote:
> [...]
> >> On Thu, 2 Aug 2018 19:57:09 -0700
> >> Joel Fernandes <joelaf@google.com> wrote:
> >>
> >>> Hi Masami,
> >>>
> >>> On Thu, Aug 2, 2018 at 7:55 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >>> > Hi Joel,
> >>> >
> >>> > I found this caused several issues when testing ftrace.
> >>> >
> >>> > #1) ftrace boottest (FTRACE_STARTUP_TEST) fails
> >>>
> >>> This sadly appears to be a real issue. The startup test for
> >>> "preemptirqsoff" tracer fails, however it passes for only preemptoff
> >>> or only irqsoff. I tested only the last 2 tracers, not the first one,
> >>> that's why I didn't catch it. I need to debug this more.
> 
> I figured out this one too. Its because I need to account for
> preempt_count() in tracer_hardirqs_off since the tracer probe is now
> called with an additional level of preempt disabled from the
> tracepoint code. Without that accounting, stop_critical_timings may
> not be called causing an empty trace buffer. That should be easy to
> fix, I'm on vacation though and back on 13th so can most likely look
> at it only then (the week after the next).

Nice! Thank you for identifying the root cause!
BTW, I'm also on vacation this week :)

> >>> > #2) mmiotrace reports "IRQs not enabled as expected" error
> >>> > #3) lock subsystem event boottest causes "IRQs not disabled as expected" error (sometimes)
> 
> The only thing left to figure out is #3 ("lock subsystem event
> boottest"). Could you let me know how to run this test?

The #3 is not always reproducible, I just enabled these 2 configs

CONFIG_FTRACE_STARTUP_TEST=y and CONFIG_EVENT_TRACE_TEST_SYSCALLS=y

and boot on Qemu. I have seen this issue about 10% of system boot.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
