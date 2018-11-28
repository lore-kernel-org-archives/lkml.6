Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B1EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61512081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61512081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeK2J1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:27:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43409 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeK2J1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:27:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so17832073qkr.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qfs//UsvcKiHbpLmFQAogEgYMzPuClz/q0/jMx4oCpA=;
        b=EnWrEIsf2NojMSQPBEGdk1WnFl8vSqd3gDZJHSH7FMT3kQrhX8GC+aQ5h6GYy9ZncD
         fgQr88AAATZz8fwuWA3a8QKLv2YnVSpnWoe+P3L56k1EV0hv9L6blCUnHYKEL/Kv26Ji
         zHPzxn1cq8oF6EkDLd0k+a/OEYM5Sevz8O8jDzdaqcvaxmtdVUl9IUfK9NHwTc0u/cMI
         28NlfbrWbdtp2rewYI8bdpT8HTh4MdPKR9G1k9kJmMqI/++xpeohS2pvG5ltEUDfMd3U
         PYmfZLpCVhZdAhipfzV5Xq2YZDXvchvzjEFh/Ypey9CyJ9TYbS5ZoKej4eQpHxM13B1s
         w2ug==
X-Gm-Message-State: AA+aEWZWBzYuHB8eI7jr7pSljQ0ApRJ0DHKCAMmjI3YKghdZZHL7W0Hf
        pMGmHw1EsQcEVrdBAa3OLS3XF6Y7H5H/BMt/0Y0ui4M2
X-Google-Smtp-Source: AFSGD/XsyqWxfj8oo/FKKr0XRAyKebm4BmRKskps4EKpTD3l+0/6x7RWGgryVatyzHhYBw+T3RwntJmVb4PfF7+uAqk=
X-Received: by 2002:a37:324a:: with SMTP id y71mr36066015qky.291.1543443883737;
 Wed, 28 Nov 2018 14:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20181128081334.18408-1-anders.roxell@linaro.org> <20181128090903.7a27ae58@gandalf.local.home>
In-Reply-To: <20181128090903.7a27ae58@gandalf.local.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Nov 2018 23:24:26 +0100
Message-ID: <CAK8P3a1tONAdbfncqzEYW_Q8LOrprez+8fYsCTTK9+d+O1Mc3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/trace: fix watchdog soft lockup
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 3:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 28 Nov 2018 09:13:34 +0100
> Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > When building a allmodconfig kernel for arm64 and boot that in qemu,
> > CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
> > watchdog expires and prints out a message like this:
> > 'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
> > Each time the function ftrace_replace_code gets called it stays in that
> > functions loop for 41424 times.
> > Rework so that function cond_resched() gets called in the
> > ftrace_replace_code loop.
> >
> > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  kernel/trace/ftrace.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 5b4f73e4fd56..3f456921dedf 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -2426,6 +2426,10 @@ void __weak ftrace_replace_code(int enable)
> >
> >       do_for_each_ftrace_rec(pg, rec) {
> >
> > +             /* This loop can take minutes when sanitizers are enabled, so
> > +              * lets make sure we allow RCU processing.
> > +              */
> > +             cond_resched();
> >               if (rec->flags & FTRACE_FL_DISABLED)
> >                       continue;
> >
>
> NACK.  On some architectures this code is run from stop machine. We
> can't call cond_resched() because it may be called with interrupts
> disabled.
>
> This is a weak function. If arm64 has special needs, just copy it in
> the arm64 code.

I think it's currently broken on all architectures that don't already
override it, the problem being that the function is simply too
expensive when all debug options are enabled.

In an ARM64 allmodconfig kernel, there are 41424 records
that we iterate through several times. In an earlier version of the
test, the cond_resched() was only in the loop in
init_trace_selftests(), and I think that is safe and should /mostly/
solve the problem, so maybe Anders can submit that version again.

However, at least trace_selftest_ops() still takes half a minute
to complete in qemu, and that triggers the softlockup watchdog.
trace_selftest_ops() calls ftrace_replace_code() four or five times.

Here is the excerpt with printk times from one of Anders' tests:

[    8.350607] Running postponed tracer tests:
[    8.356045] Testing tracer function:
[   18.932077] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   27.454205] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   27.462594] PASSED
[   27.462954] Testing dynamic ftrace:
[   28.510903] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   28.746934] PASSED
[   28.747469] Testing dynamic ftrace ops #1:
[   32.488427] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   32.501864] (1 0 1 0 0)
[   32.502041] (1 1 2 0 0)
[   50.213914] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   50.219736] (2 1 3 0 1066085)
[   50.220077] (2 2 4 0 1066100)
[   60.580678] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   60.758019] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   60.910501] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   60.918354] PASSED
[   60.919672] Testing dynamic ftrace ops #2:
[   64.680222] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   64.843430] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   81.247068] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   81.250895] (1 0 1 1033119 0)
[   81.251186] (1 1 2 1033134 0)
[   81.343168] (2 1 3 1 3732)
[   81.344492] (2 2 4 118 3849)
[   89.837665] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   89.844371] PASSED
[   89.844719] Testing ftrace recursion:
[   90.890373] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   91.042146] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   91.048475] PASSED
[   91.048806] Testing ftrace recursion safe:
[   92.091174] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   92.242403] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   92.249119] PASSED
[   92.249470] Testing ftrace regs(no arch support):
[   93.293605] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   93.444942] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[   93.451738] PASSED
[   93.452300] Testing tracer nop: PASSED
[   93.453288] Testing tracer irqsoff:
[  104.486368] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[  112.918828] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[  112.925809] PASSED
[  112.926435] Testing tracer function_graph:
[  123.303248] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[  132.599763] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
[  132.607614] PASSED

In particular, the test_probe3 in trace_selftest_ops() takes
around 20 seconds, or 482 microseconds per loop iteration
in ftrace_replace_code().
Do you think there is another bug that makes it slower than
expected, or is that a reasonable time that it could take?

       Arnd
