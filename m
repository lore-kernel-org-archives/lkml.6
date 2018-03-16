Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeCPQlj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbeCPQlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:41:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604C121742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Mar 2018 12:41:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe
 blacklist
Message-ID: <20180316124134.30fa47d5@gandalf.local.home>
In-Reply-To: <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
        <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <20170714142900.1c91949c@gandalf.local.home>
        <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
        <20180316112517.66bdd85a@gandalf.local.home>
        <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018 12:28:59 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > We probably didn't discuss it (as there was a lot to discuss, and this
> > was probably overshadowed by that). But yes, you should not probe
> > ftrace called functions. That is guaranteed to crash and that crash is
> > not a bug, but a feature.  
> 
> Are you really arguing that crashing the kernel from an ABI visible from
> userspace (even if it's only root user) is not a bug ? You are joking right ?
> Is there an EXPERIMENTAL config option that people need to select in order to
> make sure those ftrace interfaces don't end up on production systems ?

No I'm not. And yes there is. Disable kprobes. kprobes is much more
dangerous than ftrace, and its kprobes that is crashing not ftrace.

Heck we have "echo c > /proc/sysrq-trigger"

So yes, you can easily crash the kernel via root. If you can load a
module, you can crash the kernel. There's a thousand ways to crash a
kernel. This is why most of the fuzzer testing is done as non-root,
because doing it as root will do more than just crash the system, it may
corrupt it enough that you can no longer boot it.

I see below you are doing fuzzing testing too as root. Hopefully you
limit those tests because yes, things can get really bad.

> 
> > 
> > The ftrace and ring buffer files should be blacklisted from being
> > probed. Perhaps the entire directory.  
> 
> All code reachable from a kprobe handler should be blacklisted from
> kprobes, yes.

The problem is that that list constantly changes. There's been cases we
try to prevent things called by nmi do not get called, but it ended up
being every helper utility can be called in that context.

> 
> > 
> > Anyway, I don't see this as much of an urgent matter, as it's one of
> > those "Patient: Doc, it hurts when I do this. Doc: Don't do that"
> > cases. And there's a lot of urgent issues that currently need to be
> > dealt with.  
> 
> OK, short-term we'll remove everything related to ftrace functions
> from our CI fuzzer coverage. Arguably, the fact that a root user can
> crash the kernel through tracefs files is not that great security-wise
> though.

Note, probes are not a normal API. I test the hell out of the other
ftrace interfaces and if it blows up I fix it. But adding probes into
random parts of the kernel is very dangerous, and not something I care
to test. And sure, if you are worried about root killing the system,
disable kprobes.


> 
> Considering that our current focus is to test the kprobe instrumentation
> layer (and not ftrace per se), we will move our fuzzer to the LTTng ABI
> instead, which should take care of removing crashes introduced by ftrace
> from our fuzzing results.

Yes, kprobes are dangerous. I'm not saying it shouldn't be fixed, I'm
saying that I don't have time to fix it now, but would be happy to
accept patches if someone else does so.

-- Steve
