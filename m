Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9BC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D03E21726
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547008684;
	bh=ZozZl8PTh/RGHKwP46SOEn3tX4THFWGMVHsPm2As5fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=swF3CjjBEOYvF7WWJb+CtrQsf10zS59FZ1kwIqhdKxuGBNe4lYIkXUkzyvzbI+rNl
	 MfXGiF3/o5Xs4+pDBUd5U0chhQ4b0pkfKYv2agyrwMJbOnZt5utdkXRe7Wp6yue882
	 rc3ieh2KB7BADxnLvktyCr5YwIU2HgrGSlJnmCPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfAIEiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfAIEiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:38:02 -0500
Received: from devnote (p103030-mobac01.tokyo.ocn.ne.jp [153.233.94.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1997920665;
        Wed,  9 Jan 2019 04:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547008681;
        bh=ZozZl8PTh/RGHKwP46SOEn3tX4THFWGMVHsPm2As5fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BJUad3tJpcoX5MPbc2ssocRy0yLXmKbM1YQilBHCm8j47hYsKSGNKZs9MDy0DU7Cx
         ooffEmL/OWYor6HENOZnIXqNiIkwzGuGYp4AIJ4ITpYVKzAGvx366gxVMEb5nfxXv0
         JSpLklxZsG1TDTKicfOh+u6hAMv4j5ShW8G6owFU=
Date:   Wed, 9 Jan 2019 13:37:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kprobes: Fix kretprobe issues
Message-Id: <20190109133757.8b28753d301f9d5378916438@kernel.org>
In-Reply-To: <20190108103101.GE5966@xps-13>
References: <154692263564.1133.17363562046971295490.stgit@devbox>
        <20190108103101.GE5966@xps-13>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 11:31:01 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Tue, Jan 08, 2019 at 01:43:55PM +0900, Masami Hiramatsu wrote:
> > Hello,
> > 
> > This is v2 series of fixing kretprobe incorrect stacking order patches.
> > In this version, I fixed a lack of kprobes.h including and added new
> > patch for kretprobe trampoline recursion issue. (and add Cc:stable)
> > 
> > (1) kprobe incorrct stacking order problem
> > 
> > On recent talk with Andrea, I started more precise investigation on
> > the kernel panic with kretprobes on notrace functions, which Francis
> > had been reported last year ( https://lkml.org/lkml/2017/7/14/466 ).
> > 
> > See the investigation details in 
> > https://lkml.kernel.org/r/154686789378.15479.2886543882215785247.stgit@devbox
> > 
> > When we put a kretprobe on ftrace_ops_assist_func() and put another
> > kretprobe on probed-function, below happens
> > 
> > <caller>
> >  -><probed-function>
> >    ->fentry
> >     ->ftrace_ops_assist_func()
> >      ->int3
> >       ->kprobe_int3_handler()
> >       ...->pre_handler_kretprobe()
> >            push the return address (*fentry*) of ftrace_ops_assist_func() to
> >            top of the kretprobe list and replace it with kretprobe_trampoline.
> >       <-kprobe_int3_handler()
> >      <-(int3)
> >      ->kprobe_ftrace_handler()
> >       ...->pre_handler_kretprobe()
> >            push the return address (caller) of probed-function to top of the
> >            kretprobe list and replace it with kretprobe_trampoline.
> >      <-(kprobe_ftrace_handler())
> >     <-(ftrace_ops_assist_func())
> >     [kretprobe_trampoline]
> >      ->tampoline_handler()
> >        pop the return address (caller) from top of the kretprobe list
> >      <-(trampoline_handler())
> >     <caller>
> >     [run caller with incorrect stack information]
> >    <-(<caller>)
> >   !!KERNEL PANIC!!
> > 
> > Therefore, this kernel panic happens only when we put 2 k*ret*probes on
> > ftrace_ops_assist_func() and other functions. If we put kprobes, it
> > doesn't cause any issue, since it doesn't change the return address.
> > 
> > To fix (or just avoid) this issue, we can introduce a frame pointer
> > verification to skip wrong order entries. And I also would like to
> > blacklist those functions because those are part of ftrace-based 
> > kprobe handling routine.
> > 
> > (2) kretprobe trampoline recursion problem
> > 
> > This was found by Andrea in the previous thread
> > https://lkml.kernel.org/r/20190107183444.GA5966@xps-13
> > 
> > ----
> >  echo "r:event_1 __fdget" >> kprobe_events
> >  echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
> >  echo 1 > events/kprobes/enable
> >  [DEADLOCK]
> > ----
> > 
> > Because kretprobe trampoline_handler uses spinlock for protecting
> > hash table, if we probe the spinlock itself, it causes deadlock.
> > Thank you Andrea and Steve for discovering this root cause!!
> > 
> > This bug has been introduced with the asm-coded trampoline
> > code, since previously it used another kprobe for hooking
> > the function return placeholder (which only has a nop) and
> > trampoline handler was called from that kprobe.
> > 
> > To fix this bug, I introduced a dummy kprobe and set it in
> > current_kprobe as we did in old days.
> > 
> > Thank you,
> 
> It looks all good to me, with this patch set I couldn't break the
> kernel in any way.
> 
> Tested-by: Andrea Righi <righi.andrea@gmail.com>

Thank you, Andrea!

Ingo, could you pick this series?


-- 
Masami Hiramatsu <mhiramat@kernel.org>
